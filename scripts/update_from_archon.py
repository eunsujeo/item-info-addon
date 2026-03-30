#!/usr/bin/env python3
"""
archon.gg에서 스탯/장식/마법부여/보석 데이터를 수집하여
extra_data.lua를 생성합니다.

archon.gg는 Next.js 기반으로 __NEXT_DATA__ JSON에 모든 데이터가 포함되어
Playwright 없이 requests만으로 수집 가능합니다.

사용법:
    python scripts/update_from_archon.py
    python scripts/update_from_archon.py --dry-run
"""

from __future__ import annotations

import argparse
import json
import random
import re
import sys
import time
from datetime import datetime
from pathlib import Path

import requests

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
EXTRA_DATA_PATH = PROJECT_DIR / "extra_data.lua"

# ── 클래스/스펙 매핑 (archon.gg URL slug) ──
CLASS_SPECS = {
    "DEATHKNIGHT": {
        "name": "죽음의 기사",
        "specs": [
            {"index": 1, "slug": "blood/death-knight", "name": "혈기"},
            {"index": 2, "slug": "frost/death-knight", "name": "냉기"},
            {"index": 3, "slug": "unholy/death-knight", "name": "부정"},
        ],
    },
    "DEMONHUNTER": {
        "name": "악마사냥꾼",
        "specs": [
            {"index": 1, "slug": "havoc/demon-hunter", "name": "파멸"},
            {"index": 2, "slug": "vengeance/demon-hunter", "name": "복수"},
        ],
    },
    "DRUID": {
        "name": "드루이드",
        "specs": [
            {"index": 1, "slug": "balance/druid", "name": "조화"},
            {"index": 2, "slug": "feral/druid", "name": "야성"},
            {"index": 3, "slug": "guardian/druid", "name": "수호"},
            {"index": 4, "slug": "restoration/druid", "name": "회복"},
        ],
    },
    "EVOKER": {
        "name": "기원사",
        "specs": [
            {"index": 1, "slug": "devastation/evoker", "name": "황폐"},
            {"index": 2, "slug": "preservation/evoker", "name": "보존"},
            {"index": 3, "slug": "augmentation/evoker", "name": "증강"},
        ],
    },
    "HUNTER": {
        "name": "사냥꾼",
        "specs": [
            {"index": 1, "slug": "beast-mastery/hunter", "name": "야수"},
            {"index": 2, "slug": "marksmanship/hunter", "name": "사격"},
            {"index": 3, "slug": "survival/hunter", "name": "생존"},
        ],
    },
    "MAGE": {
        "name": "마법사",
        "specs": [
            {"index": 1, "slug": "arcane/mage", "name": "비전"},
            {"index": 2, "slug": "fire/mage", "name": "화염"},
            {"index": 3, "slug": "frost/mage", "name": "냉기"},
        ],
    },
    "MONK": {
        "name": "수도사",
        "specs": [
            {"index": 1, "slug": "brewmaster/monk", "name": "양조"},
            {"index": 2, "slug": "mistweaver/monk", "name": "안개"},
            {"index": 3, "slug": "windwalker/monk", "name": "풍운"},
        ],
    },
    "PALADIN": {
        "name": "성기사",
        "specs": [
            {"index": 1, "slug": "holy/paladin", "name": "신성"},
            {"index": 2, "slug": "protection/paladin", "name": "보호"},
            {"index": 3, "slug": "retribution/paladin", "name": "징벌"},
        ],
    },
    "PRIEST": {
        "name": "사제",
        "specs": [
            {"index": 1, "slug": "discipline/priest", "name": "수양"},
            {"index": 2, "slug": "holy/priest", "name": "신성"},
            {"index": 3, "slug": "shadow/priest", "name": "암흑"},
        ],
    },
    "ROGUE": {
        "name": "도적",
        "specs": [
            {"index": 1, "slug": "assassination/rogue", "name": "암살"},
            {"index": 2, "slug": "outlaw/rogue", "name": "무법"},
            {"index": 3, "slug": "subtlety/rogue", "name": "잠행"},
        ],
    },
    "SHAMAN": {
        "name": "주술사",
        "specs": [
            {"index": 1, "slug": "elemental/shaman", "name": "정기"},
            {"index": 2, "slug": "enhancement/shaman", "name": "고양"},
            {"index": 3, "slug": "restoration/shaman", "name": "복원"},
        ],
    },
    "WARLOCK": {
        "name": "흑마법사",
        "specs": [
            {"index": 1, "slug": "affliction/warlock", "name": "고통"},
            {"index": 2, "slug": "demonology/warlock", "name": "악마"},
            {"index": 3, "slug": "destruction/warlock", "name": "파괴"},
        ],
    },
    "WARRIOR": {
        "name": "전사",
        "specs": [
            {"index": 1, "slug": "arms/warrior", "name": "무기"},
            {"index": 2, "slug": "fury/warrior", "name": "분노"},
            {"index": 3, "slug": "protection/warrior", "name": "방어"},
        ],
    },
}

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml",
    "Accept-Language": "en-US,en;q=0.9",
}

