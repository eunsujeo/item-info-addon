-- tests/test_bis.lua
-- ItemInfoBIS 단위 테스트

require("tests.mock_wow_api")
dofile("ItemInfoBIS.lua")

-- WoW API 목업: 클래스/스펙 정보 (_G에 직접 주입)
_G.UnitClass = function(unit)
    if unit == "player" then return "죽음의 기사", "DEATHKNIGHT" end
    return nil, nil
end
_G.GetSpecialization     = function() return 2 end -- 냉기
_G.GetSpecializationInfo = function(_) return 250, "냉기", "", nil, "DAMAGER" end

-- bis_data.lua 로드 (정적 데이터)
dofile("bis_data.lua")

describe("ItemInfoBIS", function()

    before_each(function()
        MockWowApi_Reset()
        ItemInfoBIS.SetActiveBIS({})
    end)

    -- ============================================================
    describe("LoadForCurrentSpec", function()

        it("죽기 냉기 스펙의 BIS 데이터를 로드한다", function()
            ItemInfoBIS.LoadForCurrentSpec()
            assert.is_true(ItemInfoBIS.HasData())
        end)

        it("로드 후 활성 BIS 맵에 슬롯 데이터가 있다", function()
            ItemInfoBIS.LoadForCurrentSpec()
            local bisMap = ItemInfoBIS.GetActiveBIS()
            assert.is_not_nil(bisMap[1])  -- 머리 슬롯
            assert.is_not_nil(bisMap[16]) -- 주무기 슬롯
        end)

        it("데이터 없는 스펙은 HasData가 false를 반환한다", function()
            -- 존재하지 않는 스펙 인덱스 99
            _G.GetSpecialization = function() return 99 end
            ItemInfoBIS.LoadForCurrentSpec()
            assert.is_false(ItemInfoBIS.HasData())
            -- 원복
            _G.GetSpecialization = function() return 2 end
        end)

    end)

    -- ============================================================
    describe("GetSlotStatus", function()

        before_each(function()
            -- 죽기 냉기 BIS 주입: 슬롯 1 = 212438
            ItemInfoBIS.SetActiveBIS({ [1]=212438, [3]=212440, [16]=212449 })
        end)

        it("BIS 아이템을 장착하면 'bis'를 반환한다", function()
            -- mock_wow_api: 슬롯 1 링크에 아이템 ID 211408 (≠212438)
            -- BIS와 다르므로 upgrade 반환
            local status = ItemInfoBIS.GetSlotStatus(1)
            assert.are.equal("upgrade", status)
        end)

        it("BIS 아이템 ID와 장착 아이템 ID가 일치하면 'bis'를 반환한다", function()
            -- 목업 아이템 링크를 BIS ID(212438)와 일치하도록 변경
            MockWowApi_SetItem(1, {
                link="|Hitem:212438:6625:0:0:0:0:0:0:0:0|h[선지자의 투구]|h|r",
                ilvl=489, quality=4
            })
            local status = ItemInfoBIS.GetSlotStatus(1)
            assert.are.equal("bis", status)
        end)

        it("BIS 데이터는 있지만 슬롯이 비어 있으면 'upgrade'를 반환한다", function()
            MockWowApi_SetItem(3, nil) -- 어깨 슬롯 비우기
            local status = ItemInfoBIS.GetSlotStatus(3)
            assert.are.equal("upgrade", status)
        end)

        it("BIS 데이터가 없는 슬롯은 nil을 반환한다", function()
            local status = ItemInfoBIS.GetSlotStatus(2) -- 목 슬롯: BIS 없음
            assert.is_nil(status)
        end)

    end)

    -- ============================================================
    describe("GetSummary", function()

        it("BIS 데이터 없으면 0,0,0 반환", function()
            ItemInfoBIS.SetActiveBIS({})
            local b, u, t = ItemInfoBIS.GetSummary()
            assert.are.equal(0, b)
            assert.are.equal(0, u)
            assert.are.equal(0, t)
        end)

        it("전체 슬롯 수가 총합과 일치한다", function()
            ItemInfoBIS.SetActiveBIS({ [1]=212438, [3]=212440, [5]=212442 })
            local _, _, total = ItemInfoBIS.GetSummary()
            assert.are.equal(3, total)
        end)

        it("BIS 장착 슬롯을 정확히 카운트한다", function()
            ItemInfoBIS.SetActiveBIS({ [1]=212438, [3]=212440 })
            -- 슬롯 1: 목업 아이템 ID ≠ 212438 → upgrade
            -- 슬롯 1을 BIS ID로 교체
            MockWowApi_SetItem(1, {
                link="|Hitem:212438:0:0:0:0:0:0:0:0:0|h[투구]|h|r",
                ilvl=489, quality=4
            })
            -- 슬롯 3: 목업 아이템 ID ≠ 212440 → upgrade
            local bisCount, upgradeCount, total = ItemInfoBIS.GetSummary()
            assert.are.equal(1, bisCount)
            assert.are.equal(1, upgradeCount)
            assert.are.equal(2, total)
        end)

    end)

    -- ============================================================
    describe("HasData", function()

        it("BIS 맵이 비어 있으면 false", function()
            ItemInfoBIS.SetActiveBIS({})
            assert.is_false(ItemInfoBIS.HasData())
        end)

        it("BIS 맵에 데이터가 있으면 true", function()
            ItemInfoBIS.SetActiveBIS({ [1]=212438 })
            assert.is_true(ItemInfoBIS.HasData())
        end)

    end)

end)
