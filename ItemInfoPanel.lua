-- ItemInfoPanel.lua
-- TOP USER 50 패널 (탭 기반: BiS/장비/스탯/마부/보석/특성)

ItemInfoPanel = {}

-- 상수
local PANEL_WIDTH   = 340
local ROW_HEIGHT    = 22
local HEADER_HEIGHT = 76
local FOOTER_HEIGHT = 40
local ICON_SIZE     = 18
local SLOT_LABEL_W  = 60
local PADDING       = 8

-- 탭 정의
local TABS = {
    {id = "bis",      name = "BiS"},
    {id = "gear",     name = "장비"},
    {id = "stats",    name = "스탯"},
    {id = "embels",   name = "장식"},
    {id = "enchants", name = "마부"},
    {id = "gems",     name = "보석"},
    {id = "trinkets", name = "장신구"},
    {id = "talents",  name = "특성"},
    {id = "meta",     name = "순위"},
}

-- 상태 색상
local COLOR = {
    bis     = {r=0.2,  g=1.0,  b=0.2},
    empty   = {r=0.6,  g=0.6,  b=0.6},
    nodata  = {r=0.4,  g=0.4,  b=0.4},
    label   = {r=0.8,  g=0.8,  b=0.8},
    title   = {r=1.0,  g=0.84, b=0.0},
}

local QUALITY_COLOR = {
    [0] = {r=0.62, g=0.62, b=0.62},
    [1] = {r=1.0,  g=1.0,  b=1.0},
    [2] = {r=0.12, g=1.0,  b=0.0},
    [3] = {r=0.0,  g=0.44, b=0.87},
    [4] = {r=0.64, g=0.21, b=0.93},
    [5] = {r=1.0,  g=0.50, b=0.0},
}

local STATUS_ICON = {
    bis     = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14|t",
    upgrade = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14|t",
    empty   = "|TInterface\\RaidFrame\\ReadyCheck-Waiting:14|t",
}

-- 영어 스펙/클래스 → 한글 변환
local SPEC_CLASS_KR = {
    ["Blood Death Knight"]="혈기 죽음의 기사",["Frost Death Knight"]="냉기 죽음의 기사",
    ["Unholy Death Knight"]="부정 죽음의 기사",["Havoc Demon Hunter"]="파멸 악마사냥꾼",
    ["Vengeance Demon Hunter"]="복수 악마사냥꾼",["Balance Druid"]="조화 드루이드",
    ["Feral Druid"]="야성 드루이드",["Guardian Druid"]="수호 드루이드",
    ["Restoration Druid"]="회복 드루이드",["Devastation Evoker"]="황폐 기원사",
    ["Preservation Evoker"]="보존 기원사",["Augmentation Evoker"]="증강 기원사",
    ["Beast Mastery Hunter"]="야수 사냥꾼",["Marksmanship Hunter"]="사격 사냥꾼",
    ["Survival Hunter"]="생존 사냥꾼",["Arcane Mage"]="비전 마법사",
    ["Fire Mage"]="화염 마법사",["Frost Mage"]="냉기 마법사",
    ["Brewmaster Monk"]="양조 수도사",["Mistweaver Monk"]="안개 수도사",
    ["Windwalker Monk"]="풍운 수도사",["Holy Paladin"]="신성 성기사",
    ["Protection Paladin"]="보호 성기사",["Retribution Paladin"]="징벌 성기사",
    ["Discipline Priest"]="수양 사제",["Holy Priest"]="신성 사제",
    ["Shadow Priest"]="암흑 사제",["Assassination Rogue"]="암살 도적",
    ["Outlaw Rogue"]="무법 도적",["Subtlety Rogue"]="잠행 도적",
    ["Elemental Shaman"]="정기 주술사",["Enhancement Shaman"]="고양 주술사",
    ["Restoration Shaman"]="복원 주술사",["Affliction Warlock"]="고통 흑마법사",
    ["Demonology Warlock"]="악마 흑마법사",["Destruction Warlock"]="파괴 흑마법사",
    ["Arms Warrior"]="무기 전사",["Fury Warrior"]="분노 전사",
    ["Protection Warrior"]="방어 전사",
}

local function LocalizeTooltipBIS(tooltip)
    local changed = false
    local name = tooltip:GetName()
    for i = 1, tooltip:NumLines() do
        for _, side in ipairs({"TextLeft", "TextRight"}) do
            local line = _G[name .. side .. i]
            if line then
                local text = line:GetText()
                if text then
                    for en, kr in pairs(SPEC_CLASS_KR) do
                        if text:find(en, 1, true) then
                            line:SetText(text:gsub(en, kr))
                            changed = true
                        end
                    end
                end
            end
        end
    end
    if changed then tooltip:Show() end
end

-- 패널 상태
local panel = nil
local rows  = {}
local activeTab = "bis"
local infoLines = {}  -- 정보 탭용 텍스트 라인

local function GetQualityColor(itemLink)
    if not itemLink then return COLOR.empty end
    local _, _, quality = GetItemInfo(itemLink)
    if quality and QUALITY_COLOR[quality] then return QUALITY_COLOR[quality] end
    return COLOR.label
end

