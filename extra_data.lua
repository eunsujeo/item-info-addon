-- extra_data.lua
-- 스탯 우선순위 / 장식 / 마법부여 / 보석 (murlok.io 상위 50명 기준)
-- 업데이트: 2026-04-23

ItemInfoExtraData = {}

ItemInfoExtraData["DEATHKNIGHT"] = {
    [1] = { -- 혈기
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237834, count=44},
            {name="Hunt", id=237846, count=27},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Blessing of Speed", id=0, count=27},
            {slot="Shoulders", name="Enchant Shoulders - Akil'zon's Swiftness", id=0, count=26},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=37},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=44},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=0, count=24},
            {slot="Rings", name="Enchant Ring - Silvermoon's Tenacity", id=0, count=36},
            {slot="Main Hand", name="Rune of Sanguination", id=0, count=41},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=44},
            {name="Flawless Masterful Lapis", id=240918, count=34},
        },
        top_player = "us/zuljin/frÃ´ststrike",
    },
    [2] = { -- 냉기
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237834, count=44},
            {name="Hunt", id=237846, count=28},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Blessing of Speed", id=0, count=21},
            {slot="Shoulders", name="Enchant Shoulders - Akil'zon's Swiftness", id=0, count=21},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=34},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=40},
            {slot="Feet", name="Enchant Boots - Farstrider's Hunt", id=0, count=24},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=44},
            {slot="Main Hand", name="Rune of the Fallen Crusader", id=0, count=26},
            {slot="Off Hand", name="Rune of the Fallen Crusader", id=0, count=14},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=33},
            {name="Flawless Deadly Amethyst", id=240898, count=57},
        },
        top_player = "us/illidan/faero",
    },
    [3] = { -- 부정
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237834, count=63},
            {name="Hunt", id=237846, count=34},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=29},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=29},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=50},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=3},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=48},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=30},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=55},
            {slot="Main Hand", name="Rune of the Apocalypse", id=0, count=49},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=49},
            {name="Flawless Deadly Amethyst", id=240898, count=87},
        },
        top_player = "us/illidan/procapproved",
    },
}

ItemInfoExtraData["DEMONHUNTER"] = {
    [1] = { -- 파멸
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244576, count=63},
            {name="Hunt", id=237840, count=31},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=34},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=39},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=47},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=43},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=81},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=44},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=39},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=40},
            {name="Flawless Masterful Garnet", id=240908, count=107},
        },
        top_player = "us/illidan/rawrdh",
    },
    [2] = { -- 복수
        stats = {"가속", "치명타", "유연성", "특화"},
        embellishments = {
            {name="Hunt", id=237839, count=42},
            {name="Arcanoweave Lining", id=244576, count=29},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=31},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=30},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=44},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=46},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=27},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=61},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=35},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=29},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=40},
            {name="Flawless Deadly Peridot", id=240890, count=46},
        },
        top_player = "eu/sylvanas/kiradh",
    },
    [3] = { -- 포식
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=237840, count=50},
            {name="Arcanoweave Lining", id=244573, count=49},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=44},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=43},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=50},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=43},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=61},
            {slot="Main Hand", name="Enchant Weapon - Berserker's Rage", id=0, count=26},
            {slot="Off Hand", name="Enchant Weapon - Berserker's Rage", id=0, count=27},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=49},
            {name="Flawless Quick Amethyst", id=240900, count=83},
        },
        top_player = "us/demon-soul/jabuka",
    },
}

