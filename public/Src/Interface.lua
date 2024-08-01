NurseNancy = {}
NurseNancyMessageColor = "\124cffff4f98";

local function dump(o)
    if type(o) == 'table' then
        local s = '{ ';
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ',';
        end
        return s .. '} ';
    else
        return tostring(o);
    end
end

function debugPrint(feature, message)
    if (not (NurseNancyVars)) then
        return;
    end

    if (NurseNancyVars.debugMode == true) then
        local featName = feature or "feature_not_set";
        local prefix = "[NURSE_NANCY_DEBUG (" .. feature .. ")] ";
        print(prefix .. message);
    end
end

function NurseNancy_ConfigScreen_SetChannel(spell, value)
    local channel = 'off'
    local flooredValue = floor(value / 1) * 1

    if (flooredValue == 0) then
        channel = 'off';
    elseif (flooredValue == 1) then
        channel = 'party';
    elseif (flooredValue == 2) then
        channel = 'raid';
    elseif (flooredValue == 3) then
        channel = 'party and raid';
    end


    if (spell == "singleRess") then
        NurseNancyVars.singleRess_channel = flooredValue
        NurseNancyVars.singleRess_text = channel
        _G[NurseNancy_ConfigScreen_SingleRess_Channel:GetName() .. "Text"]:SetText(NurseNancyVars.singleRess_text)
    end

    if (spell == "massRess") then
        NurseNancyVars.massRess_channel = flooredValue
        NurseNancyVars.massRess_text = channel
        _G[NurseNancy_ConfigScreen_MassRess_Channel:GetName() .. "Text"]:SetText(NurseNancyVars.massRess_text)
    end

    if (spell == "combatRess") then
        NurseNancyVars.combatRess_channel = flooredValue
        NurseNancyVars.combatRess_text = channel
        _G[NurseNancy_ConfigScreen_CombatRess_Channel:GetName() .. "Text"]:SetText(NurseNancyVars.combatRess_text)
    end

    if (spell == "selfRess") then
        NurseNancyVars.selfRess_channel = flooredValue
        NurseNancyVars.selfRess_text = channel
        _G[NurseNancy_ConfigScreen_SelfRess_Channel:GetName() .. "Text"]:SetText(NurseNancyVars.selfRess_text)
    end
end

function NurseNancy_NurseNancyOn()
    print('\124cffffcee2NurseNancy is now ON.')
    NurseNancyVars.nurseNancyIsOn = true
    NurseNancy_ConfigScreen_NurseNancy:SetChecked(true)
end

function NurseNancy_NurseNancyOff()
    print('\124cffffcee2NurseNancy is now OFF.')
    NurseNancyVars.nurseNancyIsOn = false;
    NurseNancy_ConfigScreen_NurseNancy:SetChecked(false)
end

function NurseNancy_DebugOn()
    print('\124cffffcee2NurseNancy: Debug mode is now ON.')
    NurseNancyVars.debugMode = true
end

function NurseNancy_DebugOff()
    print('\124cffffcee2NurseNancy: Debug mode is now OFF.')
    NurseNancyVars.debugMode = false
end

function NurseNancy_SetSingleRessInstance(value)
    NurseNancyVars.singleRess_instance = value;
end

function NurseNancy_SetMassRessInstance(value)
    NurseNancyVars.massRess_instance = value;
end

function NurseNancy_SetCombatRessInstance(value)
    NurseNancyVars.combatRess_instance = value;
end

function NurseNancy_SetSelfRessInstance(value)
    NurseNancyVars.selfRess_instance = value;
end

local function NurseNancy_Init(msg)
    -- pattern matching that skips leading whitespace and whitespace between cmd and args
    -- any whitespace at end of args is retained
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

    if cmd == "reset" then
        NurseNancyVars = nil;
        if (NurseNancyVars == nil) then
            print('\124cffffcee2Nurse Nancy settings have been reset. You should now type /reload.')
        end
    elseif cmd == "on" then
        NurseNancy_NurseNancyOn()
    elseif cmd == "off" then
        NurseNancy_NurseNancyOff()
    elseif cmd == "toggle" then
        if (NurseNancyVars and NurseNancyVars.nurseNancyIsOn) then
            NurseNancy_NurseNancyOff();
            return;
        end

        if (not (NurseNancyVars) or NurseNancyVars and NurseNancyVars.nurseNancyIsOn == false) then
            NurseNancy_NurseNancyOn();
        end
    elseif cmd == "debug" then
        if (NurseNancyVars and NurseNancyVars.debugMode) then
            NurseNancy_DebugOff();
            return;
        end

        if (not (NurseNancyVars) or NurseNancyVars and NurseNancyVars.debugMode == false) then
            NurseNancy_DebugOn();
        end
        local dumpedVars = dump(NurseNancyVars);
        print("Dumped Nurse Nancy Vars: " .. dumpedVars);
    else
        NurseNancy_ConfigScreen:Show();
        -- If not handled above, display some sort of help message
        print("/nn or /nursenancy for following commands");
        print("/nn on - turns on Nurse Nancy");
        print("/nn off - turns off Nurse Nancy");
        print("/nn toggle - toggles Nurse Nancy on and off");
        print("And to reset the vars:");
        print("Syntax: /nn reset");
    end
end

SlashCmdList["NNANCY"] = NurseNancy_Init;

SLASH_NNANCY1 = "/nn"
SLASH_NNANCY2 = "/nursenancy"
