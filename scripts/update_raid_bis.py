#!/usr/bin/env python3
"""
wowhead 한국어 BIS 가이드에서 레이드 BIS 데이터를 수집하여
bis_data.lua의 raid 섹션을 업데이트합니다.

사용법:
    python scripts/update_raid_bis.py              # 레이드 데이터 수집
    python scripts/update_raid_bis.py --dry-run    # 미리보기 (파일 수정 안 함)
"""

from __future__ import annotations

import argparse
import random
import re
import sys
import time
from pathlib import Path

import requests
from bs4 import BeautifulSoup

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
BIS_DATA_PATH = PROJECT_DIR / "bis_data.lua"
SOURCES_PATH = PROJECT_DIR / "item_sources.lua"

# ── 클래스/스펙 매핑 (wowhead slug) ──
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

# 슬롯 이름 → WoW 슬롯 ID (영문/한글 모두 대응)
SLOT_MAP = {
    "head": 1, "helm": 1, "머리": 1,
    "neck": 2, "necklace": 2, "목": 2, "목걸이": 2,
    "shoulder": 3, "shoulders": 3, "어깨": 3,
    "back": 15, "cape": 15, "cloak": 15, "등": 15, "망토": 15,
    "chest": 5, "robe": 5, "가슴": 5,
    "wrist": 9, "bracer": 9, "bracers": 9, "손목": 9,
    "hands": 10, "gloves": 10, "손": 10,
    "waist": 6, "belt": 6, "허리": 6,
    "legs": 7, "leggings": 7, "다리": 7,
    "feet": 8, "boots": 8, "발": 8,
    "ring": 11, "ring 1": 11, "ring 2": 12, "반지": 11, "반지 1": 11, "반지 2": 12,
    "trinket": 13, "trinket 1": 13, "trinket 2": 14, "장신구": 13, "장신구 1": 13, "장신구 2": 14,
    "main hand": 16, "mainhand": 16, "weapon": 16, "1h weapon": 16, "2h weapon": 16, "주무기": 16,
    "off hand": 17, "offhand": 17, "shield": 17, "보조무기": 17,
}

# 기본 보너스 ID (영웅 난이도)
DEFAULT_BONUS_IDS = [12806, 13335]

# ── 봇 차단 방어 ──
USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15",
]

