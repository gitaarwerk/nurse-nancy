NurseNancy = {}
NurseNancyMessageColor = "\124cffff4f98";

local function dump(o)
    if type(o) == 'table' then
        local s = '{ ';
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. ',';
        end
        return s .. '} ';
    else
        return tostring(o);
    end
end

function debugPrint(feature, message)
    if (not(NurseNancyVars)) then
        return;
    end
    
    if (NurseNancyVars.debugMode == true) then
        local featName = feature or "feature_not_set";
        local prefix = "[NURSE_NANCY_DEBUG (" .. feature .. ")] ";
        print(prefix .. message);
    end
  end

function NurseNancy_SetScale(scale)
    local newValue = math.floor(scale*100)/100
    NurseNancy_Frame:SetScale(newValue);
    NurseNancyVars.interfaceScale = newValue;
end


local function onClickyPrint(text, value)
    NurseNancyVars.bombsGoBurr_channel = value
    NurseNancyVars.bombsGoBurr_channel_name = text
  
    -- UIDropDownMenu_SetSelectedValue(BombsGoBurrDropdown, value)
    -- UIDropDownMenu_SetText(BombsGoBurrDropdown, text)
  end


function BombsGoBurrDropdown_OnLoad(self)
    -- UIDropDownMenu_SetSelectedValue(BombsGoBurrDropdown, NurseNancyVars.bombsGoBurr_channel)
    -- UIDropDownMenu_SetText(BombsGoBurrDropdown, NurseNancyVars.bombsGoBurr_channel_name)
    
    -- Add the above information to the options menu as a button.
    UIDropDownMenu_AddButton({
      text = "None",
      value = 0,
      func = function () onClickyPrint("None", 0); end;
    });
    UIDropDownMenu_AddButton({
      text = "Raid",
      value = 1,
      func = function() onClickyPrint("Raid", 1); end;
    });
    UIDropDownMenu_AddButton({
      text = "Party",
      value = 2,
      func = function() onClickyPrint("Party", 2); end;
    });
    UIDropDownMenu_AddButton({
      text = "Raid and Party",
      value = 3,
      func = function() onClickyPrint("Raid and party", 3); end;
    });
end

function NurseNancy_NurseNancyOn()
    NurseNancyVars.nurseNancyIsOn = true
end

function NurseNancy_NurseNancyOff()
    NurseNancyVars.nurseNancyIsOn = false
end

function NurseNancy_DebugOn()
    print('NurseNancy: Debug mode is now ON.')
    NurseNancyVars.debugMode = true
end

function NurseNancy_DebugOff()
    print('NurseNancy: Debug mode is now OFF.')
    NurseNancyVars.debugMode = false
end


local function NurseNancy_Init(msg)
    -- pattern matching that skips leading whitespace and whitespace between cmd and args
    -- any whitespace at end of args is retained
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

    if cmd == "reset" then
        NurseNancyVars = nil;
        if (NurseNancyVars == nil) then
            print('Nurse Nancy settings have been reset. You should now type /reload.')
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
        print("To show or hide the button ;interface, use one of these commands:");
        print("Syntax: /eyelf show");
        print("Syntax: /eyelf hide");
        print("", "And to reset the vars");
        print("Syntax: /eyelf reset");
    end
end

SlashCmdList["NNANCY"] = NurseNancy_Init;

SLASH_NNANCY1	= "/nn"
SLASH_NNANCY2	= "/nursenancy"
