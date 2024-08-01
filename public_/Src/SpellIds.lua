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
        159931, -- Hunter's Gift of Chi-ji.
        20707,  -- Warlock's soul stone.
        391054, -- Paladin's Intercession.
        348477, -- Engineer's Disposable Spectrophasic Reanimator (older version).
        345130, -- Engineer's Disposable Spectrophasic Reanimator.
        265116, -- Engineer's Unstable Temporal Time Shifter.
        184308, -- Engineer's Disposable Spectrophasic Reanimator.
        385403, -- Engineer's Arclight Vital Correctors.
        384902, -- Engineer's Convincingly Realistic Jumper Cables #1
        384903, -- Engineer's Convincingly Realistic Jumper Cables #2
        384893, -- Engineer's Convincingly Realistic Jumper Cables #3
        384895, -- Engineer's Convincingly Realistic Jumper Cables #4
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

function NurseNancy.SpellIds.isSelfRess(spellId)
    local spellIds = {
        20608, -- Shaman's Reincarnation
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
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Shaman, Alliance heroism
function NurseNancy.SpellIds.isHeroism(spellId)
    local spellIds = {
        32182,
        65983,
        78151,
        290582,
        204362,
        32182,
        390386, -- evoker
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Shaman, Horde bloodlust
function NurseNancy.SpellIds.isBloodlust(spellId)
    local spellIds = {
        2825,
        71975,
        204361,
        37067,
        16170,
        164298,
        6742,
        390386, -- evoker
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Hunter, Ancient Hysteria
function NurseNancy.SpellIds.isAncientHysteria(spellId)
    local spellIds = {
        90355,
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Mage, Time Warp
function NurseNancy.SpellIds.isTimeWarp(spellId)
    local spellIds = {
        80353,
        145534,
        287925,
        189359,
        227665,
        350249,
        244645,
        173106,
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Drums of ...
function NurseNancy.SpellIds.isDrums(spellId)
    local spellIds = {
        309658, -- ferocity
        178207, -- fury
        146555, -- rage
        35475,  -- war
        230935, -- mountain,
        381301, -- feral hide
    }

    if NurseNancy.Helpers.tableContainsValue(spellIds, spellId) then
        return true
    end

    return false
end

-- Is drums, heroism, bloodlust, timework or ancient hysteria...
function NurseNancy.SpellIds.isBigHasteCast(spellId)
    if (NurseNancy.SpellIds.isDrums(spellId)) then
        return 'Drums'
    end

    if (NurseNancy.SpellIds.isTimeWarp(spellId)) then
        return 'Time Warp'
    end

    if (NurseNancy.SpellIds.isAncientHysteria(spellId)) then
        return 'Ancient Hysteria'
    end

    if (NurseNancy.SpellIds.isBloodlust(spellId)) then
        return 'Bloodlust'
    end

    if (NurseNancy.SpellIds.isHeroism(spellId)) then
        return 'Heroism'
    end

    return false
end