STAT_KO = {
    "Haste": "가속",
    "Mastery": "특화",
    "Critical Strike": "치명타",
    "Crit": "치명타",
    "Versatility": "유연성",
    "Vers": "유연성",
}

# 장비 슬롯 → 한글
SLOT_KO = {
    "Head": "머리", "Neck": "목", "Shoulders": "어깨", "Back": "등",
    "Chest": "가슴", "Wrists": "손목", "Hands": "손", "Waist": "허리",
    "Legs": "다리", "Feet": "발", "Finger": "반지", "Trinket": "장신구",
    "Main Hand": "주무기", "Off Hand": "보조무기",
}


def fetch_archon_data(spec_slug: str) -> dict | None:
    """archon.gg에서 __NEXT_DATA__ JSON을 추출합니다."""
    url = f"https://www.archon.gg/wow/builds/{spec_slug}/mythic-plus/overview/10/all-dungeons/this-week"
    try:
        resp = requests.get(url, headers=HEADERS, timeout=20)
        resp.raise_for_status()
    except requests.RequestException as e:
        print(f"err:{e}", end="", flush=True)
        return None

    m = re.search(
        r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>',
        resp.text, re.DOTALL,
    )
    if not m:
        return None

    try:
        return json.loads(m.group(1))
    except json.JSONDecodeError:
        return None


def parse_stats(sections: list) -> list:
    """BuildsStatPrioritySection에서 스탯 우선순위를 추출합니다."""
    for sec in sections:
        if sec["component"] == "BuildsStatPrioritySection":
            stats_raw = sec["props"].get("stats", [])
            # order 기준 정렬, 주 스탯(order=1) 제외
            secondary = [s for s in stats_raw if s.get("order", 0) > 1]
            secondary.sort(key=lambda s: s.get("order", 99))
            result = []
            for s in secondary:
                name = s.get("name", "")
                ko = STAT_KO.get(name, name)
                if ko and ko not in result:
                    result.append(ko)
            return result
    return []


def parse_gear_icon(icon_str: str) -> dict:
    """GearIcon 문자열에서 아이템 ID, 이름, 인챈트, 보석을 추출합니다."""
    result = {"id": 0, "name": "", "enchants": [], "gems": []}

    # 아이템 ID
    m = re.search(r"id=\{(\d+)\}", icon_str)
    if m:
        result["id"] = int(m.group(1))

    # 아이템 이름 (태그 끝의 텍스트)
    m = re.search(r">([^<]+)</GearIcon>", icon_str)
    if m:
        result["name"] = m.group(1).strip()

    # 인챈트
    enchants_m = re.search(r"enchants=\{(\[.*?\])\}", icon_str, re.DOTALL)
    if enchants_m:
        try:
            enchants = json.loads(enchants_m.group(1).replace("\\\"", "\""))
            for e in enchants:
                result["enchants"].append({"id": e.get("id", 0), "name": e.get("name", "")})
        except json.JSONDecodeError:
            pass

    # 보석
    gems_m = re.search(r"gems=\{(\[.*?\])\}", icon_str, re.DOTALL)
    if gems_m:
        try:
            gems = json.loads(gems_m.group(1).replace("\\\"", "\""))
            for g in gems:
                result["gems"].append({"id": g.get("id", 0), "name": g.get("name", "")})
        except json.JSONDecodeError:
            pass

    return result


