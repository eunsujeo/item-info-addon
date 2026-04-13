#!/usr/bin/env python3
"""
murlok.io에서 BIS 장비 데이터를 스크래핑하여 bis_data.lua를 생성합니다.

사용법:
    python scripts/update_bis.py              # M+ 데이터만 업데이트
    python scripts/update_bis.py --keep-raid   # 기존 레이드 데이터 유지하며 M+ 업데이트
    python scripts/update_bis.py --dry-run     # 실제 파일 생성 없이 미리보기
    python scripts/update_bis.py --diff        # 변경 전후 비교 출력
"""

import argparse
import re
import sys
import time
from datetime import datetime
from pathlib import Path

import requests
from bs4 import BeautifulSoup

# ── 클래스/스펙 매핑 ──────────────────────────────────────────
# murlok.io URL slug → WoW 내부 클래스ID/스펙인덱스
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

# murlok.io 슬롯 이름 → WoW 슬롯 ID
SLOT_MAP = {
    "Head": 1,
    "Neck": 2,
    "Shoulders": 3,
    "Back": 15,
    "Chest": 5,
    "Wrist": 9,
    "Hands": 10,
    "Waist": 6,
    "Legs": 7,
    "Feet": 8,
    "Ring": 11,       # 첫 번째 반지
    "Ring 1": 11,
    "Ring 2": 12,
    "Rings": 11,      # 복수형도 처리
    "Trinket": 13,
    "Trinket 1": 13,
    "Trinket 2": 14,
    "Trinkets": 13,
    "Main Hand": 16,
    "Off Hand": 17,
    "Two-Hand": 16,
    "Weapon": 16,
}

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.9,ko;q=0.8",
}

REQUEST_DELAY = 2.0  # 요청 간 딜레이 (초)


def fetch_spec_page(class_slug: str, spec_slug: str, content_type: str = "m+"):
    """murlok.io에서 특정 스펙의 페이지를 가져와 soup을 반환합니다."""
    url = f"https://murlok.io/{class_slug}/{spec_slug}/{content_type}"
    try:
        resp = requests.get(url, headers=HEADERS, timeout=15)
        resp.raise_for_status()
    except requests.RequestException as e:
        print(f"  ✗ 실패: {url} — {e}", file=sys.stderr)
        return None
    return BeautifulSoup(resp.text, "html.parser")


def parse_gear(soup) -> dict:
    """soup에서 gear 섹션을 파싱합니다."""
    gear_section = soup.find("section", id="gear")
    if not gear_section:
        return {}

    slots = {}
    boxes = gear_section.find_all("div", class_=lambda c: c and "vi-box-with-header" in c)

    for box in boxes:
        h3 = box.find("h3")
        if not h3:
            continue
        slot_name = h3.get_text(strip=True)

        slot_id = SLOT_MAP.get(slot_name)
        if slot_id is None:
            for key, sid in SLOT_MAP.items():
                if key.lower() in slot_name.lower():
                    slot_id = sid
                    break
        if slot_id is None:
            continue

        links = box.find_all("a", href=re.compile(r"wowhead\.com/item=\d+"))
        if not links:
            continue

        if slot_name.lower() in ("ring", "rings", "trinket", "trinkets"):
            for i, link in enumerate(links[:2]):
                match = re.search(r"item=(\d+)", link["href"])
                if match:
                    item_id = int(match.group(1))
                    sid = slot_id + i
                    if sid not in slots:
                        slots[sid] = item_id
        else:
            match = re.search(r"item=(\d+)", links[0]["href"])
            if match:
                item_id = int(match.group(1))
                if slot_id not in slots:
                    slots[slot_id] = item_id

    return slots


def _parse_name_count(raw_name: str) -> tuple:
    """아이템 이름과 사용 인원수를 분리합니다. 예: 'Hunt30' → ('Hunt', 30)"""
    m = re.match(r'^(.*?)(\d+)$', raw_name.strip())
    if m:
        return m.group(1).strip(), int(m.group(2))
    return raw_name.strip(), 0