# 소스 텍스트 → 한글 변환
SOURCE_MAP = {
    # 레이드 보스
    "Vanguard of the Blinding Light": "레이드 - 빛에 눈이 먼 선봉대",
    "Lightblinded Vanguard": "레이드 - 빛에 눈이 먼 선봉대",
    "Fallen King Saladaar": "레이드 - 몰락한 왕 살라다르",
    "Ky'meros": "레이드 - 카이메루스",
    "Chimaerus": "레이드 - 카이메루스",
    "Vorasius": "레이드 - 보라시우스",
    "Archdespot Aberzian": "레이드 - 전제군주 아베르지안",
    "Bael'gor and Ezorak": "레이드 - 바엘고어와 에조라크",
    "Vaelgor & Ezzorak": "레이드 - 바엘고어와 에조라크",
    "Belo'ren, Spawn of Alar": "레이드 - 알라르의 자손 벨로렌",
    "Belo'ren": "레이드 - 알라르의 자손 벨로렌",
    "Midnight Falls": "레이드 - 한밤의 도래",
    "Fall of the Midnight": "레이드 - 한밤의 도래",
    "Crown of the Cosmos": "레이드 - 우주의 왕관",
    "Vexie and the Geargrinders": "레이드 - 벡시와 기어그라인더",
    "Sprocketmonger Lockenstock": "레이드 - 스프로켓몽거 로큰스톡",
    "The One-Armed Bandit": "레이드 - 외팔이 도적",
    "Cauldron of Carnage": "레이드 - 학살의 가마솥",
    "Stix Bunkjunker": "레이드 - 스틱스 벙크정커",
    "Mug'Zee, Heads of Security": "레이드 - 머그지, 보안 책임자",
    "Gallywix": "레이드 - 갈리윅스",
    "Chrome King Gallywix": "레이드 - 크롬왕 갈리윅스",
    # 던전
    "Pit of Saron": "던전 - 사론의 구덩이",
    "Seat of the Triumvirate": "던전 - 승리자의 자리",
    "Algeth'ar Academy": "던전 - 알게타르 아카데미",
    "Operation: Floodgate": "던전 - 작전: 방수로",
    "The Rookery": "던전 - 바람매 첨탑",
    "The Botanica": "던전 - 마법학자의 정원",
    "Magister's Terrace": "던전 - 마법학자의 정원",
    "Mycelial Caverns": "던전 - 마이사라 동굴",
    "Maisara Caverns": "던전 - 마이사라 동굴",
    "Fungal Folly": "던전 - 균류 소동",
    "Skyreach": "던전 - 하늘매",
    "Windrunner Spire": "던전 - 바람매 첨탑",
    "Nexus-Princess Ky'veza's Gambit": "던전 - 연결점 제나스",
    "Nexus Point Xenas": "던전 - 연결점 제나스",
    "Nexus-Point Xenas": "던전 - 연결점 제나스",
    # 보스 (잘못 영문으로 들어간 케이스)
    "Imperator Averzian": "레이드 - 전제군주 아베르지안",
    "Salhadaar": "레이드 - 몰락한 왕 살라다르",
    "Fallen-King Salhadaar": "레이드 - 몰락한 왕 살라다르",
    "Imperatrix Mecha": "레이드 - 임페라트릭스 메카",
    # Tier Set 등 그룹 표시
    "Tier Set": "Tier Set",
    "Fallen-King Salhadaar(Tier Set)": "레이드 - 몰락한 왕 살라다르",
    # 기타
    "Catalyst": "행렬 촉매",
    "Revival Catalyst": "행렬 촉매",
    "Crafted": "제작",
    "Craft": "제작",
    "Delve": "구렁",
    "The Abyss": "구렁",
    "Vault": "금고",
}


def make_headers() -> dict:
    """랜덤 User-Agent로 브라우저 헤더를 생성합니다."""
    return {
        "User-Agent": random.choice(USER_AGENTS),
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
        "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Sec-Fetch-Dest": "document",
        "Sec-Fetch-Mode": "navigate",
        "Sec-Fetch-Site": "none",
        "Sec-Fetch-User": "?1",
        "Upgrade-Insecure-Requests": "1",
        "Cache-Control": "max-age=0",
    }


def parse_source_text(raw: str) -> str:
    """wowhead 소스 텍스트를 한글 획득처로 변환합니다."""
    raw = raw.strip()
    if not raw:
        return ""

    # "Boss Name (Raid)" 패턴
    raw_clean = re.sub(r"\s*\(Raid\)", "", raw, flags=re.IGNORECASE).strip()

    # "Raid | Catalyst | Vault" → 복합 소스
    parts = [p.strip() for p in raw_clean.split("|")]

    sources = []
    for part in parts:
        matched = False
        for en, ko in SOURCE_MAP.items():
            if en.lower() in part.lower():
                if ko not in sources:
                    sources.append(ko)
                matched = True
                break
        if not matched and part:
            # 매칭 안 되면 원문 그대로
            if part not in sources:
                sources.append(part)

    return " / ".join(sources) if sources else raw


