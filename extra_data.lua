-- extra_data.lua
-- 스탯 우선순위 / 장식 / 마법부여 / 보석 (murlok.io 상위 50명 기준)
-- 업데이트: 2026-03-27

ItemInfoExtraData = {}

ItemInfoExtraData["DEATHKNIGHT"] = {
    [1] = { -- 혈기
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=30},
            {name="Arcanoweave Lining", id=240167, count=17},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Blessing of Speed", id=267242, count=12},
            {slot="Shoulders", name="Enchant Shoulders - Akil'zon's Swiftness", id=267057, count=12},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=24},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=35},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=18},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=273834, count=13},
            {slot="Main Hand", name="Rune of Sanguination", id=264683, count=27},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=19},
            {name="Flawless Masterful Garnet", id=240908, count=16},
        },
        top_player = "us/stormrage/snarfknight",
    },
    [2] = { -- 냉기
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=6},
            {name="Arcanoweave Lining", id=240167, count=3},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Blessing of Speed", id=267242, count=4},
            {slot="Shoulders", name="Enchant Shoulders - Flight of the Eagle", id=267057, count=3},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=5},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=7},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=5},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=8},
            {slot="Main Hand", name="Rune of the Fallen Crusader", id=264453, count=7},
            {slot="Off Hand", name="Rune of the Fallen Crusader", id=264453, count=1},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=4},
            {name="Flawless Masterful Garnet", id=240908, count=13},
        },
        top_player = "eu/ravencrest/freggy",
    },
    [3] = { -- 부정
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=42},
            {name="Arcanoweave Lining", id=240167, count=16},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Blessing of Speed", id=267242, count=14},
            {slot="Shoulders", name="Enchant Shoulders - Flight of the Eagle", id=267057, count=13},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=40},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=43},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=14},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=56},
            {slot="Main Hand", name="Rune of the Apocalypse", id=264453, count=49},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=24},
            {name="Flawless Deadly Amethyst", id=240898, count=41},
        },
        top_player = "us/azralon/melinhaz",
    },
}

ItemInfoExtraData["DEMONHUNTER"] = {
    [1] = { -- 파멸
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=43},
            {name="Arcanoweave Lining", id=240167, count=36},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=14},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=22},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=41},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=35},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=24},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=43},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=37},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=35},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=28},
            {name="Flawless Masterful Garnet", id=240908, count=50},
        },
        top_player = "us/area-52/gcdhacker",
    },
    [2] = { -- 복수
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=44},
            {name="Loa Worshiper's Band", id=0, count=20},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Hex of Leeching", id=267057, count=9},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=6},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=25},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=29},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=10},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=18},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=21},
            {slot="Off Hand", name="Enchant Weapon - Berserker's Rage", id=267057, count=14},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=22},
            {name="Flawless Deadly Peridot", id=240890, count=18},
        },
        top_player = "eu/blackrock/rampire",
    },
}

ItemInfoExtraData["DRUID"] = {
    [1] = { -- 조화
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=42},
            {name="Arcanoweave Lining", id=240167, count=16},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=17},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=19},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=34},
            {slot="Hands", name="Enchant Gloves - Zandalari Surveying", id=159468, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=31},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=22},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=30},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=45},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=23},
            {name="Flawless Quick Amethyst", id=240900, count=27},
        },
        top_player = "us/illidan/justtinsucks",
    },
    [2] = { -- 야성
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=240167, count=33},
            {name="Hunt", id=245876, count=27},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Rune of Avoidance", id=267057, count=10},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=12},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=29},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=40},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=13},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=25},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=42},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=14},
            {name="Flawless Quick Amethyst", id=240899, count=18},
        },
        top_player = "eu/archimonde/turbogronil",
    },
    [3] = { -- 수호
        stats = {"가속", "유연성", "특화", "치명타"},
        embellishments = {
            {name="Hunt", id=245876, count=26},
            {name="Arcanoweave Lining", id=240167, count=24},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Hex of Leeching", id=267057, count=8},
            {slot="Shoulders", name="Enchant Shoulders - Akil'zon's Swiftness", id=267057, count=7},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=26},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=27},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=10},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=27},
            {slot="Main Hand", name="Enchant Weapon - Berserker's Rage", id=267057, count=31},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=9},
            {name="Flawless Versatile Peridot", id=240894, count=30},
        },
        top_player = "us/nagrand/awooweewaa",
    },
    [4] = { -- 회복
        stats = {"가속", "특화", "유연성", "치명타"},
        embellishments = {
            {name="Hunt", id=245876, count=42},
            {name="Arcanoweave Lining", id=240167, count=6},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=16},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=17},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=24},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=22},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=12},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=36},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=42},
        },
        gems = {
            {name="Cubic Blasphemia", id=217115, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=19},
            {name="Flawless Masterful Peridot", id=240892, count=26},
        },
        top_player = "eu/twisting-nether/deidah",
    },
}

