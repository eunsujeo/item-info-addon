#!/usr/bin/env python3
"""
item_sources.lua 캐시에서 획득처 매핑을 읽어
bis_data.lua M+ 섹션의 빈 source 문자열("")을 채웁니다.

사용법:
    python scripts/apply_sources.py                # 캐시 기반 매핑만
    python scripts/apply_sources.py --fetch-missing # 누락 아이템 wowhead 자동 조회
"""

from __future__ import annotations

import argparse
import re
import sys
import time
from pathlib import Path

import requests

# ── 경로 설정 ──────────────────────────────────────────
SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
BIS_DATA_PATH = PROJECT_DIR / "bis_data.lua"
SOURCES_PATH = PROJECT_DIR / "item_sources.lua"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) ItemInfo-WoW-Addon/2.0",
    "Accept": "text/html,application/xhtml+xml",
    "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
}


def load_sources_from_lua(path: Path) -> dict:
    """item_sources.lua 파일에서 아이템 소스 매핑을 파싱합니다."""
    if not path.exists():
        print(f"  경고: {path} 파일이 없습니다. 빈 매핑으로 진행합니다.", file=sys.stderr)
        return {}

    content = path.read_text(encoding="utf-8")
    sources = {}

    # [12345] = "소스 문자열", 패턴 매칭
    pattern = re.compile(r'\[(\d+)\]\s*=\s*"([^"]*)"')
    for match in pattern.finditer(content):
        item_id = int(match.group(1))
        source = match.group(2)
        sources[item_id] = source

    return sources


def fetch_source_from_wowhead(item_id: int) -> str | None:
    """wowhead에서 아이템의 획득처를 추정합니다."""
    url = f"https://www.wowhead.com/item={item_id}"
    try:
        resp = requests.get(url, headers=HEADERS, timeout=15)
        resp.raise_for_status()
    except requests.RequestException as e:
        print(f"    ✗ wowhead 조회 실패: {item_id} — {e}", file=sys.stderr)
        return None

    text = resp.text

    # 제작 아이템 판별
    if "Crafted by" in text or "Recipe:" in text or "Created by" in text:
        return "제작"

    # 던전 드롭 판별 — 일반적으로 "Dropped by" + 던전 이름
    # wowhead 페이지에서 소스 정보가 있는 경우
    # 구체적 던전 이름 매칭은 어려우므로 기본값 반환
    if "Dropped by" in text:
        # 던전/레이드 구분 시도
        if "Raid" in text or "raid" in text:
            return "레이드"
        return "던전"

    # PvP 아이템
    if "PvP" in text or "Arena" in text or "Conquest" in text or "Honor" in text:
        return "PvP"

    return None


def save_sources_to_lua(sources: dict, path: Path):
    """item_sources.lua 파일에 소스 매핑을 저장합니다."""
    lines = []
    lines.append("-- item_sources.lua")
    lines.append("-- 아이템 ID → 획득처 캐시")
    lines.append("-- 한번 조회한 아이템은 재조회 불필요")
    lines.append("-- 자동 생성 파일 — scripts/apply_sources.py")
    lines.append("")
    lines.append("ItemInfoSourceCache = {")

    # 소스별로 그룹화
    grouped = {}
    for item_id, source in sorted(sources.items()):
        grouped.setdefault(source, []).append(item_id)

    for source in sorted(grouped.keys()):
        items = grouped[source]
        lines.append(f"    -- ===== {source} =====")
        for item_id in sorted(items):
            lines.append(f'    [{item_id}] = "{source}",')
        lines.append("")

    lines.append("}")
    lines.append("")

    path.write_text("\n".join(lines), encoding="utf-8")