def fetch_spec_raid_bis(class_slug: str, spec_slug: str, page) -> dict:
    """wowhead에서 특정 스펙의 레이드 BIS 데이터를 가져옵니다 (Playwright).

    Returns: {slot_id: (item_id, source_str)}
    """
    url = f"https://www.wowhead.com/ko/guide/classes/{class_slug}/{spec_slug}/bis-gear"

    try:
        page.goto(url, wait_until="domcontentloaded", timeout=60000)
        page.wait_for_timeout(5000)
        html = page.content()
    except Exception as e:
        print(f"  x {e}", file=sys.stderr)
        return {}

    soup = BeautifulSoup(html, "html.parser")

    slots = {}

    # 테이블에서 아이템 추출
    tables = soup.find_all("table")
    for table in tables:
        rows = table.find_all("tr")
        for row in rows:
            cells = row.find_all(["td", "th"])
            if len(cells) < 2:
                continue

            # 첫 번째 셀: 슬롯 이름
            slot_text = cells[0].get_text(strip=True).lower()
            slot_id = SLOT_MAP.get(slot_text)
            if slot_id is None:
                for key, sid in SLOT_MAP.items():
                    if key in slot_text:
                        slot_id = sid
                        break
            if slot_id is None:
                continue

            # 행 전체에서 아이템 링크 찾기 (빈 셀이 끼어있을 수 있음)
            item_link = row.find("a", href=re.compile(r"item=\d+"))
            if not item_link:
                continue

            item_match = re.search(r"item=(\d+)", item_link["href"])
            if not item_match:
                continue
            item_id = int(item_match.group(1))

            # 마지막 셀: 소스
            source = ""
            last_cell = cells[-1]
            source = parse_source_text(last_cell.get_text(strip=True))

            # Ring/Trinket 복수 슬롯 처리
            if slot_id in (11, 13) and slot_id in slots:
                slot_id += 1  # 11→12, 13→14

            if slot_id not in slots:
                slots[slot_id] = (item_id, source)

    # 테이블이 없으면 wowhead 링크 기반 폴백
    if not slots:
        all_links = soup.find_all("a", href=re.compile(r"item=\d+"))
        headings = soup.find_all(["h2", "h3", "h4"])

        for heading in headings:
            text = heading.get_text(strip=True).lower()
            slot_id = SLOT_MAP.get(text)
            if slot_id is None:
                for key, sid in SLOT_MAP.items():
                    if key in text:
                        slot_id = sid
                        break
            if slot_id is None:
                continue

            # 헤딩 이후 첫 번째 아이템 링크
            next_el = heading.find_next("a", href=re.compile(r"item=\d+"))
            if next_el:
                m = re.search(r"item=(\d+)", next_el["href"])
                if m and slot_id not in slots:
                    slots[slot_id] = (int(m.group(1)), "")

    return slots


def load_existing_sources() -> dict[int, str]:
    """item_sources.lua에서 기존 소스 캐시를 로드합니다."""
    if not SOURCES_PATH.exists():
        return {}
    content = SOURCES_PATH.read_text(encoding="utf-8")
    sources = {}
    for m in re.finditer(r'\[(\d+)\]\s*=\s*"([^"]*)"', content):
        sources[int(m.group(1))] = m.group(2)
    return sources


def generate_raid_lua(raid_data: dict) -> str:
    """레이드 데이터를 Lua 코드 문자열로 생성합니다."""
    lines = []
    lines.append('ItemInfoBISData["raid"] = {')

    source_cache = load_existing_sources()

    for class_id, class_info in CLASS_SPECS.items():
        class_name = class_info["name"]
        spec_names = ", ".join(
            f'{s["index"]}={s["name"]}' for s in class_info["specs"]
        )
        lines.append(f"    -- {'=' * 57}")
        lines.append(f"    -- {class_name} ({class_id})  {spec_names}")
        lines.append(f"    -- {'=' * 57}")

        if class_id not in raid_data:
            lines.append(f'    ["{class_id}"] = {{}},')
            continue

        lines.append(f'    ["{class_id}"] = {{')

        for spec in class_info["specs"]:
            idx = spec["index"]
            name = spec["name"]

            if idx not in raid_data[class_id]:
                continue

            lines.append(f"        [{idx}] = {{ -- {name}")

            slot_data = raid_data[class_id][idx]
            for slot_id in sorted(slot_data.keys()):
                item_id, source = slot_data[slot_id]
                bonus_str = ", ".join(str(b) for b in DEFAULT_BONUS_IDS)

                # 소스가 비어있으면 캐시에서 가져오기
                if not source and item_id in source_cache:
                    source = source_cache[item_id]

                lines.append(
                    f'            [{slot_id}]={{{item_id}, {{{bonus_str}}}, "{source}"}},'
                )

            lines.append("        },")

        lines.append("    },")

    lines.append("}")
    return "\n".join(lines)


