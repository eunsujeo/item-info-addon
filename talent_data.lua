-- talent_data.lua
-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)
-- 업데이트: 2026-03-27

ItemInfoTalentData = {
    ["DEATHKNIGHT"] = {
        [1] = { -- 혈기
            "CoPASnrjTdwaLTX9NnLQoJJXfwMzyMzwMmZmhZbMz0MLmZmZmxAAAAAmhZmZmZMzYAAzMzMzAAAYmZbMMmxySjltlhJbDDbAmxAAgZmZGAGA",
            "snarfknight",
        },
        [2] = { -- 냉기
            "CsPASnrjTdwaLTX9NnLQoJJXfMAzMjZmZAz2MzMzMLmZkZMmZmZGYMzwMzMjZAAAAAAAAAwY2GYALglhJkxCmZYmBmBwwMDwMgB",
            "freggy",
        },
        [3] = { -- 부정
            "CwPASnrjTdwaLTX9NnLQoJJXfAYmhZmZGDz2MzMTzmZGzMDAAAAAAAAMzDwMDAWmxMz2MzYGDwmZxwQGY2YoxCGwMAwMzYGgZmhZMA",
            "melinhaz",
        },
    },
    ["DEMONHUNTER"] = {
        [1] = { -- 파멸
            "CEkAG5bbocFKcv+yIq8fPd6ORZGMzMzmxMzMmZmgZAAAAAAAzmxsMzYmZ2mZGLzmHYGbjhxyMLzghxyGTyYmxMWAAAAGAACwMDwAQAAgB",
            "gcdhacker",
        },
        [2] = { -- 복수
            "CUkAG5bbocFKcv+yIq8fPd6ORBA2mxMzMGmRmZGMLmxMGzMmZMjZmZMY2mZsNzMGDDAAAAz2MYYsswEGmZGbAAAAYgZmZmZrtZmZAAAAAAG",
            "rampire",
        },
    },
    ["DRUID"] = {
        [1] = { -- 조화
            "CYGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAAAAAAWoMbNjxMDwsNzMzMLMMjZZmlZWMzMzGLzsMmZwCGAMW2mZ22mZb2mpZmlZCAAAwCzMzMYzwYMAMzgZGYA",
            "justtinsucks",
        },
        [2] = { -- 야성
            "CcGA8cL7tpvige+kkmGM9zUPWDAAAAAgZmZYmZmZMmNjtZ2mZmZMzAAAAwWwsZ4BMzomxsMzMzMLjZMDAAAAAAAAAAANzysNzMzsNzWzyMbLgZGgFGMAAAmZDD",
            "turbogronil",
        },
        [3] = { -- 수호
            "CgGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAgZmZmFzMj5BWMLmZmZZZgZbGGNRzMziZmZmlhZAAAAAwgZmFzALbzMYMLDgpmZZWmZmBAwGmBwiBGYYZDwMzMLA",
            "awooweewaa",
        },
        [4] = { -- 회복
            "CkGA8cL7tpvige+kkmGM9zUPWPjxMLz2MmZmHY2GmZmxmxCzAAAAAAAAAAgFDNbMmmBmxsMmZmhhZGAAAAADAgBstM2w0MzyAAAEwCzMzgZGgmBAzMAAA",
            "deidah",
        },
    },
    ["EVOKER"] = {
        [1] = { -- 황폐
            "CEcBPJc41CfcseY0baneJ1IHrxMzYbmZmxyAzsMjxwMbAAAAAAAAMzAzgxUjZmZAAAAgZmZGzMLjZGYmtZMYBWGDjtBwMRshZmBzMAG",
            "lizzimcguire",
        },
        [2] = { -- 보존
            "CwbBPJc41CfcseY0baneJ1IHrBAAAAAYmZ2WGYGzMPwsYMzMzyAAAMzYGDmxMyMzAAAAMzMTmxMjZZmZAwAjZswCMwMaoBsAjZGgxA",
            "snowpi",
        },
        [3] = { -- 증강
            "CEcBPJc41CfcseY0baneJ1IHrNmZmZbmZmxyAzsMjxwMAAAAAAAAYmBmBjHoGzMzAAAAgZmZmxMzyYmBmZzYwCsMGGbDgZiYDzMDmZAM",
            "qbgosa",
        },
    },
    ["HUNTER"] = {
        [1] = { -- 야수
            "C0PAo4YcvOcqUdzB9zV+NhSAcAMmxwCsAzwQDbAAYGzyMzwMMzMzMmZYmZMDzMmZmBzMmxMYoZAAAAAAAAAwMjZAmZDBLzsA2MA",
            "hqnkzr",
        },
        [2] = { -- 사격
            "C4PAo4YcvOcqUdzB9zV+NhSAcwCMwMGNWGQmBbAAAAAAAAAzYmZGbzYmZMDLjpZMGzsttZmZGmZYZmZZMmlhZGAAAjxAwMjNGGgNM",
            "morthunt",
        },
        [3] = { -- 생존
            "C8PAo4YcvOcqUdzB9zV+NhSAcMgxMG2ILwMM0gFzMzMzwyAAAAAAgZMjZsZMmxMYMNDAAAAYAAssMzMLmZmZmZMzAmZDAGjZmFG",
            "govanovic",
        },
    },
    ["MAGE"] = {
        [1] = { -- 비전
            "C4DAMhlVtghLZL4RZzExaQoBYNzwYZmZmFMzQzMzMAAAGAwMjmFbzMzMzyyMTsAAw2MmZGzmZZmZGzMGDzMzYhZmZMDAwAAAYmFYGwMAYYA",
            "hairumageone",
        },
        [2] = { -- 화염
            "C8DAMhlVtghLZL4RZzExaQoBYNzwMLzMzsgZGZmxMAAAGAwMz0sssMDAwmZmx2YmZGbAAAAAwiZmZGAAYMjZMzMzMbAYmhMGjBzwA",
            "pogulemage",
        },
        [3] = { -- 냉기
            "CAEAMhlVtghLZL4RZzExaQoBYZGGLzMzswMzEzMGzMzMziZmhZMzsMTzMbzCAYmZmllZm2AAgNAAAgFA2WGzMz8AMbDjZGLAAAMzGwMMGwMYA",
            "manabananaz",
        },
    },
    ["MONK"] = {
        [1] = { -- 양조
            "CwQAi6cZM+HWADeySjzG9Lwx8DAAAwMbbGDPwYWmxGmZMAAAAAAALLYEzMwMM2YwMzMDzmlZGzsMssZbb2mZmFAAYbWmWmtZWGAgZbWamZmNG2AzMzMMNGAAwA",
            "monksea",
        },
        [2] = { -- 안개
            "C0QAi6cZM+HWADeySjzG9Lwx8PzYMghZZmZ2mxAAAAAAAAAAAALDjwM2GGwwwMzMYWYmhZZmAA2Mz2YYMzMQAsBgmtZpZmZWAGzAzMAwyMDYAD",
            "aluraye",
        },
        [3] = { -- 풍운
            "C0QAi6cZM+HWADeySjzG9Lwx8PzYMghZZmZ2mxAAAAAAAAAAAALDjwMgBWmxwMzMDzywMMLzEAwmZ2GDjZmBCgNzsMLjpZZWamZmFghBmZmBYsMDwMzsYA",
            "yuptik",
        },
    },
    ["PALADIN"] = {
        [1] = { -- 신성
            "CEEAVg1HmQqr1Dwlv86ljju8vCAAAYBAMDAwglxMzYGzMzGjxwyYbmZxMNxwYmZYY2yAwAwGYjtZmZWmtZmZrBAAAYhNMYzAzYmBAAmZwYMaA",
            "dpalx",
        },
        [2] = { -- 보호
            "CIEAVg1HmQqr1Dwlv86ljju8vuNjBzyYZMjZmZZZMzwsMLDDAwAAAAAAgmmZWmZMzMGegt2AwADYGsNAAwMTbzMbzMzsst0yMjFzgBAMDjBAzMbzAMzAG",
            "equinoxpal",
        },
        [3] = { -- 징벌
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAMaW2mZmlxYmBAAAAAwMlZZGmZsNMbDzsNjxYMMjN2AAAyMTbzMbzAA2AMAGMzGwMzMzGWmBDjhBD",
            "melee",
        },
    },
    ["PRIEST"] = {
        [1] = { -- 수양
            "CAQA4VPTJ8eQb8/qEm8PyGu4yADsAzGzMDzMjxMbzMzMDzAAAAAAAAAAYGWmBzMzghZgZamGDwMbYIMmlBYMYBAAGjZGDzMAzMz0MM",
            "jinx",
        },
        [2] = { -- 신성
            "CEQA4VPTJ8eQb8/qEm8PyGu4ywYAAAAAAgZzwYWGMmZmZMzMjtZmBAAAADzyMjZmZGmxMD2wMFAzsNz2MTmtZGAmZGsZMzGgmxMPgxgZ2WGYmBMA",
            "clemenz",
        },
        [3] = { -- 암흑
            "CIQA4VPTJ8eQb8/qEm8PyGu4yMMjZGAAAAAAAAAAAgxYxMGLzMMz2MDzY2MzYmZGbIzYxMNGYmZGMziZ0sZwsMLbZMzCDwMAjZmZMbjZ2WmZGYwA",
            "etzyk",
        },
    },
    ["ROGUE"] = {
        [1] = { -- 암살
            "CMQAByFP3pExAEG41/8+e6b8fbMjZZGMAAAAAwsMYbGAAAAAQbbzMzMzMjxMzMz2MLzMDMjZmZMzMzYAMwCMjRjZBklBsZsBYmZwA",
            "sap",
        },
        [3] = { -- 잠행
            "CUQAByFP3pExAEG41/8+e6b8fDgx2MAAAAAwsMGLTMbbjxMjZMMzMzYMbzYmZbbmZmZmZMYMjBAAAgBjBMmNDDMwsoFaxGmBMzgZMA",
            "slimthiq",
        },
    },
    ["SHAMAN"] = {
        [1] = { -- 정기
            "CYQARUG2fGwHkLP0T7/MoTNl/AAAAAzMbbzMmZmZZbbwMmZAAAAAgNzYYDWgZ0QjNAw2MzMzYbZmWYGbsMzMzYGmlZsYMmZWAAGAzMwwwA",
            "netherax",
        },
        [2] = { -- 고양
            "CcQARUG2fGwHkLP0T7/MoTNl/MzMjZmZmZmZmZmZGzAAAAAAAAAALwGMjFN2GAzEsBwsMjZMWWMwMz2YZmZmZwyYGAAgxYGxMDwgxA",
            "baralos",
        },
        [3] = { -- 복원
            "CgQARUG2fGwHkLP0T7/MoTNl/AAAAgBAAAAjZmZbZZGmZGzMzYGjllZWswYGLTjtZWYyMMWwMDmtHYmZ0YZmhZMYZGzMzwysMDAADwYGMzgZGMDG",
            "shamrocked",
        },
    },
    ["WARLOCK"] = {
        [2] = { -- 악마
            "CoQAy0jxIDofkwJmoH7WhvESoxMMzoZzM2mZGzyAAAAAAAMW2GYADYG2CZsZMGLzyMzMmBAMzMzMDwMzMzYmZDAAMmZmxYw2MAGA",
            "speedywl",
        },
        [3] = { -- 파괴
            "CsQAy0jxIDofkwJmoH7WhvESoxMzMzoZjxmZGzysMGzsYmZbhBAAzYMzMLWgBmFjGzAY2iNGAAYMYYDAYmBjZMzAAAwMzMDAgZGG",
            "loonyxdd",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- 무기
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmxsMzMzYGAAAghphZGmZbZmZmZYGzMAAAAAGbmB2iBsZGDLwAzoNaMYBYGbGDmNz2gZGAwYGGA",
            "bizentein",
        },
        [2] = { -- 분노
            "CgEAjLzRlq54bI5v+r8Sr9Xw4DAAAAAAgGDjZmZWWmZmZmhxMjZMjZWmZGjZmlxMzAAAhB2glNjGzAysgZsAYGMGAMzAYYmZGMYA",
            "kered",
        },
        [3] = { -- 방어
            "CkEAjLzRlq54bI5v+r8Sr9Xw4nBAAGzYmZmZmxsZmZZYMmpxMGWGzMzwMmZAAAAwyYAmxAMwGssY0YGAzWMzGMzMzgZbAwMDAADwA",
            "woddtian",
        },
    },
}