ItemInfoExtraData["EVOKER"] = {
    [1] = { -- 황폐
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=45},
            {name="Arcanoweave Lining", id=240167, count=23},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=19},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=23},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=42},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=36},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=26},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=273834, count=39},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=48},
        },
        gems = {
            {name="Elusive Blasphemite", id=213746, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=34},
            {name="Flawless Quick Garnet", id=240906, count=48},
        },
        top_player = "us/zuljin/lizzimcguire",
    },
    [2] = { -- 보존
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=40},
            {name="Arcanoweave Lining", id=240167, count=10},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=26},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=29},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=29},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=26},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=22},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=48},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=41},
        },
        gems = {
            {name="Insightful Blasphemite", id=213740, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=28},
            {name="Flawless Quick Amethyst", id=240900, count=49},
        },
        top_player = "eu/blackhand/snowpi",
    },
    [3] = { -- 증강
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=41},
            {name="Arcanoweave Lining", id=240167, count=19},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=17},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=23},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=35},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=28},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=26},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=273834, count=51},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=50},
        },
        gems = {
            {name="Culminating Blasphemite", id=213743, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=31},
            {name="Flawless Quick Garnet", id=240906, count=43},
        },
        top_player = "us/malganis/qbgosa",
    },
}

ItemInfoExtraData["HUNTER"] = {
    [1] = { -- 야수
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Root Warden's Regalia", id=0, count=66},
            {name="Hunt", id=245876, count=10},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=17},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=18},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=36},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=42},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=27},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=33},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=42},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=22},
            {name="Flawless Deadly Amethyst", id=240898, count=24},
        },
        top_player = "eu/dalaran/hqnkzr",
    },
    [2] = { -- 사격
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Root Warden's Regalia", id=0, count=62},
            {name="Hunt", id=245876, count=8},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=12},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=12},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=36},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=42},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=21},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=70},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=45},
        },
        gems = {
            {name="Powerful Eversong Diamond", id=240967, count=18},
            {name="Flawless Masterful Garnet", id=240908, count=35},
        },
        top_player = "us/stormrage/morthunt",
    },
    [3] = { -- 생존
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=40},
            {name="Arcanoweave Lining", id=240167, count=26},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Rune of Avoidance", id=267057, count=12},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=14},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=30},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=41},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=28},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=44},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=28},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=27},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=15},
            {name="Flawless Deadly Amethyst", id=240898, count=32},
        },
        top_player = "eu/hyjal/govanovic",
    },
}

ItemInfoExtraData["MAGE"] = {
    [1] = { -- 비전
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=27},
            {name="Blood", id=245872, count=17},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Rune of Avoidance", id=267057, count=17},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=17},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=35},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=17},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=17},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=32},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=45},
        },
        gems = {
            {name="Culminating Blasphemite", id=213743, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=18},
            {name="Flawless Deadly Amethyst", id=240898, count=15},
        },
        top_player = "us/sargeras/hairumageone",
    },
    [2] = { -- 화염
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=22},
            {name="Arcanoweave Lining", id=240167, count=9},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=7},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=5},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=19},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=13},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=7},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=14},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=26},
        },
        gems = {
            {name="Powerful Eversong Diamond", id=240967, count=9},
            {name="Flawless Masterful Peridot", id=240892, count=15},
        },
        top_player = "eu/hyjal/pogulemage",
    },
    [3] = { -- 냉기
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=41},
            {name="Arcanoweave Lining", id=240167, count=27},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=20},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=19},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=40},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=32},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=22},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=37},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=48},
        },
        gems = {
            {name="Powerful Eversong Diamond", id=240967, count=23},
            {name="Flawless Deadly Amethyst", id=240898, count=30},
        },
        top_player = "us/malganis/manabananaz",
    },
}

ItemInfoExtraData["MONK"] = {
    [1] = { -- 양조
        stats = {"치명타", "유연성", "특화", "가속"},
        embellishments = {
            {name="Loa Worshiper's Band", id=0, count=21},
            {name="Stabilizing Gemstone Bandolier", id=251490, count=13},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=21},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=23},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=35},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=32},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=22},
            {slot="Rings", name="Enchant Ring - Silvermoon's Tenacity", id=273834, count=22},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=38},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=2},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=26},
            {name="Flawless Deadly Lapis", id=240914, count=29},
        },
        top_player = "eu/ravencrest/monksea",
    },
    [2] = { -- 안개
        stats = {"가속", "치명타", "유연성", "특화"},
        embellishments = {
            {name="Void", id=245874, count=27},
            {name="Hunt", id=245876, count=7},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Hex of Leeching", id=267057, count=15},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=14},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=21},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=11},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=12},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=36},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=34},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=20},
            {name="Flawless Deadly Peridot", id=240890, count=42},
        },
        top_player = "us/zuljin/aluraye",
    },
    [3] = { -- 풍운
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Loa Worshiper's Band", id=0, count=32},
            {name="Hunt", id=245876, count=27},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=13},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=21},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=29},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=33},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=21},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=42},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=46},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=13},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=30},
            {name="Flawless Deadly Peridot", id=240890, count=34},
        },
        top_player = "us/sargeras/yuptik",
    },
}