-- ============================================================
-- 드롭다운
-- ============================================================
local function InitClassDropdown(dropdown)
    local viewingClass = ItemInfoBIS.GetViewingClassSpec()
    local info = UIDropDownMenu_CreateInfo()
    for _, cls in ipairs(ItemInfoBIS.CLASS_LIST) do
        info.text = cls.name
        info.arg1 = cls.id
        info.func = function(self, classId)
            UIDropDownMenu_SetText(dropdown, ItemInfoBIS.GetClassName(classId))
            ItemInfoBIS.LoadForSpec(classId, 1)
            local specNames = ItemInfoBIS.SPEC_NAMES[classId] or {}
            UIDropDownMenu_SetText(panel.specDropdown, specNames[1] or "?")
            UIDropDownMenu_Initialize(panel.specDropdown, InitSpecDropdown)
            for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
                local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
                if itemId then C_Item.RequestLoadItemDataByID(itemId) end
            end
            ItemInfoPanel.Refresh()
        end
        info.checked = (cls.id == viewingClass)
        UIDropDownMenu_AddButton(info)
    end
end

local function InitSpecDropdown(dropdown)
    local viewingClass, viewingSpec = ItemInfoBIS.GetViewingClassSpec()
    if not viewingClass then return end
    local specNames = ItemInfoBIS.SPEC_NAMES[viewingClass] or {}
    local info = UIDropDownMenu_CreateInfo()
    for i, specName in ipairs(specNames) do
        info.text = specName
        info.arg1 = i
        info.func = function(self, specIndex)
            UIDropDownMenu_SetText(dropdown, specNames[specIndex] or "?")
            ItemInfoBIS.LoadForSpec(viewingClass, specIndex)
            for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
                local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
                if itemId then C_Item.RequestLoadItemDataByID(itemId) end
            end
            ItemInfoPanel.Refresh()
        end
        info.checked = (i == viewingSpec)
        UIDropDownMenu_AddButton(info)
    end
end

-- ============================================================
-- 특성 복사 팝업
-- ============================================================
local function ShowTalentCopyPopup(talentString, playerName)
    if not ItemInfoTalentCopyFrame then
        local ef = CreateFrame("Frame", "ItemInfoTalentCopyFrame", UIParent, "BackdropTemplate")
        ef:SetSize(400, 80)
        ef:SetPoint("CENTER")
        ef:SetFrameStrata("FULLSCREEN_DIALOG")
        ef:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = {left=4, right=4, top=4, bottom=4},
        })
        ef:SetBackdropColor(0.05, 0.05, 0.1, 0.95)
        ef:SetBackdropBorderColor(0.3, 0.6, 1.0, 0.8)

        local t = ef:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        t:SetPoint("TOPLEFT", 8, -8)
        t:SetTextColor(1, 0.82, 0, 1)
        ef.title = t

        local eb = CreateFrame("EditBox", nil, ef, "InputBoxTemplate")
        eb:SetSize(380, 20)
        eb:SetPoint("BOTTOM", 0, 12)
        eb:SetAutoFocus(true)
        eb:SetScript("OnEscapePressed", function(self) self:GetParent():Hide() end)
        eb:SetScript("OnEnterPressed", function(self) self:GetParent():Hide() end)
        ef.editBox = eb

        local close = CreateFrame("Button", nil, ef, "UIPanelCloseButton")
        close:SetSize(20, 20)
        close:SetPoint("TOPRIGHT", -2, -2)
        close:SetScript("OnClick", function() ef:Hide() end)

        tinsert(UISpecialFrames, "ItemInfoTalentCopyFrame")
    end

    local cf = ItemInfoTalentCopyFrame
    cf.title:SetText("Ctrl+C (" .. (playerName or "") .. ")")
    cf.editBox:SetText(talentString)
    cf:Show()
    cf.editBox:HighlightText()
    cf.editBox:SetFocus()
end

