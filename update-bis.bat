@echo off
setlocal

set "PYTHON=C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe"
set "PYTHONIOENCODING=utf-8"
set "WOW_ADDON_DIR=D:\game\World of Warcraft\_retail_\Interface\AddOns\ItemInfo"

echo ========================================
echo   ItemInfo Update Pipeline
echo ========================================

if "%1"=="--skip-fetch" goto skip_fetch
if "%1"=="--raid-only" goto raid_only

echo --- [1/7] Fetch M+ data from murlok.io...
"%PYTHON%" scripts\update_bis.py --keep-raid
if errorlevel 1 (
    echo [1/7] FAILED
    exit /b 1
)

echo --- [2/7] Fetch Raid data from wowhead...
"%PYTHON%" scripts\update_raid_bis.py
if errorlevel 1 (
    echo [2/7] FAILED
    exit /b 1
)
goto apply

:raid_only
echo --- [1/7] Skipped M+ (--raid-only)
echo --- [2/7] Fetch Raid data from wowhead...
"%PYTHON%" scripts\update_raid_bis.py
if errorlevel 1 (
    echo [2/7] FAILED
    exit /b 1
)
goto apply

:skip_fetch
echo --- [1/7] Skipped (--skip-fetch)
echo --- [2/7] Skipped (--skip-fetch)

:apply
echo --- [3/7] Apply source mapping (cache)...
"%PYTHON%" scripts\apply_sources.py
if errorlevel 1 (
    echo [3/7] FAILED
    exit /b 1
)

echo --- [4/7] First verify...
"%PYTHON%" scripts\verify_bis.py >nul 2>&1
if errorlevel 1 (
    echo     Missing sources found. Auto-fetching...
    echo --- [5/7] Blizzard API + wowhead lookup...
    "%PYTHON%" scripts\fetch_missing_sources.py
    if errorlevel 1 (
        echo [5/7] FAILED
        exit /b 1
    )
    echo --- [6/7] Re-apply source mapping...
    "%PYTHON%" scripts\apply_sources.py
    if errorlevel 1 (
        echo [6/7] FAILED
        exit /b 1
    )
) else (
    echo     No missing sources. Skipping fetch.
)

echo --- [7/7] Final verify...
"%PYTHON%" scripts\verify_bis.py
if errorlevel 1 (
    echo FAILED: Add missing items to item_sources.lua manually, then re-run.
    exit /b 1
)

echo --- Installing to WoW...
if not exist "%WOW_ADDON_DIR%" mkdir "%WOW_ADDON_DIR%"
copy /y bis_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y item_sources.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoBIS.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoPanel.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.toc "%WOW_ADDON_DIR%\" >nul

echo ========================================
echo   Done! Type /reload in game
echo ========================================
