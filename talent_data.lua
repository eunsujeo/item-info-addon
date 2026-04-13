-- talent_data.lua
-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)
-- 업데이트: 2026-04-13

ItemInfoTalentData = {
    ["DEATHKNIGHT"] = {
        [1] = { -- 혈기
            "CoPASnrjTdwaLTX9NnLQoJJXfwMzyMzwMmZMjZZmZmmZxYMzMGAAAAwgZmZmZMzYMAYmZmZGAAAzMbjhxMWWasstMMZbYYBwMGDAgZmZGYwA",
            "yodadkt",
        },
        [2] = { -- 냉기
            "CwPASnrjTdwaLTX9NnLQoJJXfAYmZMjZGDz2MzMTzmZGjZMAAAAAAAAMzgZAwyMmZ2mZGzYYgBmxiGLLA2mYDDYGAYmZMDmZwwMG",
            "enerugi",
        },
        [3] = { -- 부정
            "CoPASnrjTdwaLTX9NnLQoJJXfwMzyMzwMmZmhZbmZmmZxMjZmxAAAAAmhZmZmZMzYAAzMzMzAAAYGbjhxM2WassYYy2wwGgZMAAAzMAMA",
            "bugapproved",
        },
    },
    ["DEMONHUNTER"] = {
        [2] = { -- 복수
            "CUkAG5bbocFKcv+yIq8fPd6ORBAWmxMzMzwMyMzgZxMmBzMmZMzDMzMjBz2MjNzMGDDAAAAz2MYYstwEGmZGbAAAAYgZmZmZrtZmZMzAMAAAAG",
            "zacdh",
        },
        [3] = { -- 포식
            "CgcBG5bbocFKcv+yIq8fPd6ORBAWmxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMmZmZmZmZGzsYGjFtsxMzMzWbzMzAYYmZWmZmmtZ2mxgxMA",
            "jabuka",
        },
        [1] = { -- 파멸
            "CEkAG5bbocFKcv+yIq8fPd6ORZmZmZmZ2wMzMmZmMmZAAAAAAAzixsNzDYmBmx2sNzMjxALDsNbmxwsopxMzYGbAAAADAABAzMYAIAAwA",
            "ronindh",
        },
    },
    ["DRUID"] = {
        [1] = { -- 조화
            "CYGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAAAAAAWoMbNjxMDMmFzMzMLAjZZmlZWMzM2YZmlxMjxGGGgx22MDGz2IwEAAAgFmZmZwmhxYAAYmBGA",
            "dwilkz",
        },
        [2] = { -- 야성
            "CcGA8cL7tpvige+kkmGM9zUPWDAAAAAgZMDmZmZMmNzsM2mZmZMzAAAAwSwsZ4BMzomxsYmZmZZMjZAAAAAAMwAAAAoZWmlZmZmtZ2aWmZbBMzAswgBAAwMbYA",
            "turbogronil",
        },
        [3] = { -- 수호
            "CgGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAgZmxsMMjZWMLzMzMWGY2MMaimZmlxMzMLjZGAAAAAAzYbGwy2MDGzyAYKAAAwGm5BAWMDGwCAMzAYA",
            "squishvegan",
        },
        [4] = { -- 회복
            "CkGA8cL7tpvige+kkmGM9zUPWPMmZZMjZmxsNMMmFmFbzAAAAAAAAAAglBNbzw0MjhxsYmZGLGGDAAAAgBAYGwyyYBTzMLDAgZbmtmlZWsxYGYmZB0MAAzMAMA",
            "vitalitie",
        },
    },
    ["EVOKER"] = {
        [1] = { -- 황폐
            "CEcBPJc41CfcseY0baneJ1IHrNmZmZbmZGMYmZZGjhZ2AAAAAAAAYmZghZM1YmZGAAAAMjZMmZWGzMwMLGYMjFWgBmhhGxCmZMzAYYA",
            "gonski",
        },
        [2] = { -- 보존
            "CwbBPJc41CfcseY0baneJ1IHrBAAAAAYmZ22GYYm5BmlZYMz2MGAAGzYGzMjhZixMAAAgZmZaGzMzMGzAAwYGbsADMjGaYYBGzMAMA",
            "cryve",
        },
        [3] = { -- 증강
            "CEcBPJc41CfcseY0baneJ1IHrxMzMbzMzgBzMLzYMMzGAAAAAAAAmhHwYGjpGzMzAAAAAjZmxMzyYmBmZbGDWglxwYZAMTEbYmZwMDGM",
            "chum",
        },
    },
    ["HUNTER"] = {
        [1] = { -- 야수
            "C0PAo4YcvOcqUdzB9zV+NhSAcYzsNwAGwMsBZsAAgZGLzMDzwMzMYGzMzwMmZGzYGbzMDjZYZMNDAAAAAYGAAAGjZGmZACMzCYzA",
            "morthunt",
        },
        [2] = { -- 사격
            "C4PAo4YcvOcqUdzB9zV+NhSAcwCMwMGNWGQmBbAAAAAAAAAzYmZGbzYmZMDLjpZMGzsttZmZGmZYZmZZMmlhZGAAAjxAwMjNGGgNM",
            "grimshunter",
        },
        [3] = { -- 생존
            "C8PAo4YcvOcqUdzB9zV+NhSAcMWwMzYmZb0sYYGmZawiZmZmZYZAAAAAAwMmZmZxMGzYGMmmBAAAAMAAWWmZmFzMzMMzYAzsZADjxMzGD",
            "mawgun",
        },
    },
    ["MAGE"] = {
        [1] = { -- 비전
            "C4DAMhlVtghLZL4RZzExaQoBYNzwYZmZmFMzQzMzMAAAGAwMjmFbzMzMzyyMTsAAw2MmZGzmZZmZGzMGDzMzYhZmZMDAwAAAYmFYGwMAYYA",
            "hairumageone",
        },
        [2] = { -- 화염
            "C8DAMhlVtghLZL4RZzExaQoBYNzwMLzMzsgZGZmZGAAAGAwMz0sssMDAwmZmx2YmZGbAAAAAwiZmZGAAYMDjZmZmZZAYmhYGjBzwA",
            "maguvek",
        },
        [3] = { -- 냉기
            "CAEAMhlVtghLZL4RZzExaQoBYZGGLzMzsMmZmYmxYmZmZWMzMjZMzsMTzMbzCAYmZmllZm2AAgNAAAgNA2WGzMzgZbYMDLAAAMz2MDmhxAmBD",
            "khaelt",
        },
    },
    ["MONK"] = {
        [1] = { -- 양조
            "CwQAi6cZM+HWADeySjzG9Lwx8DAAAwMbbGDGz2M2YmZMAAAAAAALLYmYmBmhZ2MwMzMDzCzMmZ5BYZb22mthZBAA2QAAAmtZpZmZ2YYDgZGmGDAAYA",
            "brewbtian",
        },
        [2] = { -- 안개
            "C4QAi6cZM+HWADeySjzG9Lwx8DAAAAAAAghxyMLjZx2MmZsYstsMjZ2Mz2yyMjFmRzYGwgBDLzMzMMbwwsMTAAAAAEgFbzsMbzMgAAYAYGwYgFZMDA",
            "ryqim",
        },
        [3] = { -- 풍운
            "C0QAi6cZM+HWADeySjzG9Lwx8PzYMghZZmZ2mxAAAAAAAAAAAALDzEmhhBMjZMzMzwsNMDzyMBAsZmtxwYmZgAYDANLzSzMzsAMMwMDAsMAGwA",
            "onlydecent",
        },
    },
    ["PALADIN"] = {
        [2] = { -- 보호
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAMa22mZmlxMzMAAAAAAmpMLzwMjthHYbYmtZMGjhZsxGAAQmZaZmZbGAwGgBAMzmBmxMzGWmBDjZMYA",
            "yodafotm",
        },
        [3] = { -- 징벌
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAMaW2mZmlxYmBAAAAAwMlZZGmZsNMbDzsNjxYMMjN2AAAyMTbzMbzAA2AMAGMDDMzMzshlZwwYYwA",
            "melee",
        },
        [1] = { -- 신성
            "CEEAVg1HmQqr1Dwlv86ljju8vCAAAYBAMDAAsMmZmZGzMzCMGWGbzMLmpJmlZMzMMMbZAYAYDsx2MzMLz2Mzs1AAmZWWWsNzwGbMwGwMmBAMzgZGmxY0A",
            "mulèyò",
        },
    },
    ["PRIEST"] = {
        [1] = { -- 수양
            "CAQA4VPTJ8eQb8/qEm8PyGu4yADsAzGjZYmZMbzsNzMzMMDAAAAAAAAAgZYZGMzMDmxMgpZiBYmNMEGzyAMGsAAAjZmZMMzAMzMTzwA",
            "jinx",
        },
        [2] = { -- 신성
            "CEQA4VPTJ8eQb8/qEm8PyGu4ywYAAAAAAgZzwYWGMmZmZMzMjlZmBAAAAjZWmZMzMzwMmZAMTNAmZZmtZmMbzMLDwMzgNjZ2A0MmhxgZ2WGMzMgB",
            "hannavi",
        },
        [3] = { -- 암흑
            "CIQA4VPTJ8eQb8/qEm8PyGu4yMMjZGAAAAAAAAAAAghZxMGLzMMzyMDjx2MzYmZGbIzYxMNAzAMziZ0sZAIjxCAmxAjZmZMbjZ2WGgZwA",
            "wildpriestxd",
        },
    },
    ["ROGUE"] = {
        [1] = { -- 암살
            "CMQAByFP3pExAEG41/8+e6b8fbmZmZzgBAAAAAmlBbzAAAAAAyyMzMzMzYMzMzsNzyMjHwDMzMzMGmZMGADsAzY0Y2AZbAbGAMzMGD",
            "woxtoxic",
        },
        [2] = { -- 무법
            "CUQAByFP3pExAEG41/8+e6b8fDgx2MAAAAAwsMGLTMbbjxMjZwDMzMzYMbjZGbbzMzMzMjBjZ2GAAAAGMGwY2MMwAziWoFbYGwMDmxA",
            "tomelvis",
        },
        [3] = { -- 잠행
            "CUQAByFP3pExAEG41/8+e6b8fDgx2MAAAAAwsMGLTMbbjxMjZwDMzMzYMbjZGbLzMzMzMjBjZ2GAAAAGMmNzyMmtZYswwyMLTL0yshZYmZmBzYA",
            "casualaddict",
        },
    },
    ["SHAMAN"] = {
        [1] = { -- 정기
            "CYQARUG2fGwHkLP0T7/MoTNl/AAAAAzMbbzMzYML2mhZMzAAAAAAbmxwGsAzohGbAwsNzMjx2iJMjtxyMzMzMsYZGLmZGzsAAMAmZghhB",
            "fauni",
        },
        [3] = { -- 복원
            "CYQARUG2fGwHkLP0T7/MoTNl/AAAAAzMbLzMmZmZZbbgxMDAAAAAsYGDbwCMjGasBAzyMzMGbLmwMzyYZmZmxwysMjFzMjZWAAGAzMwwwA",
            "xhanon",
        },
        [2] = { -- 고양
            "CcQARUG2fGwHkLP0T7/MoTNl/MzMzgZmZmZmhZmZAAAAAAAAAshFstNjZmtFNLbDzwMTDWAY2mxMGLLzAzMbzsMzMzwYZMDAwMMmZYEzMzMYwYA",
            "shadi",
        },
    },
    ["WARLOCK"] = {
        [1] = { -- 고통
            "CkQAy0jxIDofkwJmoH7WhvESoxMzMzoZzM2mZGzyAAAmZmlZzMziZAgZZbbMMmFz0YmZYLzCDbDAAAzAAAzMzMjZMGjxMYmZMGmZmBAYGYA",
            "pigson",
        },
        [2] = { -- 악마
            "CoQAy0jxIDofkwJmoH7WhvESoxMjZGNbmZ2mZGzyAAAAAAAAGzYYBGYb0CNsYMzYZ2mZmxMAwMjxMzMDwYGzYDAAMmZmxww2MGwA",
            "loonyxdd",
        },
        [3] = { -- 파괴
            "CsQAy0jxIDofkwJmoH7WhvESoxMmZmpZzM2mZGzysZGzsYmZZZMAAYGjZmZxCmZGzssMamZYbYZ2asxAAAjZYAAmZmZwYGjBAAgZmZAAwMM",
            "jixzy",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- 무기
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmxsMzMzYGAAAghphxwMbLzMzMjZGzMAAAAAGbmB2iBsZGDLwAzoNaMYBYGMGMbmtBzMAgZmhB",
            "deepps",
        },
        [3] = { -- 방어
            "CkEAjLzRlq54bI5v+r8Sr9Xw4nBAAmZGmZmZmxsZmZZYMGNMzYbZmZmZAzMAAAAYZMAzYAGYDWWMaMDgZLmZDzMmZwsNAYmBAgZAD",
            "acefloorpov",
        },
        [2] = { -- 분노
            "CgEAjLzRlq54bI5v+r8Sr9Xw4DAAAAAAgGDjZMz2yMzMzMmxMjZMjZWmZGjZmlxMzAAAxMLLjNWssYmGzMDTmFmZsAYGMGAMzgZGDzMzgBD",
            "yükí",
        },
    },
}