-- ============================================================
-- 패널 생성
-- ============================================================
local function BuildPanel()
    local slotOrder = ItemInfoBIS.SLOT_ORDER
    local numSlots  = #slotOrder
    local panelH    = HEADER_HEIGHT + (numSlots * ROW_HEIGHT) + FOOTER_HEIGHT + PADDING

    local f = CreateFrame("Frame", "ItemInfoBISPanel", UIParent, "BackdropTemplate")
    f:SetSize(PANEL_WIDTH, panelH)
    f:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    f:SetBackdrop({
        bgFile   = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = {left=4, right=4, top=4, bottom=4},
    })
    f:SetBackdropColor(0.05, 0.05, 0.08, 0.95)
    f:SetBackdropBorderColor(0.4, 0.4, 0.5, 1)

    -- 타이틀
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", f, "TOPLEFT", PADDING, -6)
    title:SetTextColor(COLOR.title.r, COLOR.title.g, COLOR.title.b, 1)
    title:SetText("쐐기 상위 50")

    -- 닫기 버튼
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetSize(24, 24)
    closeBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- 클래스 드롭다운
    local classDD = CreateFrame("Frame", "ItemInfoClassDropdown", f, "UIDropDownMenuTemplate")
    classDD:SetPoint("TOPLEFT", f, "TOPLEFT", -8, -22)
    UIDropDownMenu_SetWidth(classDD, 100)
    UIDropDownMenu_Initialize(classDD, InitClassDropdown)
    f.classDropdown = classDD

    -- 스펙 드롭다운
    local specDD = CreateFrame("Frame", "ItemInfoSpecDropdown", f, "UIDropDownMenuTemplate")
    specDD:SetPoint("LEFT", classDD, "RIGHT", -16, 0)
    UIDropDownMenu_SetWidth(specDD, 80)
    UIDropDownMenu_Initialize(specDD, InitSpecDropdown)
    f.specDropdown = specDD

    -- ============================================================
    -- 탭 버튼 (6개)
    -- ============================================================
    f.tabButtons = {}
    local tabCount = #TABS
    local tabW = math.floor((PANEL_WIDTH - PADDING * 2 - (tabCount - 1) * 2) / tabCount)
    local tabH = 18

    for i, tab in ipairs(TABS) do
        local btn = CreateFrame("Button", nil, f, "BackdropTemplate")
        btn:SetSize(tabW, tabH)
        btn:SetPoint("TOPLEFT", f, "TOPLEFT", PADDING + (i - 1) * (tabW + 2), -54)
        btn:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 8, edgeSize = 8,
            insets = {left=2, right=2, top=2, bottom=2},
        })
        local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("CENTER")
        label:SetText(tab.name)
        btn.label = label
        btn.tabId = tab.id

        btn:SetScript("OnClick", function(self)
            activeTab = self.tabId
            -- BiS/장비 탭은 콘텐츠 타입 전환
            if self.tabId == "bis" then
                ItemInfoBIS.SetContentType("raid")
                local vc, vs = ItemInfoBIS.GetViewingClassSpec()
                if vc and vs then
                    ItemInfoBIS.LoadForSpec(vc, vs)
                    for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
                        local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
                        if itemId then C_Item.RequestLoadItemDataByID(itemId) end
                    end
                end
            elseif self.tabId == "gear" then
                ItemInfoBIS.SetContentType("mplus")
                local vc, vs = ItemInfoBIS.GetViewingClassSpec()
                if vc and vs then
                    ItemInfoBIS.LoadForSpec(vc, vs)
                    for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
                        local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
                        if itemId then C_Item.RequestLoadItemDataByID(itemId) end
                    end
                end
            end
            ItemInfoPanel.Refresh()
        end)

        f.tabButtons[i] = btn
    end

    -- 구분선 (헤더 아래)
    local divider = f:CreateTexture(nil, "ARTWORK")
    divider:SetSize(PANEL_WIDTH - 16, 1)
    divider:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -HEADER_HEIGHT)
    divider:SetColorTexture(0.4, 0.4, 0.5, 0.6)

    -- ============================================================
    -- 장비 행 (BiS/장비 탭용)
    -- ============================================================
    f.gearFrame = CreateFrame("Frame", nil, f)
    f.gearFrame:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -HEADER_HEIGHT)
    f.gearFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, FOOTER_HEIGHT)

    for i, slotId in ipairs(slotOrder) do
        local y = -((i - 1) * ROW_HEIGHT) - 4

        local row = CreateFrame("Frame", nil, f.gearFrame)
        row:SetSize(PANEL_WIDTH - 16, ROW_HEIGHT)
        row:SetPoint("TOPLEFT", f.gearFrame, "TOPLEFT", 8, y)
        row.slotId = slotId

        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.05)
        hl:Hide()
        row.highlight = hl

        local slotLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slotLabel:SetSize(SLOT_LABEL_W, ROW_HEIGHT)
        slotLabel:SetPoint("LEFT", row, "LEFT", 0, 0)
        slotLabel:SetJustifyH("LEFT")
        slotLabel:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
        slotLabel:SetText(ItemInfoBIS.SLOT_NAMES[slotId] or "?")

        local icon = row:CreateTexture(nil, "OVERLAY")
        icon:SetSize(ICON_SIZE, ICON_SIZE)
        icon:SetPoint("LEFT", row, "LEFT", SLOT_LABEL_W, 0)
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        icon:Hide()
        row.icon = icon

        local itemName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        itemName:SetSize(PANEL_WIDTH - 16 - SLOT_LABEL_W - ICON_SIZE - 24, ROW_HEIGHT)
        itemName:SetPoint("LEFT", icon, "RIGHT", 4, 0)
        itemName:SetJustifyH("LEFT")
        itemName:SetWordWrap(false)
        row.itemName = itemName

        local statusIcon = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        statusIcon:SetSize(16, ROW_HEIGHT)
        statusIcon:SetPoint("RIGHT", row, "RIGHT", 0, 0)
        statusIcon:SetJustifyH("RIGHT")
        row.statusIcon = statusIcon

        row:EnableMouse(true)
        row:SetScript("OnMouseUp", function(self)
            if IsModifiedClick("CHATLINK") then
                local bisLink = ItemInfoBIS.GetSlotBISItemLink(self.slotId)
                if bisLink then
                    local _, itemLink = GetItemInfo(bisLink)
                    if itemLink then
                        HandleModifiedItemClick(itemLink)
                    end
                end
            end
        end)
        row:SetScript("OnEnter", function(self)
            self.highlight:Show()
            local bisLink = ItemInfoBIS.GetSlotBISItemLink(self.slotId)
            if bisLink then
                GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
                GameTooltip:ClearAllPoints()
                local panelRight = panel:GetRight() or 0
                local panelLeft = panel:GetLeft() or 0
                local screenW = UIParent:GetWidth()
                local tooltipOnRight = (screenW - panelRight) > panelLeft
                if tooltipOnRight then
                    GameTooltip:SetPoint("TOPLEFT", panel, "TOPRIGHT", 4, 0)
                else
                    GameTooltip:SetPoint("TOPRIGHT", panel, "TOPLEFT", -4, 0)
                end
                ItemInfoBIS.panelTooltipActive = true
                GameTooltip:SetHyperlink(bisLink)
                local source = ItemInfoBIS.GetSlotBISSource(self.slotId)
                if source and source ~= "" then
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine("|cffffd700획득처:|r " .. source, 1, 1, 1)
                end
                GameTooltip:Show()
                LocalizeTooltipBIS(GameTooltip)
                if ItemInfoBIS.IsViewingOwnSpec() then
                    local equippedLink = GetInventoryItemLink("player", self.slotId)
                    if equippedLink then
                        local bisItemId = ItemInfoBIS.GetSlotBISItemId(self.slotId)
                        local equippedId = tonumber(equippedLink:match("|Hitem:(%d+):"))
                        if equippedId and bisItemId and equippedId ~= bisItemId then
                            ShoppingTooltip1:SetOwner(UIParent, "ANCHOR_NONE")
                            ShoppingTooltip1:ClearAllPoints()
                            local sid = self.slotId
                            if sid == 11 or sid == 12 or sid == 13 or sid == 14 or sid == 16 or sid == 17 then
                                ShoppingTooltip1:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 0, -4)
                            else
                                if tooltipOnRight then
                                    ShoppingTooltip1:SetPoint("TOPLEFT", GameTooltip, "TOPRIGHT", 4, 0)
                                else
                                    ShoppingTooltip1:SetPoint("TOPRIGHT", GameTooltip, "TOPLEFT", -4, 0)
                                end
                            end
                            ShoppingTooltip1:SetHyperlink(equippedLink)
                            ShoppingTooltip1:Show()
                            LocalizeTooltipBIS(ShoppingTooltip1)
                        end
                    end
                end
            end
        end)
        row:SetScript("OnLeave", function(self)
            self.highlight:Hide()
            ItemInfoBIS.panelTooltipActive = false
            GameTooltip:Hide()
            ShoppingTooltip1:Hide()
        end)

        rows[slotId] = row
    end

    -- ============================================================
    -- 정보 프레임 (스탯/마부/보석/특성 탭용)
    -- ============================================================
    f.infoFrame = CreateFrame("Frame", nil, f)
    f.infoFrame:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -HEADER_HEIGHT)
    f.infoFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, FOOTER_HEIGHT)
    f.infoFrame:Hide()

    -- 정보 행 (최대 20줄, 아이콘 + 라벨 + 텍스트 + 툴팁)
    infoLines = {}
    for i = 1, 20 do
        local row = CreateFrame("Frame", nil, f.infoFrame)
        row:SetSize(PANEL_WIDTH - 16, ROW_HEIGHT)
        row:SetPoint("TOPLEFT", f.infoFrame, "TOPLEFT", 8, -((i - 1) * ROW_HEIGHT) - 8)
        row:EnableMouse(true)

        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.05)
        hl:Hide()
        row.highlight = hl

        local icon = row:CreateTexture(nil, "OVERLAY")
        icon:SetSize(ICON_SIZE, ICON_SIZE)
        icon:SetPoint("LEFT", row, "LEFT", 4, 0)
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        icon:Hide()
        row.icon = icon

        local slotLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slotLabel:SetSize(SLOT_LABEL_W, ROW_HEIGHT)
        slotLabel:SetPoint("LEFT", icon, "RIGHT", 4, 0)
        slotLabel:SetJustifyH("LEFT")
        slotLabel:SetTextColor(0.6, 0.6, 0.6, 1)
        slotLabel:SetWordWrap(false)
        row.slotLabel = slotLabel

        local text = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetSize(PANEL_WIDTH - 24 - ICON_SIZE - SLOT_LABEL_W, ROW_HEIGHT)
        text:SetPoint("LEFT", slotLabel, "RIGHT", 2, 0)
        text:SetJustifyH("LEFT")
        text:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
        text:SetWordWrap(false)
        row.text = text

        -- 전체 너비 텍스트 (아이콘/슬롯 없을 때)
        local fullText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fullText:SetSize(PANEL_WIDTH - 24, ROW_HEIGHT)
        fullText:SetPoint("LEFT", row, "LEFT", 4, 0)
        fullText:SetJustifyH("LEFT")
        fullText:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
        fullText:SetWordWrap(false)
        fullText:Hide()
        row.fullText = fullText

        row.itemId = nil
        row.tooltipData = nil  -- {name, count, slot} 커스텀 툴팁용
        row:SetScript("OnMouseUp", function(self)
            if IsModifiedClick("CHATLINK") and self.itemId and self.itemId > 0 then
                -- 보너스 ID 포함 링크 생성
                local link = "item:" .. self.itemId .. "::::::::::::2:12806:13335"
                local _, itemLink = GetItemInfo(link)
                if itemLink then
                    HandleModifiedItemClick(itemLink)
                else
                    -- 폴백: 기본 링크
                    local _, baseLink = GetItemInfo(self.itemId)
                    if baseLink then HandleModifiedItemClick(baseLink) end
                end
            end
        end)
        row:SetScript("OnEnter", function(self)
            self.highlight:Show()
            ItemInfoBIS.panelTooltipActive = true
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

            if self.tooltipData and self.tooltipData.dps then
                -- 장신구: 보너스 ID 포함 아이템 툴팁 + DPS 랭킹
                local td = self.tooltipData
                local meta = ItemInfoTrinketMeta or {}
                if self.itemId and self.itemId > 0 then
                    local link = "item:" .. self.itemId .. "::::::::::::2:12806:13335"
                    GameTooltip:SetHyperlink(link)
                    ShoppingTooltip1:Hide()
                    ShoppingTooltip2:Hide()
                else
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(td.name or "?", 1, 0.82, 0)
                end
                -- 획득처
                if ItemInfoSourceCache and self.itemId then
                    local source = ItemInfoSourceCache[self.itemId]
                    if source then
                        GameTooltip:AddLine(" ")
                        GameTooltip:AddLine("|cffffd700획득처:|r " .. source, 1, 1, 1)
                    end
                end
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(string.format("|cffffffff시뮬레이션 DPS: |cff00ff00%s|r", td.dps))
                if td.rank then
                    GameTooltip:AddLine(string.format("|cffffffff랭킹: |cff00ff00%d위|r", td.rank))
                end
                GameTooltip:Show()
            elseif self.tooltipData and self.itemId and self.itemId > 0 then
                -- 아이템 툴팁 (효과 설명 포함) + 사용 인원수
                GameTooltip:SetHyperlink("item:" .. self.itemId)
                ShoppingTooltip1:Hide()
                ShoppingTooltip2:Hide()
                if self.tooltipData.count and self.tooltipData.count > 0 then
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine("|cffffffff상위 50명 중 |cff00ff00" .. self.tooltipData.count .. "명|r|cffffffff 사용|r")
                end
                GameTooltip:Show()
            elseif self.tooltipData then
                -- 아이템 ID 없을 때 커스텀 텍스트
                local td = self.tooltipData
                GameTooltip:ClearLines()
                GameTooltip:AddLine(td.name, 1, 0.82, 0)
                if td.count and td.count > 0 then
                    GameTooltip:AddLine("|cffffffff상위 50명 중 |cff00ff00" .. td.count .. "명|r|cffffffff 사용|r")
                end
                GameTooltip:Show()
            elseif self.itemId and self.itemId > 0 then
                GameTooltip:SetHyperlink("item:" .. self.itemId)
                ShoppingTooltip1:Hide()
                ShoppingTooltip2:Hide()
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function(self)
            self.highlight:Hide()
            ItemInfoBIS.panelTooltipActive = false
            GameTooltip:Hide()
            ShoppingTooltip1:Hide()
            ShoppingTooltip2:Hide()
        end)

        row:Hide()
        infoLines[i] = row
    end

    -- 특성 복사 버튼 (특성 탭 전용, 정보 프레임 하단)
    local talentCopyBtn = CreateFrame("Button", nil, f.infoFrame, "BackdropTemplate")
    talentCopyBtn:SetSize(PANEL_WIDTH - PADDING * 4, 24)
    talentCopyBtn:SetPoint("BOTTOM", f.infoFrame, "BOTTOM", 0, 8)
    talentCopyBtn:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 8, edgeSize = 8,
        insets = {left=2, right=2, top=2, bottom=2},
    })
    talentCopyBtn:SetBackdropColor(0.15, 0.4, 0.15, 0.8)
    talentCopyBtn:SetBackdropBorderColor(0.3, 0.6, 0.3, 0.8)
    local tcLabel = talentCopyBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    tcLabel:SetPoint("CENTER")
    tcLabel:SetText("|cff80ff80클릭하여 특성 복사|r")
    talentCopyBtn:SetScript("OnClick", function()
        local vc, vs = ItemInfoBIS.GetViewingClassSpec()
        if not vc or not vs or not ItemInfoTalentData then return end
        local cd = ItemInfoTalentData[vc]
        if not cd or not cd[vs] then
            print("|cffffd700[ItemInfo]|r 이 스펙의 특성 데이터가 없습니다.")
            return
        end
        ShowTalentCopyPopup(cd[vs][1], cd[vs][2] or "")
    end)
    talentCopyBtn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.2, 0.5, 0.2, 0.9)
    end)
    talentCopyBtn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.15, 0.4, 0.15, 0.8)
    end)
    talentCopyBtn:Hide()
    f.talentCopyBtn = talentCopyBtn

    -- ============================================================
    -- 푸터
    -- ============================================================
    local divider2 = f:CreateTexture(nil, "ARTWORK")
    divider2:SetSize(PANEL_WIDTH - 16, 1)
    divider2:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 8, FOOTER_HEIGHT)
    divider2:SetColorTexture(0.4, 0.4, 0.5, 0.6)

    local summary = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    summary:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PADDING, 22)
    summary:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
    f.summary = summary

    local metaText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    metaText:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PADDING, 6)
    metaText:SetTextColor(0.5, 0.5, 0.5, 1)
    f.metaText = metaText

    -- ESC는 패널이 포커스일 때만 닫기
    f:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    f:Hide()
    return f
