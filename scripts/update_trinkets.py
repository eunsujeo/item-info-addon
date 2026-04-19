#!/usr/bin/env python3
"""
bloodmallet.com API에서 장신구 DPS 랭킹을 수집하여
trinket_data.lua를 생성합니다.

API: https://bloodmallet.com/chart/get/trinkets/{fightStyle}/{class}/{spec}
방식: requests (JSON) — Playwright 불필요

사용법:
    python scripts/update_trinkets.py
    python scripts/update_trinkets.py --dry-run
    python scripts/update_trinkets.py --top 5    # 상위 5개만 (기본 10)
"""

from __future__ import annotations

import argparse
import random
import sys
import time
from datetime import datetime
from pathlib import Path

import requests

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
OUTPUT_PATH = PROJECT_DIR / "trinket_data.lua"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
}

# bloodmallet는 언더스코어 사용
CLASS_SPECS = {
    "DEATHKNIGHT": {
        "slug": "death_knight", "name": "죽음의 기사",
        "specs": [
            {"index": 1, "slug": "blood", "name": "혈기"},
            {"index": 2, "slug": "frost", "name": "냉기"},
            {"index": 3, "slug": "unholy", "name": "부정"},
        ],
    },
    "DEMONHUNTER": {
        "slug": "demon_hunter", "name": "악마사냥꾼",
        "specs": [
            {"index": 1, "slug": "havoc", "name": "파멸"},
            {"index": 2, "slug": "vengeance", "name": "복수"},
            {"index": 3, "slug": "devourer", "name": "포식"},
        ],
    },
    "DRUID": {
        "slug": "druid", "name": "드루이드",
        "specs": [
            {"index": 1, "slug": "balance", "name": "조화"},
            {"index": 2, "slug": "feral", "name": "야성"},
            {"index": 3, "slug": "guardian", "name": "수호"},
            # 회복: 힐러라 bloodmallet 데이터 없음
        ],
    },
    "EVOKER": {
        "slug": "evoker", "name": "기원사",
        "specs": [
            {"index": 1, "slug": "devastation", "name": "황폐"},
            # 보존/증강: 힐러/서포터라 데이터 없음
        ],
    },
    "HUNTER": {
        "slug": "hunter", "name": "사냥꾼",
        "specs": [
            {"index": 1, "slug": "beast_mastery", "name": "야수"},
            {"index": 2, "slug": "marksmanship", "name": "사격"},
            {"index": 3, "slug": "survival", "name": "생존"},
        ],
    },
    "MAGE": {
        "slug": "mage", "name": "마법사",
        "specs": [
            {"index": 1, "slug": "arcane", "name": "비전"},
            {"index": 2, "slug": "fire", "name": "화염"},
            {"index": 3, "slug": "frost", "name": "냉기"},
        ],
    },
    "MONK": {
        "slug": "monk", "name": "수도사",
        "specs": [
            {"index": 1, "slug": "brewmaster", "name": "양조"},
            # 안개: 힐러라 데이터 없음
            {"index": 3, "slug": "windwalker", "name": "풍운"},
        ],
    },
    "PALADIN": {
        "slug": "paladin", "name": "성기사",
        "specs": [
            # 신성: 힐러라 데이터 없음
            {"index": 2, "slug": "protection", "name": "보호"},
            {"index": 3, "slug": "retribution", "name": "징벌"},
        ],
    },
    "PRIEST": {
        "slug": "priest", "name": "사제",
        "specs": [
            # 수양/신성: 힐러라 데이터 없음
            {"index": 3, "slug": "shadow", "name": "암흑"},
        ],
    },
    "ROGUE": {
        "slug": "rogue", "name": "도적",
        "specs": [
            {"index": 1, "slug": "assassination", "name": "암살"},
            {"index": 2, "slug": "outlaw", "name": "무법"},
            {"index": 3, "slug": "subtlety", "name": "잠행"},
        ],
    },
    "SHAMAN": {
        "slug": "shaman", "name": "주술사",
        "specs": [
            {"index": 1, "slug": "elemental", "name": "정기"},
            {"index": 2, "slug": "enhancement", "name": "고양"},
            # 복원: 힐러라 데이터 없음
        ],
    },
    "WARLOCK": {
        "slug": "warlock", "name": "흑마법사",
        "specs": [
            {"index": 1, "slug": "affliction", "name": "고통"},
            {"index": 2, "slug": "demonology", "name": "악마"},
            {"index": 3, "slug": "destruction", "name": "파괴"},
        ],
    },
    "WARRIOR": {
        "slug": "warrior", "name": "전사",
        "specs": [
            {"index": 1, "slug": "arms", "name": "무기"},
            {"index": 2, "slug": "fury", "name": "분노"},
            {"index": 3, "slug": "protection", "name": "방어"},
        ],
    },
}

