-- ItemInfoPanel.lua
-- BIS 전용 독립 패널 (드래그 이동 가능, 툴팁 비교 지원)

ItemInfoPanel = {}

-- 상수
local PANEL_WIDTH   = 300
local ROW_HEIGHT    = 22
local HEADER_HEIGHT = 76
local FOOTER_HEIGHT = 40
local ICON_SIZE     = 18
local SLOT_LABEL_W  = 60
local PADDING       = 8

-- 상태 색상
local COLOR = {
    bis     = {r=0.2,  g=1.0,  b=0.2},  -- 초록: BIS 장착
    empty   = {r=0.6,  g=0.6,  b=0.6},  -- 회색: 슬롯 비어 있음
    nodata  = {r=0.4,  g=0.4,  b=0.4},  -- 어두운 회색: BIS 데이터 없음
    label   = {r=0.8,  g=0.8,  b=0.8},
    title   = {r=1.0,  g=0.84, b=0.0},  -- 금색
}

-- 아이템 등급 색상
local QUALITY_COLOR = {
    [0] = {r=0.62, g=0.62, b=0.62}, -- Poor (회색)
    [1] = {r=1.0,  g=1.0,  b=1.0},  -- Common (흰색)
    [2] = {r=0.12, g=1.0,  b=0.0},  -- Uncommon (녹색)
    [3] = {r=0.0,  g=0.44, b=0.87}, -- Rare (파란색)
    [4] = {r=0.64, g=0.21, b=0.93}, -- Epic (보라색)
    [5] = {r=1.0,  g=0.50, b=0.0},  -- Legendary (주황색)
}

-- 상태 아이콘 (WoW 내장 텍스처)
local STATUS_ICON = {
    bis     = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14|t",
    upgrade = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14|t",
    empty   = "|TInterface\\RaidFrame\\ReadyCheck-Waiting:14|t",
}

-- 영어 스펙/클래스 → 한글 변환 (툴팁 BIS 태그용)
local SPEC_CLASS_KR = {
    ["Blood Death Knight"]         = "혈기 죽음의 기사",
    ["Frost Death Knight"]         = "냉기 죽음의 기사",
    ["Unholy Death Knight"]        = "부정 죽음의 기사",
    ["Havoc Demon Hunter"]         = "파멸 악마사냥꾼",
    ["Vengeance Demon Hunter"]     = "복수 악마사냥꾼",
    ["Balance Druid"]              = "조화 드루이드",
    ["Feral Druid"]                = "야성 드루이드",
    ["Guardian Druid"]             = "수호 드루이드",
    ["Restoration Druid"]          = "회복 드루이드",
    ["Devastation Evoker"]         = "황폐 기원사",
    ["Preservation Evoker"]        = "보존 기원사",
    ["Augmentation Evoker"]        = "증강 기원사",
    ["Beast Mastery Hunter"]       = "야수 사냥꾼",
    ["Marksmanship Hunter"]        = "사격 사냥꾼",
    ["Survival Hunter"]            = "생존 사냥꾼",
    ["Arcane Mage"]                = "비전 마법사",
    ["Fire Mage"]                  = "화염 마법사",
    ["Frost Mage"]                 = "냉기 마법사",
    ["Brewmaster Monk"]            = "양조 수도사",
    ["Mistweaver Monk"]            = "안개 수도사",
    ["Windwalker Monk"]            = "풍운 수도사",
    ["Holy Paladin"]               = "신성 성기사",
    ["Protection Paladin"]         = "보호 성기사",
    ["Retribution Paladin"]        = "징벌 성기사",
    ["Discipline Priest"]          = "수양 사제",
    ["Holy Priest"]                = "신성 사제",
    ["Shadow Priest"]              = "암흑 사제",
    ["Assassination Rogue"]        = "암살 도적",
    ["Outlaw Rogue"]               = "무법 도적",
    ["Subtlety Rogue"]             = "잠행 도적",
    ["Elemental Shaman"]           = "정기 주술사",
    ["Enhancement Shaman"]         = "고양 주술사",
    ["Restoration Shaman"]         = "복원 주술사",
    ["Affliction Warlock"]         = "고통 흑마법사",
    ["Demonology Warlock"]         = "악마 흑마법사",
    ["Destruction Warlock"]        = "파괴 흑마법사",
    ["Arms Warrior"]               = "무기 전사",
    ["Fury Warrior"]               = "분노 전사",
    ["Protection Warrior"]         = "방어 전사",
}

