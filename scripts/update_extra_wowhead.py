#!/usr/bin/env python3
"""
wowhead 한국어 가이드에서 장식/마법부여/보석 데이터를 수집하여
extra_data.lua를 생성합니다.

소스:
  - 장식: /guide/classes/{class}/{spec}/bis-gear
  - 마부/보석: /guide/classes/{class}/{spec}/enchants-gems-pve-{role}

사용법:
    python scripts/update_extra_wowhead.py
    python scripts/update_extra_wowhead.py --dry-run
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
from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
EXTRA_DATA_PATH = PROJECT_DIR / "extra_data.lua"

# ── 클래스/스펙 매핑 ──
CLASS_SPECS = {
    "DEATHKNIGHT": {
        "slug": "death-knight", "name": "죽음의 기사",
        "specs": [
            {"index": 1, "slug": "blood", "name": "혈기", "role": "tank"},
            {"index": 2, "slug": "frost", "name": "냉기", "role": "dps"},
            {"index": 3, "slug": "unholy", "name": "부정", "role": "dps"},
        ],
    },
    "DEMONHUNTER": {
        "slug": "demon-hunter", "name": "악마사냥꾼",
        "specs": [
            {"index": 1, "slug": "havoc", "name": "파멸", "role": "dps"},
            {"index": 2, "slug": "vengeance", "name": "복수", "role": "tank"},
        ],
    },
    "DRUID": {
        "slug": "druid", "name": "드루이드",
        "specs": [
            {"index": 1, "slug": "balance", "name": "조화", "role": "dps"},
            {"index": 2, "slug": "feral", "name": "야성", "role": "dps"},
            {"index": 3, "slug": "guardian", "name": "수호", "role": "tank"},
            {"index": 4, "slug": "restoration", "name": "회복", "role": "healer"},
        ],
    },
    "EVOKER": {
        "slug": "evoker", "name": "기원사",
        "specs": [
            {"index": 1, "slug": "devastation", "name": "황폐", "role": "dps"},
            {"index": 2, "slug": "preservation", "name": "보존", "role": "healer"},
            {"index": 3, "slug": "augmentation", "name": "증강", "role": "dps"},
        ],
    },
    "HUNTER": {
        "slug": "hunter", "name": "사냥꾼",
        "specs": [
            {"index": 1, "slug": "beast-mastery", "name": "야수", "role": "dps"},
            {"index": 2, "slug": "marksmanship", "name": "사격", "role": "dps"},
            {"index": 3, "slug": "survival", "name": "생존", "role": "dps"},
        ],
    },
    "MAGE": {
        "slug": "mage", "name": "마법사",
        "specs": [
            {"index": 1, "slug": "arcane", "name": "비전", "role": "dps"},
            {"index": 2, "slug": "fire", "name": "화염", "role": "dps"},
            {"index": 3, "slug": "frost", "name": "냉기", "role": "dps"},
        ],
    },
    "MONK": {
        "slug": "monk", "name": "수도사",
        "specs": [
            {"index": 1, "slug": "brewmaster", "name": "양조", "role": "tank"},
            {"index": 2, "slug": "mistweaver", "name": "안개", "role": "healer"},
            {"index": 3, "slug": "windwalker", "name": "풍운", "role": "dps"},
        ],
    },
    "PALADIN": {
        "slug": "paladin", "name": "성기사",
        "specs": [
            {"index": 1, "slug": "holy", "name": "신성", "role": "healer"},
            {"index": 2, "slug": "protection", "name": "보호", "role": "tank"},
            {"index": 3, "slug": "retribution", "name": "징벌", "role": "dps"},
        ],
    },
    "PRIEST": {
        "slug": "priest", "name": "사제",
        "specs": [
            {"index": 1, "slug": "discipline", "name": "수양", "role": "healer"},
            {"index": 2, "slug": "holy", "name": "신성", "role": "healer"},
            {"index": 3, "slug": "shadow", "name": "암흑", "role": "dps"},
        ],
    },
    "ROGUE": {
        "slug": "rogue", "name": "도적",
        "specs": [
            {"index": 1, "slug": "assassination", "name": "암살", "role": "dps"},
            {"index": 2, "slug": "outlaw", "name": "무법", "role": "dps"},
            {"index": 3, "slug": "subtlety", "name": "잠행", "role": "dps"},
        ],
    },
    "SHAMAN": {
        "slug": "shaman", "name": "주술사",
        "specs": [
            {"index": 1, "slug": "elemental", "name": "정기", "role": "dps"},
            {"index": 2, "slug": "enhancement", "name": "고양", "role": "dps"},
            {"index": 3, "slug": "restoration", "name": "복원", "role": "healer"},
        ],
    },
    "WARLOCK": {
        "slug": "warlock", "name": "흑마법사",
        "specs": [
            {"index": 1, "slug": "affliction", "name": "고통", "role": "dps"},
            {"index": 2, "slug": "demonology", "name": "악마", "role": "dps"},
            {"index": 3, "slug": "destruction", "name": "파괴", "role": "dps"},
        ],
    },
    "WARRIOR": {
        "slug": "warrior", "name": "전사",
        "specs": [
            {"index": 1, "slug": "arms", "name": "무기", "role": "dps"},
            {"index": 2, "slug": "fury", "name": "분노", "role": "dps"},
            {"index": 3, "slug": "protection", "name": "방어", "role": "tank"},
        ],
    },
}

# 슬롯 매핑 (wowhead 테이블 첫 번째 열)
SLOT_KEYWORDS = {
    "weapon": "무기", "무기": "무기",
    "helm": "머리", "head": "머리", "투구": "머리", "머리": "머리",
    "shoulder": "어깨", "shoulders": "어깨", "어깨": "어깨",
    "chest": "가슴", "가슴": "가슴",
    "leg": "다리", "legs": "다리", "다리": "다리",
    "boot": "발", "boots": "발", "feet": "발", "장화": "발", "발": "발",
    "ring": "반지", "rings": "반지", "반지": "반지",
    "back": "등", "cloak": "등", "cape": "등", "등": "등", "망토": "등",
    "wrist": "손목", "bracer": "손목", "손목": "손목",
    "hands": "손", "gloves": "손", "손": "손",
    "waist": "허리", "belt": "허리", "허리": "허리",
}

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:133.0) Gecko/20100101 Firefox/133.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0",
]


def make_headers() -> dict:
    return {
        "User-Agent": random.choice(USER_AGENTS),
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Sec-Fetch-Dest": "document",
        "Sec-Fetch-Mode": "navigate",
        "Sec-Fetch-Site": "none",
        "Sec-Fetch-User": "?1",
        "Cache-Control": "max-age=0",
    }


STAT_NAMES_EN_KO = {
    "intellect": "지능",
    "critical strike": "치명타",
    "crit": "치명타",
    "haste": "가속",
    "mastery": "특화",
    "versatility": "유연성",
}


def parse_stat_line(line: str) -> list:
    """스탯 우선순위 라인을 파싱합니다.
    예: 'Strength >> Crit >= Mastery >= Versatility >> Haste'
    → ['치명타', '특화', '유연성', '가속']
    """
    # >> >= > = 를 모두 구분자로 사용
    parts = re.split(r'\s*>{1,2}=?\s*|\s*>=\s*|\s*=\s*', line)
    stats = []
    for part in parts:
        part = part.strip().lower()
        for en, ko in STAT_NAMES_EN_KO.items():
            if en == part and ko not in stats:
                stats.append(ko)
                break
    # 주 스탯(지능/힘/민첩) 제외
    stats = [s for s in stats if s not in ("지능", "힘", "민첩")]
    return stats


def fetch_stat_priority_from_bis(page) -> list:
    """현재 로드된 BIS 페이지에서 스탯 우선순위를 추출합니다.
    장식 수집과 같은 페이지이므로 추가 요청 불필요.
    """
    text = page.inner_text("body")
    lines = text.split("\n")

    stat_words = ["Crit", "Haste", "Mastery", "Versatility"]

    for line in lines:
        line = line.strip()
        # ">" 포함 + 보조 스탯 이름 2개 이상 → 스탯 우선순위 라인
        if ">" in line and sum(1 for s in stat_words if s in line) >= 2:
            result = parse_stat_line(line)
            if len(result) >= 2:
                return result

    return []


def detect_slot(text: str) -> str:
    """텍스트에서 슬롯 이름을 추출합니다."""
    lower = text.lower().strip()
    for keyword, slot in SLOT_KEYWORDS.items():
        if keyword in lower:
            return slot
    return ""


# 알려진 장식 이름 → Optional Reagent ID
KNOWN_EMBELLISHMENTS = {
    "darkmoon sigil: hunt": {"name": "다크문 인장: 사냥", "id": 245876},
    "darkmoon sigil: void": {"name": "다크문 인장: 공허", "id": 245874},
    "darkmoon sigil: blood": {"name": "다크문 인장: 혈기", "id": 245872},
    "darkmoon sigil: rot": {"name": "다크문 인장: 부식", "id": 245878},
    "arcanoweave lining": {"name": "비전매듭 안감", "id": 240167},
    "sunfire silk lining": {"name": "태양불꽃 비단 안감", "id": 240165},
    "blessed pango charm": {"name": "축복받은 천산갑 부적", "id": 244604},
    "devouring banding": {"name": "포식의 결속끈", "id": 244675},
    "primal spore binding": {"name": "원시 포자 결속끈", "id": 244608},
    "prismatic focusing iris": {"name": "오색 집중의 눈동자", "id": 251488},
    "stabilizing gemstone bandolier": {"name": "안정화 보석 사선 주머니", "id": 251490},
    "root warden's regalia": {"name": "뿌리감시관의 예복", "id": 0},
    "loa worshiper's band": {"name": "로아 신봉자의 고리", "id": 251513},
    "knight commander's palisade": {"name": "기사단장의 방책", "id": 244472},
    "signet of azerothian blessings": {"name": "아제로스의 축복 인장", "id": 241140},
    # 한글 이름도 매핑
    "다크문 인장: 사냥": {"name": "다크문 인장: 사냥", "id": 245876},
    "다크문 인장: 공허": {"name": "다크문 인장: 공허", "id": 245874},
    "다크문 인장: 혈기": {"name": "다크문 인장: 혈기", "id": 245872},
    "다크문 인장: 부식": {"name": "다크문 인장: 부식", "id": 245878},
    "비전매듭 안감": {"name": "비전매듭 안감", "id": 240167},
    "태양불꽃 비단 안감": {"name": "태양불꽃 비단 안감", "id": 240165},
    "뿌리감시관의 예복": {"name": "뿌리감시관의 예복", "id": 0},
}


def fetch_embellishments(class_slug: str, spec_slug: str, page) -> list:
    """wowhead BIS 가이드에서 Playwright로 장식 데이터를 추출합니다."""
    url = f"https://www.wowhead.com/ko/guide/classes/{class_slug}/{spec_slug}/bis-gear"
    try:
        page.goto(url, wait_until="domcontentloaded", timeout=60000)
        page.wait_for_timeout(5000)
    except Exception as e:
        print(f" bis-err:{e}", end="", flush=True)
        return []

    html = page.content()
    soup = BeautifulSoup(html, "html.parser")
    items = []

    # 방법 1: "Best Embellishments" 헤딩 뒤 아이템 링크
    for h in soup.find_all(["h2", "h3", "h4"]):
        if "embellishment" in h.get_text(strip=True).lower():
            seen = set()
            el = h.next_element
            count = 0
            while el and count < 100:
                if hasattr(el, "name") and el.name == "a":
                    href = el.get("href", "")
                    m = re.search(r"item=(\d+)", href)
                    if m:
                        item_id = int(m.group(1))
                        name = el.get_text(strip=True)
                        if name and item_id > 0 and item_id not in seen:
                            seen.add(item_id)
                            items.append({"name": name, "id": item_id})
                            if len(items) >= 2:
                                break
                if hasattr(el, "name") and el.name in ["h2", "h3", "h4"] and el != h:
                    break
                el = el.next_element
                count += 1
            break

    # 방법 2: 아이템 링크로 못 찾으면 페이지 전체 텍스트에서 알려진 장식 이름 검색
    if len(items) < 2:
        page_text = soup.get_text(separator="\n").lower()
        seen_names = {i["name"].lower() for i in items}
        for key, info in KNOWN_EMBELLISHMENTS.items():
            if key in page_text and info["name"].lower() not in seen_names:
                items.append({"name": info["name"], "id": info["id"]})
                seen_names.add(info["name"].lower())
                if len(items) >= 2:
                    break

    return items[:2]


def fetch_enchants_gems(class_slug: str, spec_slug: str, role: str,
                        page) -> tuple[list, list]:
    """wowhead 마부/보석 가이드에서 Playwright로 데이터를 추출합니다."""
    url = f"https://www.wowhead.com/ko/guide/classes/{class_slug}/{spec_slug}/enchants-gems-pve-{role}"
    try:
        page.goto(url, wait_until="domcontentloaded", timeout=60000)
        page.wait_for_timeout(5000)
    except Exception as e:
        print(f" enc-err:{e}", end="", flush=True)
        return [], []

    html = page.content()
    soup = BeautifulSoup(html, "html.parser")

    enchants = []
    gems = []

    # 테이블에서 마부 추출
    tables = soup.find_all("table")
    for table in tables:
        rows = table.find_all("tr")
        for row in rows:
            cells = row.find_all(["td", "th"])
            if len(cells) < 2:
                continue

            cell_text = cells[0].get_text(strip=True)
            slot = detect_slot(cell_text)

            # 아이템 링크 찾기
            item_link = None
            for cell in cells[1:]:
                item_link = cell.find("a", href=re.compile(r"(item|spell)=\d+"))
                if item_link:
                    break

            if not item_link:
                continue

            href = item_link.get("href", "")
            m = re.search(r"(item|spell)=(\d+)", href)
            if not m:
                continue

            item_id = int(m.group(2))
            name = item_link.get_text(strip=True)
            if not name:
                continue

            if slot:
                enchants.append({"slot": slot, "name": name, "id": item_id})

    # 테이블 외 링크에서 보석 추출 (보석 섹션)
    # 보석은 보통 "다이아몬드", "석류석" 등의 키워드로 판별
    gem_keywords = ["diamond", "garnet", "peridot", "lapis", "amethyst", "ruby",
                    "sapphire", "emerald", "gem", "다이아몬드", "석류석", "감람석",
                    "청금석", "자수정", "보석", "blasphemite"]

    all_links = soup.find_all("a", href=re.compile(r"item=\d+"))
    seen_gems = set()
    for link in all_links:
        href = link.get("href", "")
        m = re.search(r"item=(\d+)", href)
        if not m:
            continue
        item_id = int(m.group(1))
        if item_id == 0 or item_id in seen_gems:
            continue

        name = link.get_text(strip=True)
        name_lower = name.lower()

        # 보석 판별
        is_gem = any(kw in name_lower for kw in gem_keywords)
        if not is_gem:
            # 주변 텍스트 확인
            parent = link.parent
            if parent:
                pt = parent.get_text(separator=" ", strip=True).lower()
                is_gem = any(kw in pt for kw in gem_keywords)

        if is_gem and name:
            seen_gems.add(item_id)
            gems.append({"name": name, "id": item_id})

    # 중복 제거 (enchants)
    seen_slots = set()
    unique_enchants = []
    for e in enchants:
        if e["slot"] not in seen_slots:
            seen_slots.add(e["slot"])
            unique_enchants.append(e)

    return unique_enchants, gems[:4]


def generate_extra_lua(data: dict) -> str:
    """extra_data.lua 내용을 생성합니다."""
    today = datetime.now().strftime("%Y-%m-%d")
    lines = [
        "-- extra_data.lua",
        "-- 장식 / 마법부여 / 보석 (wowhead 가이드 기준)",
        f"-- 업데이트: {today}",
        "",
        "ItemInfoExtraData = {}",
        "",
    ]

    for class_id, class_info in CLASS_SPECS.items():
        if class_id not in data:
            continue
        specs = data[class_id]
        if not specs:
            continue

        lines.append(f'ItemInfoExtraData["{class_id}"] = {{')

        for spec in class_info["specs"]:
            si = spec["index"]
            if si not in specs:
                continue

            d = specs[si]
            lines.append(f'    [{si}] = {{ -- {spec["name"]}')

            # 스탯
            stats = d.get("stats", [])
            stats_str = ", ".join(f'"{s}"' for s in stats)
            lines.append(f'        stats = {{{stats_str}}},')

            # 장식
            embel = d.get("embellishments", [])
            lines.append('        embellishments = {')
            for item in embel[:2]:
                lines.append(f'            {{name="{item["name"]}", id={item["id"]}}},')
            lines.append('        },')

            # 마법부여
            ench = d.get("enchantments", [])
            lines.append('        enchantments = {')
            for item in ench:
                slot = item.get("slot", "")
                lines.append(f'            {{slot="{slot}", name="{item["name"]}", id={item["id"]}}},')
            lines.append('        },')

            # 보석
            gem = d.get("gems", [])
            lines.append('        gems = {')
            for item in gem:
                lines.append(f'            {{name="{item["name"]}", id={item["id"]}}},')
            lines.append('        },')

            lines.append('    },')

        lines.append('}')
        lines.append("")

    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="wowhead enchants/gems/embellishments scraper")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    print("--- Collecting enchants/gems/embellishments from wowhead ---")

    data: dict = {}
    total_specs = sum(len(c["specs"]) for c in CLASS_SPECS.values())
    count = 0

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        for class_id, class_info in CLASS_SPECS.items():
            data[class_id] = {}

            for spec in class_info["specs"]:
                count += 1
                label = f"{class_info['name']} {spec['name']}"
                print(f"  [{count}/{total_specs}] {label}...", end=" ", flush=True)

                # 장식 + 스탯 (BIS 가이드 — 같은 페이지)
                embels = fetch_embellishments(class_info["slug"], spec["slug"], page)
                stats = fetch_stat_priority_from_bis(page)  # 이미 로드된 페이지 재사용
                time.sleep(random.uniform(4, 7))

                # 마부/보석 (enchants-gems 가이드)
                enchants, gems = fetch_enchants_gems(
                    class_info["slug"], spec["slug"], spec["role"], page
                )
                time.sleep(random.uniform(4, 7))

                data[class_id][spec["index"]] = {
                    "stats": stats,
                    "embellishments": embels,
                    "enchantments": enchants,
                    "gems": gems,
                }

                s_count = len(stats)
                e_count = len(embels)
                n_count = len(enchants)
                g_count = len(gems)
                print(f"ok (스탯:{s_count} 장식:{e_count} 마부:{n_count} 보석:{g_count})")

        browser.close()

    # 생성
    lua_content = generate_extra_lua(data)

    if args.dry_run:
        print(lua_content[:1000])
        print("...")
        print("(dry-run)")
        return

    EXTRA_DATA_PATH.write_text(lua_content, encoding="utf-8")
    print(f"\nDone! {EXTRA_DATA_PATH}")


if __name__ == "__main__":
    main()
