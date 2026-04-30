-- talent_data.lua
-- 스펙별 특성 빌드 문자열 (murlok.io 1위 플레이어 기준)
-- 업데이트: 2026-04-30

ItemInfoTalentData = {
    ["DEATHKNIGHT"] = {
        [1] = { -- 혈기
            "CoPAkXBWxkyfx9CbGaHonEAhLxMzyMzwMmZmhZZmZmmZxMjxMmBAAAAGMzMzMjZmZMAYmZmZGAAgxsNwAWCWGmADLAmxAAgZGAYA",
            "dodeyparton",
        },
        [2] = { -- 냉기
            "CwPAkXBWxkyfx9CbGaHonEAhLBYmZMjZMDz2MzMTDzMmZGDAAAAAAAAzMmxAglZMzsZmxYGwiZzwQGY2YoxCGwMAMmZGzAMzMMG",
            "vnvqt",
        },
        [3] = { -- 부정
            "CwPAkXBWxkyfx9CbGaHonEAhLBYmZMPgxYY2GzMTz2MzYmZMAAAAAAAAMzYYAwyMmZ2MzYmZMYZmNzMzimZZhZjZbasgBMDAjZmxMYmZmZMjB",
            "элслэйерх",
        },
    },
    ["DEMONHUNTER"] = {
        [1] = { -- 파멸
            "CEkAG5bbocFKcv+yIq8fPd6ORZmZGzMz2MmZmZGzkxMDAAAAAAY2MmtZYmBzM2mt5BmZMGDLDsNLmxwsppxMzYYDAAAAAABAzMYAIAAwA",
            "rawrdh",
        },
        [2] = { -- 복수
            "CgcBG5bbocFKcv+yIq8fPd6ORBA2mxMzMzMzMGmBAAAAAAgxsMYGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAQgZMYMD",
            "kiradh",
        },
        [3] = { -- 포식
            "CgcBG5bbocFKcv+yIq8fPd6ORBA2mxMzMzYmxwMAAAAAAAMmthZGAAAAAAAAmxMMzMzMzMzMDzsYGjFZhZmZmt2mZmBwwAQgZMYMD",
            "speculation",
        },
    },
    ["DRUID"] = {
        [1] = { -- 조화
            "CYGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAAAAAAWoMbNjxMDwsYmZmZhBjZZmlZWMzM2YZmlxMjxCGGgx22MDGz2IwEAAAgFzMzMD2MMGDAAzMwA",
            "canexxfourty",
        },
        [3] = { -- 수호
            "CgGA8cL7tpvige+kkmGM9zUPWDAAAAAAAAAAAgZmxsMmZMzyMLzDwMLLDYbGGNRzMziZmZmlxMMAAAAAGMjtBAAAA1MLzyMzMAAWYmBwiZwAWsZAwMbwA",
            "gnomerender",
        },
        [2] = { -- 야성
            "CcGA8cL7tpvige+kkmGM9zUPWDAAAAAgZMzGzMzMGzm5B2GbzMzMmZAAAAYJY2M8AmZUzYWMzMzsMmxMAAAAAAGYAAAA0MLzyMzMz2MbNLzstAmZAWYwAAAYmNMA",
            "turbogronil",
        },
        [4] = { -- 회복
            "CkGA8cL7tpvige+kkmGM9zUPWPMmZZMjZmxsN8AMzsMmFbzAAAAAAAAAAglBNbzw0MjBmFzMzMLzwDYAAAAAMAAzA22GLYamZZAAMbzs1sMziNmZGwMLgmBAzMzMAMA",
            "зуджадах",
        },
    },
    ["EVOKER"] = {
        [1] = { -- 황폐
            "CsbBPJc41CfcseY0baneJ1IHrBAAAAAAAAAAwMjZGMDzwMwgZMTjZmpZmxyMMzMz8AzMzAmZGDzMLzMDMADWglxox2AyMBYDzgZGMMA",
            "vyraneth",
        },
        [2] = { -- 보존
            "CwbBPJc41CfcseY0baneJ1IHrBAAAAAMzMz22YGDzMmNzYM2GGAAYGzYGjhZiZmBAAAMzMTGmZegZZmZAgxMjZW2YxGDzMz0QzGsYYMzgZmxA",
            "cryve",
        },
        [3] = { -- 증강
            "CEcBPJc41CfcseY0baneJ1IHrxMzMbzMzgBzMLzYMMzGAAAAAAAAmZ8AmBjpGzMzAAAAAzMjxMzyYmBmZbGDWglxwYZAMTEbYmZwMDgB",
            "shirodrache",
        },
    },
    ["HUNTER"] = {
        [1] = { -- 야수
            "C8PApei1JmYNvFfEFaN5bWuGKMgxMG2ILwMM0gFzMzMzwyAAAAAAgZMjZsNjxMmBjpZAAAAYAgxyyMzsYmZGmxYAzsBYYMmZ2MA",
            "gunnys",
        },
        [2] = { -- 사격
            "C4PApei1JmYNvFfEFaN5bWuGKYzsMwAmgZYLwsAAAAAAAAAMjZmZsZMzMmhlx0MGMLbMzMLzMzMzMLMzywMDAAwMGzMzMgBwAsxMA",
            "helyanwee",
        },
        [3] = { -- 생존
            "C8PApei1JmYNvFfEFaN5bWuGKMWwMzYmZb0sYYGmZawiZmZmZYZAAAAAAwMmxM2mxwYGWGTzAAAAwAAjllZmZxMzMMjxAmZzAGGjZmNDA",
            "banshers",
        },
    },
    ["MAGE"] = {
        [1] = { -- 비전
            "C4DAMhlVtghLZL4RZzExaQoBYNzwYZmZmFegZGamxMAAAGAwMz0sstMzMzMLLzMxCAAbzYmZMbmlZmZMzYMMzMjFmZmxMAADAAgZWwMDYGAMM",
            "schoowap",
        },
        [2] = { -- 화염
            "C8DAMhlVtghLZL4RZzExaQoBYZGGLzMzswMDZmZGAAAGAwMz0sssMDAwmZmx2YmZGAAAAAgFzMzMDAAGzwYmZmZWGAmZIjxYwMMA",
            "maguvek",
        },
        [3] = { -- 냉기
            "C4DAMhlVtghLZL4RZzExaQoBYNzYZmlZmZWwMDNzYAAAYAAmZyymZmZmZZZmJWAAYbGzMjZzsMzMjZGjhZmZswMzMmBAYAAAMzCmZAzAghB",
            "khaelt",
        },
    },
    ["MONK"] = {
        [1] = { -- 양조
            "CwQAi6cZM+HWADeySjzG9Lwx8DAAAwMbbGDGzyMPwGzMjBAAAAAAYZBjYmBmhZ2MwMzMDzGzMmZZYZbW2mNMLAAw2sMtMbzsMAAz2s0MzMbMsBmZmZYaMAAgB",
            "knowmehappy",
        },
        [2] = { -- 안개
            "C4QAi6cZM+HWADeySjzG9Lwx8DAAAAAAAghxyMLjZx2MmZsZstsNjZ2Mz2yyMjFmRzYGwgBDLzMzMMbwws8ATAAAAgZbab2mZZWsNzysNzACAGMMzgZAjBWkxMA",
            "spingødxx",
        },
        [3] = { -- 풍운
            "C0QAi6cZM+HWADeySjzG9Lwx8PzYMYMYbmx2MAAAAAAAAAAAALDz0MmBMwywwMzMDzGzMYZmAAWMz2YGzMzMQAshlZbMNLzSzMzsBMMwMDAjlBwAG",
            "эльпочита",
        },
    },
    ["PALADIN"] = {
        [1] = { -- 신성
            "CEEAVg1HmQqr1Dwlv86ljju8vCAAAYBAMAAglxMzYGzMzGjxYWGbzMLmpJmlZMzMMMbZAYADbgNzyMmZZ2mZmtGAAAgFAYDGzYGAAwMDzYMaA",
            "mythmaster",
        },
        [2] = { -- 보호
            "CIEAVg1HmQqr1Dwlv86ljju8vuYmZYWmHYZmZMzwyYMmZhhBAAAAAAAAaamZZmxMzYMzWbAYAAD2AAAzMtNzsMDQgNwMAGjZYMAAbzAMzAG",
            "delgato",
        },
        [3] = { -- 징벌
            "CYEAVg1HmQqr1Dwlv86ljju8vCAAAAAQz22MzsMmZGAAAAAAGlZZGmZsNMbDzsNjxYMMjN2GAAQmZabmZbGAwGgBAjZYGMjxshlZwwYGDG",
            "poznasme",
        },
    },
    ["PRIEST"] = {
        [1] = { -- 수양
            "CAQA4VPTJ8eQb8/qEm8PyGu4yADsMzwyMjxMzgZbGzMjZMzAAAAAAAAAAYMzyMYmZmxMMDWMNTMYmZmFMEGzyMbz2mxYsYAAYMzDMjBzgZmZmRwA",
            "xscream",
        },
        [2] = { -- 신성
            "CAQA4VPTJ8eQb8/qEm8PyGu4yADsYGWmZMzMzgZbGzMzMDzAAAAAAAAAAYYWmhZmZGmxMD2MNTMYmZmFMEGzyMLz2mxYsYAAYMzDMjBzgZmZmRwA",
            "clemenz",
        },
        [3] = { -- 암흑
            "CIQA4VPTJ8eQb8/qEm8PyGu4yMMjZGAAAAAAAAAAAghZxMGLzMmZWmZYmx2MGzMzYDZYxMNGYmZGAIAz2stFMbMAwgxMzMmtxMYmBzgB",
            "boreasxo",
        },
    },
    ["ROGUE"] = {
        [1] = { -- 암살
            "CUQAphyM11FofNMFa1K3vFEDUCgx2MAAAAAwsMGLTYbZMmZMjxDMzMzsNmthZstMmZmZmxgxMbDAAAAzwYAjZxwADMLahWshZAzMYGDA",
            "esra",
        },
        [2] = { -- 무법
            "CQQAphyM11FofNMFa1K3vFEDUCgZ2mBjZYmtZmZmZMmlFjZmtptBbzAAAAAAssMmBzMmZMzMGAAAAzYGAGzihhMwsxCtwGDwMDmBD",
            "tomelvis",
        },
        [3] = { -- 잠행
            "CQQAphyM11FofNMFa1K3vFEDUCgx2MYmZmZmtZmZMzMzsBmZbaZw2MAAAAAAbLzMzwMzMzYmZ2GAAAAmZADmtZxMzMamZjZhltpF2YAmZmZGYA",
            "charrend",
        },
    },
    ["SHAMAN"] = {
        [1] = { -- 정기
            "CYQARUG2fGwHkLP0T7/MoTNl/AAAAAzMbbzMzYML2mhZMzAAAAAAbmxwGsAzohGbAwsNzMjx2iJMjtxyMzMzDMjFLzYxMzYmFAgBwMDMMMA",
            "fauni",
        },
        [2] = { -- 고양
            "CcQARUG2fGwHkLP0T7/MoTNl/MzMjZmZmZmZmZmZmZGAAAAAAAAAYB2gZsox2AYmgNAmlZMzMWWmxCzMbmlZmZGGGzAAYAGGxMDAMGA",
            "shadi",
        },
        [3] = { -- 복원
            "CgQARUG2fGwHkLP0T7/MoTNl/AAAAgBAAAAjZmZZbZMzMzYmZGzYYZmFbMmxy0YbmFmMDjNMzgZbmxMNbLzMMjZhFjZGDLzyAAgBwMDmZADjBD",
            "héléna",
        },
    },
    ["WARLOCK"] = {
        [1] = { -- 고통
            "CkQAMrNP5kak+EBqLfUa3dMm+yMjZGNLmxmZGzyAAAmZmlZzMzyYAgZZbZMMmFz0YmZYLzGDbDAAAzAAAzMzMjZMzsNGzgZmZGDzMzMAgZgB",
            "arzyn",
        },
        [3] = { -- 파괴
            "CsQAMrNP5kak+EBqLfUa3dMm+yMegZGNbmx2MzMzysZMzsYmZbZMAAYmZMzMLWwMzYmllRzMDbDLzWjFGAAYMYAAmZmZwYGjZDAAwMzMAAYGG",
            "jixzy",
        },
        [2] = { -- 악마
            "CoQAMrNP5kak+EBqLfUa3dMm+yMmZGNbMz2MzYWGAAAAAAAwYGDLwAbjWohFjxMLz2MzMmBAmZMzMzMDwYGzYDAAMmZmBYWmxAGA",
            "lexó",
        },
    },
    ["WARRIOR"] = {
        [1] = { -- 무기
            "CcEAjLzRlq54bI5v+r8Sr9Xw4jZmxsMzMzYGAAAghphZGmZzMzMzwMmZAAAAAM2MDIzA2MjhFYgZ0GNGsAMjNjxY2MbDmZAAzYYA",
            "bizentein",
        },
        [2] = { -- 분노
            "CgEAjLzRlq54bI5v+r8Sr9Xw4DAAAAAAgGDDjZ2WmZmZmxMmZMjZmZWmZGjxsMmZGAAIMwGssZ0YGQmFMjFAzgxAgZGADzMzMMYA",
            "noxiv",
        },
        [3] = { -- 방어
            "CcEAjLzRlq54bI5v+r8Sr9Xw4DzMzsMzMzMDAAAghphZGzwyMzMzgxMDAAAAgZWmZAZM2WGYBMgZYCZGsBmZwsNGMjBYmBgZMMA",
            "plkawar",
        },
    },
}
