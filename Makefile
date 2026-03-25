# Makefile — ItemInfo WoW 애드온 빌드 및 검증

WOW_ADDON_DIR ?= /Applications/World\ of\ Warcraft/_retail_/Interface/AddOns/ItemInfo
ADDON_FILES   = bis_data.lua ItemInfoBIS.lua ItemInfoPanel.lua ItemInfo.lua ItemInfo.toc

.PHONY: all lint lint-tests lint-all test check install-check install clean help

all: lint test

# ============================================================
lint:
	@echo "==> [1/2] luacheck 정적 분석..."
	@luacheck bis_data.lua ItemInfoBIS.lua ItemInfoPanel.lua ItemInfo.lua \
		--config .luacheckrc
	@echo "    완료"

lint-tests:
	@echo "==> luacheck 테스트 파일 분석..."
	@luacheck tests/ --config .luacheckrc
	@echo "    완료"

lint-all: lint lint-tests

# ============================================================
test:
	@echo "==> [2/2] busted 단위 테스트..."
	@busted --verbose --lpath="./?.lua" tests/test_bis.lua
	@echo "    완료"

# ============================================================
check: lint-all test
	@echo ""
	@echo "✓ 모든 검증 통과"

# ============================================================
install-check:
	@which luacheck > /dev/null 2>&1 || (echo "✗ luacheck 미설치: brew install luacheck"; exit 1)
	@which busted   > /dev/null 2>&1 || (echo "✗ busted 미설치: luarocks install busted"; exit 1)
	@echo "도구 확인 완료"

clean:
	@find . -name "*.luac" -delete

# ============================================================
install:
	@echo "==> WoW 애드온 설치 중..."
	@mkdir -p "$(WOW_ADDON_DIR)"
	@cp $(ADDON_FILES) "$(WOW_ADDON_DIR)/"
	@echo "    설치 완료: $(WOW_ADDON_DIR)"

help:
	@echo "make lint       - 소스 정적 분석"
	@echo "make lint-all   - 소스 + 테스트 정적 분석"
	@echo "make test       - 단위 테스트 실행"
	@echo "make check      - 전체 검증 (CI 기준)"
	@echo "make install    - WoW 애드온 폴더에 설치"
	@echo "                  경로 변경: make install WOW_ADDON_DIR=/your/path"
