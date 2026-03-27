#!/usr/bin/env python3
"""
bis_data.lua에서 획득처가 빈("") 아이템을 찾아
Blizzard API (Journal 엔드포인트)로 정확한 드롭 위치를 조회한 뒤
item_sources.lua에 추가합니다.

필요: .env 파일에 BNET_CLIENT_ID, BNET_CLIENT_SECRET 설정

사용법:
    python scripts/fetch_missing_sources.py          # 조회 + 캐시 저장
    python scripts/fetch_missing_sources.py --dry-run # 조회만 (파일 수정 안 함)
"""

from __future__ import annotations

import argparse
import re
import sys
import time
from pathlib import Path

import random

import requests

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
BIS_DATA_PATH = PROJECT_DIR / "bis_data.lua"
SOURCES_PATH = PROJECT_DIR / "item_sources.lua"
ENV_PATH = PROJECT_DIR / ".env"

# Blizzard API 설정 (한국 리전)
BNET_TOKEN_URL = "https://oauth.battle.net/token"
BNET_API_BASE = "https://kr.api.blizzard.com"
NAMESPACE_STATIC = "static-kr"
LOCALE = "ko_KR"

# ── 현재 시즌 던전/레이드 Journal Instance ID ──
# https://develop.battle.net/documentation/world-of-warcraft/game-data-apis
JOURNAL_INSTANCE_IDS = [
    # Midnight Season 1 던전
    278,   # 사론의 구덩이
    1004,  # 승리자의 자리
    1196,  # 알게타르 아카데미
    1298,  # 작전: 방수로
    1268,  # 바람매 첨탑
    1210,  # 마법학자의 정원 (The Botanica)
    1299,  # 연결점 제나스
    1300,  # 마이사라 동굴
    1301,  # 하늘매
    # 레이드
    1296,  # 언더마인의 해방 (Liberation of Undermine)
    1273,  # 네룹아르 궁전
]

# 인스턴스 타입 매핑 (레이드 인스턴스 ID)
RAID_INSTANCE_IDS = {1296, 1273}

# 던전 이름 영→한 (API가 영문 반환 시 대비)
INSTANCE_NAME_KO = {
    "Pit of Saron": "사론의 구덩이",
    "Seat of the Triumvirate": "승리자의 자리",
    "Algeth'ar Academy": "알게타르 아카데미",
    "Operation: Floodgate": "작전: 방수로",
    "The Rookery": "바람매 첨탑",
    "The Botanica": "마법학자의 정원",
    "Nexus-Princess Ky'veza's Gambit": "연결점 제나스",
    "Mycelial Caverns": "마이사라 동굴",
    "Fungal Folly": "균류 소동",
    "Liberation of Undermine": "언더마인의 해방",
    "Nerub-ar Palace": "네룹아르 궁전",
}


def load_env() -> dict[str, str]:
    """프로젝트 루트 .env 파일을 로드합니다."""
    env = {}
    if not ENV_PATH.exists():
        return env
    for line in ENV_PATH.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if "=" in line:
            k, v = line.split("=", 1)
            env[k.strip()] = v.strip()
    return env


def get_access_token(client_id: str, client_secret: str) -> str:
    """Battle.net OAuth2 토큰을 발급받습니다."""
    resp = requests.post(
        BNET_TOKEN_URL,
        data={"grant_type": "client_credentials"},
        auth=(client_id, client_secret),
        timeout=15,
    )
    resp.raise_for_status()
    return resp.json()["access_token"]


def bnet_get(token: str, path: str, params: dict | None = None) -> dict:
    """Blizzard API GET 요청."""
    url = f"{BNET_API_BASE}{path}"
    p = {"namespace": NAMESPACE_STATIC, "locale": LOCALE}
    if params:
        p.update(params)
    resp = requests.get(url, params=p, headers={"Authorization": f"Bearer {token}"}, timeout=15)
    resp.raise_for_status()
    return resp.json()


