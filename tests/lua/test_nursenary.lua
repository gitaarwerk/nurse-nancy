local dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
dofile(dir .. "stubs.lua")
dofile(dir .. "../../public/Src/Helpers.lua")
dofile(dir .. "../../public/Src/SpellIds.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakSelfRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakSingleRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakCombatRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/SpeakMassRess.lua")
dofile(dir .. "../../public/Src/NurseNancy/NurseNancy.lua")

-- Helpers to configure the stubbed player / target and control line selection.
local function setPlayer(name, gender, class, race)
  function UnitClass()  return class, class:upper(), 1 end
  function UnitName()   return name, nil, 60           end
  function UnitSex()    return gender == "male" and 2 or 3 end
  function UnitRace()   return race, race               end
end

local function setTarget(name, gender, class, race)
  function GetPlayerInfoByGUID()
    return class, class:upper(), race, race, gender == "male" and 2 or 3, name, nil
  end
end

local function pickFirst() fastrandom = function(min, _)   return min end end
local function pickLast()  fastrandom = function(_, max)   return max end end
local function setDate(m, d)
  C_DateAndTime.GetCalendarTimeFromEpoch = function() return { month = m, day = d } end
end

-- ── speakSelfRess ─────────────────────────────────────────────────────────────

setPlayer("Healbot", "female", "Mage", "Human")
NurseNancyVars.usePrefix = false

