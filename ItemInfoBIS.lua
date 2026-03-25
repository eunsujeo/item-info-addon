-- ItemInfoBIS.lua
-- BIS 체크 로직 및 아이템 정보 조회

ItemInfoBIS = {}

-- 현재 스펙의 활성 BIS 맵 { [slotId] = itemId }
local activeBIS = {}

-- 슬롯 ID → 한글 이름
ItemInfoBIS.SLOT_NAMES = {
    [1]  = "머리",
    [2]  = "목",
    [3]  = "어깨",
    [5]  = "가슴",
    [6]  = "허리",
    [7]  = "다리",
    [8]  = "발",
    [9]  = "손목",
    [10] = "손",
    [11] = "반지 1",
    [12] = "반지 2",
    [13] = "장신구 1",
    [14] = "장신구 2",
    [15] = "등",
    [16] = "주무기",
    [17] = "보조무기",
}

-- 슬롯 표시 순서
ItemInfoBIS.SLOT_ORDER = {1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17}

--- 현재 플레이어 클래스/스펙 반환
local function GetPlayerClassSpec()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    return class, specIndex
end

--- 현재 스펙의 BIS 데이터 로드
function ItemInfoBIS.LoadForCurrentSpec()
    activeBIS = {}
    local class, specIndex = GetPlayerClassSpec()
    if not class or not specIndex then return end
    if not ItemInfoBISData then return end
    local specData = ItemInfoBISData[class] and ItemInfoBISData[class][specIndex]
    if not specData then return end
    for slotId, itemId in pairs(specData) do
        activeBIS[slotId] = itemId
    end
end

--- 슬롯 BIS 상태 반환
-- @return "bis" | "upgrade" | nil
function ItemInfoBIS.GetSlotStatus(slotId)
    local bisItemId = activeBIS[slotId]
    if not bisItemId then return nil end
    local link = GetInventoryItemLink("player", slotId)
    if not link then return "upgrade" end
    local equippedId = tonumber(link:match("|Hitem:(%d+):"))
    return (equippedId == bisItemId) and "bis" or "upgrade"
end

--- 슬롯의 BIS 아이템 ID 반환
function ItemInfoBIS.GetSlotBISItemId(slotId)
    return activeBIS[slotId]
end

--- 슬롯의 BIS 아이템 이름 반환 (캐시 없으면 nil)
function ItemInfoBIS.GetSlotBISItemName(slotId)
    local itemId = activeBIS[slotId]
    if not itemId then return nil end
    local name = GetItemInfo(itemId)
    return name
end

--- 슬롯의 BIS 아이템 하이퍼링크 생성 (툴팁용)
function ItemInfoBIS.GetSlotBISItemLink(slotId)
    local itemId = activeBIS[slotId]
    if not itemId then return nil end
    return "item:" .. itemId
end

--- 현재 장착 아이템 이름 반환
function ItemInfoBIS.GetEquippedItemName(slotId)
    local link = GetInventoryItemLink("player", slotId)
    if not link then return nil end
    local name = GetItemInfo(link)
    return name
end

--- 전체 요약 반환
-- @return bisCount, upgradeCount, total
function ItemInfoBIS.GetSummary()
    local bisCount, upgradeCount, total = 0, 0, 0
    for slotId in pairs(activeBIS) do
        total = total + 1
        local status = ItemInfoBIS.GetSlotStatus(slotId)
        if status == "bis" then
            bisCount = bisCount + 1
        elseif status == "upgrade" then
            upgradeCount = upgradeCount + 1
        end
    end
    return bisCount, upgradeCount, total
end

--- BIS 데이터 존재 여부
function ItemInfoBIS.HasData()
    return next(activeBIS) ~= nil
end

--- 현재 스펙 표시명 반환 (패널 타이틀용)
function ItemInfoBIS.GetSpecLabel()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    if not specIndex then return class or "알 수 없음" end
    local _, specName = GetSpecializationInfo(specIndex)
    return (specName or "") .. " " .. (class or "")
end

--- 테스트용: BIS 맵 직접 주입
function ItemInfoBIS.SetActiveBIS(data)
    activeBIS = data or {}
end

--- 테스트용: 활성 BIS 맵 반환
function ItemInfoBIS.GetActiveBIS()
    return activeBIS
end