ItemInfoExtraData["DRUID"] = {
    [1] = { -- 조화
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244576, count=55},
            {name="Hunt", id=245770, count=42},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=36},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=37},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=46},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=38},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=43},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=49},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=46},
            {name="Flawless Quick Amethyst", id=240900, count=45},
        },
        top_player = "eu/tarren-mill/canexxfourty",
    },
    [2] = { -- 야성
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244576, count=73},
            {name="Hunt", id=245771, count=16},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=30},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=30},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=46},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=48},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=38},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=44},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=49},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=45},
            {name="Flawless Quick Amethyst", id=240900, count=52},
        },
        top_player = "eu/archimonde/turbogronil",
    },
    [3] = { -- 수호
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244576, count=59},
            {name="Hunt", id=245771, count=21},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=32},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=34},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=46},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=48},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=26},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=47},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=27},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=44},
            {name="Flawless Versatile Peridot", id=240894, count=48},
        },
        top_player = "eu/silvermoon/gnomerender",
    },
    [4] = { -- 회복
        stats = {"가속", "특화", "유연성", "치명타"},
        embellishments = {
            {name="Arcanoweave Lining", id=244576, count=59},
            {name="Hunt", id=245770, count=36},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=22},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=26},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=38},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=29},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=27},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=68},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=45},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=42},
            {name="Flawless Masterful Peridot", id=240892, count=69},
        },
        top_player = "us/area-52/vitalitie",
    },
}

ItemInfoExtraData["EVOKER"] = {
    [1] = { -- 황폐
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244584, count=67},
            {name="Hunt", id=245770, count=29},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=32},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=31},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=44},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=45},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=38},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=0, count=44},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=46},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=40},
            {name="Flawless Quick Garnet", id=240906, count=71},
        },
        top_player = "eu/silvermoon/tÃ«emo",
    },
    [2] = { -- 보존
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Root Warden's Regalia", id=244610, count=47},
            {name="Arcanoweave Lining", id=244584, count=25},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=25},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=30},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=33},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=33},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=32},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=62},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=42},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=39},
            {name="Flawless Quick Amethyst", id=240900, count=73},
        },
        top_player = "eu/twisting-nether/cryve",
    },
    [3] = { -- 증강
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244584, count=66},
            {name="Hunt", id=245770, count=31},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=46},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=47},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=50},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=44},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=0, count=71},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=50},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=49},
            {name="Flawless Quick Garnet", id=240906, count=99},
        },
        top_player = "eu/blackhand/shirodrache",
    },
}

ItemInfoExtraData["HUNTER"] = {
    [1] = { -- 야수
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Root Warden's Regalia", id=244611, count=84},
            {name="Arcanoweave Lining", id=244584, count=12},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=40},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=34},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=48},
            {slot="Wrist", name="Enchant Bracers - Cooled Hearthing", id=160330, count=1},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=48},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=41},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=62},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=47},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=37},
            {name="Flawless Deadly Amethyst", id=240898, count=69},
        },
        top_player = "eu/blackhand/dpxhunt",
    },
    [2] = { -- 사격
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Root Warden's Regalia", id=244611, count=90},
            {name="Arcanoweave Lining", id=244584, count=7},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=27},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=28},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=48},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=48},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=27},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=86},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=49},
        },
        gems = {
            {name="Powerful Eversong Diamond", id=240967, count=24},
            {name="Flawless Masterful Garnet", id=240908, count=56},
        },
        top_player = "us/illidan/grimshunter",
    },
    [3] = { -- 생존
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Hunt", id=237837, count=37},
            {name="Arcanoweave Lining", id=244577, count=36},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=25},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=28},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=49},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=27},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=91},
            {slot="Main Hand", name="Enchant Weapon - Arcane Mastery", id=0, count=25},
            {slot="Off Hand", name="Enchant Weapon - Arcane Mastery", id=0, count=27},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=39},
            {name="Flawless Deadly Amethyst", id=240898, count=91},
        },
        top_player = "eu/blackrock/blubixtrap",
    },
}

