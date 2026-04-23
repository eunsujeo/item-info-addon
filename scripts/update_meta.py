#!/usr/bin/env python3
"""
murlok.io에서 쐐기 메타 랭킹(DPS/Healer/Tank)을 수집하여
meta_data.lua를 생성합니다.

사용법: python scripts/update_meta.py
"""

import re
import sys
from datetime import datetime
from pathlib import Path

import requests
from bs4 import BeautifulSoup

PROJECT_DIR = Path(__file__).parent.parent
OUTPUT_PATH = PROJECT_DIR / "meta_data.lua"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
}

# 영문 이름 → (클래스ID, 스펙인덱스)
SPEC_MAP = {
    "Blood Death Knight": ("DEATHKNIGHT", 1),
    "Frost Death Knight": ("DEATHKNIGHT", 2),
    "Unholy Death Knight": ("DEATHKNIGHT", 3),
    "Havoc Demon Hunter": ("DEMONHUNTER", 1),
    "Vengeance Demon Hunter": ("DEMONHUNTER", 2),
    "Devourer Demon Hunter": ("DEMONHUNTER", 3),
    "Balance Druid": ("DRUID", 1),
    "Feral Druid": ("DRUID", 2),
    "Guardian Druid": ("DRUID", 3),
    "Restoration Druid": ("DRUID", 4),
    "Devastation Evoker": ("EVOKER", 1),
    "Preservation Evoker": ("EVOKER", 2),
    "Augmentation Evoker": ("EVOKER", 3),
    "Beast Mastery Hunter": ("HUNTER", 1),
    "Marksmanship Hunter": ("HUNTER", 2),
    "Survival Hunter": ("HUNTER", 3),
    "Arcane Mage": ("MAGE", 1),
    "Fire Mage": ("MAGE", 2),
    "Frost Mage": ("MAGE", 3),
    "Brewmaster Monk": ("MONK", 1),
    "Mistweaver Monk": ("MONK", 2),
    "Windwalker Monk": ("MONK", 3),
    "Holy Paladin": ("PALADIN", 1),
    "Protection Paladin": ("PALADIN", 2),
    "Retribution Paladin": ("PALADIN", 3),
    "Discipline Priest": ("PRIEST", 1),
    "Holy Priest": ("PRIEST", 2),
    "Shadow Priest": ("PRIEST", 3),
    "Assassination Rogue": ("ROGUE", 1),
    "Outlaw Rogue": ("ROGUE", 2),
    "Subtlety Rogue": ("ROGUE", 3),
    "Elemental Shaman": ("SHAMAN", 1),
    "Enhancement Shaman": ("SHAMAN", 2),
    "Restoration Shaman": ("SHAMAN", 3),
    "Affliction Warlock": ("WARLOCK", 1),
    "Demonology Warlock": ("WARLOCK", 2),
    "Destruction Warlock": ("WARLOCK", 3),
    "Arms Warrior": ("WARRIOR", 1),
    "Fury Warrior": ("WARRIOR", 2),
    "Protection Warrior": ("WARRIOR", 3),
}


def fetch_role(role: str) -> list:
    """특정 역할의 메타 랭킹을 수집합니다."""
    url = f"https://murlok.io/meta/{role}/m+"
    resp = requests.get(url, headers=HEADERS, timeout=15)
    resp.raise_for_status()
    soup = BeautifulSoup(resp.text, "html.parser")

    rankings = []
    for link in soup.find_all("a", href=re.compile(r"^/[a-z-]+/[a-z-]+/m\+")):
        href = link.get("href", "")
        if href.startswith("/meta"):
            continue
        text = link.get_text(strip=True)
        m = re.match(r"^(\d+)([A-Za-z' ]+?)(\d+)$", text)
        if not m:
            continue
        rank = int(m.group(1))
        name_en = m.group(2).strip()
        score = int(m.group(3))
        spec = SPEC_MAP.get(name_en)
        if spec:
            rankings.append({
                "rank": rank,
                "name_en": name_en,
                "score": score,
                "class_id": spec[0],
                "spec_index": spec[1],
            })
    return rankings


def generate_lua(data: dict) -> str:
    today = datetime.now().strftime("%Y-%m-%d")
    lines = [
        "-- meta_data.lua",
        "-- 쐐기 메타 랭킹 (murlok.io 상위 50명 기준)",
        f"-- 업데이트: {today}",
        "",
        "ItemInfoMetaData = {",
    ]

    for role in ["dps", "healer", "tank"]:
        rankings = data.get(role, [])
        lines.append(f'    {role} = {{')
        for r in rankings:
            lines.append(
                f'        {{rank={r["rank"]}, classId="{r["class_id"]}", specIndex={r["spec_index"]}, '
                f'score={r["score"]}, nameEn="{r["name_en"]}"}},'
            )
        lines.append("    },")

    lines.append("}")
    lines.append("")
    return "\n".join(lines)


def main():
    print("--- Collecting meta rankings from murlok.io ---")
    data = {}
    for role in ["dps", "healer", "tank"]:
        print(f"  {role}...", end=" ", flush=True)
        try:
            rankings = fetch_role(role)
            data[role] = rankings
            print(f"{len(rankings)} specs")
        except Exception as e:
            print(f"err: {e}")
            data[role] = []

    lua = generate_lua(data)
    OUTPUT_PATH.write_text(lua, encoding="utf-8")
    print(f"\nDone! {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
