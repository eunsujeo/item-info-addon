@echo off
chcp 65001 >nul
set WOW_ADDON_DIR=D:\game\World of Warcraft\_retail_\Interface\AddOns\ItemInfo

echo ==> WoW 애드온 설치 중...
if not exist "%WOW_ADDON_DIR%" mkdir "%WOW_ADDON_DIR%"
copy /y bis_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y talent_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y extra_data.lua "%WOW_ADDON_DIR%\" >nul
copy /y item_sources.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoBIS.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfoPanel.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.lua "%WOW_ADDON_DIR%\" >nul
copy /y ItemInfo.toc "%WOW_ADDON_DIR%\" >nul
echo     설치 완료: %WOW_ADDON_DIR%
