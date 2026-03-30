#!/usr/bin/env python3
"""
wowhead에서 장식 데이터를 수집하여 extra_data.lua에 병합합니다.
archon.gg 데이터(스탯/마부/보석)는 유지하고 embellishments만 채웁니다.

사용법:
    python scripts/merge_embellishments.py
"""

from __future__ import annotations

import json
import random
import re
import sys
import time
from pathlib import Path

from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

PROJECT_DIR = Path(__file__).parent.parent
EXTRA_DATA_PATH = PROJECT_DIR / "extra_data.lua"

CLASS_SPECS = [
    ("death-knight", "blood"), ("death-knight", "frost"), ("death-knight", "unholy"),
    ("demon-hunter", "havoc"), ("demon-hunter", "vengeance"),
    ("druid", "balance"), ("druid", "feral"), ("druid", "guardian"), ("druid", "restoration"),
    ("evoker", "devastation"), ("evoker", "preservation"), ("evoker", "augmentation"),
    ("hunter", "beast-mastery"), ("hunter", "marksmanship"), ("hunter", "survival"),
    ("mage", "arcane"), ("mage", "fire"), ("mage", "frost"),
    ("monk", "brewmaster"), ("monk", "mistweaver"), ("monk", "windwalker"),
    ("paladin", "holy"), ("paladin", "protection"), ("paladin", "retribution"),
    ("priest", "discipline"), ("priest", "holy"), ("priest", "shadow"),
    ("rogue", "assassination"), ("rogue", "outlaw"), ("rogue", "subtlety"),
    ("shaman", "elemental"), ("shaman", "enhancement"), ("shaman", "restoration"),
    ("warlock", "affliction"), ("warlock", "demonology"), ("warlock", "destruction"),
    ("warrior", "arms"), ("warrior", "fury"), ("warrior", "protection"),
]

SLUG_TO_KEY = {
    "death-knight/blood": ("DEATHKNIGHT", 1), "death-knight/frost": ("DEATHKNIGHT", 2),
    "death-knight/unholy": ("DEATHKNIGHT", 3), "demon-hunter/havoc": ("DEMONHUNTER", 1),
    "demon-hunter/vengeance": ("DEMONHUNTER", 2), "druid/balance": ("DRUID", 1),
    "druid/feral": ("DRUID", 2), "druid/guardian": ("DRUID", 3),
    "druid/restoration": ("DRUID", 4), "evoker/devastation": ("EVOKER", 1),
    "evoker/preservation": ("EVOKER", 2), "evoker/augmentation": ("EVOKER", 3),
    "hunter/beast-mastery": ("HUNTER", 1), "hunter/marksmanship": ("HUNTER", 2),
    "hunter/survival": ("HUNTER", 3), "mage/arcane": ("MAGE", 1),
    "mage/fire": ("MAGE", 2), "mage/frost": ("MAGE", 3),
    "monk/brewmaster": ("MONK", 1), "monk/mistweaver": ("MONK", 2),
    "monk/windwalker": ("MONK", 3), "paladin/holy": ("PALADIN", 1),
    "paladin/protection": ("PALADIN", 2), "paladin/retribution": ("PALADIN", 3),
    "priest/discipline": ("PRIEST", 1), "priest/holy": ("PRIEST", 2),
    "priest/shadow": ("PRIEST", 3), "rogue/assassination": ("ROGUE", 1),
    "rogue/outlaw": ("ROGUE", 2), "rogue/subtlety": ("ROGUE", 3),
    "shaman/elemental": ("SHAMAN", 1), "shaman/enhancement": ("SHAMAN", 2),
    "shaman/restoration": ("SHAMAN", 3), "warlock/affliction": ("WARLOCK", 1),
    "warlock/demonology": ("WARLOCK", 2), "warlock/destruction": ("WARLOCK", 3),
    "warrior/arms": ("WARRIOR", 1), "warrior/fury": ("WARRIOR", 2),
    "warrior/protection": ("WARRIOR", 3),
}

