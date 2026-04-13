#!/usr/bin/env python3
"""
murlok.io에서 각 클래스/스펙의 1위 플레이어 특성 문자열을 수집합니다.

1. 스펙 페이지에서 1위 플레이어 캐릭터 URL 추출
2. 캐릭터 페이지에서 Playwright로 "Copy talents" 클릭 → 클립보드에서 문자열 추출
3. talent_data.lua 파일로 저장

사용법:
    python scripts/update_talents.py              # 전체 수집
    python scripts/update_talents.py --dry-run    # 미리보기
    python scripts/update_talents.py --spec frost-mage  # 특정 스펙만
"""

from __future__ import annotations

import argparse
import random
import re
import sys
import time
from datetime import datetime
from pathlib import Path

import requests
from playwright.sync_api import sync_playwright

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
TALENT_DATA_PATH = PROJECT_DIR / "talent_data.lua"

# ── 클래스/스펙 매핑 ──
CLASS_SPECS = {
    "DEATHKNIGHT": {
        "slug": "death-knight",
        "name": "죽음의 기사",
        "specs": [
            {"index": 1, "slug": "blood", "name": "혈기"},
            {"index": 2, "slug": "frost", "name": "냉기"},
            {"index": 3, "slug": "unholy", "name": "부정"},
        ],
    },
    "DEMONHUNTER": {
        "slug": "demon-hunter",
        "name": "악마사냥꾼",
        "specs": [
            {"index": 1, "slug": "havoc", "name": "파멸"},
            {"index": 2, "slug": "vengeance", "name": "복수"},
            {"index": 3, "slug": "devourer", "name": "포식"},
        ],
    },
    "DRUID": {
        "slug": "druid",
        "name": "드루이드",
        "specs": [
            {"index": 1, "slug": "balance", "name": "조화"},
            {"index": 2, "slug": "feral", "name": "야성"},
            {"index": 3, "slug": "guardian", "name": "수호"},
            {"index": 4, "slug": "restoration", "name": "회복"},
        ],
    },
    "EVOKER": {
        "slug": "evoker",
        "name": "기원사",
        "specs": [
            {"index": 1, "slug": "devastation", "name": "황폐"},
            {"index": 2, "slug": "preservation", "name": "보존"},
            {"index": 3, "slug": "augmentation", "name": "증강"},
        ],
    },
    "HUNTER": {
        "slug": "hunter",
        "name": "사냥꾼",
        "specs": [
            {"index": 1, "slug": "beast-mastery", "name": "야수"},
            {"index": 2, "slug": "marksmanship", "name": "사격"},
            {"index": 3, "slug": "survival", "name": "생존"},
        ],
    },
    "MAGE": {
        "slug": "mage",
        "name": "마법사",
        "specs": [
            {"index": 1, "slug": "arcane", "name": "비전"},
            {"index": 2, "slug": "fire", "name": "화염"},
            {"index": 3, "slug": "frost", "name": "냉기"},
        ],
    },
    "MONK": {
        "slug": "monk",
        "name": "수도사",
        "specs": [
            {"index": 1, "slug": "brewmaster", "name": "양조"},
            {"index": 2, "slug": "mistweaver", "name": "안개"},
            {"index": 3, "slug": "windwalker", "name": "풍운"},
        ],
    },
    "PALADIN": {
        "slug": "paladin",
        "name": "성기사",
        "specs": [
            {"index": 1, "slug": "holy", "name": "신성"},
            {"index": 2, "slug": "protection", "name": "보호"},
            {"index": 3, "slug": "retribution", "name": "징벌"},
        ],
    },
    "PRIEST": {
        "slug": "priest",
        "name": "사제",
        "specs": [
            {"index": 1, "slug": "discipline", "name": "수양"},
            {"index": 2, "slug": "holy", "name": "신성"},
            {"index": 3, "slug": "shadow", "name": "암흑"},
        ],
    },
    "ROGUE": {
        "slug": "rogue",
        "name": "도적",
        "specs": [
            {"index": 1, "slug": "assassination", "name": "암살"},
            {"index": 2, "slug": "outlaw", "name": "무법"},
            {"index": 3, "slug": "subtlety", "name": "잠행"},
        ],
    },
    "SHAMAN": {
        "slug": "shaman",
        "name": "주술사",
        "specs": [
            {"index": 1, "slug": "elemental", "name": "정기"},
            {"index": 2, "slug": "enhancement", "name": "고양"},
            {"index": 3, "slug": "restoration", "name": "복원"},
        ],
    },
    "WARLOCK": {
        "slug": "warlock",
        "name": "흑마법사",
        "specs": [
            {"index": 1, "slug": "affliction", "name": "고통"},
            {"index": 2, "slug": "demonology", "name": "악마"},
            {"index": 3, "slug": "destruction", "name": "파괴"},
        ],
    },
    "WARRIOR": {
        "slug": "warrior",
        "name": "전사",
        "specs": [
            {"index": 1, "slug": "arms", "name": "무기"},
            {"index": 2, "slug": "fury", "name": "분노"},
            {"index": 3, "slug": "protection", "name": "방어"},
        ],
    },
}

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.9,ko;q=0.8",
}