def parse_gear_enchants_gems(sections: list) -> tuple[list, list]:
    """BuildsBestInSlotGearSection에서 마법부여와 보석을 추출합니다."""
    enchants = []
    gems = []
    seen_enchant_ids = set()
    seen_gem_ids = set()

    for sec in sections:
        if sec["component"] != "BuildsBestInSlotGearSection":
            continue

        all_items = sec["props"].get("gear", []) + sec["props"].get("weapons", [])

        # 슬롯 이름 목록 (gear 순서)
        slot_names = ["머리", "목", "어깨", "등", "가슴", "손목", "손", "허리", "다리", "발", "반지", "반지"]

        for i, item in enumerate(all_items):
            icon_str = item.get("icon", "")
            parsed = parse_gear_icon(icon_str)

            slot = slot_names[i] if i < len(slot_names) else "무기"

            for e in parsed["enchants"]:
                if e["id"] and e["id"] not in seen_enchant_ids:
                    seen_enchant_ids.add(e["id"])
                    enchants.append({"slot": slot, "name": e["name"], "id": e["id"]})

            for g in parsed["gems"]:
                if g["id"] and g["id"] not in seen_gem_ids:
                    seen_gem_ids.add(g["id"])
                    gems.append({"name": g["name"], "id": g["id"]})

    return enchants, gems


def parse_embellishments(sections: list) -> list:
    """장비 목록에서 장식 아이템을 추출합니다.
    archon.gg에서는 별도 섹션이 없으므로 crafted/embellishment 아이템을 식별합니다.
    """
    # TODO: archon.gg 장식 데이터 추출 개선
    # 현재는 wowhead 데이터를 유지하거나 별도 처리 필요
    return []


def generate_extra_lua(data: dict) -> str:
    """extra_data.lua 내용을 생성합니다."""
    today = datetime.now().strftime("%Y-%m-%d")
    lines = [
        "-- extra_data.lua",
        "-- 스탯 / 마법부여 / 보석 (archon.gg 기준)",
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
            lines.append("        embellishments = {")
            for item in embel[:2]:
                lines.append(f'            {{name="{item["name"]}", id={item["id"]}}},')
            lines.append("        },")

            # 마법부여
            ench = d.get("enchantments", [])
            lines.append("        enchantments = {")
            for item in ench:
                slot = item.get("slot", "")
                lines.append(f'            {{slot="{slot}", name="{item["name"]}", id={item["id"]}}},')
            lines.append("        },")

            # 보석
            gem = d.get("gems", [])
            lines.append("        gems = {")
            for item in gem[:4]:
                lines.append(f'            {{name="{item["name"]}", id={item["id"]}}},')
            lines.append("        },")

            lines.append("    },")

        lines.append("}")
        lines.append("")

    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="archon.gg data collector")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    print("--- Collecting data from archon.gg ---")

    data: dict = {}
    total_specs = sum(len(c["specs"]) for c in CLASS_SPECS.values())
    count = 0

    for class_id, class_info in CLASS_SPECS.items():
        data[class_id] = {}

        for spec in class_info["specs"]:
            count += 1
            label = f"{class_info['name']} {spec['name']}"
            print(f"  [{count}/{total_specs}] {label}...", end=" ", flush=True)

            raw = fetch_archon_data(spec["slug"])
            if not raw:
                print("FAILED")
                data[class_id][spec["index"]] = {
                    "stats": [], "embellishments": [], "enchantments": [], "gems": [],
                }
                time.sleep(random.uniform(2, 4))
                continue

            sections = raw["props"]["pageProps"]["page"]["sections"]

            stats = parse_stats(sections)
            enchants, gems = parse_gear_enchants_gems(sections)

            data[class_id][spec["index"]] = {
                "stats": stats,
                "embellishments": [],  # archon.gg에서 장식은 별도 처리 필요
                "enchantments": enchants,
                "gems": gems,
            }

            print(f"ok (스탯:{len(stats)} 마부:{len(enchants)} 보석:{len(gems)})")
            time.sleep(random.uniform(1.5, 3))

    # Lua 생성
    lua_content = generate_extra_lua(data)

    if args.dry_run:
        print(lua_content[:1500])
        print("...")
        print("(dry-run)")
        return

    EXTRA_DATA_PATH.write_text(lua_content, encoding="utf-8")
    print(f"\nDone! {EXTRA_DATA_PATH}")


if __name__ == "__main__":
    main()