end

-- ============================================================
-- 행 갱신 (BiS/장비 탭)
-- ============================================================
local function UpdateRow(slotId)
    local row = rows[slotId]
    if not row then return end

    local status  = ItemInfoBIS.GetSlotStatus(slotId)
    local itemId  = ItemInfoBIS.GetSlotBISItemId(slotId)

    if not itemId then
        row.itemName:SetText("|cff666666-|r")
        row.statusIcon:SetText("")
        row.icon:Hide()
        return
    end

    local bisLink = ItemInfoBIS.GetSlotBISItemLink(slotId)
    local bisName, _, _, _, _, _, _, _, _, bisIcon = GetItemInfo(bisLink or itemId)
    if bisIcon then
        row.icon:SetTexture(bisIcon)
        row.icon:Show()
    else
        row.icon:Hide()
    end

    local displayName = bisName or "|cff888888로딩 중...|r"
    local qColor = GetQualityColor(bisLink or itemId)

    row.itemName:SetTextColor(qColor.r, qColor.g, qColor.b, 1)
    row.itemName:SetText(displayName)

    if status == "bis" then
        row.statusIcon:SetText(STATUS_ICON.bis)
    elseif status == "upgrade" then
        row.statusIcon:SetText(STATUS_ICON.upgrade)
    else
        row.statusIcon:SetText("")
    end
