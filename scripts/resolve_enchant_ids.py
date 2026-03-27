#!/usr/bin/env python3
"""
extra_data.lua에서 id=0인 마법부여를 Blizzard API로 검색하여
인챈트 스크롤 아이템 ID를 채웁니다.

사용법:
    python scripts/resolve_enchant_ids.py
    python scripts/resolve_enchant_ids.py --dry-run
"""

from __future__ import annotations

import argparse
import re
import sys
import time
from pathlib import Path

import requests

SCRIPT_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPT_DIR.parent
EXTRA_DATA_PATH = PROJECT_DIR / "extra_data.lua"
ENV_PATH = PROJECT_DIR / ".env"

BNET_TOKEN_URL = "https://oauth.battle.net/token"
BNET_API_BASE = "https://us.api.blizzard.com"


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


def search_item(token: str, name: str) -> int | None:
    """Blizzard API에서 아이템 이름으로 검색합니다."""
    url = f"{BNET_API_BASE}/data/wow/search/item"
    params = {
        "namespace": "static-us",
        "name.en_US": name,
        "orderby": "id:desc",
        "_pageSize": 5,
    }
    try:
        resp = requests.get(
            url,
            params=params,
            headers={"Authorization": f"Bearer {token}"},
            timeout=15,
        )
        resp.raise_for_status()
        data = resp.json()
        results = data.get("results", [])
        if results:
            return results[0]["data"]["id"]
    except requests.RequestException:
        pass
    return None


def find_enchant_names_with_zero_id(content: str) -> list[str]:
    """extra_data.lua에서 id=0인 마법부여 이름을 추출합니다."""
    pattern = re.compile(r'name="([^"]+)",\s*id=0')
    names = []
    seen = set()
    for m in pattern.finditer(content):
        name = m.group(1)
        if name not in seen:
            seen.add(name)
            names.append(name)
    return names


def main():
    parser = argparse.ArgumentParser(description="Resolve enchant scroll item IDs")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    env = load_env()
    client_id = env.get("BNET_CLIENT_ID")
    client_secret = env.get("BNET_CLIENT_SECRET")
    if not client_id or not client_secret:
        print("ERROR: .env missing BNET_CLIENT_ID/SECRET", file=sys.stderr)
        sys.exit(1)

    content = EXTRA_DATA_PATH.read_text(encoding="utf-8")
    names = find_enchant_names_with_zero_id(content)

    if not names:
        print("No enchants with id=0 found.")
        return

    print(f"--- {len(names)} enchants with id=0 ---")

    print("Getting token...")
    token = get_token(client_id, client_secret)

    resolved = {}
    for name in names:
        print(f"  {name}...", end=" ", flush=True)
        item_id = search_item(token, name)
        if item_id:
            print(f"ok ({item_id})")
            resolved[name] = item_id
        else:
            print("not found")
        time.sleep(0.2)

    print(f"\nResolved: {len(resolved)}/{len(names)}")

    if args.dry_run:
        print("(dry-run)")
        return

    if not resolved:
        return

    # extra_data.lua 업데이트: name="X", id=0 → name="X", id=실제ID
    new_content = content
    for name, item_id in resolved.items():
        old = f'name="{name}", id=0'
        new = f'name="{name}", id={item_id}'
        new_content = new_content.replace(old, new)

    EXTRA_DATA_PATH.write_text(new_content, encoding="utf-8")
    print(f"Updated {EXTRA_DATA_PATH}")


if __name__ == "__main__":
    main()