def update_bis_data_raid_section(new_raid_lua: str):
    """bis_data.lua의 raid 섹션만 교체합니다."""
    content = BIS_DATA_PATH.read_text(encoding="utf-8")

    # raid 섹션 찾기
    raid_start = content.find('ItemInfoBISData["raid"]')
    if raid_start == -1:
        # 없으면 파일 끝에 추가
        content = content.rstrip() + "\n\n" + new_raid_lua + "\n"
    else:
        # 기존 raid 섹션의 끝 찾기 (brace counting)
        brace_pos = content.find("{", raid_start)
        depth = 0
        end_pos = brace_pos
        for i in range(brace_pos, len(content)):
            if content[i] == "{":
                depth += 1
            elif content[i] == "}":
                depth -= 1
                if depth == 0:
                    end_pos = i + 1
                    break

        content = content[:raid_start] + new_raid_lua + content[end_pos:]

    BIS_DATA_PATH.write_text(content, encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description="wowhead BIS guide raid data scraper")
    parser.add_argument("--dry-run", action="store_true", help="Preview only")
    args = parser.parse_args()

    print("--- [1/3] wowhead raid BIS data collection (Playwright) ---")

    from playwright.sync_api import sync_playwright

    raid_data: dict[str, dict[int, dict[int, tuple]]] = {}
    total_specs = sum(len(c["specs"]) for c in CLASS_SPECS.values())
    count = 0
    fail_count = 0

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        for class_id, class_info in CLASS_SPECS.items():
            raid_data[class_id] = {}

            for spec in class_info["specs"]:
                count += 1
                label = f"{class_info['name']} - {spec['name']}"
                print(f"  [{count}/{total_specs}] {label}...", end=" ", flush=True)

                slots = fetch_spec_raid_bis(class_info["slug"], spec["slug"], page)
                if slots:
                    raid_data[class_id][spec["index"]] = slots
                    print(f"ok {len(slots)} slots")
                else:
                    print("EMPTY")
                    fail_count += 1

                # 랜덤 딜레이 (3~5초)
                time.sleep(random.uniform(3, 5))

        browser.close()

    # 통계
    total_items = sum(
        len(slots)
        for specs in raid_data.values()
        for slots in specs.values()
    )
    success_specs = total_specs - fail_count
    print(f"\n  Result: {success_specs}/{total_specs} specs, {total_items} items")

    if total_items == 0:
        print("  ERROR: No data collected!", file=sys.stderr)
        sys.exit(1)

    # Lua 생성
    print("\n--- [2/3] Generating raid Lua ---")
    raid_lua = generate_raid_lua(raid_data)
    print(f"  {len(raid_lua)} chars generated")

    if args.dry_run:
        print("\n--- Preview (first 50 lines) ---")
        for line in raid_lua.split("\n")[:50]:
            print(f"  {line}")
        print("  ...")
        print("\n  (dry-run: no file changes)")
        return

    # bis_data.lua 업데이트
    print("\n--- [3/3] Updating bis_data.lua raid section ---")
    update_bis_data_raid_section(raid_lua)
    print("  Done!")

    if fail_count > 0:
        print(f"\n  WARNING: {fail_count} specs failed. Re-run to retry.")


if __name__ == "__main__":
    main()