end

-- ============================================================
-- 정보 탭 콘텐츠 표시
-- ============================================================
local function ClearInfoLines()
    for i = 1, #infoLines do
        local row = infoLines[i]
        row.icon:Hide()
        row.slotLabel:SetText("")
        row.text:SetText("")
        row.fullText:SetText("")
        row.fullText:Hide()
        row.slotLabel:Show()
        row.text:Show()
        row.itemId = nil
        row.highlight:Hide()
        row:Hide()
    end
    panel.talentCopyBtn:Hide()
end

--- 단순 텍스트 행 (아이콘 없음)
local function SetInfoLine(idx, text, r, g, b)
    if idx > #infoLines then return end
    local row = infoLines[idx]
    row.icon:Hide()
    row.slotLabel:Hide()
    row.text:Hide()
    row.fullText:SetText(text)
    if r then row.fullText:SetTextColor(r, g, b, 1)
    else row.fullText:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1) end
    row.fullText:Show()
    row.itemId = nil
    row:Show()
end

--- 아이템 행 (아이콘 + 슬롯 + 이름 + 툴팁)
-- tooltipOverride: {name, count, slot} 전달 시 커스텀 툴팁 사용
local function SetInfoItemLine(idx, slotText, itemName, itemId, tooltipOverride)
    if idx > #infoLines then return end
    local row = infoLines[idx]
    row.fullText:Hide()
    row.slotLabel:Show()
    row.text:Show()

    row.slotLabel:SetText(slotText or "")
    row.itemId = itemId

    row.tooltipData = tooltipOverride or nil

    -- 아이콘은 아이템 정보에서, 이름은 데이터 우선
    if itemId and itemId > 0 then
        local _, _, _, _, _, _, _, _, _, iconTexture = GetItemInfo(itemId)
        if iconTexture then
            row.icon:SetTexture(iconTexture)
            row.icon:Show()
        else
            row.icon:Hide()
            C_Item.RequestLoadItemDataByID(itemId)
        end
        local qColor = GetQualityColor(itemId)
        row.text:SetText(itemName or "|cff888888로딩 중...|r")
        row.text:SetTextColor(qColor.r, qColor.g, qColor.b, 1)
    else
        row.icon:Hide()
        row.text:SetText(itemName or "")
        row.text:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
    end

    row:Show()