def _clean_item_name(raw_name: str) -> str:
    """아이템 이름 끝의 사용 횟수 숫자를 제거합니다. 예: 'Hunt30' → 'Hunt'"""
    return _parse_name_count(raw_name)[0]


def parse_section_items(soup, section_id: str) -> list:
    """soup에서 특정 섹션의 아이템 목록을 파싱합니다.
    Returns: [{name, id, type, slot}, ...]
    """
    section = soup.find("section", id=section_id)
    if not section:
        return []

    items = []
    boxes = section.find_all("div", class_=lambda c: c and "vi-box-with-header" in c)

    for box in boxes:
        h3 = box.find("h3")
        slot_name = h3.get_text(strip=True) if h3 else ""

        links = box.find_all("a", href=re.compile(r"wowhead\.com/(item|spell)=\d+"))
        for link in links:
            raw_name = link.get_text(strip=True)
            name, count = _parse_name_count(raw_name)
            if not name:
                continue
            href = link.get("href", "")
            id_match = re.search(r"(item|spell)=(\d+)", href)
            entry_id = int(id_match.group(2)) if id_match else 0
            entry_type = id_match.group(1) if id_match else "item"
            items.append({
                "name": name,
                "id": entry_id,
                "type": entry_type,
                "slot": slot_name,
                "count": count,
            })
            break  # 각 박스에서 1순위만

    # 박스가 없으면 링크 직접 추출 (장식 등)
    if not items and section:
        links = section.find_all("a", href=re.compile(r"wowhead\.com/(item|spell)=\d+"))
        for link in links:
            raw_name = link.get_text(strip=True)
            name, count = _parse_name_count(raw_name)
            if not name:
                continue
            href = link.get("href", "")
            id_match = re.search(r"(item|spell)=(\d+)", href)
            entry_id = int(id_match.group(2)) if id_match else 0
            entry_type = id_match.group(1) if id_match else "item"
            if entry_id > 0:
                items.append({
                    "name": name,
                    "id": entry_id,
                    "type": entry_type,
                    "slot": "",
                    "count": count,
                })

    return items


def parse_stat_priority(soup) -> list:
    """soup에서 스탯 우선순위를 파싱합니다.
    "Stat priority" 텍스트 뒤에 나오는 스탯 이름 순서를 추출합니다.
    Returns: ["가속", "특화", "치명타", "유연성"]
    """
    section = soup.find("section", id="stat-priority")
    if not section:
        return []

    STAT_NAMES = {
        "haste": "가속",
        "mastery": "특화",
        "critical strike": "치명타",
        "versatility": "유연성",
    }

    # 섹션 텍스트를 줄 단위로 분리
    texts = [t.strip() for t in section.get_text(separator="\n").split("\n") if t.strip()]

    # "Stat priority" 텍스트를 찾되, 첫 번째는 섹션 제목이므로 두 번째부터 수집
    stats = []
    priority_count = 0
    collecting = False
    for text in texts:
        if text.lower() == "stat priority":
            priority_count += 1
            if priority_count == 2:  # 두 번째 "Stat priority"가 실제 순서
                collecting = True
                continue
            elif priority_count >= 3:  # 세 번째는 Minor Stats → 중단
                break
            continue
        if collecting:
            lower = text.lower()
            matched = False
            for en, ko in STAT_NAMES.items():
                if en == lower and ko not in stats:
                    stats.append(ko)
                    matched = True
                    break
            if not matched and stats:
                break  # 스탯이 아닌 텍스트가 나오면 수집 종료

    return stats


def parse_top_player(soup) -> str | None:
    """soup에서 1위 플레이어 캐릭터 URL을 추출합니다."""
    matches = re.findall(r'/character/(\w+)/([^/]+)/([^/]+)/pve', str(soup))
    if matches:
        region, realm, name = matches[0]
        return f"{region}/{realm}/{name}"
    return None


