-- extra_data.lua
-- 스탯 / 마법부여 / 보석 (archon.gg 기준)
-- 업데이트: 2026-04-23

ItemInfoExtraData = {}

ItemInfoExtraData["DEATHKNIGHT"] = {
    [1] = { -- 혈기
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="로아 신봉자의 고리", id=251513},
            {name="안정화 보석 사선 주머니", id=251490},
        },
        enchantments = {
            {slot="머리", name="Empowered Blessing of Speed", id=243981},
            {slot="어깨", name="Akil'zon's Swiftness", id=243963},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Farstrider's Hunt", id=244009},
            {slot="반지", name="Nature's Fury", id=243987},
        },
        gems = {
            {name="Flawless Masterful Garnet", id=240908},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 냉기
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Blessing of Speed", id=243981},
            {slot="어깨", name="Akil'zon's Swiftness", id=243963},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Farstrider's Hunt", id=244009},
            {slot="반지", name="Eyes of the Eagle", id=243957},
        },
        gems = {
            {name="Flawless Masterful Garnet", id=240908},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 부정
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240166},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
        },
        gems = {
            {name="Flawless Deadly Amethyst", id=240898},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["DEMONHUNTER"] = {
    [1] = { -- 파멸
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Masterful Garnet", id=240908},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 복수
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 포식
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Arcane Mastery", id=244031},
            {slot="무기", name="Berserker's Rage", id=243973},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["DRUID"] = {
    [1] = { -- 조화
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 야성
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240166},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 수호
        stats = {"가속", "특화", "유연성", "치명타"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240166},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Berserker's Rage", id=243973},
        },
        gems = {
            {name="Flawless Versatile Peridot", id=240894},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [4] = { -- 회복
        stats = {"가속", "특화", "유연성", "치명타"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Masterful Peridot", id=240892},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["EVOKER"] = {
    [1] = { -- 황폐
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="로아 신봉자의 고리", id=251513},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Nature's Fury", id=243987},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Garnet", id=240906},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 보존
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 증강
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Nature's Fury", id=243987},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Garnet", id=240906},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["HUNTER"] = {
    [1] = { -- 야수
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="세계지기의 껍질죔쇠띠", id=244611},
            {name="세계지기의 뿌리끌신", id=244610},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Amethyst", id=240898},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 사격
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="세계지기의 뿌리끌신", id=244610},
            {name="세계지기의 껍질죔쇠띠", id=244611},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Masterful Garnet", id=240908},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 생존
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Arcane Mastery", id=244031},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Amethyst", id=240898},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["MAGE"] = {
    [1] = { -- 비전
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="비전매듭 망토", id=239661},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Masterful Garnet", id=240908},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 화염
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Masterful Peridot", id=240892},
            {name="Powerful Eversong Diamond", id=240967},
        },
    },
    [3] = { -- 냉기
        stats = {"치명타", "특화", "가속", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Masterful Garnet", id=240908},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["MONK"] = {
    [1] = { -- 양조
        stats = {"치명타", "유연성", "특화", "가속"},
        embellishments = {
            {name="로아 신봉자의 고리", id=251513},
            {name="안정화 보석 사선 주머니", id=251490},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Nature's Fury", id=243987},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Versatile Garnet", id=240910},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 안개
        stats = {"가속", "치명타", "유연성", "특화"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 공허", id=245874},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 풍운
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245875},
            {name="로아 신봉자의 고리", id=251513},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["PALADIN"] = {
    [1] = { -- 신성
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Magister", id=244003},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 보호
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240166},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Versatile Peridot", id=240894},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 징벌
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="로아 신봉자의 고리", id=251513},
        },
        enchantments = {
            {slot="머리", name="Empowered Blessing of Speed", id=243981},
            {slot="어깨", name="Akil'zon's Swiftness", id=243963},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Farstrider's Hunt", id=244009},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Amethyst", id=240898},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["PRIEST"] = {
    [1] = { -- 수양
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 장식끈", id=239664},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Magister", id=244003},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 신성
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 장식끈", id=239664},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Magister", id=244003},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Nature's Fury", id=243987},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Versatile Garnet", id=240910},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 암흑
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Akil'zon's Swiftness", id=243963},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Arcane Mastery", id=244031},
        },
        gems = {
            {name="Flawless Masterful Peridot", id=240892},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["ROGUE"] = {
    [1] = { -- 암살
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Garnet", id=240906},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 무법
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240166},
            {name="오색 집중의 눈동자", id=251488},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 잠행
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="Darkmoon Sigil: Hunt", id=245876},
            {name="Arcanoweave Lining", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
            {slot="무기", name="Arcane Mastery", id=244031},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["SHAMAN"] = {
    [1] = { -- 정기
        stats = {"특화", "치명타", "가속", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="뿌리감시관의 예복", id=0},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Arcane Mastery", id=244031},
        },
        gems = {
            {name="Flawless Deadly Amethyst", id=240898},
            {name="Powerful Eversong Diamond", id=240967},
        },
    },
    [2] = { -- 고양
        stats = {"특화", "가속", "치명타", "유연성"},
        embellishments = {
            {name="Darkmoon Sigil: Hunt", id=245876},
            {name="Arcanoweave Lining", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 복원
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240167},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Magister", id=244003},
            {slot="다리", name="Arcanoweave Spellthread", id=240155},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Nature's Fury", id=243987},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Versatile Garnet", id=240910},
            {name="Telluric Eversong Diamond", id=240969},
        },
    },
}

ItemInfoExtraData["WARLOCK"] = {
    [1] = { -- 고통
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240166},
            {name="다크문 인장: 사냥", id=245875},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 악마
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240166},
            {name="다크문 인장: 사냥", id=245875},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Nature's Fury", id=243987},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Garnet", id=240906},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 파괴
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240166},
            {name="다크문 인장: 사냥", id=245875},
        },
        enchantments = {
            {slot="머리", name="Empowered Rune of Avoidance", id=244007},
            {slot="어깨", name="Flight of the Eagle", id=243961},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Sunfire Silk Spellthread", id=240133},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Deadly Peridot", id=240890},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}

ItemInfoExtraData["WARRIOR"] = {
    [1] = { -- 무기
        stats = {"치명타", "가속", "특화", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Blood Knight's Armor Kit", id=244643},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Eyes of the Eagle", id=243957},
            {slot="무기", name="Acuity of the Ren'dorei", id=244029},
        },
        gems = {
            {name="Flawless Quick Garnet", id=240906},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [2] = { -- 분노
        stats = {"가속", "특화", "치명타", "유연성"},
        embellishments = {
            {name="비전매듭 안감", id=240167},
            {name="다크문 인장: 사냥", id=245876},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Amirdrassil's Grace", id=243991},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Blood Knight's Armor Kit", id=244643},
            {slot="발", name="Lynx's Dexterity", id=243953},
            {slot="반지", name="Zul'jin's Mastery", id=243959},
            {slot="무기", name="Arcane Mastery", id=244031},
        },
        gems = {
            {name="Flawless Quick Amethyst", id=240900},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
    [3] = { -- 방어
        stats = {"가속", "치명타", "특화", "유연성"},
        embellishments = {
            {name="다크문 인장: 사냥", id=245876},
            {name="비전매듭 안감", id=240166},
        },
        enchantments = {
            {slot="머리", name="Empowered Hex of Leeching", id=243951},
            {slot="어깨", name="Silvermoon's Mending", id=244021},
            {slot="가슴", name="Mark of the Worldsoul", id=243977},
            {slot="다리", name="Forest Hunter's Armor Kit", id=244641},
            {slot="발", name="Shaladrassil's Roots", id=243983},
            {slot="반지", name="Silvermoon's Alacrity", id=244015},
            {slot="무기", name="Berserker's Rage", id=243973},
        },
        gems = {
            {name="Flawless Versatile Peridot", id=240894},
            {name="Indecipherable Eversong Diamond", id=240983},
        },
    },
}