end

local function GetExtraData()
    if not ItemInfoExtraData then return nil end
    local vc, vs = ItemInfoBIS.GetViewingClassSpec()
    if not vc or not vs then return nil end
    local cd = ItemInfoExtraData[vc]
    if not cd then return nil end
    return cd[vs]
end

local function RefreshStatsTab()
    ClearInfoLines()
    local data = GetExtraData()
    local line = 1

    SetInfoLine(line, "|cffffd700스탯 우선순위|r", 1, 0.84, 0)
    line = line + 1

    if data and data.stats then
        for i, stat in ipairs(data.stats) do
            SetInfoLine(line, "  " .. i .. ". |cffffffff" .. stat .. "|r")
            line = line + 1
        end
    else
        SetInfoLine(line, "  |cff888888데이터 없음|r")
    end
end

local function RefreshEmbelsTab()
    ClearInfoLines()
    local data = GetExtraData()
    local line = 1

    SetInfoLine(line, "|cffffd700장식|r", 1, 0.84, 0)
    line = line + 1

    if data and data.embellishments then
        for _, item in ipairs(data.embellishments) do
            local itemId = item.id or 0
            local name = item.name or ""
            local count = item.count or 0
            SetInfoItemLine(line, "", name, itemId, {name=name, count=count, slot=""})
            line = line + 1
            if line > #infoLines then break end
        end
    else
        SetInfoLine(line, "  |cff888888데이터 없음|r")
    end
end

local function RefreshEnchantsTab()
    ClearInfoLines()
    local data = GetExtraData()
    local line = 1

    SetInfoLine(line, "|cffffd700마법부여|r", 1, 0.84, 0)
    line = line + 1

    if data and data.enchantments then
        for _, ench in ipairs(data.enchantments) do
            local slot = ench.slot or ""
            local itemId = ench.id or 0
            local name = ench.name or ""
            local count = ench.count or 0
            SetInfoItemLine(line, slot, name, itemId, {name=name, count=count, slot=slot})
            line = line + 1
            if line > #infoLines then break end
        end
    else
        SetInfoLine(line, "  |cff888888데이터 없음|r")
    end