ItemInfoExtraData["MAGE"] = {
    [1] = { -- 비전
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=239648, count=36},
            {name="Arcanoweave Trappings", id=239660, count=25},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=34},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=28},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=38},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=25},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=28},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=45},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=50},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=28},
            {name="Flawless Quick Amethyst", id=240900, count=26},
        },
        top_player = "us/area-52/schoowap",
    },
    [2] = { -- 화염
        stats = {"가속", "특화", "유연성", "치명타"},
        embellishments = {
            {name="Arcanoweave Lining", id=239648, count=58},
            {name="Hunt", id=245770, count=36},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=27},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=32},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=43},
            {slot="Hands", name="Enchant Gloves - Fishing", id=38802, count=2},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=42},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=29},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=68},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=46},
        },
        gems = {
            {name="Powerful Eversong Diamond", id=240967, count=33},
            {name="Flawless Masterful Peridot", id=240892, count=49},
        },
        top_player = "us/malganis/placement",
    },
    [3] = { -- 냉기
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=239648, count=53},
            {name="Hunt", id=245770, count=39},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=45},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=44},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=48},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=47},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=43},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=62},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=46},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=38},
            {name="Flawless Masterful Garnet", id=240908, count=60},
        },
        top_player = "eu/sylvanas/khaelt",
    },
}

ItemInfoExtraData["MONK"] = {
    [1] = { -- 양조
        stats = {"치명타", "유연성", "특화", "가속"},
        embellishments = {
            {name="Loa Worshiper's Band", id=251513, count=38},
            {name="Stabilizing Gemstone Bandolier", id=240950, count=33},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=43},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=42},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=47},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=45},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=0, count=45},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=46},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=1},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=46},
            {name="Flawless Versatile Garnet", id=240910, count=69},
        },
        top_player = "eu/blackhand/knowmehappy",
    },
    [2] = { -- 안개
        stats = {"가속", "치명타", "유연성", "특화"},
        embellishments = {
            {name="Arcanoweave Lining", id=244576, count=52},
            {name="Void", id=245770, count=25},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=38},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=36},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=37},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=29},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=36},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=67},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=46},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=45},
            {name="Flawless Deadly Peridot", id=240890, count=70},
        },
        top_player = "eu/draenor/spingÃ¸dxx",
    },
    [3] = { -- 풍운
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Loa Worshiper's Band", id=251513, count=47},
            {name="Stabilizing Gemstone Bandolier", id=240950, count=34},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=26},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=28},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Hands", name="Enchant Gloves - Legion Surveying", id=128561, count=1},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=46},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=32},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=31},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=44},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=7},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=49},
            {name="Flawless Deadly Peridot", id=240890, count=52},
        },
        top_player = "eu/howling-fjord/ÑÐ»ÑÐ¿Ð¾ÑÐ¸ÑÐ°",
    },
}

ItemInfoExtraData["PALADIN"] = {
    [1] = { -- 신성
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237831, count=51},
            {name="Hunt", id=237843, count=34},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=32},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=34},
            {slot="Chest", name="Enchant Chest - Mark of the Magister", id=0, count=28},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=28},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=36},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=44},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=49},
            {slot="Off Hand", name="Pyrium Shield Spike", id=55056, count=2},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=29},
            {name="Flawless Quick Amethyst", id=240900, count=41},
        },
        top_player = "eu/taerar/mythmaster",
    },
    [2] = { -- 보호
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237831, count=45},
            {name="Hunt", id=237839, count=31},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=33},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=30},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=34},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=44},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=30},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=45},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=41},
            {slot="Off Hand", name="Pyrium Shield Spike", id=55056, count=2},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=39},
            {name="Flawless Quick Garnet", id=240906, count=30},
        },
        top_player = "eu/kazzak/delgato",
    },
    [3] = { -- 징벌
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237834, count=53},
            {name="Hunt", id=237846, count=25},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=35},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=35},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=46},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=49},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=29},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=81},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=47},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=46},
            {name="Flawless Masterful Garnet", id=240908, count=59},
        },
        top_player = "eu/blackhand/xail",
    },
}