def build_item_source_map(token: str) -> dict[int, str]:
    """Journal API에서 인스턴스 → 인카운터 → 드롭 아이템을 수집하여
    itemId → '던전/레이드 - 인스턴스명' 매핑을 구축합니다."""
    item_map: dict[int, str] = {}

    for inst_id in JOURNAL_INSTANCE_IDS:
        print(f"    인스턴스 {inst_id} 조회...", end=" ", flush=True)
        try:
            inst = bnet_get(token, f"/data/wow/journal-instance/{inst_id}")
        except requests.RequestException as e:
            print(f"✗ 실패: {e}")
            continue

        inst_name = inst.get("name", f"인스턴스-{inst_id}")
        # 한글 이름이 아니면 매핑 시도
        if inst_name in INSTANCE_NAME_KO:
            inst_name = INSTANCE_NAME_KO[inst_name]

        is_raid = inst_id in RAID_INSTANCE_IDS
        prefix = "레이드" if is_raid else "던전"

        encounters = inst.get("encounters", [])
        item_count = 0

        for enc_ref in encounters:
            enc_id = enc_ref.get("id")
            if not enc_id:
                continue
            try:
                enc = bnet_get(token, f"/data/wow/journal-encounter/{enc_id}")
            except requests.RequestException:
                continue

            enc_name = enc.get("name", "")
            # 레이드는 보스 이름, 던전은 인스턴스 이름
            source = f"레이드 - {enc_name}" if is_raid else f"던전 - {inst_name}"

            for section in enc.get("sections", []):
                _collect_items_from_section(section, source, item_map)
                item_count += 1

            # items 필드 직접 확인
            for item_entry in enc.get("items", []):
                item_obj = item_entry.get("item", {})
                iid = item_obj.get("id")
                if iid:
                    item_map[iid] = source

            time.sleep(0.05)  # rate limiting

        print(f"✓ {inst_name} ({len(encounters)}개 인카운터)")

    return item_map


def _collect_items_from_section(section: dict, source: str, item_map: dict[int, str]):
    """Journal 섹션에서 아이템을 재귀적으로 수집합니다."""
    for creature_drop in section.get("creature_drops", []):
        for item_entry in creature_drop.get("items", []):
            item_obj = item_entry.get("item", {})
            iid = item_obj.get("id")
            if iid:
                item_map[iid] = source

    # 하위 섹션 재귀
    for sub in section.get("sections", []):
        _collect_items_from_section(sub, source, item_map)


def find_missing_item_ids(bis_path: Path) -> set[int]:
    """bis_data.lua M+ 섹션에서 획득처가 빈 아이템 ID를 찾습니다."""
    content = bis_path.read_text(encoding="utf-8")
    raid_pos = content.find('ItemInfoBISData["raid"]')
    if raid_pos == -1:
        raid_pos = len(content)
    mplus_section = content[:raid_pos]
    pattern = re.compile(r'\[\d+\]=\{(\d+),\s*\{[^}]*\},\s*""\}')
    return {int(m.group(1)) for m in pattern.finditer(mplus_section)}


def load_existing_sources(path: Path) -> dict[int, str]:
    """item_sources.lua에서 기존 캐시를 로드합니다."""
    if not path.exists():
        return {}
    content = path.read_text(encoding="utf-8")
    sources = {}
    pattern = re.compile(r'\[(\d+)\]\s*=\s*"([^"]*)"')
    for m in pattern.finditer(content):
        sources[int(m.group(1))] = m.group(2)
    return sources


def update_sources_lua(sources: dict[int, str], path: Path):
    """item_sources.lua를 업데이트합니다."""
    lines = [
        "-- item_sources.lua",
        "-- 아이템 ID → 획득처 캐시",
        "-- 한번 조회한 아이템은 재조회 불필요",
        "-- 자동 생성 파일 — scripts/fetch_missing_sources.py",
        "",
        "ItemInfoSourceCache = {",
    ]

    grouped: dict[str, list[int]] = {}
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


