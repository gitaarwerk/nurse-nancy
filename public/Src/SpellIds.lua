NurseNancy.SpellIds = {}

function NurseNancy.SpellIds.isSingleRess(spellId)
    local spellIds = {
        2006,   -- Priest's Resurrection
        2008,   -- Shaman's Ancesttral spirit
        7328,   -- Paladin's Redemption
        50769,  --Druid's revive
        115178, --Monk's Resuscitate
        8342,   --Goblin Jumper cables
        22999,  --Goblin Jumper cables XL
        54732,  --Gnomish army knife
        361227, -- Evoker's return

        -- Classic flavors use one spell id per rank; retail never fires these.
        2010, 10880, 10881, 20770, 25435, 48171,  -- Priest's Resurrection ranks 2-7
        20609, 20610, 20776, 20777, 25590, 49277, -- Shaman's Ancestral Spirit ranks 2-7
        10322, 10324, 20772, 20773, 48949, 48950, -- Paladin's Redemption ranks 2-7
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

function NurseNancy.SpellIds.isCombatRess(spellId)
    local spellIds = {
        20484,  -- Druid's Rebirth.
        61999,  -- Death knight's Raise ally.
        159931, -- Hunter's Gift of Chi-ji (removed in retail 8.0, kept for older clients).
        267922, -- Hunter's Eternal Guardian (Stone Hound / quilen pet battle ress, cast by the pet).
        20707,  -- Warlock's soul stone.
        391054, -- Paladin's Intercession.
        1229923, -- Engineer's Emergency Soul Link (Midnight).
        1247510, -- Engineer's Emergency Soul Link (Midnight, live variant).
        1259646, -- Engineer's Emergency Soul Link (Midnight 12.0.5 variant).
        348477, -- Engineer's Disposable Spectrophasic Reanimator (older version).
        345130, -- Engineer's Disposable Spectrophasic Reanimator.
        265116, -- Engineer's Unstable Temporal Time Shifter.
        184308, -- Engineer's Disposable Spectrophasic Reanimator.
        385403, -- Engineer's Arclight Vital Correctors.
        384902, -- Engineer's Convincingly Realistic Jumper Cables #1
        384903, -- Engineer's Convincingly Realistic Jumper Cables #2
        384893, -- Engineer's Convincingly Realistic Jumper Cables #3
        384895, -- Engineer's Convincingly Realistic Jumper Cables #4

        -- Classic flavors use one spell id per rank; retail never fires these.
        20739, 20742, 20747, 20748, 26994, 48477, -- Druid's Rebirth ranks 2-7
        20762, 20763, 20764, 20765, 27239, 47883, -- Warlock's Soulstone Resurrection ranks 2-7
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

function NurseNancy.SpellIds.isSelfRess(spellId)
    local spellIds = {
        20608, -- Shaman's Reincarnation (passive)
        21169, -- Reincarnation (the actual self-ress cast)
        3026,  -- Use Soulstone (Warlock soulstone self-ress)
        23701, -- Darkmoon card: Twisting Nether
    }

  if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
    return true
  end

  return false
end

function NurseNancy.SpellIds.isMassRess(spellId)
    local spellIds = {
        212048, -- Shaman's Ancestral Vision
        212036, -- Priest's Mass Resurrection
        212056, -- Paladin's Absolution
        212051, -- Monk's Reawaken
        212040, -- Druid's Revitalize
        361178, -- Evoker's Mass Return
        83968,  -- Mass Resurrection (Cata/MoP guild perk, for classic flavors)
        1229924, -- M3DDY (Midnight engineering mass-ress robot, usable by anyone)
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Shaman, Alliance heroism
function NurseNancy.SpellIds.isHeroism(spellId)
  local spellIds = { 32182, 65983, 78151, 290582, 204362, 32182, 390386 } -- evoker

  if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
    return true
  end

  return false
end

-- Shaman, Horde bloodlust
function NurseNancy.SpellIds.isBloodlust(spellId)
  local spellIds = { 2825, 71975, 204361, 37067, 16170, 164298, 6742, 390386 } -- evoker

  if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
    return true
  end

  return false
end

-- Hunter, Ancient Hysteria
function NurseNancy.SpellIds.isAncientHysteria(spellId)
  local spellIds = { 90355 }

  if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
    return true
  end

  return false
end

-- Mage, Time Warp
function NurseNancy.SpellIds.isTimeWarp(spellId)
  local spellIds = { 80353, 145534, 287925, 189359, 227665, 350249, 244645, 173106 }

  if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
    return true
  end

  return false
end

-- Drums of ...
function NurseNancy.SpellIds.isDrums(spellId)
  local spellIds = { 309658, 178207, 146555, 35475, 230935, 381301 } -- ferocity -- fury -- rage -- war -- mountain, -- feral hide

  if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
    return true
  end

  return false
end

-- Is drums, heroism, bloodlust, timework or ancient hysteria...
function NurseNancy.SpellIds.isBigHasteCast(spellId)
  if NurseNancy.SpellIds.isDrums(spellId) then
    return "Drums"
  end

  if NurseNancy.SpellIds.isTimeWarp(spellId) then
    return "Time Warp"
  end

  if NurseNancy.SpellIds.isAncientHysteria(spellId) then
    return "Ancient Hysteria"
  end

  if NurseNancy.SpellIds.isBloodlust(spellId) then
    return "Bloodlust"
  end

  if NurseNancy.SpellIds.isHeroism(spellId) then
    return "Heroism"
  end

  return false
end
