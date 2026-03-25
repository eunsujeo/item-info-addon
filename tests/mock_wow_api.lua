-- tests/mock_wow_api.lua
-- WoW API 전역 함수 목업 (busted 오프라인 테스트용)

-- ============================================================
-- 기본 Lua 환경에 없는 WoW 전역 설정
-- ============================================================

-- 아이템 링크 샘플 데이터
-- 형식: |Hitem:ID:enchantID:gem1:gem2:gem3:gem4:...|h[이름]|h|r
local MOCK_ITEMS = {
    -- slotId → { link, ilvl, quality, enchantId }
    [1]  = { link="|Hitem:211408:6625:0:0:0:0:0:0:0:0|h[선지자의 투구]|h|r",  ilvl=489, quality=4, enchant="6625" },
    [3]  = { link="|Hitem:211410:0:0:0:0:0:0:0:0:0|h[선지자의 어깨]|h|r",    ilvl=489, quality=4, enchant="0"    },
    [5]  = { link="|Hitem:211412:6578:0:0:0:0:0:0:0:0|h[선지자의 흉갑]|h|r", ilvl=489, quality=4, enchant="6578" },
    [16] = { link="|Hitem:211430:6632:0:0:0:0:0:0:0:0|h[선지자의 검]|h|r",   ilvl=496, quality=4, enchant="6632" },
}

-- 내구도 목업 데이터 (slotId → {current, max})
local MOCK_DURABILITY = {
    [1]  = {current=100, max=100},
    [3]  = {current=10,  max=100},  -- 10% → 낮음
    [5]  = {current=50,  max=100},
    [16] = {current=25,  max=100},  -- 25% → 경계
}

-- ============================================================
-- WoW API 목업 함수
-- ============================================================

function GetInventoryItemLink(unit, slotId)
    if unit ~= "player" then return nil end
    local item = MOCK_ITEMS[slotId]
    return item and item.link or nil
end

function GetItemInfo(itemLink)
    for _, item in pairs(MOCK_ITEMS) do
        if item.link == itemLink then
            -- name, link, quality, ilvl, minLevel, type, subType, stackCount, equipLoc, texture, sellPrice
            return "아이템명", item.link, item.quality, item.ilvl, 70, "무기", nil, 1, "INVTYPE_HEAD", nil, 0
        end
    end
    return nil
end

function GetDetailedItemLevelInfo(itemLink)
    for _, item in pairs(MOCK_ITEMS) do
        if item.link == itemLink then
            return item.ilvl, false, item.ilvl
        end
    end
    return nil
end

function GetInventoryItemDurability(slotId)
    local dur = MOCK_DURABILITY[slotId]
    if dur then
        return dur.current, dur.max
    end
    return nil, nil
end

-- ============================================================
-- 테스트 헬퍼
-- ============================================================

--- 특정 슬롯의 목업 아이템을 교체 (테스트 케이스별 시나리오 설정용)
-- @param slotId number
-- @param item table|nil  nil이면 빈 슬롯
function MockWowApi_SetItem(slotId, item)
    MOCK_ITEMS[slotId] = item
end

--- 내구도 목업 교체
function MockWowApi_SetDurability(slotId, current, max)
    MOCK_DURABILITY[slotId] = {current=current, max=max}
end

--- 목업 초기화 (테스트 격리)
function MockWowApi_Reset()
    MOCK_ITEMS = {
        [1]  = { link="|Hitem:211408:6625:0:0:0:0:0:0:0:0|h[선지자의 투구]|h|r",  ilvl=489, quality=4, enchant="6625" },
        [3]  = { link="|Hitem:211410:0:0:0:0:0:0:0:0:0|h[선지자의 어깨]|h|r",    ilvl=489, quality=4, enchant="0"    },
        [5]  = { link="|Hitem:211412:6578:0:0:0:0:0:0:0:0|h[선지자의 흉갑]|h|r", ilvl=489, quality=4, enchant="6578" },
        [16] = { link="|Hitem:211430:6632:0:0:0:0:0:0:0:0|h[선지자의 검]|h|r",   ilvl=496, quality=4, enchant="6632" },
    }
    MOCK_DURABILITY = {
        [1]  = {current=100, max=100},
        [3]  = {current=10,  max=100},
        [5]  = {current=50,  max=100},
        [16] = {current=25,  max=100},
    }
end