pickFirst()
local line = NurseNancy.NurseNancy.speakSelfRess(nil, 0)
assert_true(type(line) == "string" and #line > 0, "speakSelfRess returns a non-empty string")
assert_no_template(line, "speakSelfRess first line has no template leaks")

NurseNancyVars.usePrefix = true
line = NurseNancy.NurseNancy.speakSelfRess(nil, 0)
assert_true(line:sub(1, 1) == "[", "speakSelfRess prefix applied when usePrefix=true")
NurseNancyVars.usePrefix = false

-- Shaman gets extra lines appended; pickLast should land on a Shaman line.
setPlayer("Shammy", "male", "Shaman", "Orc")
pickLast()
line = NurseNancy.NurseNancy.speakSelfRess(nil, 0)
assert_no_template(line, "speakSelfRess Shaman last line no template leaks")
assert_true(
  line:find("element") ~= nil or line:find("Shaman") ~= nil
  or line:find("Reincarnati") ~= nil or line:find("beer") ~= nil
  or line:find("totem") ~= nil or line:find("phoenix") ~= nil,
  "speakSelfRess Shaman: last line is Shaman-specific"
)

-- Night Elf gets a race-specific line appended after Shaman lines.
setPlayer("Nightblade", "female", "Shaman", "Night Elf")
pickLast()
line = NurseNancy.NurseNancy.speakSelfRess(nil, 0)
assert_no_template(line, "speakSelfRess Night Elf+Shaman last line no template leaks")

-- Easter holiday (month=4, day=4): two lines appended → pickLast hits Easter line.
setPlayer("Eggy", "female", "Mage", "Human")
setDate(4, 4)
pickLast()
line = NurseNancy.NurseNancy.speakSelfRess(nil, 0)
assert_no_template(line, "speakSelfRess Easter line no template leaks")
assert_true(line:find("egg") ~= nil or line:find("Easter") ~= nil or line:find("bunny") ~= nil
  or line:find("Risen") ~= nil or line:find("spring") ~= nil or line:find("chocolate") ~= nil,
  "speakSelfRess Easter: last line is Easter-specific")
setDate(6, 15)

-- ── speakSingleRess ───────────────────────────────────────────────────────────

setPlayer("Priestess", "female", "Priest", "Human")
setTarget("Tanky", "male", "Warrior", "Dwarf")
NurseNancyVars.usePrefix = false

pickFirst()
line = NurseNancy.NurseNancy.speakSingleRess("uid-001", 2006)
assert_true(type(line) == "string" and #line > 0, "speakSingleRess returns a non-empty string")
assert_no_template(line, "speakSingleRess first line no template leaks")
assert_true(line:find("Tanky") ~= nil, "speakSingleRess first line contains target name")

NurseNancyVars.usePrefix = true
line = NurseNancy.NurseNancy.speakSingleRess("uid-001", 2006)
assert_true(line:find("%[Ressing Tanky%]") ~= nil, "speakSingleRess prefix contains target name")
NurseNancyVars.usePrefix = false

-- Engineering spell IDs trigger extra lines; pickLast should hit one.
pickLast()
line = NurseNancy.NurseNancy.speakSingleRess("uid-001", 8342)
assert_no_template(line, "speakSingleRess engineering last line no template leaks")

-- Druid target gets an extra line. Use a Mage player so no class lines are
-- appended after the Druid-target line, ensuring pickLast() lands on it.
setPlayer("Magi", "female", "Mage", "Human")
setTarget("Leafy", "female", "Druid", "Night Elf")
pickLast()
line = NurseNancy.NurseNancy.speakSingleRess("uid-002", 2006)
assert_no_template(line, "speakSingleRess Druid target last line no template leaks")
assert_true(line:find("root") ~= nil or line:find("RAWR") ~= nil or line:find("Leafy") ~= nil,
  "speakSingleRess Druid target: last line is Druid-specific")

-- Christmas holiday.
setTarget("Tanky", "male", "Warrior", "Human")
setDate(12, 25)
pickLast()
line = NurseNancy.NurseNancy.speakSingleRess("uid-001", 2006)
assert_no_template(line, "speakSingleRess Christmas last line no template leaks")
assert_true(line:find("Christmas") ~= nil or line:find("naughty") ~= nil
  or line:find("Santa") ~= nil or line:find("gift") ~= nil,
  "speakSingleRess Christmas: last line is Christmas-specific")
setDate(6, 15)

-- ── speakCombatRess ───────────────────────────────────────────────────────────

setPlayer("Deathblade", "male", "Death Knight", "Human")
setTarget("Priesty", "female", "Priest", "Human")
NurseNancyVars.usePrefix = false

pickFirst()
line = NurseNancy.NurseNancy.speakCombatRess("uid-003", 61999)
assert_true(type(line) == "string" and #line > 0, "speakCombatRess returns a non-empty string")
assert_no_template(line, "speakCombatRess first line no template leaks")

NurseNancyVars.usePrefix = true
line = NurseNancy.NurseNancy.speakCombatRess("uid-003", 61999)
assert_true(line:find("%[Combat ressing Priesty%]") ~= nil, "speakCombatRess prefix contains target name")
NurseNancyVars.usePrefix = false

-- Death Knight extra lines appended; pickLast should hit one.
pickLast()
line = NurseNancy.NurseNancy.speakCombatRess("uid-003", 61999)
assert_no_template(line, "speakCombatRess DK last line no template leaks")
assert_true(line:find("Lich") ~= nil or line:find("undeath") ~= nil
  or line:find("Necromancer") ~= nil or line:find("abomination") ~= nil
  or line:find("brittle") ~= nil or line:find("limb") ~= nil
  or line:find("shotgun") ~= nil or line:find("hell") ~= nil,
  "speakCombatRess DK: last line is DK-specific")

-- Warlock overrides the prefix to [Soulstone on ...].
setPlayer("Warlie", "male", "Warlock", "Human")
NurseNancyVars.usePrefix = true
line = NurseNancy.NurseNancy.speakCombatRess("uid-003", 20707)
assert_true(line:find("%[Soulstone on Priesty%]") ~= nil, "speakCombatRess Warlock soulstone prefix")
NurseNancyVars.usePrefix = false

-- ── speakMassRess ─────────────────────────────────────────────────────────────

setPlayer("Holyroller", "female", "Priest", "Human")
NurseNancyVars.usePrefix = false

pickFirst()
line = NurseNancy.NurseNancy.speakMassRess()
assert_true(type(line) == "string" and #line > 0, "speakMassRess returns a non-empty string")
assert_no_template(line, "speakMassRess first line no template leaks")

NurseNancyVars.usePrefix = true
line = NurseNancy.NurseNancy.speakMassRess()
assert_true(line:find("%[Mass ressing%]") ~= nil, "speakMassRess prefix applied when usePrefix=true")
NurseNancyVars.usePrefix = false

-- Priest extra lines; pickLast should hit one.
pickLast()
line = NurseNancy.NurseNancy.speakMassRess()
assert_no_template(line, "speakMassRess Priest last line no template leaks")
assert_true(line:find("afterlife") ~= nil or line:find("seminary") ~= nil
  or line:find("second chance") ~= nil or line:find("thank%-you") ~= nil,
  "speakMassRess Priest: last line is Priest-specific")

-- Paladin extra lines.
setPlayer("Pallie", "male", "Paladin", "Human")
pickLast()
line = NurseNancy.NurseNancy.speakMassRess()
assert_no_template(line, "speakMassRess Paladin last line no template leaks")
assert_true(line:find("Light") ~= nil or line:find("owe me one") ~= nil
  or line:find("champions") ~= nil or line:find("fancy") ~= nil,
  "speakMassRess Paladin: last line is Paladin-specific")

-- Christmas mass ress holiday.
setPlayer("Holyroller", "female", "Priest", "Human")
setDate(12, 26)
pickLast()
line = NurseNancy.NurseNancy.speakMassRess()
assert_no_template(line, "speakMassRess Christmas last line no template leaks")
assert_true(line:find("Christmas") ~= nil or line:find("Santa") ~= nil
  or line:find("dinner") ~= nil,
  "speakMassRess Christmas: last line is Christmas-specific")
setDate(6, 15)

report("nursenary")