def apply_sources(bis_content: str, sources: dict) -> tuple[str, int, set]:
    """bis_data.lua M+ 섹션에 소스 매핑을 적용합니다.

    Returns:
        (modified_content, replaced_count, missing_item_ids)
    """
    lines = bis_content.split("\n")

    # raid 섹션 경계 찾기
    raid_line = None
    for i, line in enumerate(lines):
        if 'ItemInfoBISData["raid"]' in line:
            raid_line = i
            break

    if raid_line is None:
        print("ERROR: raid 섹션 경계를 찾을 수 없습니다!", file=sys.stderr)
        sys.exit(1)

    # 빈 소스 문자열 패턴 매칭
    item_pattern = re.compile(r'(\[\d+\]=\{)(\d+)(,\s*\{[^}]*\},\s*)""')

    replaced = 0
    missing_ids = set()

    new_lines = []
    for i, line in enumerate(lines):
        if i < raid_line:
            m = item_pattern.search(line)
            if m:
                item_id = int(m.group(2))
                if item_id in sources:
                    src = sources[item_id]
                    new_line = line.replace('""', f'"{src}"', 1)
                    new_lines.append(new_line)
                    replaced += 1
                else:
                    missing_ids.add(item_id)
                    new_lines.append(line)
            else:
                new_lines.append(line)
        else:
            new_lines.append(line)

    return "\n".join(new_lines), replaced, missing_ids


def main():
    parser = argparse.ArgumentParser(description="아이템 획득처 매핑 적용")
    parser.add_argument(
        "--fetch-missing",
        action="store_true",
        help="누락 아이템을 wowhead에서 자동 조회",
    )
    parser.add_argument(
        "--bis-data",
        type=str,
        default=None,
        help="bis_data.lua 경로 (기본: 프로젝트 루트)",
    )
    parser.add_argument(
        "--sources",
        type=str,
        default=None,
        help="item_sources.lua 경로 (기본: 프로젝트 루트)",
    )
    args = parser.parse_args()

    bis_path = Path(args.bis_data) if args.bis_data else BIS_DATA_PATH
    sources_path = Path(args.sources) if args.sources else SOURCES_PATH

    # ── 소스 캐시 로드 ──
    print("==> item_sources.lua에서 캐시 로드 중...")
    sources = load_sources_from_lua(sources_path)
    print(f"    {len(sources)}개 아이템 매핑 로드됨")

    # ── bis_data.lua 읽기 ──
    if not bis_path.exists():
        print(f"ERROR: {bis_path} 파일이 없습니다!", file=sys.stderr)
        sys.exit(1)

    content = bis_path.read_text(encoding="utf-8")

    # ── 소스 매핑 적용 ──
    new_content, replaced, missing_ids = apply_sources(content, sources)

    # ── 누락 아이템 wowhead 조회 ──
    fetched_count = 0
    if args.fetch_missing and missing_ids:
        print(f"\n==> wowhead에서 누락 아이템 {len(missing_ids)}개 조회 중...")
        for item_id in sorted(missing_ids):
            print(f"    [{item_id}]...", end=" ", flush=True)
            source = fetch_source_from_wowhead(item_id)
            if source:
                sources[item_id] = source
                print(f"✓ {source}")
                fetched_count += 1
            else:
                print("✗ 판별 불가")
            time.sleep(1.0)  # rate limiting

        # 새로 찾은 소스로 다시 적용
        if fetched_count > 0:
            new_content, replaced, missing_ids = apply_sources(content, sources)

            # 캐시 파일 업데이트
            print(f"\n==> item_sources.lua 캐시 업데이트 중...")
            save_sources_to_lua(sources, sources_path)
            print(f"    {len(sources)}개 항목 저장됨")

    # ── 파일 쓰기 ──
    bis_path.write_text(new_content, encoding="utf-8")

    # ── 요약 출력 ──
    print(f"\n==> 결과:")
    print(f"    매핑 완료: {replaced}개")
    print(f"    누락: {len(missing_ids)}개")
    if fetched_count > 0:
        print(f"    wowhead 조회 성공: {fetched_count}개")

    if missing_ids:
        print(f"\n    매핑 누락 아이템 ID: {sorted(missing_ids)}")


if __name__ == "__main__":
    main()