def fetch_spec_gear(class_slug: str, spec_slug: str, content_type: str = "m+") -> dict:
    """murlok.io에서 특정 스펙의 장비 데이터를 가져옵니다. (하위 호환)"""
    soup = fetch_spec_page(class_slug, spec_slug, content_type)
    if not soup:
        return {}
    return parse_gear(soup)


def fetch_spec_all(class_slug: str, spec_slug: str, content_type: str = "m+") -> dict:
    """murlok.io에서 특정 스펙의 장비 + 스탯/장식/마법부여/보석을 가져옵니다."""
    soup = fetch_spec_page(class_slug, spec_slug, content_type)
    if not soup:
        return {}

    return {
        "gear": parse_gear(soup),
        "stats": parse_stat_priority(soup),
        "embellishments": parse_section_items(soup, "embellishments"),
        "enchantments": parse_section_items(soup, "enchantments"),
        "gems": parse_section_items(soup, "gems"),
        "top_player": parse_top_player(soup),
    }


def parse_new_format_raid_data(content: str) -> dict:
    """새 형식 (ItemInfoBISData["raid"] = { ... }) 에서 레이드 데이터를 파싱합니다."""
    # ItemInfoBISData["raid"] = { 부터 마지막 } 까지 추출
    raid_match = re.search(
        r'ItemInfoBISData\["raid"\]\s*=\s*\{(.*)',
        content,
        re.DOTALL,
    )
    if not raid_match:
        return {}

    raid_block = raid_match.group(1)

    raid_data = {}

    # 클래스별 블록 추출
    class_pattern = re.compile(
        r'\["(\w+)"\]\s*=\s*\{(.*?)\n    \}',
        re.DOTALL,
    )

    for class_match in class_pattern.finditer(raid_block):
        class_id = class_match.group(1)
        class_block = class_match.group(2)

        # 스펙별 블록 추출
        spec_pattern = re.compile(
            r'\[(\d+)\]\s*=\s*\{[^{]*?((?:\[\d+\]=\{.*?\},?\s*)+)\s*\}',
            re.DOTALL,
        )

        specs = {}
        for spec_match in spec_pattern.finditer(class_block):
            spec_index = int(spec_match.group(1))
            slot_block = spec_match.group(2)

            # 슬롯별 데이터 추출
            slot_pattern = re.compile(
                r'\[(\d+)\]=\{(\d+),\s*\{([^}]*)\},\s*"([^"]*)"\}'
            )

            slot_data = {}
            for slot_match in slot_pattern.finditer(slot_block):
                slot_id = int(slot_match.group(1))
                item_id = int(slot_match.group(2))
                bonus_str = slot_match.group(3).strip()
                source = slot_match.group(4)

                bonus_ids = []
                if bonus_str:
                    bonus_ids = [int(b.strip()) for b in bonus_str.split(",") if b.strip()]

                slot_data[slot_id] = {
                    "itemId": item_id,
                    "bonusIds": bonus_ids,
                    "source": source,
                }

            if slot_data:
                specs[spec_index] = slot_data

        if specs:
            raid_data[class_id] = specs

    return raid_data


