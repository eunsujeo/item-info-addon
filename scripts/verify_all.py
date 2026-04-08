#!/usr/bin/env python3
"""
전체 데이터 검증: bis_data.lua, extra_data.lua, talent_data.lua

검증 항목:
  1. bis_data.lua: 기존 verify_bis.py 위임
  2. extra_data.lua: 39스펙 스탯/장식/마부/보석 존재 여부
  3. talent_data.lua: 스펙별 특성 문자열 존재 여부

사용법:
    python scripts/verify_all.py
"""

import re
import subprocess
import sys
from pathlib import Path

PROJECT_DIR = Path(__file__).parent.parent
PYTHON = sys.executable

TOTAL_SPECS = 39
CLASS_SPEC_COUNT = {
    "DEATHKNIGHT": 3, "DEMONHUNTER": 2, "DRUID": 4, "EVOKER": 3,
    "HUNTER": 3, "MAGE": 3, "MONK": 3, "PALADIN": 3, "PRIEST": 3,
    "ROGUE": 3, "SHAMAN": 3, "WARLOCK": 3, "WARRIOR": 3,
}


def verify_bis():
    """bis_data.lua 검증 (기존 스크립트 위임)"""
    result = subprocess.run(
        [PYTHON, str(PROJECT_DIR / "scripts" / "verify_bis.py")],
        capture_output=True, text=True, encoding="utf-8",
    )
    return result.returncode == 0, result.stdout


def verify_extra():
    """extra_data.lua 검증"""
    path = PROJECT_DIR / "extra_data.lua"
    if not path.exists():
        return False, "extra_data.lua not found"

    content = path.read_text(encoding="utf-8")
    errors = []

    # 클래스별 존재 확인
    for class_id, spec_count in CLASS_SPEC_COUNT.items():
        if f'ItemInfoExtraData["{class_id}"]' not in content:
            errors.append(f"{class_id}: missing")
            continue

    # 스펙별 데이터 확인
    stats_ok = 0
    embel_ok = 0
    enchant_ok = 0
    gems_ok = 0

    blocks = re.findall(
        r'\{ -- (.+?)\n\s+stats = \{(.+?)\},\s+embellishments = \{(.*?)\},\s+enchantments = \{(.*?)\},\s+gems = \{(.*?)\},',
        content, re.DOTALL,
    )

    for spec, stats, embel, enchants, gems in blocks:
        s_count = stats.count('"') // 2
        e_count = embel.count("name=")
        n_count = enchants.count("name=")
        g_count = gems.count("name=")

        if s_count >= 4:
            stats_ok += 1
        else:
            errors.append(f"{spec}: stats {s_count}/4")

        if e_count >= 1:
            embel_ok += 1
        else:
            errors.append(f"{spec}: embellishments {e_count}")

        if n_count >= 5:
            enchant_ok += 1
        else:
            errors.append(f"{spec}: enchantments {n_count}")

        if g_count >= 1:
            gems_ok += 1
        else:
            errors.append(f"{spec}: gems {g_count}")

    total = len(blocks)
    summary = f"extra_data: {total} specs | stats:{stats_ok} embel:{embel_ok} enchant:{enchant_ok} gems:{gems_ok}"

    if total < TOTAL_SPECS:
        errors.insert(0, f"Only {total}/{TOTAL_SPECS} specs found")

    return len(errors) == 0, summary + ("\n  " + "\n  ".join(errors) if errors else "")


def verify_talents():
    """talent_data.lua 검증"""
    path = PROJECT_DIR / "talent_data.lua"
    if not path.exists():
        return False, "talent_data.lua not found"

    content = path.read_text(encoding="utf-8")

    if "ItemInfoTalentData = {}" in content:
        return False, "talent_data.lua is empty"

    # Count specs with talent strings
    talent_count = 0
    for cls_m in re.finditer(r'\["\w+"\]\s*=\s*\{', content):
        start = cls_m.end()
        next_cls = content.find('["', start + 1)
        block = content[start:next_cls] if next_cls > 0 else content[start:]
        talent_count += len(re.findall(r'\[\d+\]\s*=\s*\{', block))
    string_count = len(re.findall(r'"C[A-Za-z0-9+/=]{30,}"', content))

    summary = f"talent_data: {talent_count} specs, {string_count} talent strings"

    errors = []
    if talent_count < TOTAL_SPECS - 5:  # Some specs may be missing
        errors.append(f"Only {talent_count} specs (expected ~{TOTAL_SPECS})")
    if string_count < talent_count:
        errors.append(f"Missing strings: {talent_count - string_count}")

    return len(errors) == 0, summary + ("\n  " + "\n  ".join(errors) if errors else "")


def main():
    print("========================================")
    print("  ItemInfo Data Verification")
    print("========================================\n")

    all_passed = True

    # 1. bis_data
    print("[1/3] bis_data.lua...")
    ok, msg = verify_bis()
    if ok:
        print("  OK")
    else:
        print(f"  FAILED\n{msg}")
        all_passed = False

    # 2. extra_data
    print("[2/3] extra_data.lua...")
    ok, msg = verify_extra()
    print(f"  {'OK' if ok else 'ISSUES'}: {msg}")
    if not ok:
        all_passed = False

    # 3. talent_data
    print("[3/3] talent_data.lua...")
    ok, msg = verify_talents()
    print(f"  {'OK' if ok else 'ISSUES'}: {msg}")
    if not ok:
        all_passed = False

    print()
    if all_passed:
        print("All verifications passed!")
    else:
        print("Some verifications failed.")
        sys.exit(1)


if __name__ == "__main__":
    main()