--- 툴팁 내 영어 스펙/클래스명을 한글로 변환
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

-- 패널 프레임 및 행 캐시
local panel = nil
local rows  = {}

--- 아이템 등급에 따른 색상 반환 (보너스 ID 포함 링크 사용)
local function GetQualityColor(itemLink)
    if not itemLink then return COLOR.empty end
    local _, _, quality = GetItemInfo(itemLink)
    if quality and QUALITY_COLOR[quality] then
        return QUALITY_COLOR[quality]
    end
    return COLOR.label
end

--- 클래스/스펙 드롭다운 초기화
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

--- 패널 생성
local function BuildPanel()
    local slotOrder = ItemInfoBIS.SLOT_ORDER
    local numSlots  = #slotOrder
    local panelH    = HEADER_HEIGHT + (numSlots * ROW_HEIGHT) + FOOTER_HEIGHT + PADDING

    -- 메인 프레임
    local f = CreateFrame("Frame", "ItemInfoBISPanel", UIParent,
                          "BackdropTemplate")
    f:SetSize(PANEL_WIDTH, panelH)
    f:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    f:SetFrameStrata("DIALOG")
    tinsert(UISpecialFrames, "ItemInfoBISPanel")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop",  f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    -- 배경
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
    title:SetText("TOP USER 50")
    f.title = title

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

    -- 특성 드롭다운
    local specDD = CreateFrame("Frame", "ItemInfoSpecDropdown", f, "UIDropDownMenuTemplate")
    specDD:SetPoint("LEFT", classDD, "RIGHT", -16, 0)
    UIDropDownMenu_SetWidth(specDD, 80)
    UIDropDownMenu_Initialize(specDD, InitSpecDropdown)
    f.specDropdown = specDD

    -- 콘텐츠 타입 토글 버튼 (M+ / 레이드)
    f.contentButtons = {}
    local btnWidth = 60
    local btnHeight = 18
    for i, ct in ipairs(ItemInfoBIS.CONTENT_TYPES) do
        local btn = CreateFrame("Button", nil, f, "BackdropTemplate")
        btn:SetSize(btnWidth, btnHeight)
        btn:SetPoint("TOPLEFT", f, "TOPLEFT", PADDING + (i - 1) * (btnWidth + 4), -54)
        btn:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 8, edgeSize = 8,
            insets = {left=2, right=2, top=2, bottom=2},
        })
        local label = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("CENTER")
        label:SetText(ct.name)
        btn.label = label
        btn.contentId = ct.id
        btn:SetScript("OnClick", function(self)
            ItemInfoBIS.SetContentType(self.contentId)
            local viewingClass, viewingSpec = ItemInfoBIS.GetViewingClassSpec()
            if viewingClass and viewingSpec then
                ItemInfoBIS.LoadForSpec(viewingClass, viewingSpec)
                for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
                    local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
                    if itemId then C_Item.RequestLoadItemDataByID(itemId) end
                end
            end
            ItemInfoPanel.Refresh()
        end)
        f.contentButtons[i] = btn
    end

    -- 구분선 (헤더 아래)
    local divider = f:CreateTexture(nil, "ARTWORK")
    divider:SetSize(PANEL_WIDTH - 16, 1)
    divider:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -HEADER_HEIGHT)
    divider:SetColorTexture(0.4, 0.4, 0.5, 0.6)

    -- 슬롯 행 생성
    for i, slotId in ipairs(slotOrder) do
        local y = -HEADER_HEIGHT - ((i - 1) * ROW_HEIGHT) - 4

        local row = CreateFrame("Frame", nil, f)
        row:SetSize(PANEL_WIDTH - 16, ROW_HEIGHT)
        row:SetPoint("TOPLEFT", f, "TOPLEFT", 8, y)
        row.slotId = slotId

        -- 호버 하이라이트
        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.05)
        hl:Hide()
        row.highlight = hl

        -- 슬롯 이름 레이블
        local slotLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slotLabel:SetSize(SLOT_LABEL_W, ROW_HEIGHT)
        slotLabel:SetPoint("LEFT", row, "LEFT", 0, 0)
        slotLabel:SetJustifyH("LEFT")
        slotLabel:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
        slotLabel:SetText(ItemInfoBIS.SLOT_NAMES[slotId] or "?")
        row.slotLabel = slotLabel

        -- 아이템 아이콘
        local icon = row:CreateTexture(nil, "OVERLAY")
        icon:SetSize(ICON_SIZE, ICON_SIZE)
        icon:SetPoint("LEFT", row, "LEFT", SLOT_LABEL_W, 0)
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        icon:Hide()
        row.icon = icon

        -- 아이템 이름
        local itemName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        itemName:SetSize(PANEL_WIDTH - 16 - SLOT_LABEL_W - ICON_SIZE - 24, ROW_HEIGHT)
        itemName:SetPoint("LEFT", icon, "RIGHT", 4, 0)
        itemName:SetJustifyH("LEFT")
        itemName:SetWordWrap(false)
        row.itemName = itemName

        -- 상태 아이콘 (우측)
        local statusIcon = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        statusIcon:SetSize(16, ROW_HEIGHT)
        statusIcon:SetPoint("RIGHT", row, "RIGHT", 0, 0)
        statusIcon:SetJustifyH("RIGHT")
        row.statusIcon = statusIcon

        -- 툴팁 이벤트
        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            self.highlight:Show()
            local bisLink = ItemInfoBIS.GetSlotBISItemLink(self.slotId)
            if bisLink then
                -- BIS 툴팁: 패널 옆에 수동 배치
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
                -- 자기 캐릭터일 때만 장착 아이템 비교 툴팁
                if ItemInfoBIS.IsViewingOwnSpec() then
                    local equippedLink = GetInventoryItemLink("player", self.slotId)
                    if equippedLink then
                        -- 같은 아이템이면 비교 툴팁 생략
                        local bisItemId = ItemInfoBIS.GetSlotBISItemId(self.slotId)
                        local equippedId = tonumber(equippedLink:match("|Hitem:(%d+):"))
                        if equippedId and bisItemId and equippedId ~= bisItemId then
                            ShoppingTooltip1:SetOwner(UIParent, "ANCHOR_NONE")
                            ShoppingTooltip1:ClearAllPoints()
                            -- 반지/장신구/무기는 아래에, 나머지는 옆에 배치
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

    -- 구분선 (푸터 위)
    local divider2 = f:CreateTexture(nil, "ARTWORK")
    divider2:SetSize(PANEL_WIDTH - 16, 1)
    divider2:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 8, FOOTER_HEIGHT)
    divider2:SetColorTexture(0.4, 0.4, 0.5, 0.6)

    -- 요약 텍스트 (하단)
    local summary = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    summary:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PADDING, 22)
    summary:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
    f.summary = summary

    -- 메타 정보 (업데이트 날짜)
    local metaText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    metaText:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PADDING, 6)
    metaText:SetTextColor(0.5, 0.5, 0.5, 1)
    f.metaText = metaText

    f:Hide()
    return f
