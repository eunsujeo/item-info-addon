-- .luacheckrc
-- ItemInfo WoW 애드온 정적 분석 설정

max_line_length = 120
unused_args     = true
unused          = true
allow_defined_top = true

ignore = {
    "212", -- 미사용 변수 (루프 변수 포함)
    "611", -- 라인 끝 공백
    "614", -- 후행 공백 (주석)
}

globals = {
    -- 애드온 전역 테이블
    "ItemInfo",
    "ItemInfoBIS",
    "ItemInfoBISData",
    "ItemInfoBISMeta",
    "ItemInfoPanel",
    "ItemInfoDB",

    -- WoW 프레임/UI
    "CreateFrame",
    "UIParent",
    "GameTooltip",
    "ShoppingTooltip1",
    "BackdropTemplate",
    "UIDropDownMenu_Initialize",
    "UIDropDownMenu_CreateInfo",
    "UIDropDownMenu_AddButton",
    "UIDropDownMenu_SetWidth",
    "UIDropDownMenu_SetText",

    -- WoW 유닛/스펙 API
    "UnitClass",
    "GetSpecialization",
    "GetSpecializationInfo",

    -- WoW 아이템 API
    "GetInventoryItemLink",
    "GetItemInfo",
    "C_Item",

    -- WoW 슬래시 커맨드
    "SlashCmdList",
    "SLASH_ITEMINFO1",
    "SLASH_ITEMINFO2",

    -- WoW 유틸
    "_G",
    "ReloadUI",
    "string",
    "math",
    "table",

    -- 테스트 목업 헬퍼
    "MockWowApi_SetItem",
    "MockWowApi_Reset",
}

files = {
    ["tests/*.lua"] = {
        globals = {
            "describe", "it", "before_each", "after_each",
            "setup", "teardown", "assert", "dofile", "require", "_G",
        },
        ignore = {
            "212", -- 미사용 인자
            "213", -- 미사용 루프 변수
            "131", -- 미사용 전역 (WoW API 목업)
        },
    },
}
