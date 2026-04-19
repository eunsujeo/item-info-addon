-- talent_data.lua
-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)
-- 업데이트: 2026-04-18

ItemInfoTalentData = {
    ["DEATHKNIGHT"] = {
        [1] = { -- 혈기
            "CoPASnrjTdwaLTX9NnLQoJJXfwMzyMzwMmZmZMLzMz0MLGjZmxAAAAAGMzMzMjZmZMAYmZmZGAAAzMbjhxMWWasstMMZbYYBwMGAAMzMzAwA",
            "yodadkt",
        },
        [2] = { -- 냉기
            "CwPASnrjTdwaLTX9NnLQoJJXfAYmZMjZGDz2MzMTzmZGzMjBAAAAAAAgZeAMDAWmxMz2MzYGDwmZxwQGY2YoxCGwMAMmZGzAMzgZMA",
            "enerugi",
        },
        [3] = { -- 부정
            "CwPASnrjTdwaLTX9NnLQoJJXfAwMjZMzYY2mZmZaWMzMjZMAAAAAAAAMzwMDAWmxMz2MzYGDD2mZxMzsoZWWY2Y2mGLAYGAYmZMDmZmZGmxA",
            "bugapproved",
        },
    },
    ["DEMONHUNTER"] = {
        [2] = { -- 복수
            "CgcBG5bbocFKcv+yIq8fPd6ORBA2mxMzMmZmxYmBAAAAAAgxsNYGAAAAAAAAmxMMmZmZmZmZGzsYGjFtsxMzMzWbzMzAYYAIwMGMmB",
            "zacdh",
        },
        [3] = { -- 포식
            "CgcBG5bbocFKcv+yIq8fPd6ORBA2mxMzMzMzMGmBAAAAAAgxsNYGAAAAAAAAmxMMmZmZmZmZGzsYGjFtsxMzMzWbzMzAYYmZWmZmmtZ2mxgxMA",
            "jabuka",
        },
        [1] = { -- 파멸
            "CEkAG5bbocFKcv+yIq8fPd6ORZmZmZmZ2wMzMmZmMmZAAAAAAAzixsNzDYmBmx2sNzMjxALDsNbmxwsopxMzYGbAAAADAABAzMYAIAAwA",
            "ronindh",
        },
    },
    ["DRUID"] = {
        [1] = { -- 조화
            "CYGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAAAAAAWoMbNjxMDwsMzMzMYYGzyMLDzYGbsMzyMzMMLYYAGgltxGmmZWGBAAAYjZmZGsZYMmBwMDAMA",
            "dwilkz",
        },
        [2] = { -- 야성
            "CcGA8cL7tpvige+kkmGM9zUPWDAAAAAgZMzGzMzMGzmx2MbzMzMmZAAAAYJY2M8AmZUzYWMzMzsMmxMAAAAAAGYAAAA0MLzyMzMz2MbNLzstAmZAWYwAAAYmNMA",
            "turbogronil",
        },
        [3] = { -- 수호
            "CgGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAgZmxsMzMjZ2MLDMWGwmZMaimZmlZmZmZZMDAAAAAAzMLzAAAAQNzysMzMDAgFMzDAsYGMgFLbDAmZDG",
            "squishvegan",
        },
        [4] = { -- 회복
            "CkGA8cL7tpvige+kkmGM9zUPWPMmZZMjZmxsNMMmFmFbzAAAAAAAAAAglBNbzw0MjhHwsYmZGLzwDYAAAAAMAAzAWWGLYamZZAAMbzs1sMziNmZGYmZB0MAAzMAMA",
            "vitalitie",
        },
    },
    ["EVOKER"] = {
        [1] = { -- 황폐
            "CEcBPJc41CfcseY0baneJ1IHrNmZmZbmZGMYmZZGjhZ2AAAAAAAAYmhxMYM1YmZGAAAAMjZMmZ2GzMwMLGYMjFWgBmhhGxCmZMzAAD",
            "gonski",
        },
        [2] = { -- 보존
            "CwbBPJc41CfcseY0baneJ1IHrBAAAAAMzMz22ADzMPwsYGjZ2GGAAGzYGzMjhZixMAAAgZmZaGzMzMGzAAjZGzssxiNGmZmphmNDLGGzMYmhB",
            "cryve",
        },
        [3] = { -- 증강
            "CEcBPJc41CfcseY0baneJ1IHrxMzMbzMzgBzMLzYMMzGAAAAAAAAmBzYGjpGzMzAAAAAjZmxMzyYmBmZbGDWglxwYZAMTEbYmZwMDGM",
            "chum",
        },
    },
    ["HUNTER"] = {
        [1] = { -- 야수
            "C0PAo4YcvOcqUdzB9zV+NhSAcYzsNwAGwMsBZsAAgZGLzMDzwMzMYGzMzwMmZGzMzYbmZYMDLjpZAAAAAAzAAAwYMzwMDQAzCYxA",
            "morthunt",
        },
        [2] = { -- 사격
            "C4PAo4YcvOcqUdzB9zV+NhSAcwCMwMGNWGQmBbAAAAAAAAAzYmZGbzYmZMDLjpZMGzsttZmZGmZYZmZZMmlhZGAAAjxAwMjNGGgFM",
            "grimshunter",
        },
        [3] = { -- 생존
            "C8PAo4YcvOcqUdzB9zV+NhSAcMWwMzYmZb0sYYGmZawiZmZmZYZAAAAAAwMmxMLmxYGzwyYaGAAAAwAAYZZmZWMzMzMGjBMzmBMMGzMbMA",
            "mawgun",
        },
    },
    ["MAGE"] = {
        [1] = { -- 비전
            "C4DAMhlVtghLZL4RZzExaQoBYNzwYZmZmFMzQzMzMAAAGAwMjmFbzMzMzyyMTsAAw2MmZGzmZZmZGzMGDzMzYhZmZMDAwAAAYmFYGwMAYYA",
            "hairumageone",
        },
        [2] = { -- 화염
            "C8DAMhlVtghLZL4RZzExaQoBYNzwMLzMzsgZGZmZGAAAGAwMz0sssMDAwmZmx2YmZGbAAAAAwiZmZGAAYMDjZmZmZbAYmhYGjBzwA",
            "maguvek",
        },
        [3] = { -- 냉기
            "CAEAMhlVtghLZL4RZzExaQoBYZGGLzMzsMmZmYmxYmZMziZmZmZMzsMTzMbzCAYmZmllZm2AAgNAAAgNA2WGzMzgZbYMDLAAAMz2MDmhxAmBD",
            "khaelt",
        },
    },
    ["MONK"] = {
        [1] = { -- 양조
            "CwQAi6cZM+HWADeySjzG9Lwx8DAAAwMbbGDGz2M2YmZMAAAAAAALLYEzMwMMzmBmZmZY2YmxMLDLbz22sNMLAAwGCAAwsNLNzMzGDbAMzw0YAAAD",
            "brewbtian",
        },
        [2] = { -- 안개
            "C4QAi6cZM+HWADeySjzG9Lwx8DAAAAAAAghxyMLjZx2MmZsYstsMjZ2Mz2yyMjFmZaGzAGMYYZmZmhZDGmlHYCAAAAgAsYbmlZbmBEAADAzAGDsIjZA",
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
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAMaW2mZmlxYmBAAAAAwMlZZGmZsNMbDzsNjxYMMjN2AAAyMTbzMbzAA2AMAGMzGwMzMzGWmBDjhBD",
            "melee",
        },
        [1] = { -- 신성
            "CEEAVg1HmQqr1Dwlv86ljju8vCAAAYBAMDAAsMmZmZGzMzCMGWGbzMLmpJmlZMzMMMbZAYAYDsx2MzMLz2Mzs1AAmZWWWsNzwGbMwGwMmBAMzgZGmxY0A",
            "mulèyò",
        },
    },
    ["PRIEST"] = {
        [1] = { -- 수양
            "CAQA4VPTJ8eQb8/qEm8PyGu4yADsYwyMjZmZGMbzsNzMjxMDAAAAAAAAAgxYZGMzMDzYmBMNTMAzsghwYWGgxgFAAYMzMjBzAMzMTwA",
            "jinx",
        },
        [2] = { -- 신성
            "CEQA4VPTJ8eQb8/qEm8PyGu4ywYAAAAAAgZzwYWGMmZmZMzMjlZmBAAAAjZWmZMzMzwMMDgZKAmZZmtZmMbzMLDwMzgNjZ2A0MmhxwMz2ygZmZgB",
            "hannavi",
        },
        [3] = { -- 암흑
            "CIQA4VPTJ8eQb8/qEm8PyGu4yMMjZGAAAAAAAAAAAghZxMGLzMMzyMDjx2MzYmZGbIzYxMNAzAMzmZ0sZAIjxCAmxAjZmZMbjZ2WGgZwA",
            "wildpriestxd",
        },
    },
    ["ROGUE"] = {
        [1] = { -- 암살
            "CMQAByFP3pExAEG41/8+e6b8fbmZMbGMAAAAAwsMYZGAAAAAQbbzMzMzMjxMzMz2MLzMDMzMzMjZmZGDgBWgZMaMLgsNgNDAmZGMA",
            "woxtoxic",
        },
        [2] = { -- 무법
            "CQQAByFP3pExAEG41/8+e6b8fDgx2MYmZmZmtZmZmZmHYmFeAmZbaZw2MAAAAAALLzMzwMzMzYmZ2GAAAAGADmtZzMzMamZjZhttpNWYAwMzMYA",
            "tomelvis",
        },
        [3] = { -- 잠행
            "CUQAByFP3pExAEG41/8+e6b8fDgZ2mBAAAAAmlxYZiZbbMmZMjhZmZGjZbGzYbZmZMzMjBjZWGAAAAGMmFzyMmtZYswwyMLTL0yshZYmZmBzYA",
            "салатисос",
        },
    },
    ["SHAMAN"] = {
        [1] = { -- 정기
            "CYQARUG2fGwHkLP0T7/MoTNl/AAAAAzMbbzMzYML2mhZMzAAAAAAbmxwGsAzohGbAwsNzMjx2iJMjtxyMzMzDMjFLzYxMzYmFAgBwMDMMMA",
            "fauni",
        },
        [3] = { -- 복원
            "CgQARUG2fGwHkLP0T7/MoTNl/AAAAgBAAAAjZmZbbZMzMzYmZGzYYBWgZsox2AyMwGzMDmtZGjmllZGmxsxixMjhlZZGAAGAzMYmBAGM",
            "xhanon",
        },
        [2] = { -- 고양
            "CcQARUG2fGwHkLP0T7/MoTNl/MzMzgZmZmZmZmZmZGAAAAAAAAgNsgttZMzstoZZbYGmZawCAz2MmZGLLzYjZGzsMzMzwYZYAAmhxMYEzMzMYw4CA",
            "shadi",
        },
    },
    ["WARLOCK"] = {
        [1] = { -- 고통
            "CkQAy0jxIDofkwJmoH7WhvESoxMjZGNbmx2MzYWGAAwMzsMbmZWGDAMLLbjhxsYmGzMDbZWYYbAAAYGAAYmZmZMjZGjxMYmZmxwMzMDAYGYA",
            "pigson",
        },
        [2] = { -- 악마
            "CoQAy0jxIDofkwJmoH7WhvESoxMzMzoZjZ2mZGzyAAAAAAAAGzYYBGYb0CNsYMzYZ2mZmxMAwMjxYmZAGzYGAAAmZmZMjhlZMgB",
            "loonyxdd",
        },
        [3] = { -- 파괴
            "CsQAy0jxIDofkwJmoH7WhvESoxMmZGNbmx2MzMz2sZGzsYmZZZMAAYmZMzMLWwMzYmllRzMDbDbzWjFGAAYMYAAmZmZwYGjBAAgZmZAAwMM",
            "jixzy",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- 무기
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmZmFzMzYGAAAghphxwMbLzMzMjZGzMAAAAAGLmB2iZssMwCYAzwEyMYDYGMGMbzsNAzMAMjhB",
            "deepps",
        },
        [3] = { -- 방어
            "CkEAjLzRlq54bI5v+r8Sr9Xw4nBAAmZGmZmZmxsZMLzYMGNMzYbZmZmZAzMAAAAYZMAzYAGYDWWMaMDgZLmZDzMmZwsNAYmBAgZAD",
            "acefloorpov",
        },
        [2] = { -- 분노
            "CgEAjLzRlq54bI5v+r8Sr9Xw4DAAAAAAgGDjhZ2WmZmZmZmxMjZMjZWmZGjZmtxMzAAAxYZZgFwEMDTgZYDwMYMAAYmxwMzMDDG",
            "noxiv",
        },
    },
}
