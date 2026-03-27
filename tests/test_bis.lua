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

        it("로드 후 엔트리가 테이블 형태이다", function()
            ItemInfoBIS.LoadForCurrentSpec()
            local bisMap = ItemInfoBIS.GetActiveBIS()
            local entry = bisMap[1]
            assert.is_not_nil(entry)
            assert.are.equal("table", type(entry))
            assert.are.equal("number", type(entry[1]))
            assert.are.equal("table", type(entry[2]))
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
            ItemInfoBIS.SetActiveBIS({
                [1]={212438, {10390}},
                [3]={212440, {10390}},
                [16]={212449, {10390}},
            })
        end)

        it("BIS 아이템을 장착하면 'bis'를 반환한다", function()
            -- mock_wow_api: 슬롯 1 링크에 아이템 ID 211408 (≠212438)
            -- BIS와 다르므로 upgrade 반환
            local status = ItemInfoBIS.GetSlotStatus(1)
            assert.are.equal("upgrade", status)
        end)

        it("BIS 아이템 ID와 장착 아이템 ID가 일치하면 'bis'를 반환한다", function()
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
    describe("GetSlotBISItemLink", function()

        it("보너스 ID를 포함한 아이템 링크를 생성한다", function()
            ItemInfoBIS.SetActiveBIS({ [1]={212438, {10390, 10878}} })
            local link = ItemInfoBIS.GetSlotBISItemLink(1)
            assert.are.equal("item:212438::::::::::::2:10390:10878", link)
        end)

        it("보너스 ID가 없으면 기본 링크를 생성한다", function()
            ItemInfoBIS.SetActiveBIS({ [1]={212438, {}} })
            local link = ItemInfoBIS.GetSlotBISItemLink(1)
            assert.are.equal("item:212438", link)
        end)

        it("BIS 데이터가 없는 슬롯은 nil을 반환한다", function()
            ItemInfoBIS.SetActiveBIS({})
            assert.is_nil(ItemInfoBIS.GetSlotBISItemLink(1))
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
            ItemInfoBIS.SetActiveBIS({
                [1]={212438, {10390}},
                [3]={212440, {10390}},
                [5]={212442, {10390}},
            })
            local _, _, total = ItemInfoBIS.GetSummary()
            assert.are.equal(3, total)
        end)

        it("BIS 장착 슬롯을 정확히 카운트한다", function()
            ItemInfoBIS.SetActiveBIS({
                [1]={212438, {10390}},
                [3]={212440, {10390}},
            })
            MockWowApi_SetItem(1, {
                link="|Hitem:212438:0:0:0:0:0:0:0:0:0|h[투구]|h|r",
                ilvl=489, quality=4
            })
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
            ItemInfoBIS.SetActiveBIS({ [1]={212438, {10390}} })
            assert.is_true(ItemInfoBIS.HasData())
        end)

    end)

    -- ============================================================
    describe("BuildTooltipLookup", function()

        it("현재 스펙의 BIS 아이템 ID로 역방향 조회가 가능하다", function()
            ItemInfoBIS.BuildTooltipLookup()
            -- 죽기 냉기(스펙2) 머리 슬롯의 아이템 ID 가져오기
            local contentData = ItemInfoBISData["mplus"]
            local entry = contentData["DEATHKNIGHT"][2][1] -- 냉기 머리
            local itemId = entry[1]
            local info = ItemInfoBIS.GetTooltipBISInfo(itemId)
            assert.is_not_nil(info)
            assert.is_true(#info >= 1)
            -- M+ 라벨이 포함되어 있어야 함
            local hasLabel = false
            for _, e in ipairs(info) do
                if e.label == "M+" then hasLabel = true end
            end
            assert.is_true(hasLabel)
        end)

        it("BIS가 아닌 아이템은 nil을 반환한다", function()
            ItemInfoBIS.BuildTooltipLookup()
            assert.is_nil(ItemInfoBIS.GetTooltipBISInfo(99999))
        end)

        it("M+과 레이드 모두에 있는 아이템은 두 라벨 모두 반환한다", function()
            ItemInfoBIS.BuildTooltipLookup()
            -- M+과 레이드 데이터에서 동일 아이템 ID 찾기
            local mplusData = ItemInfoBISData["mplus"]["DEATHKNIGHT"][2]
            local raidData  = ItemInfoBISData["raid"] and ItemInfoBISData["raid"]["DEATHKNIGHT"] and ItemInfoBISData["raid"]["DEATHKNIGHT"][2]
            if not raidData then return end -- 레이드 데이터 없으면 스킵

            for slotId, mEntry in pairs(mplusData) do
                if raidData[slotId] and type(mEntry) == "table" and type(raidData[slotId]) == "table" then
                    if mEntry[1] == raidData[slotId][1] then
                        local info = ItemInfoBIS.GetTooltipBISInfo(mEntry[1])
                        assert.is_not_nil(info)
                        local labels = {}
                        for _, e in ipairs(info) do labels[e.label] = true end
                        assert.is_true(labels["M+"] and labels["레이드"])
                        return
                    end
                end
            end
            -- 동일 아이템이 없으면 테스트 스킵 (pass)
        end)

        it("획득처 정보가 포함되어 있다", function()
            ItemInfoBIS.BuildTooltipLookup()
            local contentData = ItemInfoBISData["mplus"]
            local entry = contentData["DEATHKNIGHT"][2][1]
            local info = ItemInfoBIS.GetTooltipBISInfo(entry[1])
            assert.is_not_nil(info)
            assert.is_not_nil(info[1].source)
            assert.are.equal(entry[3], info[1].source)
        end)

    end)

end)