end

local function RefreshGemsTab()
    ClearInfoLines()
    local data = GetExtraData()
    local line = 1

    SetInfoLine(line, "|cffffd700보석|r", 1, 0.84, 0)
    line = line + 1

    if data and data.gems then
        for _, gem in ipairs(data.gems) do
            local itemId = gem.id or 0
            local name = gem.name or ""
            local count = gem.count or 0
            SetInfoItemLine(line, "", name, itemId, {name=name, count=count, slot=""})
            line = line + 1
            if line > #infoLines then break end
        end
    else
        SetInfoLine(line, "  |cff888888데이터 없음|r")
    end
end

local function RefreshTrinketsTab()
    ClearInfoLines()
    local vc, vs = ItemInfoBIS.GetViewingClassSpec()
    local line = 1

    SetInfoLine(line, "|cffffd700장신구 시뮬레이션 DPS 랭킹|r", 1, 0.84, 0)
    line = line + 1

    if not vc or not vs or not ItemInfoTrinketData then
        SetInfoLine(line, "  |cff888888데이터 없음|r")
        return
    end

    local cd = ItemInfoTrinketData[vc]
    if not cd or not cd[vs] then
        SetInfoLine(line, "  |cff888888이 스펙의 장신구 데이터가 없습니다.|r")
        SetInfoLine(line + 1, "  |cff888888(힐러/서포터 스펙은 미지원)|r")
        return
    end

    for rank, trinket in ipairs(cd[vs]) do
        if line > #infoLines then break end
        local itemId = trinket.id or 0
        local dps = trinket.dps or 0

        -- 한글 이름은 GetItemInfo에서 가져오기
        local koName = nil
        if itemId > 0 then
            koName = GetItemInfo(itemId)
            C_Item.RequestLoadItemDataByID(itemId)
        end
        local displayName = koName or trinket.name or "?"
        local dpsStr = string.format("|cff888888%s DPS|r", dps)

        -- 커스텀 툴팁 데이터 (아이템 툴팁 대신)
        local tooltipData = {
            name = displayName,
            dps = dps,
            rank = rank,
        }
        SetInfoItemLine(line, "", displayName .. "  " .. dpsStr, itemId, tooltipData)
        line = line + 1
    end
end

-- 클래스 색상 (WoW 표준)
local CLASS_COLOR = {
    DEATHKNIGHT={r=0.77,g=0.12,b=0.23}, DEMONHUNTER={r=0.64,g=0.19,b=0.79},
    DRUID={r=1.00,g=0.49,b=0.04},       EVOKER={r=0.20,g=0.58,b=0.50},
    HUNTER={r=0.67,g=0.83,b=0.45},      MAGE={r=0.25,g=0.78,b=0.92},
    MONK={r=0.00,g=1.00,b=0.59},        PALADIN={r=0.96,g=0.55,b=0.73},
    PRIEST={r=1.00,g=1.00,b=1.00},      ROGUE={r=1.00,g=0.96,b=0.41},
    SHAMAN={r=0.00,g=0.44,b=0.87},      WARLOCK={r=0.53,g=0.53,b=0.93},
    WARRIOR={r=0.78,g=0.61,b=0.43},
}

local function RefreshMetaTab()
    ClearInfoLines()
    local line = 1

    SetInfoLine(line, "|cffffd700쐐기 메타 순위|r (DPS / 힐러 / 탱커)", 1, 0.84, 0)
    line = line + 1

    if not ItemInfoMetaData then
        SetInfoLine(line, "  |cff888888데이터 없음|r")
        return
    end

    local ROLE_LABELS = {dps="DPS", healer="힐러", tank="탱커"}
    for _, role in ipairs({"dps", "healer", "tank"}) do
        local rankings = ItemInfoMetaData[role] or {}
        if #rankings > 0 and line <= #infoLines then
            SetInfoLine(line, "|cff00aaff▼ " .. ROLE_LABELS[role] .. "|r", 0, 0.67, 1)
            line = line + 1
            for _, r in ipairs(rankings) do
                if line > #infoLines then break end
                local color = CLASS_COLOR[r.classId] or {r=1,g=1,b=1}
                local hex = string.format("|cff%02x%02x%02x", color.r*255, color.g*255, color.b*255)
                local specNames = ItemInfoBIS.SPEC_NAMES[r.classId] or {}
                local className = ItemInfoBIS.GetClassName(r.classId) or r.classId
                local specName = specNames[r.specIndex] or "?"
                local text = string.format("  %d. %s%s %s|r  |cff888888%d|r",
                    r.rank, hex, specName, className, r.score)
                SetInfoLine(line, text)
                line = line + 1
            end
        end
    end
end

