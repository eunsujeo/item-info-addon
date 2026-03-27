#!/usr/bin/env python3
"""
extra_data.lua의 장식(embellishment) 아이템 ID를
선택 재료(Optional Reagent) 아이템 ID로 교체합니다.
효과 설명이 포함된 올바른 툴팁이 표시됩니다.

사용법:
    python scripts/resolve_embel_ids.py
"""

import re
from pathlib import Path

PROJECT_DIR = Path(__file__).parent.parent
EXTRA_DATA_PATH = PROJECT_DIR / "extra_data.lua"

# murlok.io 장식 이름 → Optional Reagent 아이템 ID
EMBEL_REAGENT_MAP = {
    # Darkmoon Sigils — Midnight Season (245xxx)
    "Hunt": 245876,                       # 다크문 인장: 사냥
    "Void": 245874,                       # 다크문 인장: 공허
    "Blood": 245872,                      # 다크문 인장: 혈기
    # Tailoring embellishments
    "Arcanoweave Lining": 240167,         # 비전매듭 안감
    "Arcanoweave Cord": 240167,           # → 비전매듭 안감 (완성품→재료로 매핑)
    "Arcanoweave Trappings": 240167,      # → 비전매듭 안감 (완성품→재료로 매핑)
    "Sunfire Silk Lining": 240165,        # 태양불꽃 비단 안감
    "Sunfire Silk Trappings": 240165,     # → 태양불꽃 비단 안감 (완성품→재료로 매핑)
    # Midnight crafting reagents
    "Blessed Pango Charm": 244604,        # 축복받은 천산갑 부적
    "Devouring Banding": 244675,          # 포식의 결속끈
    "Primal Spore Binding": 244608,       # 원시 포자 결속끈
    # Jewelcrafting embellishments
    "Prismatic Focusing Iris": 251488,    # 오색 집중의 눈동자
    "Stabilizing Gemstone Bandolier": 251490,  # 안정화 보석 사선 주머니
    # 완성품 (재료가 아닌 장식 내장 아이템) — id=0으로 설정하여 커스텀 툴팁 사용
    "Loa Worshiper's Band": 0,
    "Knight Commander's Palisade": 0,
    "Root Warden's Regalia": 0,
    "Signet Of Azerothian Blessings": 0,
}


def main():
    content = EXTRA_DATA_PATH.read_text(encoding="utf-8")
    replaced = 0

    for name, reagent_id in EMBEL_REAGENT_MAP.items():
        # embellishments 블록 내에서만 교체 (count 필드 유무 모두 대응)
        pattern = re.compile(
            r'(\{name="' + re.escape(name) + r'", id=)\d+(,|\})'
        )
        new_content = pattern.sub(rf'\g<1>{reagent_id}\g<2>', content)
        if new_content != content:
            count = len(pattern.findall(content))
            replaced += count
            content = new_content

    EXTRA_DATA_PATH.write_text(content, encoding="utf-8")
    print(f"Replaced {replaced} embellishment IDs in {EXTRA_DATA_PATH}")


if __name__ == "__main__":
    main()
