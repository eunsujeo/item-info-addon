#!/usr/bin/env python3
"""
미해결 아이템 ID를 Blizzard API로 개별 조회하여
아이템 정보(이름, 타입, 장착 부위, 제작 여부)를 출력합니다.

사용법:
    python scripts/identify_items.py 151320 151328 193709
    python scripts/identify_items.py --all   # bis_data.lua에서 빈 획득처 전체
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

import requests

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
ENV_PATH = PROJECT_DIR / ".env"
BIS_DATA_PATH = PROJECT_DIR / "bis_data.lua"
SOURCES_PATH = PROJECT_DIR / "item_sources.lua"

BNET_TOKEN_URL = "https://oauth.battle.net/token"
BNET_API_BASE = "https://kr.api.blizzard.com"


def load_env() -> dict[str, str]:
    env = {}
    if not ENV_PATH.exists():
        return env
    for line in ENV_PATH.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if "=" in line:
            k, v = line.split("=", 1)
            env[k.strip()] = v.strip()
    return env


def get_token(client_id: str, client_secret: str) -> str:
    resp = requests.post(
        BNET_TOKEN_URL,
        data={"grant_type": "client_credentials"},
        auth=(client_id, client_secret),
        timeout=15,
    )
    resp.raise_for_status()
    return resp.json()["access_token"]


def get_item(token: str, item_id: int) -> dict | None:
    url = f"{BNET_API_BASE}/data/wow/item/{item_id}"
    try:
        resp = requests.get(
            url,
            params={"namespace": "static-kr", "locale": "ko_KR"},
            headers={"Authorization": f"Bearer {token}"},
            timeout=15,
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        print(f"  [{item_id}] ✗ 조회 실패: {e}")
        return None


def find_missing_item_ids() -> set[int]:
    content = BIS_DATA_PATH.read_text(encoding="utf-8")
    raid_pos = content.find('ItemInfoBISData["raid"]')
    if raid_pos == -1:
        raid_pos = len(content)
    mplus_section = content[:raid_pos]
    pattern = re.compile(r'\[\d+\]=\{(\d+),\s*\{[^}]*\},\s*""\}')
    return {int(m.group(1)) for m in pattern.finditer(mplus_section)}


def load_existing_sources() -> dict[int, str]:
    if not SOURCES_PATH.exists():
        return {}
    content = SOURCES_PATH.read_text(encoding="utf-8")
    sources = {}
    for m in re.finditer(r'\[(\d+)\]\s*=\s*"([^"]*)"', content):
        sources[int(m.group(1))] = m.group(2)
    return sources


def main():
    parser = argparse.ArgumentParser(description="아이템 정보 조회")
    parser.add_argument("item_ids", nargs="*", type=int, help="조회할 아이템 ID")
    parser.add_argument("--all", action="store_true", help="bis_data.lua 빈 획득처 전체")
    args = parser.parse_args()

    env = load_env()
    client_id = env.get("BNET_CLIENT_ID")
    client_secret = env.get("BNET_CLIENT_SECRET")
    if not client_id or not client_secret:
        print("ERROR: .env에 BNET_CLIENT_ID, BNET_CLIENT_SECRET 필요", file=sys.stderr)
        sys.exit(1)

    if args.all:
        existing = load_existing_sources()
        item_ids = sorted(find_missing_item_ids() - set(existing.keys()))
    elif args.item_ids:
        item_ids = args.item_ids
    else:
        print("아이템 ID를 지정하거나 --all 사용")
        sys.exit(1)

    print(f"토큰 발급 중...")
    token = get_token(client_id, client_secret)

    print(f"\n{len(item_ids)}개 아이템 조회:\n")
    print(f"{'ID':>10}  {'이름':<30}  {'타입':<15}  {'장착부위':<15}  {'설명'}")
    print("-" * 100)

    for item_id in item_ids:
        data = get_item(token, item_id)
        if not data:
            continue

        name = data.get("name", "?")
        item_class = data.get("item_class", {}).get("name", "?")
        item_subclass = data.get("item_subclass", {}).get("name", "?")
        equip_slot = data.get("inventory_type", {}).get("name", "-")
        description = data.get("preview_item", {}).get("description", {})
        if isinstance(description, dict):
            description = description.get("display_string", "")

        # 제작 여부 힌트
        preview = data.get("preview_item", {})
        crafting_hint = ""
        if preview.get("recipe"):
            crafting_hint = "[제작]"
        elif "crafted_stats" in str(preview) or "Crafted" in str(preview):
            crafting_hint = "[제작?]"

        type_str = f"{item_class}/{item_subclass}"
        print(f"  {item_id:>8}  {name:<30}  {type_str:<15}  {equip_slot:<15}  {crafting_hint} {description}")


if __name__ == "__main__":
    main()
