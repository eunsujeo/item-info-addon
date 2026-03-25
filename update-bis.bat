@echo off
chcp 65001 >nul
setlocal

set PYTHON=C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe
set PYTHONIOENCODING=utf-8
set WOW_ADDON_DIR=D:\game\World of Warcraft\_retail_\Interface\AddOns\ItemInfo

echo ==> [1/4] murlok.io에서 M+ BIS 데이터 수집...
"%PYTHON%" scripts\update_bis.py --keep-raid
if errorlevel 1 (echo 수집 실패! & exit /b 1)

echo ==> [2/4] 획득처 매핑 적용...
"%PYTHON%" scripts\apply_sources.py
if errorlevel 1 (echo 매핑 실패! & exit /b 1)

echo ==> [3/4] 데이터 검증...
"%PYTHON%" scripts\verify_bis.py
if errorlevel 1 (echo 검증 실패! & exit /b 1)

echo ==> [4/4] WoW 애드온 설치...
if not exist "%WOW_ADDON_DIR%" mkdir "%WOW_ADDON_DIR%"
copy /y bis_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y item_sources.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoBIS.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoPanel.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.toc "%WOW_ADDON_DIR%\" >nul

echo.
echo ✓ BIS 데이터 업데이트 완료
