#!/usr/bin/env python3
"""
bis_data.lua 데이터 무결성 검증 스크립트.

검증 항목:
  1. 각 스펙에 필수 슬롯(1,2,3,5,6,7,8,9,10,11,12,13,14,15,16) 존재
  2. 모든 아이템 ID > 1000
  3. 빈 보너스 ID {} 없음
  4. M+ 섹션에 빈 source 문자열 "" 없음
  5. M+과 레이드 섹션의 클래스/스펙 커버리지 일치

사용법:
    python scripts/verify_bis.py
    python scripts/verify_bis.py --file path/to/bis_data.lua
"""

import argparse
import re
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent

REQUIRED_SLOTS = {1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}

# 클래스별 스펙 수 (검증용)
CLASS_SPEC_COUNTS = {
    "DEATHKNIGHT": 3,
    "DEMONHUNTER": 2,
    "DRUID": 4,
    "EVOKER": 3,
    "HUNTER": 3,
    "MAGE": 3,
    "MONK": 3,
    "PALADIN": 3,
    "PRIEST": 3,
    "ROGUE": 3,
    "SHAMAN": 3,
    "WARLOCK": 3,
    "WARRIOR": 3,
}


def extract_section_block(content: str, section_name: str) -> str:
    """ItemInfoBISData["section"] = { ... } 블록을 brace counting으로 추출합니다."""
    marker = f'ItemInfoBISData["{section_name}"]'
    start = content.find(marker)
    if start == -1:
        return ""

    # '=' 뒤의 첫 '{' 찾기
    eq_pos = content.find("=", start + len(marker))
    if eq_pos == -1:
        return ""
    brace_start = content.find("{", eq_pos)
    if brace_start == -1:
        return ""

    depth = 0
    in_string = False
    i = brace_start
    while i < len(content):
        ch = content[i]
        if ch == '"' and (i == 0 or content[i - 1] != '\\'):
            in_string = not in_string
        elif not in_string:
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
                if depth == 0:
                    return content[brace_start + 1:i]
        i += 1
    return ""


def parse_section_data(content: str, section_name: str) -> dict:
    """bis_data.lua에서 특정 섹션(mplus/raid)의 데이터를 파싱합니다.

    Returns:
        {class_id: {spec_index: {slot_id: (item_id, bonus_ids_str, source)}}}
    """
    section_block = extract_section_block(content, section_name)
    if not section_block:
        return {}

    data = {}

    # 클래스별 블록 — 정규식 대신 brace counting으로 추출
    class_starts = list(re.finditer(r'\["(\w+)"\]\s*=\s*\{', section_block))
    for ci, class_match in enumerate(class_starts):
        class_id = class_match.group(1)
        # 해당 클래스 블록의 시작 '{' 위치
        block_start = class_match.end() - 1
        depth = 0
        block_end = block_start
        for j in range(block_start, len(section_block)):
            if section_block[j] == '{':
                depth += 1
            elif section_block[j] == '}':
                depth -= 1
                if depth == 0:
                    block_end = j
                    break
        class_block = section_block[block_start + 1:block_end]

        specs = {}
        spec_pattern = re.compile(
            r'\[(\d+)\]\s*=\s*\{[^{]*?((?:\[\d+\]=\{.*?\},?\s*)+)\s*\}',
            re.DOTALL,
        )

        for spec_match in spec_pattern.finditer(class_block):
            spec_index = int(spec_match.group(1))
            slot_block = spec_match.group(2)

            slots = {}
            slot_pattern = re.compile(
                r'\[(\d+)\]=\{(\d+),\s*\{([^}]*)\},\s*"([^"]*)"\}'
            )

            for slot_match in slot_pattern.finditer(slot_block):
                slot_id = int(slot_match.group(1))
                item_id = int(slot_match.group(2))
                bonus_str = slot_match.group(3).strip()
                source = slot_match.group(4)
                slots[slot_id] = (item_id, bonus_str, source)

            if slots:
                specs[spec_index] = slots

        if specs:
            data[class_id] = specs

    return data


def check_required_slots(data: dict, section_name: str) -> list:
    """각 스펙에 필수 슬롯이 있는지 검증합니다."""
    errors = []
    for class_id, specs in sorted(data.items()):
        for spec_idx, slots in sorted(specs.items()):
            present_slots = set(slots.keys())
            missing = REQUIRED_SLOTS - present_slots
            if missing:
                missing_str = ", ".join(str(s) for s in sorted(missing))
                errors.append(
                    f"[{section_name}] {class_id} 스펙{spec_idx}: "
                    f"누락 슬롯 — {missing_str}"
                )
    return errors


def check_item_ids(data: dict, section_name: str) -> list:
    """모든 아이템 ID가 1000보다 큰지 검증합니다."""
    errors = []
    for class_id, specs in sorted(data.items()):
        for spec_idx, slots in sorted(specs.items()):
            for slot_id, (item_id, _, _) in sorted(slots.items()):
                if item_id <= 1000:
                    errors.append(
                        f"[{section_name}] {class_id} 스펙{spec_idx} "
                        f"슬롯{slot_id}: 아이템 ID {item_id} <= 1000"
                    )
    return errors


