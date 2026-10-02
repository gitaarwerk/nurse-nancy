local dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
dofile(dir .. "stubs.lua")
dofile(dir .. "../../public/Src/Helpers.lua")
dofile(dir .. "../../public/Src/SpellIds.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakSelfRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakSingleRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakCombatRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakMassRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/NurseNancy.lua")

-- Helpers (same as test_nursenary.lua)
local function setPlayer(name, gender, class, race)
  function UnitClass() return class, class:upper(), 1 end
  function UnitName()  return name, nil, 60           end
  function UnitSex()   return gender == "male" and 2 or 3 end
  function UnitRace()  return race, race               end
end

local function setTarget(name, gender, class, race)
  function GetPlayerInfoByGUID()
    return class, class:upper(), race, race, gender == "male" and 2 or 3, name, nil
  end
end

local function setDate(m, d)
  C_DateAndTime.GetCalendarTimeFromEpoch = function() return { month = m, day = d } end
end

-- Iterate fastrandom from 1..maxIdx.  pcall absorbs out-of-bounds indices
-- (table[i] returns nil → parseText errors on nil concatenation).
local function checkAllLengths(label, callFn, maxIdx)
  for i = 1, maxIdx do
    fastrandom = function() return i end
    local ok, line = pcall(callFn)
    if ok and type(line) == "string" then
      assert_true(
        #line <= 245,
        string.format("%s index %d: length %d is within 245-char limit", label, i, #line)
      )
    end
  end
end

-- ── speakSelfRess ─────────────────────────────────────────────────────────────
-- Worst-case: Shaman + Night Elf (most appended lines) + Easter holiday.
setPlayer("Healbot", "female", "Shaman", "Night Elf")
setDate(4, 4)
checkAllLengths("speakSelfRess", function()
  return NurseNancy.NurseNancy.speakSelfRess(nil, 0)
end, 60)
setDate(6, 15)

-- ── speakSingleRess ───────────────────────────────────────────────────────────
-- Worst-case: Warlock player + Priest target + engineering spell + Christmas.
setPlayer("Dotmaster", "male", "Warlock", "Human")
setTarget("Priesty", "female", "Priest", "Human")
setDate(12, 25)
checkAllLengths("speakSingleRess", function()
  return NurseNancy.NurseNancy.speakSingleRess("uid-001", 8342)
end, 130)
setDate(6, 15)

-- ── speakCombatRess ───────────────────────────────────────────────────────────
-- Worst-case: Warlock player + Easter.
setPlayer("Warlie", "male", "Warlock", "Human")
setTarget("Priesty", "female", "Priest", "Human")
setDate(4, 4)
checkAllLengths("speakCombatRess", function()
  return NurseNancy.NurseNancy.speakCombatRess("uid-002", 20707)
end, 80)
setDate(6, 15)

-- ── speakMassRess ─────────────────────────────────────────────────────────────
-- Worst-case: Paladin player + Christmas.
setPlayer("Pallie", "male", "Paladin", "Human")
setDate(12, 25)
checkAllLengths("speakMassRess", function()
  return NurseNancy.NurseNancy.speakMassRess()
end, 80)
setDate(6, 15)

-- ── Retry behaviour ───────────────────────────────────────────────────────────
-- Verify that all speak functions never produce a line > 245 chars with a
-- player/target whose names are at the realistic upper end (20 chars each).
-- If they do, the retry loop in announceRess would catch it — but ideally the
-- lines are always short enough that no retry is needed.
setPlayer("Averylongplayername", "female", "Shaman", "Night Elf")
setTarget("Averylongtargetname", "male", "Warlock", "Human")
setDate(12, 25)

fastrandom = function(_, max) return max end  -- pickLast always

local line

line = NurseNancy.NurseNancy.speakSelfRess(nil, 0)
assert_true(type(line) == "string" and #line > 0,   "retry/long-name: speakSelfRess returns a string")
assert_true(#line <= 245, "retry/long-name: speakSelfRess within 245 chars (got " .. #line .. ")")

line = NurseNancy.NurseNancy.speakSingleRess("uid-long", 8342)
assert_true(type(line) == "string" and #line > 0,   "retry/long-name: speakSingleRess returns a string")
assert_true(#line <= 245, "retry/long-name: speakSingleRess within 245 chars (got " .. #line .. ")")

line = NurseNancy.NurseNancy.speakCombatRess("uid-long", 20707)
assert_true(type(line) == "string" and #line > 0,   "retry/long-name: speakCombatRess returns a string")
assert_true(#line <= 245, "retry/long-name: speakCombatRess within 245 chars (got " .. #line .. ")")

setPlayer("Averylongplayername", "male", "Paladin", "Human")
line = NurseNancy.NurseNancy.speakMassRess()
assert_true(type(line) == "string" and #line > 0,   "retry/long-name: speakMassRess returns a string")
assert_true(#line <= 245, "retry/long-name: speakMassRess within 245 chars (got " .. #line .. ")")

setDate(6, 15)

report("line_length")