def fetch_item_name(token: str, item_id: int) -> str | None:
    """Blizzard API에서 아이템 이름을 조회합니다."""
    try:
        data = bnet_get(token, f"/data/wow/item/{item_id}")
        return data.get("name")
    except requests.RequestException:
        return None


# ── wowhead 폴백 ──────────────────────────────────────

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15",
]

# 던전/레이드/기타 키워드 → 소스 매핑 (wowhead 한국어 페이지용)
WOWHEAD_SOURCE_PATTERNS = [
    # 제작
    (["제작:", "만들기:", "제작 시 귀속", "Crafted by"], "제작"),
    # 구렁
    (["구렁", "Delve"], "구렁"),
    # 행렬 촉매
    (["행렬 촉매", "Revival Catalyst"], "행렬 촉매"),
    # PvP
    (["PvP", "정복 점수", "명예 점수"], "PvP"),
]

# 던전 이름 패턴 (한국어 wowhead 페이지에서 검출)
WOWHEAD_DUNGEON_PATTERNS = {
    "사론의 구덩이": "던전 - 사론의 구덩이",
    "승리자의 자리": "던전 - 승리자의 자리",
    "알게타르 아카데미": "던전 - 알게타르 아카데미",
    "작전: 방수로": "던전 - 작전: 방수로",
    "바람매 첨탑": "던전 - 바람매 첨탑",
    "마법학자의 정원": "던전 - 마법학자의 정원",
    "연결점 제나스": "던전 - 연결점 제나스",
    "마이사라 동굴": "던전 - 마이사라 동굴",
    "하늘매": "던전 - 하늘매",
    "균류 소동": "던전 - 균류 소동",
    "Pit of Saron": "던전 - 사론의 구덩이",
    "Seat of the Triumvirate": "던전 - 승리자의 자리",
    "Algeth'ar Academy": "던전 - 알게타르 아카데미",
    "Operation: Floodgate": "던전 - 작전: 방수로",
    "The Rookery": "던전 - 바람매 첨탑",
    "The Botanica": "던전 - 마법학자의 정원",
    "Mycelial Caverns": "던전 - 마이사라 동굴",
    "Fungal Folly": "던전 - 균류 소동",
}


def fetch_from_wowhead(item_id: int) -> str | None:
    """wowhead 한국어 페이지에서 아이템 획득처를 파싱합니다."""
    url = f"https://www.wowhead.com/ko/item={item_id}"
    headers = {
        "User-Agent": random.choice(USER_AGENTS),
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
        "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1",
        "Sec-Fetch-Dest": "document",
        "Sec-Fetch-Mode": "navigate",
        "Sec-Fetch-Site": "none",
        "Sec-Fetch-User": "?1",
        "Cache-Control": "max-age=0",
    }
    try:
        resp = requests.get(url, headers=headers, timeout=20)
        resp.raise_for_status()
    except requests.RequestException as e:
        return f"__error__:{e}"

    text = resp.text

    # 기본 소스 패턴 매칭
    for keywords, source in WOWHEAD_SOURCE_PATTERNS:
        if any(kw in text for kw in keywords):
            return source

    # 던전/레이드 이름 매칭
    for pattern, source in WOWHEAD_DUNGEON_PATTERNS.items():
        if pattern in text:
            return source

    # 레이드 보스 매칭
    for en_name, ko_name in INSTANCE_NAME_KO.items():
        if en_name in text or ko_name in text:
            return f"레이드 - {ko_name}"

    return None


