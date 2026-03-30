# ItemInfo WoW Addon

WoW(World of Warcraft) 리테일 애드온. 현재 스펙의 쐐기(M+) 상위 50명 장비, 레이드 BiS, 스탯, 장식, 마법부여, 보석, 특성 정보를 패널로 제공한다.

## 구조

### 애드온 파일 (Lua)
- `ItemInfo.lua` - 메인: 이벤트 등록, 슬래시 커맨드 (`/ii`)
- `ItemInfoBIS.lua` - BIS 로직: 데이터 로드, 슬롯 상태 판정, 툴팁 훅
- `ItemInfoPanel.lua` - UI 패널: 7탭(BiS/장비/스탯/장식/마부/보석/특성), 드롭다운, 툴팁
- `bis_data.lua` - 장비 데이터 (M+ + 레이드)
- `extra_data.lua` - 스탯/장식/마법부여/보석 데이터
- `talent_data.lua` - 특성 빌드 문자열
- `item_sources.lua` - 아이템 획득처 캐시

### 데이터 수집 스크립트 (Python)
| 스크립트 | 소스 | 수집 항목 | 방식 |
|---------|------|----------|------|
| `scripts/update_bis.py` | murlok.io | M+ 장비, 스탯 | requests (HTML) |
| `scripts/update_raid_bis.py` | wowhead | 레이드 BiS 장비 | Playwright |
| `scripts/update_from_archon.py` | archon.gg | 스탯, 마법부여, 보석 | requests (JSON) |
| `scripts/merge_embellishments.py` | wowhead | 장식 (embellishment) | Playwright |
| `scripts/update_talents.py` | murlok.io | 특성 문자열 | Playwright |
| `scripts/fetch_missing_sources.py` | Blizzard API | 누락 아이템 획득처 | requests |
| `scripts/resolve_enchant_ids.py` | Blizzard API | 인챈트 스크롤 ID | requests |
| `scripts/resolve_embel_ids.py` | - | 장식 Optional Reagent ID 매핑 | 정적 매핑 |
| `scripts/apply_sources.py` | item_sources.lua | 획득처 매핑 적용 | 로컬 |
| `scripts/verify_bis.py` | - | bis_data.lua 검증 | 로컬 |

### 배치 파일
- `update-bis.bat` - 전체 파이프라인 (수집 → 매핑 → 검증 → 설치)
- `install.bat` - WoW 애드온 폴더에 복사
- `verify.bat` - 데이터 검증만

## 데이터 소스 정리

| 데이터 | 소스 | 이유 |
|--------|------|------|
| 쐐기 장비 | murlok.io | 상위 50명 실사용 데이터 |
| 레이드 장비 | wowhead | 가이드 기반 BiS |
| 스탯 우선순위 | archon.gg | JSON 구조화, 4개 스탯 정확 |
| 마법부여/보석 | archon.gg | JSON 구조화, item ID 포함 |
| 장식 | wowhead | archon.gg에 장식 섹션 없음 |
| 특성 | murlok.io | 1위 플레이어 Copy 버튼 (Playwright) |
| 획득처 | Blizzard API | Journal 엔드포인트 정확 |

## 주요 의존성

- Python 3.12: `C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe`
- `requests`, `beautifulsoup4`, `playwright` (chromium)
- Blizzard API 키: `.env` 파일 (BNET_CLIENT_ID, BNET_CLIENT_SECRET)

## 명령어

```bash
# 전체 업데이트 파이프라인
.\update-bis.bat

# M+ 수집 스킵 (매핑 + 검증 + 설치만)
.\update-bis.bat --skip-fetch

# 레이드만 수집
.\update-bis.bat --raid-only

# 개별 수집
python scripts/update_from_archon.py      # archon.gg: 스탯/마부/보석
python scripts/merge_embellishments.py     # wowhead: 장식
python scripts/update_talents.py           # murlok.io: 특성

# 설치
.\install.bat
```

## 파이프라인 (update-bis.bat)

1. murlok.io M+ 장비 수집 → `bis_data.lua` + `extra_data.lua`(스탯)
2. wowhead 레이드 BiS 수집
3. 획득처 매핑 (item_sources.lua 캐시)
4. 1차 검증
5. 누락 소스 자동 조회 (Blizzard API + wowhead 폴백)
6. 재매핑
7. 인챈트 스크롤 ID 해결
8. 장식 Optional Reagent ID 매핑
9. 최종 검증 → WoW 설치

## 패널 UI

- 타이틀: "쐐기 상위 50"
- 7탭: BiS(레이드) / 장비(쐐기) / 스탯 / 장식 / 마부 / 보석 / 특성
- 장비 탭: 아이콘 + 이름 + 달성 체크 + 마우스 오버 툴팁 + 비교 툴팁
- 장식/마부/보석: 아이콘 + 이름 + 커스텀 툴팁
- 특성: 클릭 → EditBox 팝업 → Ctrl+C 복사
- ESC로 패널 닫기
- 게임 내 아이템 툴팁에 BIS 표시 (TooltipDataProcessor 훅)

## 주의사항

- `.env` 파일은 gitignore 대상 (API 키 포함)
- `.claude/settings.local.json`도 gitignore 대상
- bat 파일에서 `>` 문자는 리다이렉트로 해석됨 → `---` 사용
- bat 파일에 한글 사용 시 인코딩 깨짐 → 영문만 사용
- `PYTHONIOENCODING=utf-8` 설정 필요 (bash에서 Python 실행 시)
- murlok.io User-Agent에 봇 식별자 넣으면 차단됨
- wowhead는 JS 렌더링 → Playwright 필요
- archon.gg는 Next.js → `__NEXT_DATA__` JSON으로 requests만으로 가능
- 장식 item ID는 제작 완성품이 아닌 Optional Reagent ID 사용해야 정확한 툴팁
- Darkmoon Sigil 시즌 주의: 카즈 알가르(226xxx) vs Midnight(245xxx)

## WoW 설치 경로

`D:\game\World of Warcraft\_retail_\Interface\AddOns\ItemInfo`
