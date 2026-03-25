-- ItemInfoBIS.lua
-- BIS 체크 로직 및 아이템 정보 조회

ItemInfoBIS = {}

-- 현재 스펙의 활성 BIS 맵 { [slotId] = {itemId, {bonusId1, bonusId2, ...}, "획득처"} }
local activeBIS = {}

-- 현재 조회 중인 클래스/스펙 (nil이면 자기 캐릭터)
local viewingClass = nil
local viewingSpec  = nil

-- 콘텐츠 타입 ("mplus" 또는 "raid")
local activeContentType = "mplus"

-- 콘텐츠 타입 상수
ItemInfoBIS.CONTENT_TYPES = {
    {id = "mplus", name = "M+"},
    {id = "raid",  name = "레이드"},
}

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

-- 클래스 한글 이름 (표시 순서 겸용)
ItemInfoBIS.CLASS_LIST = {
    {id="DEATHKNIGHT",  name="죽음의 기사"},
    {id="DEMONHUNTER",  name="악마사냥꾼"},
    {id="DRUID",        name="드루이드"},
    {id="EVOKER",       name="기원사"},
    {id="HUNTER",       name="사냥꾼"},
    {id="MAGE",         name="마법사"},
    {id="MONK",         name="수도사"},
    {id="PALADIN",      name="성기사"},
    {id="PRIEST",       name="사제"},
    {id="ROGUE",        name="도적"},
    {id="SHAMAN",       name="주술사"},
    {id="WARLOCK",      name="흑마법사"},
    {id="WARRIOR",      name="전사"},
}

-- 클래스별 특성 이름
ItemInfoBIS.SPEC_NAMES = {
    ["DEATHKNIGHT"]  = {"혈기", "냉기", "부정"},
    ["DEMONHUNTER"]  = {"파멸", "복수"},
    ["DRUID"]        = {"조화", "야성", "수호", "회복"},
    ["EVOKER"]       = {"황폐", "보존", "증강"},
    ["HUNTER"]       = {"야수", "사격", "생존"},
    ["MAGE"]         = {"비전", "화염", "냉기"},
    ["MONK"]         = {"양조", "안개", "풍운"},
    ["PALADIN"]      = {"신성", "보호", "징벌"},
    ["PRIEST"]       = {"수양", "신성", "암흑"},
    ["ROGUE"]        = {"암살", "무법", "잠행"},
    ["SHAMAN"]       = {"정기", "고양", "복원"},
    ["WARLOCK"]      = {"고통", "악마", "파괴"},
    ["WARRIOR"]      = {"무기", "분노", "방어"},
}

--- 현재 플레이어 클래스/스펙 반환
local function GetPlayerClassSpec()
    local _, class = UnitClass("player")
    local specIndex = GetSpecialization()
    return class, specIndex
end

--- 콘텐츠 타입 설정
function ItemInfoBIS.SetContentType(contentType)
    activeContentType = contentType or "mplus"
end

--- 현재 콘텐츠 타입 반환
function ItemInfoBIS.GetContentType()
    return activeContentType
end

--- 메타데이터 반환
function ItemInfoBIS.GetMeta()
    return ItemInfoBISMeta or {}
end

--- 업데이트 날짜 반환
function ItemInfoBIS.GetUpdateDate()
    local meta = ItemInfoBIS.GetMeta()
    return meta.updatedAt or "알 수 없음"
end

--- 데이터 설명 반환
function ItemInfoBIS.GetSourceDescription()
    local meta = ItemInfoBIS.GetMeta()
    return meta.description or ""
end

--- 특정 클래스/스펙의 BIS 데이터 로드
function ItemInfoBIS.LoadForSpec(class, specIndex)
    activeBIS = {}
    viewingClass = class
    viewingSpec = specIndex
    if not class or not specIndex then return end
    if not ItemInfoBISData then return end
    -- 콘텐츠 타입별 데이터 참조
    local contentData = ItemInfoBISData[activeContentType]
    if not contentData then return end
    local specData = contentData[class] and contentData[class][specIndex]
    if not specData then return end
    for slotId, entry in pairs(specData) do
        if type(entry) == "table" then
            activeBIS[slotId] = entry
        else
            activeBIS[slotId] = {entry, {}}
        end
    end