ItemInfoExtraData["PALADIN"] = {
    [1] = { -- 신성
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=42},
            {name="Arcanoweave Lining", id=240167, count=35},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=21},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=32},
            {slot="Chest", name="Enchant Chest - Mark of the Magister", id=268545, count=29},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=26},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=23},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=46},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=47},
        },
        gems = {
            {name="Telluric Eversong Diamond", id=240969, count=20},
            {name="Flawless Quick Amethyst", id=240900, count=30},
        },
        top_player = "us/azuremyst/dpalx",
    },
    [2] = { -- 보호
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=240167, count=45},
            {name="Hunt", id=245876, count=28},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Hex of Leeching", id=267057, count=14},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=10},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=22},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=31},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=13},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=23},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=25},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=19},
            {name="Flawless Versatile Peridot", id=240894, count=19},
        },
        top_player = "us/sargeras/equinoxpal",
    },
    [3] = { -- 징벌
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=44},
            {name="Arcanoweave Lining", id=240167, count=15},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Blessing of Speed", id=267242, count=13},
            {slot="Shoulders", name="Enchant Shoulders - Akil'zon's Swiftness", id=267057, count=19},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=33},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=41},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=20},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=37},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=47},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=25},
            {name="Flawless Quick Amethyst", id=240900, count=28},
        },
        top_player = "us/nathrezim/melee",
    },
}

ItemInfoExtraData["PRIEST"] = {
    [1] = { -- 수양
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=36},
            {name="Arcanoweave Cord", id=240167, count=4},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=18},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=18},
            {slot="Chest", name="Enchant Chest - Mark of the Magister", id=268545, count=19},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=27},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=20},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=32},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=29},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=22},
            {name="Flawless Deadly Peridot", id=240890, count=31},
        },
        top_player = "eu/blackrock/jinx",
    },
    [2] = { -- 신성
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=44},
            {name="Arcanoweave Lining", id=240167, count=15},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=20},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=18},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=19},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=23},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=17},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=273834, count=32},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=38},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=21},
            {name="Flawless Versatile Garnet", id=240910, count=22},
        },
        top_player = "us/stormrage/clemenz",
    },
    [3] = { -- 암흑
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=42},
            {name="Arcanoweave Lining", id=240167, count=5},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=10},
            {slot="Shoulders", name="Enchant Shoulders - Akil'zon's Swiftness", id=267057, count=9},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=37},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=32},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=13},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=42},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=22},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=27},
            {name="Flawless Quick Amethyst", id=240900, count=29},
        },
        top_player = "eu/ysondre/etzyk",
    },
}

ItemInfoExtraData["ROGUE"] = {
    [1] = { -- 암살
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=11},
            {name="Arcanoweave Lining", id=240167, count=10},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Hex of Leeching", id=267057, count=5},
            {slot="Shoulders", name="Enchant Shoulders - Thalassian Recovery", id=268480, count=3},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=9},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=10},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=3},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=9},
            {slot="Main Hand", name="Enchant Weapon - Berserker's Rage", id=267057, count=9},
            {slot="Off Hand", name="Enchant Weapon - Berserker's Rage", id=267057, count=7},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=4},
            {name="Flawless Quick Garnet", id=240906, count=14},
        },
        top_player = "us/proudmoore/sap",
    },
    [2] = { -- 무법
        stats = {"치명타", "가속", "유연성", "특화"},
        embellishments = {
            {name="Void", id=245874, count=19},
            {name="Arcanoweave Lining", id=240167, count=14},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=8},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=7},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=18},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=19},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=7},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=32},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=21},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=18},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=10},
            {name="Flawless Deadly Peridot", id=240890, count=16},
        },
        top_player = "us/stormrage/Ã§l",
    },
    [3] = { -- 잠행
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=49},
            {name="Arcanoweave Lining", id=240167, count=46},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=17},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=23},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=35},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=38},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=24},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=38},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=43},
            {slot="Off Hand", name="Enchant Weapon - Arcane Mastery", id=267654, count=26},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=30},
            {name="Flawless Deadly Amethyst", id=240898, count=21},
        },
        top_player = "us/proudmoore/slimthiq",
    },
}