ItemInfoExtraData["PRIEST"] = {
    [1] = { -- 수양
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=245770, count=45},
            {name="Arcanoweave Cord", id=239664, count=33},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=38},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=37},
            {slot="Chest", name="Enchant Chest - Mark of the Magister", id=0, count=28},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=33},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=34},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=49},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=44},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=39},
            {name="Flawless Deadly Peridot", id=240890, count=83},
        },
        top_player = "eu/tarren-mill/xscream",
    },
    [2] = { -- 신성
        stats = {"치명타", "가속", "유연성", "특화"},
        embellishments = {
            {name="Hunt", id=245770, count=43},
            {name="Arcanoweave Cord", id=239664, count=26},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=29},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=30},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=25},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=29},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=29},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=0, count=44},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=43},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=36},
            {name="Flawless Versatile Garnet", id=240910, count=30},
        },
        top_player = "us/stormrage/clemenz",
    },
    [3] = { -- 암흑
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Hunt", id=245770, count=39},
            {name="Arcanoweave Cord", id=239664, count=38},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=27},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=26},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=48},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=49},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=30},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=57},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=25},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=48},
            {name="Flawless Quick Amethyst", id=240900, count=49},
        },
        top_player = "eu/howling-fjord/ÑÑÐµÑÑÐºÐ°",
    },
}

ItemInfoExtraData["ROGUE"] = {
    [1] = { -- 암살
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Hunt", id=237837, count=50},
            {name="Arcanoweave Lining", id=244573, count=48},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=41},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=42},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=49},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=41},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=83},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=35},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=28},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=49},
            {name="Flawless Quick Garnet", id=240906, count=85},
        },
        top_player = "us/area-52/woxtoxic",
    },
    [2] = { -- 무법
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244569, count=38},
            {name="Hunt", id=237837, count=28},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=25},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=28},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=49},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=27},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=77},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=40},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=42},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=43},
            {name="Flawless Quick Garnet", id=240906, count=56},
        },
        top_player = "eu/draenor/tomelvis",
    },
    [3] = { -- 잠행
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244573, count=50},
            {name="Hunt", id=237837, count=49},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=36},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=37},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Hands", name="Enchant Gloves - Zandalari Mining", id=159466, count=1},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=50},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=40},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=71},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=38},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=30},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=48},
            {name="Flawless Quick Amethyst", id=240900, count=30},
        },
        top_player = "us/malganis/charrend",
    },
}

ItemInfoExtraData["SHAMAN"] = {
    [1] = { -- 정기
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Root Warden's Regalia", id=244611, count=39},
            {name="Arcanoweave Lining", id=244582, count=27},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=38},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=39},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=3},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=45},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=46},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=44},
            {slot="Main Hand", name="Enchant Weapon - Arcane Mastery", id=0, count=22},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=29},
            {name="Flawless Deadly Amethyst", id=240898, count=67},
        },
        top_player = "eu/stormreaver/fauni",
    },
    [2] = { -- 고양
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=244582, count=46},
            {name="Hunt", id=237845, count=46},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=37},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=38},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=47},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=39},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=58},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=48},
            {slot="Off Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=44},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=42},
            {name="Flawless Quick Amethyst", id=240900, count=70},
        },
        top_player = "eu/stormscale/shadi",
    },
    [3] = { -- 복원
        stats = {"치명타", "가속", "유연성", "특화"},
        embellishments = {
            {name="Arcanoweave Lining", id=244584, count=56},
            {name="Hunt", id=245770, count=26},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=29},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=33},
            {slot="Chest", name="Enchant Chest - Mark of the Magister", id=0, count=39},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=2},
            {slot="Legs", name="Arcanoweave Spellthread", id=240155, count=36},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=32},
            {slot="Rings", name="Enchant Ring - Nature's Fury", id=0, count=66},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=45},
            {slot="Off Hand", name="Thorium Shield Spike", id=12645, count=1},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=25},
            {name="Flawless Versatile Garnet", id=240910, count=62},
        },
        top_player = "eu/kazzak/xhanon",
    },
}