def check_empty_bonus_ids(data: dict, section_name: str) -> list:
    """빈 보너스 ID({})가 있는지 검증합니다."""
    errors = []
    for class_id, specs in sorted(data.items()):
        for spec_idx, slots in sorted(specs.items()):
            for slot_id, (item_id, bonus_str, _) in sorted(slots.items()):
                if not bonus_str:
                    errors.append(
                        f"[{section_name}] {class_id} 스펙{spec_idx} "
                        f"슬롯{slot_id}: 아이템 {item_id} — 빈 보너스 ID {{}}"
                    )
    return errors


def check_empty_sources(data: dict) -> list:
    """M+ 섹션에서 빈 source 문자열이 있는지 검증합니다."""
    errors = []
    for class_id, specs in sorted(data.items()):
        for spec_idx, slots in sorted(specs.items()):
            for slot_id, (item_id, _, source) in sorted(slots.items()):
                if not source:
                    errors.append(
                        f"[mplus] {class_id} 스펙{spec_idx} "
                        f"슬롯{slot_id}: 아이템 {item_id} — 빈 획득처"
                    )
    return errors


def check_coverage(mplus_data: dict, raid_data: dict) -> list:
    """M+과 레이드 섹션의 클래스/스펙 커버리지를 비교합니다."""
    errors = []

    mplus_classes = set(mplus_data.keys())
    raid_classes = set(raid_data.keys())

    # 양쪽 모두 있어야 하는 클래스
    only_mplus = mplus_classes - raid_classes
    only_raid = raid_classes - mplus_classes

    if only_mplus:
        errors.append(f"M+에만 있는 클래스: {', '.join(sorted(only_mplus))}")
    if only_raid:
        errors.append(f"레이드에만 있는 클래스: {', '.join(sorted(only_raid))}")

    # 공통 클래스의 스펙 커버리지
    for class_id in sorted(mplus_classes & raid_classes):
        mplus_specs = set(mplus_data[class_id].keys())
        raid_specs = set(raid_data[class_id].keys())

        only_m = mplus_specs - raid_specs
        only_r = raid_specs - mplus_specs

        if only_m:
            specs_str = ", ".join(str(s) for s in sorted(only_m))
            errors.append(f"{class_id}: M+에만 있는 스펙 — {specs_str}")
        if only_r:
            specs_str = ", ".join(str(s) for s in sorted(only_r))
            errors.append(f"{class_id}: 레이드에만 있는 스펙 — {specs_str}")

    return errors


def main():
    parser = argparse.ArgumentParser(description="bis_data.lua 데이터 검증")
    parser.add_argument(
        "--file",
        type=str,
        default=None,
        help="bis_data.lua 경로 (기본: 프로젝트 루트)",
    )
    args = parser.parse_args()

    bis_path = Path(args.file) if args.file else PROJECT_DIR / "bis_data.lua"

    if not bis_path.exists():
        print(f"ERROR: {bis_path} 파일이 없습니다!", file=sys.stderr)
        sys.exit(1)

    content = bis_path.read_text(encoding="utf-8")

    print(f"==> bis_data.lua 검증 중... ({bis_path})")
    print()

    mplus_data = parse_section_data(content, "mplus")
    raid_data = parse_section_data(content, "raid")

    if not mplus_data:
        print("ERROR: M+ 데이터를 파싱할 수 없습니다!", file=sys.stderr)
        sys.exit(1)

    all_passed = True
    checks = [
        ("필수 슬롯 (M+)", lambda: check_required_slots(mplus_data, "mplus")),
        ("필수 슬롯 (레이드)", lambda: check_required_slots(raid_data, "raid")),
        ("아이템 ID > 1000 (M+)", lambda: check_item_ids(mplus_data, "mplus")),
        ("아이템 ID > 1000 (레이드)", lambda: check_item_ids(raid_data, "raid")),
        ("빈 보너스 ID (M+)", lambda: check_empty_bonus_ids(mplus_data, "mplus")),
        ("빈 보너스 ID (레이드)", lambda: check_empty_bonus_ids(raid_data, "raid")),
        ("빈 획득처 (M+)", lambda: check_empty_sources(mplus_data)),
        ("클래스/스펙 커버리지", lambda: check_coverage(mplus_data, raid_data)),
    ]

    for name, check_fn in checks:
        errors = check_fn()
        if errors:
            print(f"  ✗ {name} — {len(errors)}개 문제")
            for err in errors[:10]:  # 최대 10개만 표시
                print(f"      {err}")
            if len(errors) > 10:
                print(f"      ... 외 {len(errors) - 10}개")
            all_passed = False
        else:
            print(f"  ✓ {name}")

    # ── 통계 ──
    mplus_items = sum(
        len(slots) for specs in mplus_data.values() for slots in specs.values()
    )
    raid_items = sum(
        len(slots) for specs in raid_data.values() for slots in specs.values()
    )
    mplus_specs = sum(len(specs) for specs in mplus_data.values())
    raid_specs = sum(len(specs) for specs in raid_data.values())

    print()
    print(f"  M+: {len(mplus_data)}개 클래스, {mplus_specs}개 스펙, {mplus_items}개 아이템")
    print(f"  레이드: {len(raid_data)}개 클래스, {raid_specs}개 스펙, {raid_items}개 아이템")

    if all_passed:
        print("\n✓ 모든 검증 통과")
        sys.exit(0)
    else:
        print("\n✗ 일부 검증 실패")
        sys.exit(1)


if __name__ == "__main__":
    main()
