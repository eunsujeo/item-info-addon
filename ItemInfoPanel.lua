-- ItemInfoPanel.lua
-- BIS 전용 독립 패널 (드래그 이동 가능, 툴팁 비교 지원)

ItemInfoPanel = {}

-- 상수
local PANEL_WIDTH   = 280
local ROW_HEIGHT    = 22
local HEADER_HEIGHT = 28
local FOOTER_HEIGHT = 26
local SLOT_LABEL_W  = 60
local PADDING       = 8

-- 상태 색상
local COLOR = {
    bis     = {r=0.2,  g=1.0,  b=0.2},  -- 초록: BIS 장착
    upgrade = {r=1.0,  g=0.5,  b=0.1},  -- 주황: 업그레이드 가능
    empty   = {r=0.6,  g=0.6,  b=0.6},  -- 회색: 슬롯 비어 있음
    nodata  = {r=0.4,  g=0.4,  b=0.4},  -- 어두운 회색: BIS 데이터 없음
    label   = {r=0.8,  g=0.8,  b=0.8},
    title   = {r=1.0,  g=0.84, b=0.0},  -- 금색
}

-- 상태 아이콘 텍스트
local STATUS_ICON = {
    bis     = "|cff33ff33✓|r",
    upgrade = "|cffff8020✗|r",
    empty   = "|cff999999—|r",
}

-- 패널 프레임 및 행 캐시
local panel = nil
local rows  = {}

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
    title:SetPoint("TOPLEFT", f, "TOPLEFT", PADDING, -8)
    title:SetTextColor(COLOR.title.r, COLOR.title.g, COLOR.title.b, 1)
    f.title = title

    -- 닫기 버튼
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetSize(24, 24)
    closeBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

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

        -- 아이템 이름
        local itemName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        itemName:SetSize(PANEL_WIDTH - 16 - SLOT_LABEL_W - 20, ROW_HEIGHT)
        itemName:SetPoint("LEFT", row, "LEFT", SLOT_LABEL_W, 0)
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
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(bisLink)
                GameTooltip:ShowCompareItem()
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function(self)
            self.highlight:Hide()
            GameTooltip:Hide()
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
    summary:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PADDING, 8)
    summary:SetTextColor(COLOR.label.r, COLOR.label.g, COLOR.label.b, 1)
    f.summary = summary

    f:Hide()
    return f
end

--- 행 하나 갱신
local function UpdateRow(slotId)
    local row = rows[slotId]
    if not row then return end

    local status  = ItemInfoBIS.GetSlotStatus(slotId)
    local bisName = ItemInfoBIS.GetSlotBISItemName(slotId)

    if not ItemInfoBIS.GetSlotBISItemId(slotId) then
        -- BIS 데이터 없는 슬롯 (이 스펙에 미지원)
        row.itemName:SetText("|cff666666-|r")
        row.statusIcon:SetText("")
        return
    end

    local displayName = bisName or "|cff888888로딩 중...|r"

    if status == "bis" then
        row.itemName:SetTextColor(COLOR.bis.r, COLOR.bis.g, COLOR.bis.b, 1)
        row.itemName:SetText(displayName)
        row.statusIcon:SetText(STATUS_ICON.bis)
    elseif status == "upgrade" then
        row.itemName:SetTextColor(COLOR.upgrade.r, COLOR.upgrade.g, COLOR.upgrade.b, 1)
        row.itemName:SetText(displayName)
        row.statusIcon:SetText(STATUS_ICON.upgrade)
    else
        -- 슬롯 비어 있음 (BIS 데이터는 있으나 아이템 미장착)
        row.itemName:SetTextColor(COLOR.empty.r, COLOR.empty.g, COLOR.empty.b, 1)
        row.itemName:SetText(displayName)
        row.statusIcon:SetText(STATUS_ICON.empty)
    end
end

--- 패널 전체 갱신
function ItemInfoPanel.Refresh()
    if not panel or not panel:IsShown() then return end

    -- 타이틀 업데이트
    panel.title:SetText(ItemInfoBIS.GetSpecLabel())

    -- 행 갱신
    for _, slotId in ipairs(ItemInfoBIS.SLOT_ORDER) do
        UpdateRow(slotId)
    end

    -- 요약
    if ItemInfoBIS.HasData() then
        local bisCount, _, total = ItemInfoBIS.GetSummary()
        panel.summary:SetText(string.format(
            "BIS 달성: |cffd700%d|r / %d 슬롯", bisCount, total
        ))
    else
        panel.summary:SetText("|cffff6060이 스펙의 BIS 데이터가 없습니다.|r")
    end
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