ItemInfoExtraData["WARLOCK"] = {
    [1] = { -- 고통
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=239648, count=65},
            {name="Hunt", id=245770, count=26},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=24},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=17},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Wrist", name="Enchant Bracers - Shaded Hearthing", id=172416, count=1},
            {slot="Hands", name="Enchant Gloves - Shadowlands Gathering", id=172406, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=46},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=25},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=42},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=36},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=43},
            {name="Flawless Deadly Peridot", id=240890, count=39},
        },
        top_player = "eu/the-maelstrom/saf",
    },
    [2] = { -- 악마
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=239648, count=57},
            {name="Hunt", id=245770, count=39},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=43},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=40},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=50},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=49},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=46},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=43},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=45},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=44},
            {name="Flawless Quick Garnet", id=240906, count=73},
        },
        top_player = "eu/twisting-nether/lexÃ³",
    },
    [3] = { -- 파괴
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=239656, count=53},
            {name="Hunt", id=245770, count=36},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=23},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=20},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=47},
            {slot="Legs", name="Sunfire Silk Spellthread", id=240133, count=44},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=28},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=43},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=33},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=30},
            {name="Flawless Deadly Peridot", id=240890, count=32},
        },
        top_player = "eu/blackmoore/jixzy",
    },
}

ItemInfoExtraData["WARRIOR"] = {
    [1] = { -- 무기
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237834, count=66},
            {name="Hunt", id=237846, count=31},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=26},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=32},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=49},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Blood Knight's Armor Kit", id=244643, count=33},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=38},
            {slot="Rings", name="Enchant Ring - Eyes of the Eagle", id=0, count=62},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=17},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=45},
            {name="Flawless Quick Garnet", id=240906, count=79},
        },
        top_player = "eu/ravencrest/farover",
    },
    [2] = { -- 분노
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237834, count=49},
            {name="Hunt", id=237846, count=44},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Rune of Avoidance", id=0, count=27},
            {slot="Shoulders", name="Enchant Shoulders - Amirdrassil's Grace", id=0, count=29},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=42},
            {slot="Wrist", name="+66 Speed", id=0, count=1},
            {slot="Hands", name="Heavy Knothide Armor Kit", id=34330, count=1},
            {slot="Legs", name="Blood Knight's Armor Kit", id=244643, count=30},
            {slot="Feet", name="Enchant Boots - Lynx's Dexterity", id=0, count=38},
            {slot="Rings", name="Enchant Ring - Zul'jin's Mastery", id=0, count=42},
            {slot="Main Hand", name="Enchant Weapon - Arcane Mastery", id=0, count=23},
            {slot="Off Hand", name="Enchant Weapon - Arcane Mastery", id=0, count=20},
        },
        gems = {
            {name="Elusive Blasphemite", id=213746, count=1},
            {name="Indecipherable Eversong Diamond", id=240983, count=47},
            {name="Harmonic Music Stone", id=204019, count=1},
            {name="Flawless Quick Amethyst", id=240900, count=62},
        },
        top_player = "us/zuljin/noxiv",
    },
    [3] = { -- 방어
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="Arcanoweave Lining", id=237831, count=62},
            {name="Hunt", id=237850, count=24},
        },
        enchantments = {
            {slot="Head", name="Enchant Helm - Empowered Hex of Leeching", id=0, count=42},
            {slot="Shoulders", name="Enchant Shoulders - Silvermoon's Mending", id=0, count=35},
            {slot="Chest", name="Enchant Chest - Mark of the Worldsoul", id=0, count=39},
            {slot="Legs", name="Forest Hunter's Armor Kit", id=244641, count=33},
            {slot="Feet", name="Enchant Boots - Shaladrassil's Roots", id=0, count=39},
            {slot="Rings", name="Enchant Ring - Silvermoon's Alacrity", id=0, count=63},
            {slot="Main Hand", name="Enchant Weapon - Acuity of the Ren'dorei", id=0, count=29},
            {slot="Off Hand", name="Pyrium Shield Spike", id=55056, count=6},
        },
        gems = {
            {name="Indecipherable Eversong Diamond", id=240983, count=40},
            {name="Flawless Versatile Peridot", id=240894, count=49},
        },
        top_player = "us/emerald-dream/plkawar",
    },
}
