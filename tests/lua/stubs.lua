-- WoW global stubs and minimal test framework for Nurse Nancy unit tests.

-- Namespace
NurseNancy = {}
NurseNancyVars = {
  usePrefix = false,
  debugMode = false,
  nurseNancyIsOn = true,
  selfRess_channel = 3,
  selfRess_instance = true,
  massRess_channel = 3,
  massRess_instance = true,
  singleRess_channel = 3,
  singleRess_instance = true,
  combatRess_channel = 3,
  combatRess_instance = true,
}

-- Unit info stubs (can be overridden per-test)
function UnitClass()  return "Mage",    "MAGE",    8  end
function UnitName()   return "Testchar", nil,      60 end
function UnitLevel()  return 60                       end
function UnitSex()    return 2                        end  -- 2 = male
function UnitRace()   return "Human",   "Human"       end

function GetPlayerInfoByGUID()
  return "Warrior", "WARRIOR", "Human", "Human", 2, "Targetchar", nil
end
function UnitGUID()           return "Player-1234-ABCDEF" end

-- Zone / instance stubs
function GetZoneText()     return "Stormwind" end
function GetRealZoneText() return "Stormwind" end
function GetInstanceInfo()
  return "Stormwind", "party", 1, "Normal", 5, 0, false, 1234, 5, 42
end
function IsInRaid() return false end

-- Frame / chat stubs
function CreateFrame()
  return {
    RegisterEvent     = function() end,
    RegisterUnitEvent = function() end,
    SetScript         = function() end,
  }
end
function SendChatMessage()  end
function debugPrint()       end

C_DateAndTime = {
  GetCalendarTimeFromEpoch = function() return { month = 6, day = 15 } end
}
C_ChatInfo = { SendChatMessage = function() end }

-- Random stub – tests override this to select a specific index
function fastrandom(min, max) return min end

-- ── Test framework ────────────────────────────────────────────────────────────

local _run, _fail = 0, 0

function assert_equal(actual, expected, label)
  _run = _run + 1
  if actual ~= expected then
    _fail = _fail + 1
    print(string.format("FAIL [%s]: expected %q, got %q", label, tostring(expected), tostring(actual)))
  end
end

function assert_true(val, label)
  _run = _run + 1
  if not val then
    _fail = _fail + 1
    print(string.format("FAIL [%s]: expected true, got %s", label, tostring(val)))
  end
end

function assert_false(val, label)
  _run = _run + 1
  if val then
    _fail = _fail + 1
    print(string.format("FAIL [%s]: expected false, got %s", label, tostring(val)))
  end
end

-- Asserts that no ${...} placeholder survives in the output string.
function assert_no_template(str, label)
  _run = _run + 1
  local leak = str and str:match("%${%w+}")
  if leak then
    _fail = _fail + 1
    print(string.format("FAIL [%s]: unresolved template %q in: %s", label, leak, str))
  end
end

function report(suite)
  local passed = _run - _fail
  if _fail == 0 then
    print(string.format("OK  %s — %d/%d tests passed", suite, passed, _run))
    os.exit(0)
  else
    print(string.format("FAIL %s — %d/%d tests failed", suite, _fail, _run))
    os.exit(1)
  end
end