def parse_flat_data_as_raid(content: str) -> dict:
    """기존 플랫 구조의 bis_data.lua를 레이드 데이터로 파싱합니다."""
    raid_data = {}

    # 클래스별 블록 추출
    class_pattern = re.compile(
        r'\["(\w+)"\]\s*=\s*\{(.*?)\n    \}',
        re.DOTALL,
    )

    for class_match in class_pattern.finditer(content):
        class_id = class_match.group(1)
        class_block = class_match.group(2)

        # 스펙별 블록 추출
        spec_pattern = re.compile(
            r'\[(\d+)\]\s*=\s*\{[^{]*?((?:\[\d+\]=\{.*?\},?\s*)+)\s*\}',
            re.DOTALL,
        )

        specs = {}
        for spec_match in spec_pattern.finditer(class_block):
            spec_index = int(spec_match.group(1))
            slot_block = spec_match.group(2)

            # 슬롯별 데이터 추출
            slot_pattern = re.compile(
                r'\[(\d+)\]=\{(\d+),\s*\{([^}]*)\},\s*"([^"]*)"\}'
            )

            slot_data = {}
            for slot_match in slot_pattern.finditer(slot_block):
                slot_id = int(slot_match.group(1))
                item_id = int(slot_match.group(2))
                bonus_str = slot_match.group(3).strip()
                source = slot_match.group(4)

                bonus_ids = []
                if bonus_str:
                    bonus_ids = [int(b.strip()) for b in bonus_str.split(",") if b.strip()]

                slot_data[slot_id] = {
                    "itemId": item_id,
                    "bonusIds": bonus_ids,
                    "source": source,
                }

            if slot_data:
                specs[spec_index] = slot_data

        if specs:
            raid_data[class_id] = specs

    return raid_data


def parse_existing_raid_data(lua_path: Path) -> dict:
    """기존 bis_data.lua에서 레이드 데이터를 파싱합니다."""
    if not lua_path.exists():
        return {}

    content = lua_path.read_text(encoding="utf-8")

    # 새 형식 (ItemInfoBISData["raid"] = { ... }) 우선 시도
    if 'ItemInfoBISData["raid"]' in content:
        raid_data = parse_new_format_raid_data(content)
        if raid_data:
            return raid_data

    # 폴백: 기존 플랫 구조
    return parse_flat_data_as_raid(content)


def parse_existing_mplus_data(lua_path: Path) -> dict:
    """기존 bis_data.lua에서 M+ 데이터를 파싱합니다 (diff용)."""
    if not lua_path.exists():
        return {}

    content = lua_path.read_text(encoding="utf-8")

    # ItemInfoBISData["mplus"] = { ... } 영역 추출
    mplus_match = re.search(
        r'ItemInfoBISData\["mplus"\]\s*=\s*\{(.*?)(?:\n\s*\}.*?ItemInfoBISData\["raid"\]|\n\s*\},?\s*\})',
        content,
        re.DOTALL,
    )
    if not mplus_match:
        return {}

    mplus_block = mplus_match.group(1)
    mplus_data = {}

    # 클래스별 블록 추출
    class_pattern = re.compile(
        r'\["(\w+)"\]\s*=\s*\{(.*?)\n\s{8}\}',
        re.DOTALL,
    )

    for class_match in class_pattern.finditer(mplus_block):
        class_id = class_match.group(1)
        class_block = class_match.group(2)

        spec_pattern = re.compile(
            r'\[(\d+)\]\s*=\s*\{[^{]*?((?:\[\d+\]=\{.*?\},?\s*)+)\s*\}',
            re.DOTALL,
        )

        specs = {}
        for spec_match in spec_pattern.finditer(class_block):
            spec_index = int(spec_match.group(1))
            slot_block = spec_match.group(2)

            slot_pattern = re.compile(
                r'\[(\d+)\]=\{(\d+),\s*\{([^}]*)\},\s*"([^"]*)"\}'
            )

            slot_data = {}
            for slot_match in slot_pattern.finditer(slot_block):
                slot_id = int(slot_match.group(1))
                item_id = int(slot_match.group(2))
                slot_data[slot_id] = item_id

            if slot_data:
                specs[spec_index] = slot_data

        if specs:
            mplus_data[class_id] = specs

    return mplus_data