FIGHT_STYLE = "castingpatchwerk"


def fetch_trinkets(class_slug: str, spec_slug: str, top_n: int = 10) -> tuple:
    """bloodmallet API에서 장신구 DPS 랭킹을 가져옵니다.
    Returns: (trinket_list, max_ilvl)
    """
    url = f"https://bloodmallet.com/chart/get/trinkets/{FIGHT_STYLE}/{class_slug}/{spec_slug}"
    try:
        resp = requests.get(url, headers=HEADERS, timeout=15)
        resp.raise_for_status()
        data = resp.json()
    except (requests.RequestException, ValueError) as e:
        print(f"err:{e}", end="")
        return [], 0

    items = data.get("data", {})
    item_ids = data.get("item_ids", {})
    steps = data.get("simulated_steps", [])

    if not items or not steps:
        return [], 0

    max_ilvl = str(max(steps))
    max_ilvl_num = max(steps)

    # DPS 기준 정렬
    ranked = []
    seen_ids = set()
    for name, ilvl_data in items.items():
        if not isinstance(ilvl_data, dict):
            continue
        # 최고 아이템 레벨의 DPS
        dps = ilvl_data.get(max_ilvl, 0)
        if not dps:
            # 가장 높은 값 사용
            dps = max(ilvl_data.values()) if ilvl_data else 0

        # 변형(variants) 제거: [xxx] 없는 기본 이름만
        base_name = name.split("[")[0].strip()
        item_id = item_ids.get(base_name) or item_ids.get(name, 0)

        if item_id and item_id not in seen_ids and dps > 0:
            seen_ids.add(item_id)
            ranked.append({
                "name": base_name,
                "id": item_id,
                "dps": round(dps),
            })

    ranked.sort(key=lambda x: x["dps"], reverse=True)
    return ranked[:top_n], max_ilvl_num


def generate_lua(data: dict, top_n: int, ilvl: int = 0) -> str:
    today = datetime.now().strftime("%Y-%m-%d")
    lines = [
        "-- trinket_data.lua",
        f"-- 장신구 DPS 랭킹 (bloodmallet.com, 상위 {top_n}개)",
        f"-- 시뮬레이션 기준: {FIGHT_STYLE}",
        f"-- 업데이트: {today}",
        "-- 힐러/서포터 스펙은 DPS 시뮬레이션 대상 아님",
        "",
        "ItemInfoTrinketData = {}",
        f"ItemInfoTrinketMeta = {{ ilvl = {ilvl}, source = \"bloodmallet.com\", fightStyle = \"{FIGHT_STYLE}\" }}",
        "",
    ]

    for class_id, class_info in CLASS_SPECS.items():
        if class_id not in data or not data[class_id]:
            continue

        lines.append(f'ItemInfoTrinketData["{class_id}"] = {{')

        for spec in class_info["specs"]:
            si = spec["index"]
            if si not in data[class_id]:
                continue

            trinkets = data[class_id][si]
            lines.append(f'    [{si}] = {{ -- {spec["name"]}')
            for t in trinkets:
                lines.append(f'        {{name="{t["name"]}", id={t["id"]}, dps={t["dps"]}}},')
            lines.append("    },")

        lines.append("}")
        lines.append("")

    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="bloodmallet trinket ranking collector")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--top", type=int, default=15, help="Top N trinkets per spec")
    args = parser.parse_args()

    print(f"--- Collecting trinket data from bloodmallet.com (top {args.top}) ---")

    data: dict = {}
    max_ilvl = 0
    total = sum(len(c["specs"]) for c in CLASS_SPECS.values())
    count = 0

    for class_id, class_info in CLASS_SPECS.items():
        data[class_id] = {}
        for spec in class_info["specs"]:
            count += 1
            print(f"  [{count}/{total}] {class_info['name']} {spec['name']}...", end=" ", flush=True)
            trinkets, ilvl = fetch_trinkets(class_info["slug"], spec["slug"], args.top)
            if trinkets:
                data[class_id][spec["index"]] = trinkets
                if ilvl > max_ilvl:
                    max_ilvl = ilvl
                print(f"ok ({len(trinkets)}, ilvl {ilvl})")
            else:
                print("EMPTY")
            time.sleep(random.uniform(0.5, 1.5))

    lua = generate_lua(data, args.top, max_ilvl)

    if args.dry_run:
        print(lua[:2000])
        return

    OUTPUT_PATH.write_text(lua, encoding="utf-8")
    print(f"\nDone! {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