def main():
    parser = argparse.ArgumentParser(description="Blizzard API로 누락 아이템 획득처 조회")
    parser.add_argument("--dry-run", action="store_true", help="조회만 하고 파일 수정 안 함")
    args = parser.parse_args()

    # 0. 환경 변수 로드
    env = load_env()
    client_id = env.get("BNET_CLIENT_ID")
    client_secret = env.get("BNET_CLIENT_SECRET")
    if not client_id or not client_secret:
        print("ERROR: .env에 BNET_CLIENT_ID, BNET_CLIENT_SECRET 필요", file=sys.stderr)
        sys.exit(1)

    # 1. 누락 아이템 찾기
    print("==> [1/5] bis_data.lua에서 빈 획득처 아이템 검색...")
    missing = find_missing_item_ids(BIS_DATA_PATH)
    if not missing:
        print("    누락 아이템 없음!")
        return
    print(f"    {len(missing)}개 발견: {sorted(missing)}")

    # 2. 기존 캐시 로드
    print("\n==> [2/5] 기존 캐시 로드...")
    sources = load_existing_sources(SOURCES_PATH)
    truly_missing = missing - set(sources.keys())
    print(f"    기존 {len(sources)}개, 조회 필요 {len(truly_missing)}개")

    if not truly_missing:
        print("    모든 누락 아이템이 캐시에 있습니다. apply_sources.py를 다시 실행하세요.")
        return

    # 3. Battle.net 토큰 발급
    print("\n==> [3/5] Battle.net 토큰 발급...")
    try:
        token = get_access_token(client_id, client_secret)
        print("    ✓ 토큰 발급 완료")
    except requests.RequestException as e:
        print(f"    ✗ 토큰 발급 실패: {e}", file=sys.stderr)
        sys.exit(1)

    # 4. Journal API에서 드롭 테이블 수집
    print("\n==> [4/5] Journal API에서 드롭 테이블 수집...")
    journal_map = build_item_source_map(token)
    print(f"    총 {len(journal_map)}개 아이템 매핑 수집")

    # 5. 누락 아이템 매칭
    print(f"\n==> [5/5] 누락 아이템 매칭...")
    found = 0
    still_missing = []

    need_wowhead = []
    for item_id in sorted(truly_missing):
        if item_id in journal_map:
            source = journal_map[item_id]
            sources[item_id] = source
            print(f"    [{item_id}] ✓ {source}")
            found += 1
        else:
            name = fetch_item_name(token, item_id)
            need_wowhead.append((item_id, name))
            time.sleep(0.1)

    # 5-2. Journal 미해결 → wowhead 한국어 페이지 폴백
    if need_wowhead:
        print(f"\n==> [5-2/5] Journal 미해결 {len(need_wowhead)}개 → wowhead 조회...")
        for item_id, name in need_wowhead:
            print(f"    [{item_id}] {name or '?'} ... ", end="", flush=True)
            source = fetch_from_wowhead(item_id)

            if source and source.startswith("__error__:"):
                print(f"✗ 요청 실패: {source[10:]}")
                still_missing.append((item_id, name))
            elif source:
                print(f"✓ {source}")
                sources[item_id] = source
                found += 1
            else:
                print("✗ 판별 불가")
                still_missing.append((item_id, name))

            # 자연스러운 간격 (3~6초 랜덤)
            time.sleep(random.uniform(3, 6))

    # 결과 요약
    print(f"\n==> 결과: {found}개 매칭 / {len(still_missing)}개 미해결")

    if still_missing:
        print("\n    미해결 아이템 (수동 확인 필요):")
        for item_id, name in still_missing:
            print(f"      [{item_id}] {name or '이름 불명'}")
        print("\n    → item_sources.lua에 수동 추가 후 apply_sources.py 실행")

    if args.dry_run:
        print("\n    (dry-run: 파일 수정 안 함)")
        return

    if found > 0:
        print(f"\n    item_sources.lua 저장 중... ({len(sources)}개 항목)")
        update_sources_lua(sources, SOURCES_PATH)
        print("    ✓ 완료!")
        print("\n    다음 단계:")
        print("    python scripts/apply_sources.py")
        print("    python scripts/verify_bis.py")


if __name__ == "__main__":
    main()
