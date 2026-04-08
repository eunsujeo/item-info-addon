-- talent_data.lua
-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)
-- 업데이트: 2026-04-09

ItemInfoTalentData = {
    ["DEATHKNIGHT"] = {
        [1] = { -- 혈기
            "CoPASnrjTdwaLTX9NnLQoJJXfwY2mZmxMzMjhZbmZmmhxYmZMAAAAgZmZmZmZGmxYGAGzMzMAAAmZ2GDjZst0YZbZYy2wwGgZYAAYmZmBDMA",
            "neunacht",
        },
        [2] = { -- 냉기
            "CwPASnrjTdwaLTX9NnLQoJJXfAwMjZMDDz2MzMTz2MzYMjBAAAAAAAgZeAmZAwyMmZ2mZGzYGwmZxwQGY2YoxCAmBAmZGzAMzMjZMA",
            "myzouth",
        },
        [3] = { -- 부정
            "CwPASnrjTdwaLTX9NnLQoJJXfAwMjZmxYY2mZmZa2MzYMjBAAAAAAAgZGmZAwyMmZ2mZGzYYw2MLmZmFNzyCzGz20YBAzAAzMjZAmZmxMG",
            "gigabests",
        },
    },
    ["DEMONHUNTER"] = {
        [1] = { -- 파멸
            "CEkAG5bbocFKcv+yIq8fPd6ORZmZGzMz2MmZmxYmMmZAAAAAAAzmxsNDzMwMWmtZmZMzALDsNbmxwsopxMzYGbAAAADAABAzMYAIAAwA",
            "gokkesokken",
        },
        [2] = { -- 복수
            "CUkAG5bbocFKcv+yIq8fPd6ORBAMjZmZMMzkZmhZWMjZwMjZGzYmZGDmtZGbPwMzyYYAAAAY2mBDjlFmwwMzYDAAAADMzMzMbtNzMDAAAAAwA",
            "rampire",
        },
    },
    ["DRUID"] = {
        [1] = { -- 조화
            "CYGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAAAAAAWoMbNjxMDMmFmZmBYGzyMLDzYGbsMjZmZMzCGGgBYZbshpZmlRAAAA2MzMzMYzwYMDgZGAYA",
            "lihanna",
        },
        [2] = { -- 야성
            "CcGA8cL7tpvige+kkmGM9zUPWDAAAAAAjZwMzMzMmtl5BWGbzYGzMDAAAALBzGMmZUzYWMzMzYMjZAAAAAAMwAAAAoZWmtZmZmtZWa2mZZDMzAsYGMAAmZwMbYA",
            "turbogronil",
        },
        [3] = { -- 수호
            "CgGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAgZmxsMzMjZ2MLDMWGwmZMaimZmlZmZmxYGGAAAAAwMWmBAAAgamlZZmZGAALYmBYxMYALW2GAMzGM",
            "squishvegan",
        },
        [4] = { -- 회복
            "CkGA8cL7tpvige+kkmGM9zUPWPMmZZMjZmxsNMMmFmFbzAAAAAAAAAAglBNbzw0MjhHwsYmZGLGeADAAAAgBAYGwyyYBTzMLDAgZbmtmlZWsxMz8AYmZB0MAAzMAMA",
            "vitalitie",
        },
    },
    ["EVOKER"] = {
        [2] = { -- 보존
            "CwbBPJc41CfcseY0baneJ1IHrBAAAAAYmZ22GYYm5BmFzYMz2MAAwYGzYmZMMTMmBAAAMzMTzYmZmxYGAAGzYjFYgZ0QDDLwMzMAMA",
            "cryve",
        },
        [3] = { -- 증강
            "CEcBPJc41CfcseY0baneJ1IHrxMzMbzMzgBzMLzYMMzGAAAAAAAAmBz8AzYM1YmZGAAAAYMzMmZWGzMwMbzYwCsMGGLDgZiYDzMDmZAM",
            "chum",
        },
        [1] = { -- 황폐
            "CsbBPJc41CfcseY0baneJ1IHrBAAAAAAAAAAAzMDMDzwMgBjZaMzMNjx2MmZmZmHYmZGwMzMzYmZZmZgBGDWglxox2AyMBYDDMzghB",
            "fazo",
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
            "C8PAo4YcvOcqUdzB9zV+NhSAcMgxMG2ILwMM0gFzMzMzwyAAAAAAgZMmZsNjxMmhlx0MAAAAgBAwyyMzsYmZmZMmZAzsBAjxMzGD",
            "mawgun",
        },
    },
    ["MAGE"] = {
        [1] = { -- 비전
            "C4DAMhlVtghLZL4RZzExaQoBYNzwMLzMzsgZGamxAAAwAAMzklNzMzMzyyMTsAAwyMmZGzmZZmZGzMGDzMzYhZmZegZAAGAAAzsgZGwMAYYA",
            "nakali",
        },
        [2] = { -- 화염
            "C8DAMhlVtghLZL4RZzExaQoBYNzwYZmZmFMzIzMGAAAmZZGzYZWmZmmtllZAA2MzM2GzMzYDAAAAAWMzMzMAAYMDjZmZmZZAzMzMkxYMYGG",
            "placement",
        },
        [3] = { -- 냉기
            "CAEAMhlVtghLZL4RZzExaQoBYNzwMLzMzsMMzEzMGzMzMzmZmhZMzsMTzMLzCAYmZmllZm2AAgNAAAgFA2WGzMzgZbYMzYBAAgZ2mZwMMGwMYA",
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
            "C0QAi6cZM+HWADeySjzG9Lwx8PzYMghZZmZ2mxAAAAAAAAAAAALDzEmhhBMjhZmZGmthZYWmJAgNzsNGGzMDEAbAoZZWamZmFghBmZAglxAGwA",
            "skriptzy",
        },
    },
    ["PALADIN"] = {
        [2] = { -- 보호
            "CIEAVg1HmQqr1Dwlv86ljju8vuNjBzyYbMjZmZZZMzwsMLDDAwAAAAAAgmmZWmZMzMGmt2AwADYGsBAAmZabmZbmZmttlWmZsYGMAgZYMAYmBAzMgB",
            "yodafotm",
        },
        [3] = { -- 징벌
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAQz22MzsMGzMAAAAAAGlZbGmZsNMbDzsNjxYMMjN2wAAQmZabmZbGAwGgBAjZYGMzMzshlZwwYYwA",
            "melee",
        },
        [1] = { -- 신성
            "CEEAVg1HmQqr1Dwlv86ljju8vCAAAYBAMDAAsMmZmZGzMzCMGWGbzMLmpJmlZMzMMMbZAYAYDsx2MzMLz2Mzs1AAmZWWWsNzwGbMwGwMmBAMzgZGmxY0A",
            "mulèyò",
        },
    },
    ["PRIEST"] = {
        [2] = { -- 신성
            "CEQA4VPTJ8eQb8/qEm8PyGu4ywYAAAAAAgZzwYWGMmZmZMzMjtZmBAAAAjZWmhZmZmhxMD2wMFAzsNz2MTmtZGAmZGsZMzGgmxMPgxgZ2WGYmBMA",
            "clemenz",
        },
        [3] = { -- 암흑
            "CIQA4VPTJ8eQb8/qEm8PyGu4yMMjZGAAAAAAAAAAAgxDMbmxYZmhZWmZYY2mZGzMzYDZGLmpBYGgZWMjmNDAZMWAwMAjZmZMbjZ2WGgZwA",
            "djvildie",
        },
        [1] = { -- 수양
            "CAQA4VPTJ8eQb8/qEm8PyGu4yADsAzGjZYmZMbzsNzMzMMDAAAAAAAAAgxYZGMzMDmxMgpZiBYmNMEGzyAMGsAAAjZmZMMzAMzMTzwA",
            "jinx",
        },
    },
    ["ROGUE"] = {
        [2] = { -- 무법
            "CQQAByFP3pExAEG41/8+e6b8fDgZ2mBzMzMzsNzMzMz8AzswDwMbTLD2mBAAAAAYZZmZGmZmZGzMz2AAAAwAYwsNbmZmRzMbMLstNtxCDAmZGYA",
            "tomelvis",
        },
        [3] = { -- 잠행
            "CMQAByFP3pExAEG41/8+e6b8fbmZmZzgBAAAAAmlBbzAAAAAAyyMzMzMzYMzMzsNzyMjHwDMzMzMGmZMGADsAzY0Y2AZZAbGAMzMGD",
            "woxtoxic",
        },
        [1] = { -- 암살
            "CMQAByFP3pExAEG41/8+e6b8fbmZmZxgBAAAAAmlBbzAAAAAAabZmZmZmZMmZmZ2mZZmxD4BmZmZGDzMGzA2mZZswYGzSjZbbYy2wwGYmBzMDG",
            "zerøcool",
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
            "CgQARUG2fGwHkLP0T7/MoTNl/AAAAgBAAAAjZmZZbZMzMzYmBDDLwCMjFN2GQmB2YGjZmtZmZ0YZmhZMYZGzMPwwysMDAAzAMzgZGAYwA",
            "shamrocked",
        },
    },
    ["WARLOCK"] = {
        [1] = { -- 고통
            "CkQAy0jxIDofkwJmoH7WhvESoxMzMzoZzM2mZGzyAAAmZmlZxMziZAgZZbbMMmFz0YmZYLzCDbDAAAzAAAzMzMjZMGjxMYmZMGmZmBAYGYA",
            "pigson",
        },
        [2] = { -- 악마
            "CoQAy0jxIDofkwJmoH7WhvESoxMzMzoZjZ2mZGzyAAAAAAAAGzYYBGYb0GNsYwMLzyMzMmBAmhZmZmZAYGzAAAYmZmZmhxsMjBMA",
            "lexó",
        },
        [3] = { -- 파괴
            "CsQAy0jxIDofkwJmoH7WhvESoxMjZGNbmxmZGzysNzYmFzMLLjBAAzYMzMLWgBmFjGzAY2iNGAAgZYAAwMDGzYmZDAAwMzMDAAzwA",
            "bloise",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- 무기
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmxsMzMzYGAAAghphxwMbLzMzMjZGzMAAAAAGbmB2iBsZGDLwAzoNaMYBYGMGMbmtBzMAgZmhB",
            "deepps",
        },
        [2] = { -- 분노
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmxsMzMzYGAAAghphBzMbLzMzMjZGzMAAAAAGbmB2iBsZGDLwAzoNaMYBMzwwgZzsNYmBAYmhB",
            "farover",
        },
        [3] = { -- 방어
            "CkEAjLzRlq54bI5v+r8Sr9Xw4nBAAmZGzMzMzMmNzMLDjxohZGWmZmZGGmZAAAAwyYAmxAMwGssY0YGAzWMzGMjZGMbDAmZAAYGwA",
            "acefloorpov",
        },
    },
}