def compute_diff(old_data: dict, new_data: dict) -> dict:
    """M+ 데이터의 변경사항을 계산합니다.

    Returns:
        dict with keys: changed, added, removed, per_spec details
    """
    changed = 0
    added = 0
    removed = 0
    per_spec = []

    all_classes = set(list(old_data.keys()) + list(new_data.keys()))
    for class_id in sorted(all_classes):
        if class_id not in CLASS_SPECS:
            continue
        class_info = CLASS_SPECS[class_id]

        old_specs = old_data.get(class_id, {})
        new_specs = new_data.get(class_id, {})

        for spec in class_info["specs"]:
            si = spec["index"]
            old_slots = old_specs.get(si, {})
            new_slots = new_specs.get(si, {})

            spec_changes = []
            all_slot_ids = set(list(old_slots.keys()) + list(new_slots.keys()))

            for slot_id in sorted(all_slot_ids):
                old_item = old_slots.get(slot_id)
                new_item = new_slots.get(slot_id)

                if old_item is None and new_item is not None:
                    spec_changes.append(f"  슬롯{slot_id}: + {new_item} (신규)")
                    added += 1
                elif old_item is not None and new_item is None:
                    spec_changes.append(f"  슬롯{slot_id}: - {old_item} (제거)")
                    removed += 1
                elif old_item != new_item:
                    spec_changes.append(f"  슬롯{slot_id}: {old_item} → {new_item}")
                    changed += 1

            if spec_changes:
                label = f"{class_info['name']} {spec['name']}"
                per_spec.append((label, spec_changes))

    return {
        "changed": changed,
        "added": added,
        "removed": removed,
        "per_spec": per_spec,
    }


def print_diff(diff_result: dict):
    """변경사항을 출력합니다."""
    if not diff_result["per_spec"]:
        print("\n==> 변경사항 없음")
        return

    print("\n==> 변경사항:")
    for label, changes in diff_result["per_spec"]:
        print(f"\n  [{label}]")
        for change in changes:
            print(f"    {change}")

    total = diff_result["changed"] + diff_result["added"] + diff_result["removed"]
    print(f"\n변경: {diff_result['changed']}개 아이템, "
          f"신규: {diff_result['added']}개, "
          f"제거: {diff_result['removed']}개 "
          f"(총 {total}개)")


def generate_extra_lua(extra_data: dict, output_path: Path):
    """extra_data.lua (스탯/장식/마법부여/보석) 파일을 생성합니다."""
    today = datetime.now().strftime("%Y-%m-%d")
    lines = [
        "-- extra_data.lua",
        f"-- 스탯 우선순위 / 장식 / 마법부여 / 보석 (murlok.io 상위 50명 기준)",
        f"-- 업데이트: {today}",
        "",
        "ItemInfoExtraData = {}",
        "",
    ]

    for class_id, class_info in CLASS_SPECS.items():
        if class_id not in extra_data:
            continue
        specs = extra_data[class_id]
        if not specs:
            continue

        lines.append(f'ItemInfoExtraData["{class_id}"] = {{')

        for spec in class_info["specs"]:
            si = spec["index"]
            if si not in specs:
                continue

            data = specs[si]
            lines.append(f'    [{si}] = {{ -- {spec["name"]}')

            # 스탯 우선순위
            stats = data.get("stats", [])
            stats_str = ", ".join(f'"{s}"' for s in stats)
            lines.append(f'        stats = {{{stats_str}}},')

            # 장식
            embel = data.get("embellishments", [])
            lines.append(f'        embellishments = {{')
            for item in embel[:2]:
                c = item.get("count", 0)
                lines.append(f'            {{name="{item["name"]}", id={item["id"]}, count={c}}},')
            lines.append(f'        }},')

            # 마법부여
            ench = data.get("enchantments", [])
            lines.append(f'        enchantments = {{')
            for item in ench[:10]:
                slot = item.get("slot", "")
                c = item.get("count", 0)
                lines.append(f'            {{slot="{slot}", name="{item["name"]}", id={item["id"]}, count={c}}},')
            lines.append(f'        }},')

            # 보석
            gems = data.get("gems", [])
            lines.append(f'        gems = {{')
            for item in gems[:4]:
                c = item.get("count", 0)
                lines.append(f'            {{name="{item["name"]}", id={item["id"]}, count={c}}},')
            lines.append(f'        }},')

            # 1위 플레이어
            top_player = data.get("top_player", "")
            lines.append(f'        top_player = "{top_player}",')

            lines.append(f'    }},')

        lines.append(f'}}')
        lines.append("")

    output_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"✓ {output_path} 생성 완료")


