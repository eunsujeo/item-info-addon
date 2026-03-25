-- ItemInfo.lua
-- 메인 애드온 로직: 이벤트 등록 및 흐름 제어

ItemInfo = ItemInfo or {}

local ADDON_NAME = "ItemInfo"
local frame = CreateFrame("Frame", ADDON_NAME .. "Frame", UIParent)

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")  -- 아이템 캐시 완료 시 패널 갱신

frame:SetScript("OnEvent", function(_, event, ...)
    if event == "ADDON_LOADED" then
        if ... == ADDON_NAME then ItemInfo.OnLoad() end

    elseif event == "PLAYER_LOGIN" then
        ItemInfo.OnPlayerLogin()

    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        ItemInfoBIS.LoadForCurrentSpec()
        ItemInfoPanel.Refresh()

    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        ItemInfoPanel.Refresh()

    elseif event == "GET_ITEM_INFO_RECEIVED" then
        -- 아이템 데이터 캐시 완료 → 패널에 이름 반영
        ItemInfoPanel.Refresh()
    end
end)

function ItemInfo.OnLoad()
    if not ItemInfoDB then
        ItemInfoDB = {}
    end
end

function ItemInfo.OnPlayerLogin()
    ItemInfoBIS.LoadForCurrentSpec()
    ItemInfoPanel.Init()
end

-- 슬래시 커맨드
SLASH_ITEMINFO1 = "/iteminfo" -- luacheck: ignore
SLASH_ITEMINFO2 = "/ii"      -- luacheck: ignore
SlashCmdList["ITEMINFO"] = function(msg)
    local cmd = msg:lower():trim()

    if cmd == "" or cmd == "bis" then
        ItemInfoPanel.Toggle()

    elseif cmd == "update" then
        print("|cffffd700[ItemInfo]|r BIS 데이터 정보:")
        print("  업데이트 날짜: " .. ItemInfoBIS.GetUpdateDate())
        print("  데이터 출처: " .. ItemInfoBIS.GetSourceDescription())
        print("  업데이트 방법: 게임 밖에서 make update-bis 실행")

    elseif cmd == "help" then
        print("|cffffd700[ItemInfo]|r 명령어:")
        print("  /ii        - BIS 패널 열기/닫기")
        print("  /ii update - 데이터 정보 확인")
        print("  /ii help   - 도움말")

    else
        print("|cffffd700[ItemInfo]|r 알 수 없는 명령어. /ii help 를 입력하세요.")
    end
end