def get_top_player_url(class_slug: str, spec_slug: str) -> str | None:
    """murlok.io 스펙 페이지에서 1위 플레이어의 캐릭터 URL을 추출합니다."""
    url = f"https://murlok.io/{class_slug}/{spec_slug}/m+"
    try:
        resp = requests.get(url, headers=HEADERS, timeout=15)
        resp.raise_for_status()
    except requests.RequestException as e:
        print(f"    x page fetch failed: {e}", file=sys.stderr)
        return None

    # /character/region/realm/name/pve 패턴
    matches = re.findall(r'/character/(\w+)/([^/]+)/([^/]+)/pve', resp.text)
    if not matches:
        return None

    region, realm, name = matches[0]
    return f"https://murlok.io/character/{region}/{realm}/{name}/pve"


def extract_talent_string(page, char_url: str) -> str | None:
    """Playwright로 캐릭터 페이지에서 특성 문자열을 추출합니다."""
    try:
        page.goto(char_url, timeout=60000)

        # Copy 버튼 대기
        copy_btn = page.locator('button:has-text("Copy")')
        copy_btn.first.wait_for(state='visible', timeout=60000)

        # 클릭
        copy_btn.first.click()
        page.wait_for_timeout(1500)

        # 클립보드 읽기
        talent_string = page.evaluate('navigator.clipboard.readText()')

        if talent_string and len(talent_string) > 20:
            return talent_string.strip()

    except Exception as e:
        print(f"    x extract failed: {e}", file=sys.stderr)

    return None


def generate_talent_lua(talent_data: dict) -> str:
    """talent_data.lua 파일 내용을 생성합니다."""
    today = datetime.now().strftime("%Y-%m-%d")
    lines = [
        "-- talent_data.lua",
        "-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)",
        f"-- 업데이트: {today}",
        "",
        "ItemInfoTalentData = {",
    ]

    for class_id, class_info in CLASS_SPECS.items():
        class_name = class_info["name"]
        if class_id not in talent_data:
            continue

        lines.append(f'    ["{class_id}"] = {{')

        for spec in class_info["specs"]:
            idx = spec["index"]
            if idx not in talent_data[class_id]:
                continue

            entry = talent_data[class_id][idx]
            talent_str = entry["talent_string"]
            player = entry["player"]

            lines.append(f'        [{idx}] = {{ -- {spec["name"]}')
            lines.append(f'            "{talent_str}",')
            lines.append(f'            "{player}",')
            lines.append(f'        }},')

        lines.append(f'    }},')

    lines.append("}")
    lines.append("")

    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="murlok.io talent string collector")
    parser.add_argument("--dry-run", action="store_true", help="Preview only")
    parser.add_argument("--spec", type=str, help="Single spec (e.g., frost-mage)")
    args = parser.parse_args()

    print("--- [1/3] Collecting top player URLs from murlok.io ---")

    # 수집 대상 결정
    targets = []
    for class_id, class_info in CLASS_SPECS.items():
        for spec in class_info["specs"]:
            if args.spec:
                key = f"{spec['slug']}-{class_info['slug']}"
                if args.spec not in key:
                    continue
            targets.append((class_id, class_info, spec))

    print(f"  {len(targets)} specs to process")

    # 1위 플레이어 URL 수집
    player_urls: list[tuple[str, dict, dict, str]] = []
    for class_id, class_info, spec in targets:
        label = f"{class_info['name']} {spec['name']}"
        print(f"  {label}...", end=" ", flush=True)

        url = get_top_player_url(class_info["slug"], spec["slug"])
        if url:
            player_name = url.split("/")[-2]
            print(f"ok ({player_name})")
            player_urls.append((class_id, class_info, spec, url))
        else:
            print("SKIP (no player found)")

        time.sleep(random.uniform(1.5, 3.0))

    print(f"\n  {len(player_urls)} players found")

    if not player_urls:
        print("  ERROR: No players found!", file=sys.stderr)
        sys.exit(1)

    # Playwright로 특성 문자열 추출
    print(f"\n--- [2/3] Extracting talent strings (Playwright) ---")

    talent_data: dict = {}

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context()
        context.grant_permissions(['clipboard-read', 'clipboard-write'])
        page = context.new_page()

        for i, (class_id, class_info, spec, char_url) in enumerate(player_urls):
            label = f"{class_info['name']} {spec['name']}"
            player_name = char_url.split("/")[-2]
            print(f"  [{i+1}/{len(player_urls)}] {label} ({player_name})...", end=" ", flush=True)

            talent_string = extract_talent_string(page, char_url)

            if talent_string:
                print(f"ok ({len(talent_string)} chars)")
                if class_id not in talent_data:
                    talent_data[class_id] = {}
                talent_data[class_id][spec["index"]] = {
                    "talent_string": talent_string,
                    "player": player_name,
                }
            else:
                print("FAILED")

            time.sleep(random.uniform(2.0, 4.0))

        browser.close()

    # 통계
    total = sum(len(specs) for specs in talent_data.values())
    print(f"\n  Result: {total}/{len(player_urls)} talent strings collected")

    if total == 0:
        print("  ERROR: No talent strings collected!", file=sys.stderr)
        sys.exit(1)

    # Lua 파일 생성
    print(f"\n--- [3/3] Generating talent_data.lua ---")
    lua_content = generate_talent_lua(talent_data)

    if args.dry_run:
        print(lua_content[:500])
        print("...")
        print("\n  (dry-run: no file changes)")
        return

    TALENT_DATA_PATH.write_text(lua_content, encoding="utf-8")
    print(f"  Done! {TALENT_DATA_PATH}")


if __name__ == "__main__":
    main()
