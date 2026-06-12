local dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
dofile(dir .. "stubs.lua")
dofile(dir .. "../../public/Src/Helpers.lua")
dofile(dir .. "../../public/Src/SpellIds.lua")

-- isSingleRess: known spell IDs
assert_true( NurseNancy.SpellIds.isSingleRess(2006),   "isSingleRess Priest Resurrection")
assert_true( NurseNancy.SpellIds.isSingleRess(2008),   "isSingleRess Shaman Ancestral Spirit")
assert_true( NurseNancy.SpellIds.isSingleRess(7328),   "isSingleRess Paladin Redemption")
assert_true( NurseNancy.SpellIds.isSingleRess(50769),  "isSingleRess Druid Revive")
assert_true( NurseNancy.SpellIds.isSingleRess(115178), "isSingleRess Monk Resuscitate")
assert_true( NurseNancy.SpellIds.isSingleRess(8342),   "isSingleRess Goblin Jumper Cables")
assert_true( NurseNancy.SpellIds.isSingleRess(22999),  "isSingleRess Goblin Jumper Cables XL")
assert_true( NurseNancy.SpellIds.isSingleRess(54732),  "isSingleRess Gnomish Army Knife")
assert_true( NurseNancy.SpellIds.isSingleRess(361227), "isSingleRess Evoker Return")
assert_false(NurseNancy.SpellIds.isSingleRess(20484),  "isSingleRess not Druid Rebirth (combat)")
assert_false(NurseNancy.SpellIds.isSingleRess(0),      "isSingleRess unknown ID")

-- isCombatRess: known spell IDs
assert_true( NurseNancy.SpellIds.isCombatRess(20484),  "isCombatRess Druid Rebirth")
assert_true( NurseNancy.SpellIds.isCombatRess(61999),  "isCombatRess DK Raise Ally")
assert_true( NurseNancy.SpellIds.isCombatRess(159931), "isCombatRess Hunter Gift of Chi-Ji")
assert_true( NurseNancy.SpellIds.isCombatRess(20707),  "isCombatRess Warlock Soulstone")
assert_true( NurseNancy.SpellIds.isCombatRess(391054), "isCombatRess Paladin Intercession")
assert_true( NurseNancy.SpellIds.isCombatRess(384902), "isCombatRess Engineer Jumper Cables #1")
assert_false(NurseNancy.SpellIds.isCombatRess(2006),   "isCombatRess not Priest Resurrection")
assert_false(NurseNancy.SpellIds.isCombatRess(0),      "isCombatRess unknown ID")

-- isSelfRess: known spell IDs
assert_true( NurseNancy.SpellIds.isSelfRess(20608), "isSelfRess Shaman Reincarnation")
assert_true( NurseNancy.SpellIds.isSelfRess(23701), "isSelfRess Darkmoon Card Twisting Nether")
assert_false(NurseNancy.SpellIds.isSelfRess(20484), "isSelfRess not combat ress")
assert_false(NurseNancy.SpellIds.isSelfRess(0),     "isSelfRess unknown ID")

-- isMassRess: known spell IDs
assert_true( NurseNancy.SpellIds.isMassRess(212048), "isMassRess Shaman Ancestral Vision")
assert_true( NurseNancy.SpellIds.isMassRess(212036), "isMassRess Priest Mass Resurrection")
assert_true( NurseNancy.SpellIds.isMassRess(212056), "isMassRess Paladin Absolution")
assert_true( NurseNancy.SpellIds.isMassRess(212051), "isMassRess Monk Reawaken")
assert_true( NurseNancy.SpellIds.isMassRess(212040), "isMassRess Druid Revitalize")
assert_true( NurseNancy.SpellIds.isMassRess(361178), "isMassRess Evoker Mass Return")
assert_false(NurseNancy.SpellIds.isMassRess(2006),   "isMassRess not single ress")
assert_false(NurseNancy.SpellIds.isMassRess(0),      "isMassRess unknown ID")

-- isBigHasteCast: returns the spell family name or false
assert_equal(NurseNancy.SpellIds.isBigHasteCast(32182),  "Heroism",          "isBigHasteCast Heroism")
assert_equal(NurseNancy.SpellIds.isBigHasteCast(65983),  "Heroism",          "isBigHasteCast Heroism variant")
assert_equal(NurseNancy.SpellIds.isBigHasteCast(2825),   "Bloodlust",        "isBigHasteCast Bloodlust")
assert_equal(NurseNancy.SpellIds.isBigHasteCast(80353),  "Time Warp",        "isBigHasteCast Time Warp")
assert_equal(NurseNancy.SpellIds.isBigHasteCast(90355),  "Ancient Hysteria", "isBigHasteCast Ancient Hysteria")
assert_equal(NurseNancy.SpellIds.isBigHasteCast(309658), "Drums",            "isBigHasteCast Drums of Ferocity")
assert_equal(NurseNancy.SpellIds.isBigHasteCast(381301), "Drums",            "isBigHasteCast Drums of Feral Hide")
assert_false(NurseNancy.SpellIds.isBigHasteCast(9999),   "isBigHasteCast unknown returns false")

-- Mutually exclusive: a single-ress spell is not a mass-ress and vice versa
assert_false(NurseNancy.SpellIds.isMassRess(2006),   "cross-check single vs mass")
assert_false(NurseNancy.SpellIds.isSingleRess(212036),"cross-check mass vs single")
assert_false(NurseNancy.SpellIds.isSelfRess(20484),  "cross-check combat vs self")

report("spellids")