end

--- 현재 스펙의 BIS 데이터 로드
function ItemInfoBIS.LoadForCurrentSpec()
    local class, specIndex = GetPlayerClassSpec()
    ItemInfoBIS.LoadForSpec(class, specIndex)
end

--- 현재 자기 캐릭터의 BIS를 보고 있는지 여부
function ItemInfoBIS.IsViewingOwnSpec()
    local class, specIndex = GetPlayerClassSpec()
    return viewingClass == class and viewingSpec == specIndex
end

--- 현재 조회 중인 클래스/스펙 반환
function ItemInfoBIS.GetViewingClassSpec()
    return viewingClass, viewingSpec
end

--- 슬롯 BIS 상태 반환 (다른 직업이면 nil)
-- @return "bis" | "upgrade" | nil
function ItemInfoBIS.GetSlotStatus(slotId)
    local entry = activeBIS[slotId]
    if not entry then return nil end
    if not ItemInfoBIS.IsViewingOwnSpec() then return nil end
    local bisItemId = entry[1]
    local link = GetInventoryItemLink("player", slotId)
    if not link then return "upgrade" end
    local equippedId = tonumber(link:match("|Hitem:(%d+):"))
    return (equippedId == bisItemId) and "bis" or "upgrade"
end

--- 슬롯의 BIS 아이템 ID 반환
function ItemInfoBIS.GetSlotBISItemId(slotId)
    local entry = activeBIS[slotId]
    if not entry then return nil end
    return entry[1]
end

--- 슬롯의 BIS 아이템 이름 반환 (캐시 없으면 nil)
function ItemInfoBIS.GetSlotBISItemName(slotId)
    local itemId = ItemInfoBIS.GetSlotBISItemId(slotId)
    if not itemId then return nil end
    local name = GetItemInfo(itemId)
    return name
end

--- 슬롯의 BIS 아이템 하이퍼링크 생성 (툴팁용, 보너스 ID 포함)
function ItemInfoBIS.GetSlotBISItemLink(slotId)
    local entry = activeBIS[slotId]
    if not entry then return nil end
    local itemId = entry[1]
    local bonusIds = entry[2]
    if not bonusIds or #bonusIds == 0 then
        return "item:" .. itemId
    end
    -- item:ID:enchant:gem1:gem2:gem3:gem4:suffix:unique:level:spec:upgradeType:instanceDifficulty:numBonuses:b1:b2:...
    local parts = {"item", itemId, "", "", "", "", "", "", "", "", "", "", ""}
    parts[#parts + 1] = #bonusIds
    for _, b in ipairs(bonusIds) do
        parts[#parts + 1] = b
    end
    return table.concat(parts, ":")
end

--- 슬롯의 BIS 아이템 획득처 반환
function ItemInfoBIS.GetSlotBISSource(slotId)
    local entry = activeBIS[slotId]
    if not entry then return nil end
    return entry[3]
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

--- 현재 조회 중인 스펙 표시명 반환 (패널 타이틀용)
function ItemInfoBIS.GetSpecLabel()
    local class = viewingClass
    local specIndex = viewingSpec
    if not class or not specIndex then return "알 수 없음" end
    local specNames = ItemInfoBIS.SPEC_NAMES[class]
    local specName = specNames and specNames[specIndex] or "?"
    local className = "?"
    for _, c in ipairs(ItemInfoBIS.CLASS_LIST) do
        if c.id == class then className = c.name break end
    end
    return specName .. " " .. className
end

--- 클래스 영문 ID → 한글 이름
function ItemInfoBIS.GetClassName(classId)
    for _, c in ipairs(ItemInfoBIS.CLASS_LIST) do
        if c.id == classId then return c.name end
    end
    return classId
end

--- 테스트용: BIS 맵 직접 주입
function ItemInfoBIS.SetActiveBIS(data)
    activeBIS = data or {}
end

--- 테스트용: 활성 BIS 맵 반환
function ItemInfoBIS.GetActiveBIS()
    return activeBIS
end