def generate_lua(mplus_data: dict, raid_data: dict, output_path: Path):
    """bis_data.lua 파일을 생성합니다."""
    today = datetime.now().strftime("%Y-%m-%d")

    lines = []
    lines.append("-- bis_data.lua")
    lines.append("-- BIS (Best in Slot) 데이터")
    lines.append("-- M+ 출처: murlok.io (상위 플레이어 실사용 데이터)")
    lines.append("-- 레이드 출처: wowhead.com (가이드 기반)")
    lines.append("-- 기준: The War Within — Midnight Season 1")
    lines.append(f"-- 최종 업데이트: {today}")
    lines.append("--")
    lines.append("-- 슬롯 ID:")
    lines.append("--   1=머리  2=목  3=어깨  5=가슴  6=허리  7=다리  8=발")
    lines.append("--   9=손목  10=손  11=반지1  12=반지2  13=장신구1  14=장신구2")
    lines.append("--   15=등  16=주무기  17=보조무기(없으면 생략)")
    lines.append("")
    lines.append("-- [contentType][CLASS][specIndex][slotId] = {itemId, {bonusIds}, \"획득처\"}")
    lines.append("")

    # 메타데이터
    lines.append("ItemInfoBISMeta = {")
    lines.append(f'    source = "murlok.io / wowhead",')
    lines.append(f'    updatedAt = "{today}",')
    lines.append(f'    season = "Midnight Season 1",')
    lines.append(f'    description = "M+: 상위 플레이어 실사용 장비 | 레이드: wowhead 가이드",')
    lines.append("}")
    lines.append("")

    lines.append("ItemInfoBISData = {}")
    lines.append("")

    # ── M+ 데이터 ──
    lines.append('ItemInfoBISData["mplus"] = {')

    for class_id, class_info in CLASS_SPECS.items():
        if class_id not in mplus_data:
            continue

        spec_names = ", ".join(
            f"{s['index']}={s['name']}" for s in class_info["specs"]
        )
        lines.append("")
        lines.append(f"        -- {class_info['name']} ({class_id})  {spec_names}")
        lines.append(f'        ["{class_id}"] = {{')

        for spec in class_info["specs"]:
            si = spec["index"]
            if si not in mplus_data[class_id]:
                continue

            lines.append(f"            [{si}] = {{ -- {spec['name']}")
            slot_data = mplus_data[class_id][si]
            slot_order = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
            for slot_id in slot_order:
                if slot_id in slot_data:
                    item_id = slot_data[slot_id]
                    lines.append(f'                [{slot_id}]={{{item_id}, {{12806, 13335}}, ""}},')
            lines.append("            },")

        lines.append("        },")

    lines.append("}")
    lines.append("")

    # ── 레이드 데이터 ──
    lines.append('ItemInfoBISData["raid"] = {')

    for class_id, class_info in CLASS_SPECS.items():
        if class_id not in raid_data:
            continue

        spec_names = ", ".join(
            f"{s['index']}={s['name']}" for s in class_info["specs"]
        )
        lines.append("    -- =========================================================")
        lines.append(f"    -- {class_info['name']} ({class_id})  {spec_names}")
        lines.append("    -- =========================================================")
        lines.append(f'    ["{class_id}"] = {{')

        for spec in class_info["specs"]:
            si = spec["index"]
            if si not in raid_data[class_id]:
                continue

            lines.append(f"        [{si}] = {{ -- {spec['name']}")
            spec_data = raid_data[class_id][si]
            slot_order = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
            for slot_id in slot_order:
                if slot_id in spec_data:
                    entry = spec_data[slot_id]
                    item_id = entry["itemId"]
                    bonus_ids = entry["bonusIds"]
                    source = entry["source"]
                    bonus_str = ", ".join(str(b) for b in bonus_ids)
                    lines.append(
                        f'            [{slot_id}]={{{item_id}, {{{bonus_str}}}, "{source}"}},'
                    )
            lines.append("        },")

        lines.append("    },")

    lines.append("}")
    lines.append("")

    output_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"\n✓ {output_path} 생성 완료 ({today})")


