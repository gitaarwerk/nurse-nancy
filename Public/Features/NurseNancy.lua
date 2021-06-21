-- init
NurseNancy.Ressurection = {}

function NurseNancy.Ressurection.speakSelfRess(spellId)
    local playerName, playerGender, playerClass, playerRace, playerLevel  = Ressurection.Helpers.GetPlayerInformation()
    
    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

    local playerSex = "girls"

    if (playerGender == "male") then
        oppositeSex = "guys"
    end
    
    local selfRessLines = {
        "${playerName} back allright!",
        "I'm back by popular demand.",
        "Hiiiiii, missed me?",
    }

    if (playerClass == "Shaman") then
        table.insert(selfRessLines, "Nobody believed in Reincarnation. Well, here's the proof!'")
    end
        
    pickedLine = selfRessLines[fastrandom(1, #selfRessLines)]

    return NurseNancy.Helpers.parseText(
        pickedLine, {
            playerName = playerName,
            playerGender = playerGender,
            playerClass = playerClass,
            playerRace = playerRace,
            playerLevel = playerLevel,
            playerManWoman = playerManWoman,
            playerGuyGirl = playerGuyGirl,
            targetName = targetName, 
            targetGender = targetGender, 
            targetClass = targetClass, 
            targetRace = targetRace, 
            targetLevel = targetLevel,
            oppositeSex = oppositeSex,
        }
    )
end

function NurseNancy.Ressurection.speakSingleRess(targetGUID, spellId)
    local playerName, playerGender, playerClass, playerRace, playerLevel  = Ressurection.Helpers.GetPlayerInformation()
    local targetName, targetGender, targetClass, targetRace, targetLevel  = Ressurection.Helpers.GetTargetInformation()
    
    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

    local playerSex = "girls"

    if (playerGender == "male") then
        oppositeSex = "guys"
    end
    
    local singleRessLines = {
        "Stop eating the floor, ${targetName}!",
        "You look so unflattering, my ${targetName}, here, have a ress.",
        "You are not my child, ${targetName}, but I will raise you.",
        "And ${targetName} said: 'it was just a flesh wound'.", 
        "Damnit, ${targetName}, I'm a ${playerClass} not a doctor.",
        "It just happens that ${targetName} here is only MOSTLY dead.",
        "Now rezzing ${targetNAme}. Your reputation with [Floor] has been increased by 100.",
        "Wake up! Wake up!, ${targetName}.",
        "Rezzing: ${targetName}, get back to work!",
        "Sorry to break your dream, ${targetNAme}, but the princess ain't in another castle!",
        "You know, ${targetName}, the floor doesn't contain any floor heating, so get up and work it, baby!",
        "This ${targetName} is always resting,... Get back in your body and do your job, ${targetClass}!",
        "${targetName} has failed at living. Please deposit 50g to try again.",
        "Rezzing ${targetName}. Please no one else do this, or we could end up with a split body each and that would be unfortunate.",
        "Currently interrupting %T's love affair with the floor in 3....2....1.",
        "Here lies ${targetName}, my autumn flower. A lot less attractive now that you're all corpsified and gross.",
        "By the feeling, ${targetName} is still warm, but as I am being watched right now, i’ll just ress you instead,… of other things i wanted to do",
        "${targetNAme} brought to life by Spirit Travels, Inc. Have you considered our Frequent Death program?",
        "It was just an ordinary gas cloud, ${targetName} said.",
        "${targetName}, by clicking 'Accept', you, the resurrectee, hereby consign your soul to the resurrecter, i.e., me.",
        "Giving ${targetName} a shot at another 10% durability loss, please stand by.",
        "Quit kissin' the floor, ${targetName}!",
        "Mourning period for ${targetName} concludes in 10...9...",
        "You have 10 seconds to finish going through ${targetName}'s pockets.",
        "Resurrecting ${targetName}. Side effects may include: drowsiness, hunger pangs, liquid dependence, sensitivity to heat, susceptibility to disease, and long-term degradation of strength, manual dexterity, vision, hearing, and cognitive faculties.",
        "Rezzing ${targetName}; /roll for blame.",
        "I hear cats have nine lives--how many does ${targetName} have left?",
        "Removing the 'Kill Me' sign from ${targetName}'s back, please stand by...",
        "Remember, ${targetName}, if you do not fear death, there is nothing you cannot achieve...unless you die.",
        "Renewing ${targetName}'s lease on life, just a moment.",
        "Reports of ${targetName}'s death have been greatly exaggerated.",
        "${targetName}'s death *probably* wasn't my fault.",
    }

    if (playerClass == "Shaman") then
        table.insert(singleRessLines, "Ressing ${targetName} goes like: 'oo ee oo aa aa, ting, tang, walla walla bing bang'")
    end

    if (targetClass == "Warlock" or targetClass == "Priest") then
        table.insert(singleRessLines, "No kittens are being sacrificed by resurrecting ${targetName}, well, at least, no more than five.")
        table.insert(singleRessLines, "I told you, MORE DOTS, ${targetName}! This is what happens. Now I will need to resurrect you again!")
    end

    if (targetClass == "Druid") then
        table.insert(singleRessLines, "hey ${targetName} stop growing roots there! I need you to RAWR!")
    end

        
    pickedLine = singleRessLines[fastrandom(1, #singleRessLines)]

    return NurseNancy.Helpers.parseText(
        pickedLine, {
            playerName = playerName,
            playerGender = playerGender,
            playerClass = playerClass,
            playerRace = playerRace,
            playerLevel = playerLevel,
            playerManWoman = playerManWoman,
            playerGuyGirl = playerGuyGirl,
            targetName = targetName, 
            targetGender = targetGender, 
            targetClass = targetClass, 
            targetRace = targetRace, 
            targetLevel = targetLevel,
            oppositeSex = oppositeSex,
        }
    )
end

function NurseNancy.Ressurection.speakCombatRess(targetGUID, spellId)
    local playerName, playerGender, playerClass, playerRace, playerLevel  = Ressurection.Helpers.GetPlayerInformation()
    local targetName, targetGender, targetClass, targetRace, targetLevel  = Ressurection.Helpers.GetTargetInformation()
    local zoneName = GetRealZoneText()

    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

    local playerSex = "girls"

    if (playerGender == "male") then
        oppositeSex = "guys"
    end
    
    local combatRessLines = {
        "Combat ress on ${targetName}.",
        "${targetName}, always deciding to enjoy the floor while fighting. Come on, ${playerManWoman}, accept the ress!",
        "${targetName}, stand up and walk!",
        "In Soviet ${zoneName}, life chooses ${targetName}",
        "${targetName}, please report to the land of the living. Your urgent assistance is required.",
    }
        
    if (playerGender == "female") then 
        table.insert(combatRessLines, "Arise my Champ... oh, I mean, you. Yes ${targetName}, there.")
    end 

    if (playerClass == "Death Knight") then
        table.insert(combatRessLines, "Raising hell in ${zoneName},...err, I mean raising ${targetName}")
        table.insert(combatRessLines, "Bringing the torment of undeath to ${targetName}: slower, weaker, and only slightly less dead.")
        table.insert(combatRessLines, "Raising ${targetName} into unlife for the glory of the Lich Ki--whoops.")
        table.insert(combatRessLines, "Here, ${targetName}, have a taste of what working for the Lich King is like.")
        table.insert(combatRessLines, "Animating ${targetNAme}'s body, shotguns at the ready!")
        table.insert(combatRessLines, "Don't worry, ${targetName}, you'll be all dead again soon.")
        table.insert(combatRessLines, "Look, ${targetName} I'm a soulless abomination, not a miracle worker!")
        table.insert(combatRessLines, "${targetName}, if any of your limbs fall off after this, it's completely your fault and has nothing to do with the influence of the Lich King.")
    end

    if (playerClass == "Druid") then
        table.insert(combatRessLines, "I coulda been a bear, y'know. Or a kitty. Maybe a tree. Even one of those...whaddayacallems...owlbears. But nooooo, I had ta rez ${targetName}. Not that I'm bitter or anything.")
        table.insert(combatRessLines, "Warm fuzzy naturey things for you, ${targetName}...now get UP!")
    end

    if (playerClass == "Warlock") then
        table.insert(combatRessLines, "Do not worry, ${targetName}, this soulstone - shouldn't - hurt a bit...")
        table.insert(combatRessLines, "According to my Failometer, ${targetName} has a high chance of dying in the next fifteen minutes.")
        table.insert(combatRessLines, "I'm just gonna borrow your sould for a bit, ${targetName}, I promise I'll give it back... when you're dead.")
        table.insert(combatRessLines, "One spare soul coming straight up for you, ${targetName}.")
        table.insert(combatRessLines, "Soulstone on ${targetName}. It's not that i think you're going to die, honstely ${targetName}.")
        table.insert(combatRessLines, "Soulstoning is a routine procedure. I totally don't think ${targetName} will die in the next 15 minutes.")
        table.insert(combatRessLines, "${targetName}, this soulstone is just my way of saying `I don't trust you.`")
        table.insert(combatRessLines, "Soulstoning ${targetName}. I promise to not devour your soul in the next 15 minutes, if you are a tank, a healer or a fellow Warlock. Maybe.")
        table.insert(combatRessLines, "${targetName}, I heard you love to get stoned, so I will stone you, so you will be stoned, while you are stoned. Or something.")
        table.insert(combatRessLines, "Stoning ${targetName}. Suicide is no longer an option for you.")
        table.insert(combatRessLines, "Stoning ${targetName}. If you hate my rock, feel free to go to your nearest Death Knight.")
        table.insert(combatRessLines, "Soulstoning ${targetName}. ARCHSURGEON'S WARNING: Soulstones contain puppy hearts, and are linked to ghoul fever in laboratory tests.")
        table.insert(combatRessLines, "Package for you, ${targetName}. Contents: One(1) soul.")
        table.insert(combatRessLines, "FYI, ${targetName}, using a soulstone removes any chance of getting into heaven.")
    end

    -- engineering's kit
    if (spellId == 8342 or spellId == 22999 or spellId == 54732) then
        table.insert(combatRessLines, "CLEAR!")
        table.insert(combatRessLines, "${targetName}, you might feel a slight jolt...")
        table.insert(combatRessLines, "I'd pray for a miracle, but then ${targetName} wouldn't need these things.")
        table.insert(combatRessLines, "${targetName}'s dead...what's the worst that could happen?")
        table.insert(combatRessLines, "Don't worry, ${targetName}, I'm an Undermine, Inc. Certified Cable Jumper!")
        table.insert(combatRessLines, "I saw this on House once. Piece of cake!")
        table.insert(combatRessLines, "Have you hugged your engineer today?")
        table.insert(combatRessLines, "I can rebuild ${targetName}, but there'll be a...slight chance of explosion.")
        table.insert(combatRessLines, "One order of fried ${targetName}, comin' right up!")
        table.insert(combatRessLines, "When the Light goes out, call in an engineer!")
        table.insert(combatRessLines, "Let's see...orange to nipple, black to ground...or was it the other way around?")
        table.insert(combatRessLines, "Zappy, zappy, ending ${targetName}'s nappy!")
        table.insert(combatRessLines, "Huh...never noticed this warning label. 'ARCHSURGEON'S WARNING: High dosages of electricity are hazardous to one's health. Use only if patient is already dead.' Well, ${targetName} certainly fits the bill.")
        table.insert(combatRessLines, "Finally, no more need to ask for ${targetName}'s permission to start experimentation!")
        table.insert(combatRessLines, "The clamps on these cables leave some nasty bruises, but I don't think ${targetName} would prefer the alternative")
        table.insert(combatRessLines, "Don't worry, ${targetName}, this is for SCIENCE!")
        table.insert(combatRessLines, "Five gold says ${targetName} enjoys these clamps.")
        table.insert(combatRessLines, "${targetName} has encountered a fatal error. Rebooting...")
    end 

        
    pickedLine = combatRessLines[fastrandom(1, #combatRessLines)]

    return NurseNancy.Helpers.parseText(
        pickedLine, {
            playerName = playerName,
            playerGender = playerGender,
            playerClass = playerClass,
            playerRace = playerRace,
            playerLevel = playerLevel,
            playerManWoman = playerManWoman,
            playerGuyGirl = playerGuyGirl,
            targetName = targetName, 
            targetGender = targetGender, 
            targetClass = targetClass, 
            targetRace = targetRace, 
            targetLevel = targetLevel,
            oppositeSex = oppositeSex,
            zoneName = zoneName
        }
    )
end

function NurseNancy.Ressurection.speakMassRess()
    local playerName, playerGender, playerClass, playerRace, playerLevel  = NurseNancy.Helpers.GetPlayerInformation()

    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

    local playerSex = "girls"

    if (playerGender == "male") then
        oppositeSex = "guys"
    end
    
    local pickedLine
  
    local massRessLines = {
        "Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo... that's the best ambulance impression I can do",
        "What is ${playerName} gonna do now, buddy? oh, well, I guess I should start getting you all up",
        "I have a morbid interest in all of your bodies…., but I want to tell y’all my problems too,.. hmm, what to do....fine, ill ress,.. again!",
        "Roses are red, your corpses are blue, I’m incredible bored, by all of you.",
        "Unfortunatly, you are all not revered with ${playerRace} ${playerGender} ${playerClass}s to be rezzed. Lucky for you, I just stole 5g from all. Ressing now...",
        "They say the Cataclysm changed everything, but apparently not,...I'm still scraping your corpse off the pavement.",
        "Up-up-up-up-up! Everyone UP!",
        "You get a repair bill! And YOU get a repair bill! And YOU get a repair bill!",
    }

    pickedLine = massRessLines[fastrandom(1, #massRessLines)]

    return NurseNancy.Helpers.parseText(
        pickedLine, {
            playerName = playerName,
            playerGender = playerGender,
            playerClass = playerClass,
            playerRace = playerRace,
            playerLevel = playerLevel,
            playerManWoman = playerManWoman,
            playerGuyGirl = playerGuyGirl,
            oppositeSex = oppositeSex,
        }
    )

end


function NurseNancy.Ressurection.Run()
    local line
    local groupChannel
    local outputChannel

    NurseNancy.Ressurection.Frame = CreateFrame("Frame")
    NurseNancy.Ressurection.Frame:RegisterEvent("UNIT_SPELLCAST_SENT")
    NurseNancy.Ressurection.Frame:RegisterEvent("UNIT_SPELLCAST_START")

    NurseNancy.Ressurection.Frame:SetScript("OnEvent", function (self, event, ...)
    groupChannel = IsInRaid() and "RAID" or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or "PARTY"
    isInParty = UnitInParty("player")

    
    if (not(NurseNancyVars.isOn == true and isInParty == true)) then 
        return
    end
    
        -- do single ress
        if (event == "UNIT_SPELLCAST_SENT") then 
            local targetType, target, spellGUID, spellId = ...
            
            local unitIdentificator = UnitGUID(target)
            local selfIdentifier = UnitGUID("player")
            local isInRaid = UnitInRaid(target)
            local isInParty = UnitInParty(target)


            local isCombatRess = NurseNancy.SpellIds.isCombatRess(spellID)
            local isSingleRess = NurseNancy.SpellIds.isSingleRess(spellId)
            local isSelfRess = NurseNancy.SpellIds.isSelfRess(spellId)

            if ((isInRaid or isInParty) and not(unitIdentificator == selfIdentifier)) then 
                if (isSingleRess) then
                    line = NurseNancy.Ressurection.speakSingleRess(unitIdentificator, spellId)
                    SendChatMessage(line, groupChannel, nil, index)
                elseif (isCombatRess) then
                    line = NurseNancy.Ressurection.speakCombatRess(targetGUID, spellId)
                    SendChatMessage(line, groupChannel, nil, index)
                elseif (isSelfRess) then
                    line = NurseNancy.Ressurection.isSelfRess(unitIdentificator, spellId)
                    SendChatMessage(line, groupChannel, nil, index)
                else 
                    return
                end                
            end
        end
        
        -- do mass ress
        if (event == "UNIT_SPELLCAST_START") then 
            local unitTarget, castGUID, spellID = ...
            
            local isMassRess = NurseNancy.SpellIds.isMassRess(spellID)
            if (isMassRess == true) then
                line = NurseNancy.Ressurection.speakMassRess()
                SendChatMessage(line, groupChannel, nil, index)
            else
                return
            end
        end 
    end)    
end


NurseNancy.Ressurection.Run()