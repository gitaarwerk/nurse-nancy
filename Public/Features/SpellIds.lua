-- init
NurseNancy.SpellIds = {}

function NurseNancy.SpellIds.isSingleRess(spellId)
    local singleTargetSpells = {
            2006, -- Priest's Resurrection
            2008, -- Shaman's Ancesttral spirit
            7328, -- Paladin's Redemption
            50769, --Druid's revive
            115178, --Monk's Resuscitate
            8342, --Goblin Jumper cables
            22999, --Goblin Jumper cables XL
            54732, --Gnomish army knife
    }

    if NurseNancy.Helpers.tableContainsValue(singleTargetSpells, spellId) then
        return true
    end
    return false
end


function NurseNancy.SpellIds.isCombatRess(spellId)
    local combatRessSpells = {
        20484, -- Druid's Rebirth
        61999, -- Death knight's Raise ally
        159931, -- Hunter's Gift of Chi-ji
        20707, -- Warlock's soul stone
        348477, -- Engineer's Disposable Spectrophasic Reanimator (older version)
        345130, -- Engineer's Disposable Spectrophasic Reanimator
    }
    
    if NurseNancy.Helpers.tableContainsValue(combatRessSpells, spellId) then
        return true
    end
    return false
end


function NurseNancy.SpellIds.isSelfRess(spellId)
    local selfRessSpells = {
        20608, -- Shaman's Reincarnation
        23701, -- Darkmoon card: Twisting Nether
    }

    if NurseNancy.Helpers.tableContainsValue(selfRessSpells, spellId) then
        return true
    end
    return false
end


function NurseNancy.SpellIds.isMassRess(spellId)
    local massRessSpels = {
        212048, -- Shaman's Ancestral Vision
        212036, -- Priest's Mass Resurrection
        212056, -- Paladin's Absolution
        212051, -- Monk's Reawaken
        212040, -- Druid's Revitalize
    }

    if NurseNancy.Helpers.tableContainsValue(massRessSpels, spellId) then
        return true
    end
    return false
end