local function RefreshTalentsTab()
    ClearInfoLines()
    local vc, vs = ItemInfoBIS.GetViewingClassSpec()
    local line = 1

    SetInfoLine(line, "|cffffd700특성 빌드|r", 1, 0.84, 0)
    line = line + 1

    if not vc or not vs or not ItemInfoTalentData then
        SetInfoLine(line, "  |cff888888데이터 없음|r")
        return
    end

    local cd = ItemInfoTalentData[vc]
    if not cd or not cd[vs] then
        SetInfoLine(line, "  |cff888888이 스펙의 특성 데이터가 없습니다.|r")
        return
    end

    local entry = cd[vs]
    local playerName = entry[2] or ""
    local talentStr = entry[1] or ""

    SetInfoLine(line, "  |cffaaaaaa플레이어:|r |cffffffff" .. playerName .. "|r")
    line = line + 1
    SetInfoLine(line, " ")
    line = line + 1

    -- 특성 문자열 표시 (줄바꿈 분할)
    local charsPerLine = 40
    for i = 1, #talentStr, charsPerLine do
        local chunk = talentStr:sub(i, i + charsPerLine - 1)
        SetInfoLine(line, "  |cff80ff80" .. chunk .. "|r")
        line = line + 1
        if line > #infoLines then break end
    end

    -- 복사 버튼 표시
    panel.talentCopyBtn:Show()
end

-- ============================================================
-- 드롭다운 동기화
-- ============================================================
local function SyncDropdowns()
    if not panel then return end
    local viewingClass, viewingSpec = ItemInfoBIS.GetViewingClassSpec()
    if viewingClass then
        UIDropDownMenu_SetText(panel.classDropdown, ItemInfoBIS.GetClassName(viewingClass))
        local specNames = ItemInfoBIS.SPEC_NAMES[viewingClass] or {}
        UIDropDownMenu_SetText(panel.specDropdown, specNames[viewingSpec] or "?")
        UIDropDownMenu_Initialize(panel.specDropdown, InitSpecDropdown)
    end
end

-- ============================================================
-- 패널 전체 갱신
-- ============================================================
function ItemInfoPanel.Refresh()
    if not panel or not panel:IsShown() then return end

    SyncDropdowns()

    -- 탭 하이라이트
    for _, btn in ipairs(panel.tabButtons) do
        if btn.tabId == activeTab then
            btn:SetBackdropColor(0.2, 0.6, 1.0, 0.8)
            btn:SetBackdropBorderColor(0.3, 0.7, 1.0, 1)
            btn.label:SetTextColor(1, 1, 1, 1)
        else
            btn:SetBackdropColor(0.1, 0.1, 0.15, 0.6)
            btn:SetBackdropBorderColor(0.3, 0.3, 0.4, 0.6)
            btn.label:SetTextColor(0.5, 0.5, 0.5, 1)
        end
    end

    -- 탭별 콘텐츠 전환
    local isGearTab = (activeTab == "bis" or activeTab == "gear")

    if isGearTab then
        panel.gearFrame:Show()
        panel.infoFrame:Hide()

        for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
            UpdateRow(slotId)
        end

        -- 요약
        if not ItemInfoBIS.HasData() then
            panel.summary:SetText("|cffff6060데이터가 없습니다.|r")
        elseif ItemInfoBIS.IsViewingOwnSpec() then
            local bisCount, _, total = ItemInfoBIS.GetSummary()
            panel.summary:SetText(string.format("달성: |cffffd700%d|r / %d 슬롯", bisCount, total))
        else
            local _, _, total = ItemInfoBIS.GetSummary()
            panel.summary:SetText(string.format("%s — %d 슬롯", ItemInfoBIS.GetSpecLabel(), total))
        end

        local ctLabel = activeTab == "bis" and "레이드 가이드" or "쐐기 상위 50명"
        panel.metaText:SetText(ctLabel .. " | " .. ItemInfoBIS.GetUpdateDate())
    else
        panel.gearFrame:Hide()
        panel.infoFrame:Show()

        if activeTab == "stats" then
            RefreshStatsTab()
            panel.summary:SetText("스탯 우선순위")
        elseif activeTab == "embels" then
            RefreshEmbelsTab()
            panel.summary:SetText("장식")
        elseif activeTab == "enchants" then
            RefreshEnchantsTab()
            panel.summary:SetText("마법부여")
        elseif activeTab == "gems" then
            RefreshGemsTab()
            panel.summary:SetText("보석")
        elseif activeTab == "trinkets" then
            RefreshTrinketsTab()
            local meta = ItemInfoTrinketMeta or {}
            panel.summary:SetText(string.format("장신구 DPS 랭킹 (ilvl %d)", meta.ilvl or 0))
        elseif activeTab == "talents" then
            RefreshTalentsTab()
            panel.summary:SetText("특성 빌드")
        elseif activeTab == "meta" then
            RefreshMetaTab()
            panel.summary:SetText("쐐기 메타 순위")
        end

        if activeTab == "trinkets" then
            panel.metaText:SetText("bloodmallet.com | SimulationCraft")
        elseif activeTab == "meta" then
            panel.metaText:SetText("murlok.io 쐐기 메타 | 상위 50명 점수 기준")
        else
            panel.metaText:SetText("쐐기 상위 50명 | " .. ItemInfoBIS.GetUpdateDate())
        end
    end
end

-- ============================================================
-- 공개 API
-- ============================================================
function ItemInfoPanel.Init()
    if not panel then
        panel = BuildPanel()
    end
end

function ItemInfoPanel.Toggle()
    if not panel then return end
    if panel:IsShown() then
        panel:Hide()
    else
        ItemInfoBIS.LoadForCurrentSpec()
        for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
            local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
            if itemId then C_Item.RequestLoadItemDataByID(itemId) end
        end
        panel:Show()
        ItemInfoPanel.Refresh()
    end
end

function ItemInfoPanel.IsShown()
    return panel and panel:IsShown()
end
