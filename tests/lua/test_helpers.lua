local dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
dofile(dir .. "stubs.lua")
dofile(dir .. "../../public/Src/Helpers.lua")

-- parseText
assert_equal(NurseNancy.Helpers.parseText("Hello ${name}!", { name = "World" }), "Hello World!", "parseText basic substitution")
assert_equal(NurseNancy.Helpers.parseText("No vars", {}), "No vars", "parseText no variables")
assert_equal(NurseNancy.Helpers.parseText("${a} and ${b}", { a = "foo", b = "bar" }), "foo and bar", "parseText multiple vars")
assert_equal(NurseNancy.Helpers.parseText("${missing}", {}), "${missing}", "parseText missing key left as-is")
assert_equal(NurseNancy.Helpers.parseText("", {}), "", "parseText empty string")

-- mergeTable
local t1 = { 10, 20, 30 }
local t2 = { 40, 50 }
local result = NurseNancy.Helpers.mergeTable(t1, t2)
assert_equal(result, t1, "mergeTable returns first table")
assert_equal(#t1, 5, "mergeTable length after merge")
assert_equal(t1[4], 40, "mergeTable first appended element")
assert_equal(t1[5], 50, "mergeTable second appended element")
assert_equal(#t1, 5, "mergeTable original elements unchanged")

local empty = {}
NurseNancy.Helpers.mergeTable(empty, { 1, 2 })
assert_equal(#empty, 2, "mergeTable into empty table")

-- GetHimHer
assert_equal(NurseNancy.Helpers.GetHimHer("male"),   "Him", "GetHimHer male")
assert_equal(NurseNancy.Helpers.GetHimHer("female"), "Her", "GetHimHer female")
assert_equal(NurseNancy.Helpers.GetHimHer("other"),  "Her", "GetHimHer default is Her")

-- GetHeShe
assert_equal(NurseNancy.Helpers.GetHeShe("male"),   "he",  "GetHeShe male")
assert_equal(NurseNancy.Helpers.GetHeShe("female"), "she", "GetHeShe female")

-- GetHisHer
assert_equal(NurseNancy.Helpers.GetHisHer("male"),   "His", "GetHisHer male")
assert_equal(NurseNancy.Helpers.GetHisHer("female"), "Her", "GetHisHer female")

-- GetGuyGirl
assert_equal(NurseNancy.Helpers.GetGuyGirl("male"),   "guy",  "GetGuyGirl male")
assert_equal(NurseNancy.Helpers.GetGuyGirl("female"), "girl", "GetGuyGirl female")

-- GetManWoman
assert_equal(NurseNancy.Helpers.GetManWoman("male"),   "man",   "GetManWoman male")
assert_equal(NurseNancy.Helpers.GetManWoman("female"), "woman", "GetManWoman female")

-- GetSirMam
assert_equal(NurseNancy.Helpers.GetSirMam("male"),   "sir",  "GetSirMam male")
assert_equal(NurseNancy.Helpers.GetSirMam("female"), "ma'm", "GetSirMam female")

-- GetPoppaMomma
assert_equal(NurseNancy.Helpers.GetPoppaMomma("male"),   "poppa", "GetPoppaMomma male")
assert_equal(NurseNancy.Helpers.GetPoppaMomma("female"), "momma", "GetPoppaMomma female")

-- oppositeBfGf
assert_equal(NurseNancy.Helpers.oppositeBfGf("male"),   "girlfriend", "oppositeBfGf male")
assert_equal(NurseNancy.Helpers.oppositeBfGf("female"), "boyfriend",  "oppositeBfGf female")

-- tableContainsValue
assert_true( NurseNancy.Helpers.tableContainsValue({ 1, 2, 3 }, 2),   "tableContainsValue found number")
assert_false(NurseNancy.Helpers.tableContainsValue({ 1, 2, 3 }, 4),   "tableContainsValue absent number")
assert_false(NurseNancy.Helpers.tableContainsValue({}, 1),            "tableContainsValue empty table")
assert_true( NurseNancy.Helpers.tableContainsValue({ "a", "b" }, "a"),"tableContainsValue found string")
assert_false(NurseNancy.Helpers.tableContainsValue({ "a", "b" }, "c"),"tableContainsValue absent string")

report("helpers")