end

--- 행 하나 갱신
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

    if status == "bis" then
        -- 자기 캐릭터 + BIS 장착: 아이템 등급 색상 + 체크마크
        row.itemName:SetTextColor(qColor.r, qColor.g, qColor.b, 1)
        row.itemName:SetText(displayName)
        row.statusIcon:SetText(STATUS_ICON.bis)
    elseif status == "upgrade" then
        -- 자기 캐릭터 + 업그레이드 필요: 아이템 등급 색상
        row.itemName:SetTextColor(qColor.r, qColor.g, qColor.b, 1)
        row.itemName:SetText(displayName)
        row.statusIcon:SetText(STATUS_ICON.upgrade)
    else
        -- 다른 직업이거나 상태 없음: 아이템 등급 색상
        row.itemName:SetTextColor(qColor.r, qColor.g, qColor.b, 1)
        row.itemName:SetText(displayName)
        row.statusIcon:SetText("")
    end
end

--- 드롭다운 텍스트 동기화
local function SyncDropdowns()
    if not panel then return end
    local viewingClass, viewingSpec = ItemInfoBIS.GetViewingClassSpec()
    if viewingClass then
        UIDropDownMenu_SetText(panel.classDropdown, ItemInfoBIS.GetClassName(viewingClass))
        local specNames = ItemInfoBIS.SPEC_NAMES[viewingClass] or {}
        UIDropDownMenu_SetText(panel.specDropdown, specNames[viewingSpec] or "?")
        -- 특성 드롭다운 재초기화 (클래스 변경 시 목록 갱신)
        UIDropDownMenu_Initialize(panel.specDropdown, InitSpecDropdown)
    end
