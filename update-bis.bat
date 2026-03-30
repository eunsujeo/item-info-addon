@echo off
setlocal

set "PYTHON=C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe"
set "PYTHONIOENCODING=utf-8"
set "WOW_ADDON_DIR=D:\game\World of Warcraft\_retail_\Interface\AddOns\ItemInfo"

echo ========================================
echo   ItemInfo Full Update Pipeline
echo ========================================

if "%1"=="--skip-fetch" goto apply
if "%1"=="--extra-only" goto extra

echo --- [1/12] M+ gear from murlok.io...
"%PYTHON%" scripts\update_bis.py --keep-raid
if errorlevel 1 (
    echo [1] FAILED
    exit /b 1
)

echo --- [2/12] Raid gear from wowhead (Playwright)...
"%PYTHON%" scripts\update_raid_bis.py
if errorlevel 1 (
    echo [2] FAILED - continuing without raid update
)

echo --- [3/12] Apply source mapping...
"%PYTHON%" scripts\apply_sources.py
if errorlevel 1 (
    echo [3] FAILED
    exit /b 1
)

echo --- [4/12] Verify gear data...
"%PYTHON%" scripts\verify_bis.py >nul 2>&1
if errorlevel 1 (
    echo     Missing sources found. Auto-fetching...
    echo --- [5/12] Blizzard API lookup...
    "%PYTHON%" scripts\fetch_missing_sources.py
    echo --- [6/12] Re-apply source mapping...
    "%PYTHON%" scripts\apply_sources.py
) else (
    echo     No missing sources.
)

:extra
if "%1"=="--extra-only" (
    echo --- [1-6] Skipped (--extra-only)
)

echo --- [7/12] Stats/enchants/gems from archon.gg...
"%PYTHON%" scripts\update_from_archon.py
if errorlevel 1 (
    echo [7] FAILED
    exit /b 1
)

echo --- [8/12] Embellishments from wowhead (Playwright)...
"%PYTHON%" scripts\merge_embellishments.py
if errorlevel 1 (
    echo [8] FAILED - continuing
)

echo --- [9/12] Resolve enchant IDs...
"%PYTHON%" scripts\resolve_enchant_ids.py
if errorlevel 1 (
    echo [9] FAILED - continuing
)

echo --- [10/12] Resolve embellishment IDs...
"%PYTHON%" scripts\resolve_embel_ids.py
if errorlevel 1 (
    echo [10] FAILED - continuing
)

echo --- [11/12] Talents from murlok.io (Playwright)...
"%PYTHON%" scripts\update_talents.py
if errorlevel 1 (
    echo [11] FAILED - continuing without talent update
)

if "%1"=="--extra-only" goto verify

:apply
if "%1"=="--skip-fetch" (
    echo --- [1-11] Skipped (--skip-fetch)
)

:verify
echo --- [12/12] Final verification...
"%PYTHON%" scripts\verify_all.py
if errorlevel 1 (
    echo WARNING: Some verifications failed. Check output above.
)

echo --- Installing to WoW...
if not exist "%WOW_ADDON_DIR%" mkdir "%WOW_ADDON_DIR%"
copy /y bis_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y talent_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y extra_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y item_sources.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoBIS.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoPanel.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.toc "%WOW_ADDON_DIR%\" >nul

echo ========================================
echo   Done! Type /reload in game
echo ========================================
