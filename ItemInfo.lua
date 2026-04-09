-- ItemInfo.lua
-- 메인 애드온 로직: 이벤트 등록 및 흐름 제어

ItemInfo = ItemInfo or {}

local ADDON_NAME = "WhatToWriteItemInfo"
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
        ItemInfoBIS.BuildTooltipLookup()
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
    ItemInfoBIS.BuildTooltipLookup()
    ItemInfoBIS.InitTooltipHook()
    ItemInfoPanel.Init()
    ItemInfo.CreateMinimapButton()
end

-- 미니맵 버튼
function ItemInfo.CreateMinimapButton()
    local btn = CreateFrame("Button", "WhatToWriteMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:RegisterForClicks("anyUp")
    btn:RegisterForDrag("LeftButton")
    btn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    -- 아이콘
    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetSize(18, 18)
    icon:SetPoint("CENTER", 0, 1)
    icon:SetTexture(136201)  -- Spell_Shadow_Shadowfury
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    -- 테두리
    local border = btn:CreateTexture(nil, "OVERLAY")
    border:SetSize(52, 52)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(20, 20)
    bg:SetPoint("CENTER", 0, 1)
    bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    -- 위치 (SavedVariables로 저장)
    local db = ItemInfoDB
    if not db.minimapAngle then db.minimapAngle = 220 end

    local function UpdatePosition()
        local angle = math.rad(db.minimapAngle)
        local radius = Minimap:GetWidth() / 2
        btn:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * radius, math.sin(angle) * radius)
    end
    UpdatePosition()

    -- 드래그로 위치 변경
    local isDragging = false
    btn:SetScript("OnDragStart", function()
        isDragging = true
    end)
    btn:SetScript("OnDragStop", function()
        isDragging = false
    end)
    btn:SetScript("OnUpdate", function()
        if not isDragging then return end
        local mx, my = Minimap:GetCenter()
        local cx, cy = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()
        cx, cy = cx / scale, cy / scale
        db.minimapAngle = math.deg(math.atan2(cy - my, cx - mx))
        btn:ClearAllPoints()
        UpdatePosition()
    end)

    -- 클릭
    btn:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            ItemInfoPanel.Toggle()
        end
    end)

    -- 툴팁
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("|cffffd700WhatToWriteItemInfo|r")
        GameTooltip:AddLine("|cffffffffLeft-click:|r Toggle panel", 1, 1, 1)
        GameTooltip:AddLine("|cffffffffDrag:|r Move button", 1, 1, 1)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

-- 슬래시 커맨드
SLASH_ITEMINFO1 = "/iteminfo" -- luacheck: ignore
SLASH_ITEMINFO2 = "/ii"      -- luacheck: ignore
SlashCmdList["ITEMINFO"] = function(msg)
    local cmd = msg:lower():trim()

    if cmd == "" or cmd == "bis" then
        ItemInfoPanel.Toggle()

    elseif cmd == "update" then
        print("|cffffd700[ItemInfo]|r 데이터 정보:")
        print("  업데이트 날짜: " .. ItemInfoBIS.GetUpdateDate())
        print("  데이터 출처: " .. ItemInfoBIS.GetSourceDescription())
        print("  업데이트 방법: 게임 밖에서 make update-bis 실행")

    elseif cmd == "help" then
        print("|cffffd700[ItemInfo]|r 명령어:")
        print("  /ii        - 패널 열기/닫기")
        print("  /ii update - 데이터 정보 확인")
        print("  /ii help   - 도움말")

    else
        print("|cffffd700[ItemInfo]|r 알 수 없는 명령어. /ii help 를 입력하세요.")
    end
end
