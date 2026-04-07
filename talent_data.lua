-- talent_data.lua
-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)
-- 업데이트: 2026-04-07

ItemInfoTalentData = {
    ["DEATHKNIGHT"] = {
        [1] = { -- 혈기
            "CoPASnrjTdwaLTX9NnLQoJJXfwYWmZmxMzMjhZbmZmmhZGjZMAAAAgZmZmZmZGmxMDAGzMzMAAAmZ2GDjZst0YZbZYy2wwCgZYAAYmZmBDMA",
            "neunacht",
        },
        [2] = { -- 냉기
            "CwPASnrjTdwaLTX9NnLQoJJXfAYmhZMjZY2mZmZa2MzYmZMAAAAAAAAMDmZAwyMmZ2mZGzYYgBmxiGLLA2mYDDYGAGzMjZwMDMmxA",
            "myzouth",
        },
        [3] = { -- 부정
            "CwPASnrjTdwaLTX9NnLQoJJXfAwMjZmxYY2mZmZa2MzYMjBAAAAAAAgZGmZAwyMmZ2mZGzYYw2MLmZmFNzyCzGz20YBAzAAzMjZAmZmxMG",
            "gigabests",
        },
    },
    ["DEMONHUNTER"] = {
        [1] = { -- 파멸
            "CEkAG5bbocFKcv+yIq8fPd6ORZmZmZmZ2mxMzMmZmMmZAAAAAAAzmxsNDzM4Bmx2sNzMjxALDsNbmxwsppxMzYYDAAAAAABAzMYAIAAwA",
            "gokkesokken",
        },
        [2] = { -- 복수
            "CUkAG5bbocFKcv+yIq8fPd6ORBAMjZmZMMzkZmxYMzMzAzYmxMmZmxgZbmx2DMzsNGGAAAAmtZwwYZhJMMzM2AAAAwAzMzMzWbzMzAAAAAAMA",
            "rampire",
        },
    },
    ["DRUID"] = {
        [1] = { -- 조화
            "CYGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAAAAAAWoMbNjxMDwsYmZmZhBjZZmlZWMzMWYZmlxMjxCGGgxy2MDGz2IwEAAAgFzMzMD2MMGDAAzMwA",
            "lihanna",
        },
        [2] = { -- 야성
            "CcGA8cL7tpvige+kkmGM9zUPWDAAAAAgZMDzMzMjxsZsNz2MzMjZGAAAA2CmNDPgZG1MmFzMzMLjZMDAAAAAgBGAAAANzysMzMzsNzWzyMbLgZGgFGMAAAmZDD",
            "turbogronil",
        },
        [3] = { -- 수호
            "CgGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAgZmZmlhZMziZZMzMWGY2MMaimZmlZmZmZZmZeAAAAAAAzYZGwy2MDGzyAYKAAAwGmBwiZwAWwAMzAYA",
            "squishvegan",
        },
        [4] = { -- 회복
            "CkGA8cL7tpvige+kkmGM9zUPWPMmZZMjZmxsNMMmFmFbzAAAAAAAAAAglBNbzw0MjhHwsYmZGLGeADAAAAgBAYGwyyYBTzMLDAgZbmtmlZWsxMz8AYmZB0MAAzMAMA",
            "vitalitie",
        },
    },
    ["EVOKER"] = {
        [2] = { -- 보존
            "CwbBPJc41CfcseY0baneJ1IHrBAAAAAYmZ22GYYm5BmFzYMz2MGAAGzYGzYMMTMmBAAAMzMTzYmZmxYGAAGzYjFYgZ0QDDLwMzMAMA",
            "cryve",
        },
        [3] = { -- 증강
            "CEcBPJc41CfcseY0baneJ1IHrNmZmZbmZmxyAzsMjxwMAAAAAAAAwMYmHYGjpGzMzAAAAAjZmxMzyYmBmZzYwCsMGGbDgZiYDzMDmZAM",
            "chum",
        },
    },
    ["HUNTER"] = {
        [1] = { -- 야수
            "C0PAo4YcvOcqUdzB9zV+NhSAcYzsNwAGwMsBZsAAgZGLzMDzwMzMYGzMzwMmZGzMzYbmZYMDLDNDAAAAAYGAAAMjxwMDQYYWALGA",
            "nobackshot",
        },
        [2] = { -- 사격
            "C4PAo4YcvOcqUdzB9zV+NhSAcwCMwMGNWGQmBbAAAAAAAAAzYmZGbGzMjZYZMNjxYmttNzMzwMDLzMLjxsMMzAAAMjxAwMjNwAshB",
            "undercoviira",
        },
        [3] = { -- 생존
            "C0PAo4YcvOcqUdzB9zV+NhSAcYzsNwAGwMsBZsAAgZGLzMDzwMzMYGzMzwMmZGzMzYbmZYMDLjpZAAAAAAzAAAgHYmxwMDQAzCYzA",
            "mawgun",
        },
    },
    ["MAGE"] = {
        [1] = { -- 비전
            "C4DAMhlVtghLZL4RZzExaQoBYNzwYZmZmFMzQzMzMAAAGAwMjmFbzMzMzyyMTsAAw2MmZGzmZZmZGzMGDzMzYhZmZMDAwAAAYmFYGwMAYYA",
            "hairumageone",
        },
        [2] = { -- 화염
            "C8DAMhlVtghLZL4RZzExaQoBYZGGLzMzswMzIzMGAAAmZZGzMLzyMz0stsMDAwmZmx2YmZGbAAAAAwiZmZmBAAjZMjZmZmZZAYmhwYMwwA",
            "placement",
        },
        [3] = { -- 냉기
            "CAEAMhlVtghLZL4RZzExaQoBYNzwYZmZmlxMzEzMGzMzMziZmZMjZmlZamZbWAAzMzssMz0GAAsBAAAsBw2yYmZGMbDjZYBAAgZ2mZwMwAmBD",
            "khaelt",
        },
    },
    ["MONK"] = {
        [1] = { -- 양조
            "CwQAi6cZM+HWADeySjzG9Lwx8DAAAwMbbGDGz2M2YmZMAAAAAAALLYEzMwMMzmBmZmZYWYmxMLDLbz22sNMLAAwGCAAwsNLNzMzGDbAMzw0YAAAD",
            "brewbtian",
        },
        [2] = { -- 안개
            "C4QAi6cZM+HWADeySjzG9Lwx8DAAAAAAAghxyMLjZx2MmZsZstsNjZ2Mz2yyMjFmRzYGwgBDLzMzMMbYGmlZCAAAAgAsYbmlZbmBEAAAYGwYgFZMDA",
            "ryqim",
        },
        [3] = { -- 풍운
            "C4QAi6cZM+HWADeySjzG9Lwx8DAAAAAAAgxM2mZZGbWMjZsYsssMzMDzsstMzYhx0MmBMYAzyMzMDz2ghZxEAAAAY2mWmlZWmNAAEAMAzMAwYYsIDA",
            "skriptzy",
        },
    },
    ["PALADIN"] = {
        [2] = { -- 보호
            "CIEAVg1HmQqr1Dwlv86ljju8vuNjBzyYbMjZmZZZMzwsMLDDAwAAAAAAgmmZWmZMzMGmt2AwADYGsBAAmZabmZbmZmttlWmZsYGMAgZYMAYmBAzMgB",
            "yodafotm",
        },
        [3] = { -- 징벌
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAQzy2MzsMGzMAAAAAAmpMLzwMjthZbYmtZMGjhZsxGAAQmZabmZbGAwGgBwYMjBMzMzshlZwwYYwA",
            "melee",
        },
    },
    ["PRIEST"] = {
        [2] = { -- 신성
            "CEQA4VPTJ8eQb8/qEm8PyGu4ywYAAAAAAgZzwYWGMmZmZMzMjtZmBAAAADzyMMzMzMMmZwGmpAYmtZ2mZysNzAwMzgNjZ2A0MmZMGMz2yAzMgB",
            "clemenz",
        },
        [3] = { -- 암흑
            "CIQA4VPTJ8eQb8/qEm8PyGu4yMMjZGAAAAAAAAAAAgxMMjxyMDzsMzwMjtZMmZmxGyMWMTDwMAzsZGNbGAyYsAgZAGzMzY2GzstMAzgB",
            "boreasxo",
        },
    },
    ["ROGUE"] = {
        [2] = { -- 무법
            "CQQAByFP3pExAEG41/8+e6b8fDgx2MYmZmZmtZmZmZmHYmFeAmZbaZw2MAAAAAALLzMzwMzMzYmZ2GAAAAGADmtZzMzMamZjZhttpNWYAwMzMYA",
            "tomelvis",
        },
        [3] = { -- 잠행
            "CUQAByFP3pExAEG41/8+e6b8fDgZ2mBAAAAAmlxYZiZbbMmhZMegZmZGjZbGzYbZMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA",
            "woxtoxic",
        },
    },
    ["SHAMAN"] = {
        [1] = { -- 정기
            "CYQARUG2fGwHkLP0T7/MoTNl/AAAAAzMbbzMzMzMLbbDMmZAAAAAgFzYYDWgZ0QjNAYWmZmxYbx0CzMGLzMzMGWmlZsYmhZWAAGAzMwwwA",
            "deeprayaa",
        },
        [2] = { -- 고양
            "CcQARUG2fGwHkLP0T7/MoTNl/MzMjZmZmZmZmZmZGzAAAAAAAAAALYZbGzMLLaW2GmhZmGsBwsNjZMWWmBmZ2GLzMzMMWGzAAAMGzImZAGMGA",
            "drakthul",
        },
        [3] = { -- 복원
            "CgQARUG2fGwHkLP0T7/MoTNl/AAAAgBAAAAjZmZbZZGzMzYmxYYssMziFGzYZasNzCTmhxCmZws8AzMjmtlZGmxglZMzMDLzyMAAMAjZwMDmZwMYA",
            "shamrocked",
        },
    },
    ["WARLOCK"] = {
        [1] = { -- 고통
            "CkQAy0jxIDofkwJmoH7WhvESohZmZGNbmx2MzYWGAAwMzsMLmZWGDAMLbbjhxsYmGzMDbZWYYbAAAYGAAYmZmZMjxsNGzgZmZGDzMzAAMDMA",
            "pigson",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- 무기
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmxsMzMzYGAAAghphxwMbLzMzMjZGzMAAAAAGbmB2iBsZGDLwAzoNaMYBYGMGMbmtBzMAgZmhB",
            "deepps",
        },
        [2] = { -- 분노
            "CgEAjLzRlq54bI5v+r8Sr9Xw4DAAAAAAgGDzYMzmZmZmZMjZGzYmZmlZmxYMLjZmBAACDsBLLGNmBkZDzYBwMYMAYmBwwMzMDDG",
            "farover",
        },
        [3] = { -- 방어
            "CkEAjLzRlq54bI5v+r8Sr9Xw4nBAAmZGzMzMzMmNzMLDjxohZGWmZmZGGmZAAAAwyYAmxAMwGssY0YGAzWMzGMjZGMbDAmZAAYGwA",
            "acefloorpov",
        },
    },
}
