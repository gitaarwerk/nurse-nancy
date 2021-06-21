NurseNancy = {}
NurseNancy.Helpers = {}

function NurseNancy.Helpers.parseText(s, tab)
  return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end


function NurseNancy.Helpers.tableContainsValue(table, val)
    for index, value in ipairs(table) do
        if value == val then
            return true
        end
    end

    return false
end


function NurseNancy.Helpers.parseText(s, tab)
    return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

function NurseNancy.Helpers.mergeTable(t1, t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end
  
  
function NurseNancy.Helpers.GetHisHer(gender)
    if (gender == "male") then
        return "His"
    end

    return "Her"
end


function NurseNancy.Helpers.GetHeShe(gender)
    if (gender == "male") then
        return "he"
    end

    return "she"
end

function NurseNancy.Helpers.GetSirMam(gender)
    if (gender == "male") then
        return "sir"
    end

    return "ma'm"
end

function NurseNancy.Helpers.GetGuyGirl(gender)
    if (gender == "male") then
        return "guy"
    end

    return "girl"
end

function NurseNancy.Helpers.GetManWoman(gender)
    if (gender == "male") then
        return "man"
    end

    return "woman"
end

function NurseNancy.Helpers.GetPoppaMomma(gender)
    if (gender == "male") then
        return "poppa"
    end

    return "momma"
end


function getCharacterinfo(target)
    local genderTable = { "neuter or unknown", "male", "female" };
    local playerClass, englishClass, classIndex = UnitClass(target);
    local name, upName, level = UnitName(target)
    local unitLevel = UnitLevel(target)
    local gender = genderTable[UnitSex(target)]
    local race, raceEn = UnitRace(target);

    return name, gender, playerClass, race, unitLevel
end


function NurseNancy.Helpers.GetTargetInformation(uid)
    return getCharacterinfo(uid)
end


function NurseNancy.Helpers.GetPlayerInformation()
    return getCharacterinfo("player")
end
