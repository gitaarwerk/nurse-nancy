NurseNancy = {}
NurseNancy.Init = {}

function NurseNancy.Init.InitVars()
    NurseNancy.Init.Frame = CreateFrame("Frame")
    NurseNancy.Init.Frame:RegisterEvent("ADDON_LOADED")
    NurseNancy.Init.Frame:SetScript("OnEvent", function (self, event, ...)
        if (event == "ADDON_LOADED" and ... == "NurseNancy") then
            -- set default vars
            if (NurseNancyVars == nil) then
                NurseNancyVars = {}
                NurseNancyVars.channel = "SAY"
                NurseNancyVars.isOn = true
                NurseNancyVars.usePrefix = true
            end
        end
    end)
end

function NurseNancy.Init.Commands(msg)
    -- pattern matching that skips leading whitespace and whitespace between cmd and args
    -- any whitespace at end of args is retained
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

    if cmd == "off" then
        NurseNancyVars.isOn = false
    elseif cmd == "on" then
        NurseNancyVars.isOn = true
    elseif cmd == "prefix" then
        NurseNancyVars.usePrefix = true
    elseif cmd == "noprefix" then
        NurseNancyVars.usePrefix = false
    else
        -- If not handled above, display some sort of help message
        print("Nurse Nancy will announce who you are ressing, soulstoning, etc.");
        print("The slash commands are /nursenancy or /nn");
        print(" ");
        print("To put the addon on or off, use:");
        print("Commands: /nn on or /nn off");
        print(" ");
        print("To put the prefix on or off, use:");
        print("Commands: /nn prefix or /nn noprefix");
    end
end

SlashCmdList["COMMANDS"] = NurseNancy.Init.Commands

SLASH_COMMANDS1	= "/nursenancy"
SLASH_COMMANDS2	= "/nn"

print("NurseNancy loaded. To check options; type: /nn or /nursenancy")

NurseNancy.Init.InitVars()