end

--- 패널 전체 갱신
function ItemInfoPanel.Refresh()
    if not panel or not panel:IsShown() then return end

    SyncDropdowns()

    -- 콘텐츠 타입 토글 하이라이트
    local currentCT = ItemInfoBIS.GetContentType()
    for _, btn in ipairs(panel.contentButtons) do
        if btn.contentId == currentCT then
            btn:SetBackdropColor(0.2, 0.6, 1.0, 0.8)
            btn:SetBackdropBorderColor(0.3, 0.7, 1.0, 1)
            btn.label:SetTextColor(1, 1, 1, 1)
        else
            btn:SetBackdropColor(0.1, 0.1, 0.15, 0.6)
            btn:SetBackdropBorderColor(0.3, 0.3, 0.4, 0.6)
            btn.label:SetTextColor(0.5, 0.5, 0.5, 1)
        end
    end

    -- 행 갱신
    for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
        UpdateRow(slotId)
    end

    -- 요약
    if not ItemInfoBIS.HasData() then
        panel.summary:SetText("|cffff6060이 콘텐츠의 데이터가 없습니다.|r")
    elseif ItemInfoBIS.IsViewingOwnSpec() then
        local bisCount, _, total = ItemInfoBIS.GetSummary()
        panel.summary:SetText(string.format(
            "달성: |cffffd700%d|r / %d 슬롯", bisCount, total
        ))
    else
        local _, _, total = ItemInfoBIS.GetSummary()
        panel.summary:SetText(string.format(
            "%s — %d 슬롯", ItemInfoBIS.GetSpecLabel(), total
        ))
    end

    -- 메타 정보
    local updateDate = ItemInfoBIS.GetUpdateDate()
    local ctLabel = currentCT == "raid" and "레이드 가이드" or "쐐기 상위 50명"
    panel.metaText:SetText(ctLabel .. " | 업데이트: " .. updateDate)
end

--- 패널 초기화 (최초 1회)
function ItemInfoPanel.Init()
    if not panel then
        panel = BuildPanel()
    end
end

--- 패널 토글
function ItemInfoPanel.Toggle()
    if not panel then return end
    if panel:IsShown() then
        panel:Hide()
    else
        ItemInfoBIS.LoadForCurrentSpec()
        -- 캐시 안 된 아이템 미리 요청
        for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
            local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
            if itemId then
                C_Item.RequestLoadItemDataByID(itemId)
            end
        end
        panel:Show()
        ItemInfoPanel.Refresh()
    end
end

--- 패널이 열려 있는지 확인
function ItemInfoPanel.IsShown()
    return panel and panel:IsShown()
end