KNOWN_EMBELLISHMENTS = {
    "darkmoon sigil: hunt": {"name": "다크문 인장: 사냥", "id": 245876},
    "darkmoon sigil: void": {"name": "다크문 인장: 공허", "id": 245874},
    "darkmoon sigil: blood": {"name": "다크문 인장: 혈기", "id": 245872},
    "darkmoon sigil: rot": {"name": "다크문 인장: 부식", "id": 245878},
    "arcanoweave lining": {"name": "비전매듭 안감", "id": 240167},
    "sunfire silk lining": {"name": "태양불꽃 비단 안감", "id": 240165},
    "root warden's regalia": {"name": "뿌리감시관의 예복", "id": 0},
    "loa worshiper's band": {"name": "로아 신봉자의 고리", "id": 251513},
    "knight commander's palisade": {"name": "기사단장의 방책", "id": 244472},
    "blessed pango charm": {"name": "축복받은 천산갑 부적", "id": 244604},
    "devouring banding": {"name": "포식의 결속끈", "id": 244675},
    "primal spore binding": {"name": "원시 포자 결속끈", "id": 244608},
    "prismatic focusing iris": {"name": "오색 집중의 눈동자", "id": 251488},
    "stabilizing gemstone bandolier": {"name": "안정화 보석 사선 주머니", "id": 251490},
    "signet of azerothian blessings": {"name": "아제로스의 축복 인장", "id": 241140},
    # Korean names
    "다크문 인장: 사냥": {"name": "다크문 인장: 사냥", "id": 245876},
    "다크문 인장: 공허": {"name": "다크문 인장: 공허", "id": 245874},
    "비전매듭 안감": {"name": "비전매듭 안감", "id": 240167},
    "뿌리감시관의 예복": {"name": "뿌리감시관의 예복", "id": 0},
}


def fetch_embellishments(cls: str, spec: str, page) -> list:
    url = f"https://www.wowhead.com/ko/guide/classes/{cls}/{spec}/bis-gear"
    try:
        page.goto(url, wait_until="domcontentloaded", timeout=60000)
        page.wait_for_timeout(4000)
    except Exception as e:
        print(f"err:{e}", end="")
        return []

    html = page.content()
    soup = BeautifulSoup(html, "html.parser")
    items = []

    # Method 1: heading + item links
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

    # Method 2: text fallback
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


def merge_into_extra_data(embel_data: dict):
    content = EXTRA_DATA_PATH.read_text(encoding="utf-8")
    lines = content.split("\n")

    # Build position map: line_number -> (class_id, spec_idx)
    current_class = None
    current_spec = None
    embel_positions = {}  # line_number -> key

    for i, line in enumerate(lines):
        m = re.search(r'ItemInfoExtraData\["(\w+)"\]', line)
        if m:
            current_class = m.group(1)
        m = re.search(r'\[(\d+)\] = \{ --', line)
        if m:
            current_spec = int(m.group(1))
        if "embellishments = {" in line:
            key = f"{current_class}/{current_spec}"
            embel_positions[i] = key

    # Rebuild lines, inserting embellishment data
    new_lines = []
    i = 0
    while i < len(lines):
        new_lines.append(lines[i])

        if i in embel_positions:
            key = embel_positions[i]
            # Skip existing content until closing },
            i += 1
            while i < len(lines) and "        }," not in lines[i]:
                i += 1

            # Insert embellishment items
            if key in embel_data and embel_data[key]:
                for item in embel_data[key]:
                    new_lines.append(f'            {{name="{item["name"]}", id={item["id"]}}},')

            # Add closing },
            if i < len(lines):
                new_lines.append(lines[i])

        i += 1

    EXTRA_DATA_PATH.write_text("\n".join(new_lines), encoding="utf-8")

    # Save cache for debugging
    cache_path = PROJECT_DIR / "_embel_cache.json"
    import json
    cache_path.write_text(json.dumps(embel_data, ensure_ascii=False, indent=2), encoding="utf-8")


def main():
    print("--- Collecting embellishments from wowhead ---")

    embel_data = {}

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        for i, (cls, spec) in enumerate(CLASS_SPECS):
            slug = f"{cls}/{spec}"
            class_id, si = SLUG_TO_KEY[slug]
            key = f"{class_id}/{si}"
            print(f"  [{i+1}/{len(CLASS_SPECS)}] {cls}/{spec}...", end=" ", flush=True)

            items = fetch_embellishments(cls, spec, page)
            embel_data[key] = items
            print(f"{len(items)}")
            time.sleep(random.uniform(3, 5))

        browser.close()

    print(f"\nMerging into {EXTRA_DATA_PATH}...")
    merge_into_extra_data(embel_data)
    print("Done!")


if __name__ == "__main__":
    main()