def main():
    parser = argparse.ArgumentParser(description="murlok.io BIS 데이터 업데이트")
    parser.add_argument("--dry-run", action="store_true", help="파일 생성 없이 미리보기")
    parser.add_argument("--keep-raid", action="store_true", help="기존 레이드 데이터 유지")
    parser.add_argument("--diff", action="store_true", help="변경 전후 비교 출력")
    parser.add_argument(
        "--output",
        type=str,
        default=None,
        help="출력 파일 경로 (기본: bis_data.lua)",
    )
    args = parser.parse_args()

    script_dir = Path(__file__).parent
    project_dir = script_dir.parent
    output_path = Path(args.output) if args.output else project_dir / "bis_data.lua"

    # ── 기존 데이터 로드 (diff용) ──
    old_mplus_data = {}
    if args.diff and output_path.exists():
        old_mplus_data = parse_existing_mplus_data(output_path)

    # ── 기존 레이드 데이터 로드 ──
    raid_data = {}
    if args.keep_raid and output_path.exists():
        print("==> 기존 레이드 데이터 로드 중...")
        raid_data = parse_existing_raid_data(output_path)
        print(f"    {len(raid_data)}개 클래스 레이드 데이터 로드됨")

    # ── M+ 데이터 수집 ──
    print("==> murlok.io에서 M+ BIS 데이터 수집 중...")
    mplus_data = {}
    extra_data = {}
    total_specs = sum(len(c["specs"]) for c in CLASS_SPECS.values())
    current = 0

    for class_id, class_info in CLASS_SPECS.items():
        mplus_data[class_id] = {}
        extra_data[class_id] = {}

        for spec in class_info["specs"]:
            current += 1
            label = f"[{current}/{total_specs}]"
            print(f"  {label} {class_info['name']} - {spec['name']}...", end=" ", flush=True)

            result = fetch_spec_all(class_info["slug"], spec["slug"], "m+")
            gear = result.get("gear", {})
            if gear:
                mplus_data[class_id][spec["index"]] = gear
                extra_data[class_id][spec["index"]] = {
                    "stats": result.get("stats", []),
                    "embellishments": result.get("embellishments", []),
                    "enchantments": result.get("enchantments", []),
                    "gems": result.get("gems", []),
                    "top_player": result.get("top_player", ""),
                }
                print(f"✓ {len(gear)}개 슬롯")
            else:
                print("✗ 데이터 없음")

            time.sleep(REQUEST_DELAY)

    # ── 결과 요약 ──
    total_items = sum(
        len(slots)
        for specs in mplus_data.values()
        for slots in specs.values()
    )
    print(f"\n==> M+ 수집 완료: {total_items}개 아이템")

    # ── diff 출력 ──
    if args.diff and old_mplus_data:
        diff_result = compute_diff(old_mplus_data, mplus_data)
        print_diff(diff_result)

    if args.dry_run:
        print("\n[DRY RUN] 파일 생성을 건너뜁니다.")
        for class_id, specs in mplus_data.items():
            for si, slots in specs.items():
                spec_name = next(
                    s["name"]
                    for s in CLASS_SPECS[class_id]["specs"]
                    if s["index"] == si
                )
                print(f"  {CLASS_SPECS[class_id]['name']} {spec_name}: {slots}")
        return

    # ── Lua 파일 생성 ──
    generate_lua(mplus_data, raid_data, output_path)

    # ── extra_data.lua 생성 ──
    extra_path = project_dir / "extra_data.lua"
    generate_extra_lua(extra_data, extra_path)


if __name__ == "__main__":
    main()