ItemInfoExtraData["SHAMAN"] = {
    [1] = { -- 정기
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=35},
            {name="Root Warden's Regalia", id=0, count=20},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=23},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=21},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=45},
            {slot="Hands", name="Enchant Gloves - Legion Skinning", id=128560, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=32},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=24},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=40},
            {slot="Main Hand", name="Enchant Weapon - Arcane Mastery", id=267654, count=33},
        },
        gems = {
            {name="Powerful Eversong Diamond", id=240967, count=16},
            {name="Flawless Deadly Amethyst", id=240898, count=27},
        },
        top_player = "eu/ragnaros/netherax",
    },
    [2] = { -- 고양
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=49},
            {name="Arcanoweave Lining", id=240167, count=38},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Rune of Avoidance", id=267057, count=14},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=17},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=34},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=38},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=27},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=46},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=41},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=37},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=20},
            {name="Flawless Quick Amethyst", id=240900, count=42},
        },
        top_player = "eu/blackmoore/baralos",
    },
    [3] = { -- 복원
        stats = {"치명타", "가속", "유연성", "특화"},
        embellishments = {
            {name="Hunt", id=245876, count=34},
            {name="Arcanoweave Lining", id=240167, count=23},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=23},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=26},
            {slot="Chest", name="Enchant Chest - Mark of the Magister", id=268545, count=28},
            {slot="Hands", name="Enchant Gloves - Zandalari Crafting", id=159471, count=1},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=26},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=267057, count=23},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=273834, count=44},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=43},
        },
        gems = {
            {name="Culminating Blasphemite", id=213742, count=1},
            {name="Telluric Eversong Diamond", id=240969, count=15},
            {name="Flawless Versatile Garnet", id=240910, count=15},
        },
        top_player = "us/zuljin/shamrocked",
    },
}

ItemInfoExtraData["WARLOCK"] = {
    [1] = { -- 고통
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=39},
            {name="Arcanoweave Lining", id=240167, count=18},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=16},
            {slot="Shoulders", name="Enchant Shoulders - Nature's Grace", id=268043, count=9},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=42},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=38},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=17},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=30},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=33},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=24},
            {name="Flawless Deadly Peridot", id=240890, count=21},
        },
        top_player = "eu/silvermoon/qatoriellÃ©",
    },
    [2] = { -- 악마
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=43},
            {name="Arcanoweave Lining", id=240167, count=15},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=14},
            {slot="Shoulders", name="Enchant Shoulders - Nature's Grace", id=268043, count=10},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=38},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=35},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=17},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=273834, count=25},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=37},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=25},
            {name="Flawless Quick Garnet", id=240906, count=21},
        },
        top_player = "eu/tarren-mill/speedywl",
    },
    [3] = { -- 파괴
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=48},
            {name="Arcanoweave Lining", id=240167, count=18},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=267057, count=12},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=9},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=39},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=35},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=17},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=24},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=32},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=24},
            {name="Flawless Deadly Peridot", id=240890, count=33},
        },
        top_player = "eu/draenor/loonyxdd",
    },
}

ItemInfoExtraData["WARRIOR"] = {
    [1] = { -- 무기
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=15},
            {name="Arcanoweave Lining", id=240167, count=6},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=4},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=4},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=12},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Blood Knight's Armor Kit", id=244643, count=10},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=4},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=273834, count=7},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=267399, count=12},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=11},
            {name="Flawless Quick Garnet", id=240906, count=13},
        },
        top_player = "eu/silvermoon/bizentein",
    },
    [2] = { -- 분노
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245876, count=46},
            {name="Arcanoweave Lining", id=240167, count=13},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=267057, count=17},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=268043, count=16},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=40},
            {slot="Legs", name="Blood Knight's Armor Kit", id=244643, count=32},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=267057, count=20},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=273834, count=26},
            {slot="Main Hand", name="Enchant Weapon - Arcane Mastery", id=267654, count=20},
            {slot="Off Hand", name="Enchant Weapon - Berserker's Rage", id=267057, count=18},
        },
        gems = {
            {name="Culminating Blasphemite", id=213742, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=28},
            {name="Flawless Quick Amethyst", id=240900, count=29},
        },
        top_player = "us/area-52/kered",
    },
    [3] = { -- 방어
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=240167, count=30},
            {name="Hunt", id=245876, count=27},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Hex of Leeching", id=267057, count=14},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=267641, count=14},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=268545, count=23},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=25},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=267447, count=10},
            {slot="Rings", name="Enchant Ring - Thalassian Haste", id=273834, count=37},
            {slot="Main Hand", name="Enchant Weapon - Berserker's Rage", id=267057, count=25},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=15},
            {name="Flawless Versatile Peridot", id=240894, count=20},
        },
        top_player = "us/illidan/woddtian",
    },
}
