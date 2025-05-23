-- init
NurseNancy.NurseNancy = {}
local feature = "NurseNancy";

function NurseNancy.NurseNancy.speakSelfRess(_, spellId)
    local pickedLine
    local prefix = NurseNancyVars.usePrefix == true and "[Self ress]: " or ""
    local playerName, playerGender, playerClass, playerRace, playerLevel = NurseNancy.Helpers.GetPlayerInformation()
    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)
    local playerHimHer = NurseNancy.Helpers.GetHimHer(playerGender);
    local zoneName = GetZoneText();
    local oppositeSex = "guys"
    local d = C_DateAndTime.GetCalendarTimeFromEpoch(1e6 * 60 * 60 * 24)

    if (playerGender == "male") then
        oppositeSex = "girls"
    end

    local selfRessLines = {
        "Here I am, this is me. There's nowhere else on ${zoneName} I'd rather be.",
        "${playerName}'s back, allright!",
        "I'm back by popular demand.",
        "Hiiiiii, missed me?",
        "I'm....back!!!!",
        "Sorry, I was just taking a quick nap. What did I miss?",
        "Sorry, I just got killed by accident. I'm back now.",
        "The other side didn't provide free Wi-Fi, so I came back here.",
        "The floor heating was off, so I decided to come back.",
        "I just finished writing a novel, I'm back to sell it to y'all!",
        "I forgot to show my slideshow!",
        "I forgot to play my own smallest violin!, so I'll do it just now.",
        "I'm my own worst enemy, so I think it's time I'll LIT something else.",
        "Self-service brought me back here.",
        "Here's {playerName}!!!",
        "I'm back, and I brought snacks!",
        "Ha! Death can't keep me down for long!",
        "Ha! Death can't keep me down for long!, probably not up either.",
        "I knew I shouldn't have trusted that boss to kill me for good.",
        "I'm like a cat, I always land on my feet. Even when I'm dead.",
        "Well, that was a close one. I almost had to walk all the way back to my corpse.",
        "I wasn't dead, I was just taking a really long nap.",
        "I think I might have just broken a record for 'most times resurrected in one raid'.",
        "Reporting for booty! I mean, duty.",
        "I'm back, and I brought cookies!",
        "Here I am, so young and strong. Right here in the place where I belong",
        "Here I am, this is me. I come into this world so wild and free",
        "Apparently, my bones were not considered loot, so I decided to sell them elsewhere.",
        "I am certain that I have been here as I am now a thousand times before, and I hope to return a thousand times.",
    }

    if (playerRace == "Night Elf" or playerRace == "Blood Elf") then
        table.insert(selfRessLines, "Like the night, I return. And I promise, no more moonlight serenades... for now.");
    end

    if (playerRace == "Worgen") then
        table.insert(selfRessLines, "I'm back, and hairier than ever!");
    end

    if (playerRace == "Undead") then
        table.insert(selfRessLines, "The dead can't die twice, right? Right?");
    end

    if (playerClass == "Shaman") then
        table.insert(selfRessLines, "Nobody believed in Reincarnation. Well, here's the proof!'")
        table.insert(selfRessLines,
            "I'm like a phoenix, rising from the ashes of my own death. Except less fiery and more wet.")
        table.insert(selfRessLines,
            "Reincarnation is great, but I'm not sure I want to come back as myself again. I mean, once was enough, am I right?")
        table.insert(selfRessLines,
            "Reincarnating in WoW is like playing a game of Russian roulette, except instead of a bullet, you might come back as a gnome. Scary stuff.")
        table.insert(selfRessLines,
            "I hoped that when I reincarnated, I got to keep all the loot and XP I earned in my previous life. It's like a rewards program for dying.")
        table.insert(selfRessLines,
            "I heard that if you reincarnate enough times in WoW, you eventually unlock a secret achievement called 'The Immortal'. I'm still working on it.")
        table.insert(selfRessLines,
            "Well, that was a refreshing trip to the spirit world. I almost didn't want to come back!")
        table.insert(selfRessLines,
            "I'm like a phoenix, rising from the ashes of my own death. Except less fiery and more wet.")
        table.insert(selfRessLines, "Death thought it had me, but the elements said 'hold my beer'.")
        table.insert(selfRessLines, "That was a real 'hold my totem' moment, but I made it work.")
        table.insert(selfRessLines,
            "I'm not just a Shaman, I'm a one-person resurrection army. Who needs healers anyway?")
    end

    -- eastern
    if (d.month == 4 and d.day == 4) then
        table.insert(selfRessLines, "Got afraid and hid in this egg, but now i'm back!")
        table.insert(selfRessLines, "Risen like a chocolate bunny in spring—no meltdown can hold me down!")
    end

    pickedLine = selfRessLines[fastrandom(1, #selfRessLines)]

    return NurseNancy.Helpers.parseText(
        prefix .. pickedLine, {
            playerName = playerName,
            playerGender = playerGender,
            playerClass = playerClass,
            playerRace = playerRace,
            playerLevel = playerLevel,
            playerManWoman = playerManWoman,
            playerGuyGirl = playerGuyGirl,
            playerHimHer = playerHimHer,
            oppositeSex = oppositeSex,
        }
    )
end

function NurseNancy.NurseNancy.speakSingleRess(targetGUID, spellId)
    local prefix = NurseNancyVars.usePrefix == true and "[Ressing ${targetName}]: " or ""
    local playerName, playerGender, playerClass, playerRace, playerLevel = NurseNancy.Helpers.GetPlayerInformation()
    local targetName, targetGender, targetClass, targetRace = NurseNancy.Helpers.GetTargetInformationByUID(targetGUID)
    local targetHimHer = NurseNancy.Helpers.GetHimHer(targetGender);
    local d = C_DateAndTime.GetCalendarTimeFromEpoch(1e6 * 60 * 60 * 24)

    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)
    local zoneName = GetZoneText();

    local oppositeSex = "guys"

    if (playerGender == "male") then
        oppositeSex = "girls"
    end

    local singleRessLines = {
        "${targetName} will be back in action in 10,...9,...8,...7,...6,...5,...4,...3,...2,...1,...",
        "${targetName} is back in the game, and ${playerName} is the one to blame!",
        "I'm not saying ${targetName} owes me their life, but I'm not NOT saying it either.",
        "${targetName}'s soul has been returned to their body. I hope they didn't lose the receipt.",
        "${targetName} time is now to get back on your feet and learn a real job.",
        "Even though ${targetName} is killing it on the floor, I'm going to bring ${targetHimHer} back.",
        "As long as you are not aware of the continual law of Die and Be Again, you are merely a vague guest on a dark Azeroth.",
        "Stop eating the floor, ${targetName}!",
        "Nobody informed ${targetName} that ${zoneName}'s gravity works different. Here's something to make you feel lighter.",
        "You look so unflattering, my ${targetName}, here, have a ress.",
        "You are not my child, ${targetName}, but I will raise you.",
        "And ${targetName} said: 'it was just a flesh wound'.",
        "Damnit, ${targetName}, I'm a ${playerClass} not a doctor.",
        "It just happens that ${targetName} here is only MOSTLY dead.",
        "Now rezzing ${targetName}. Your reputation with [Floor] has been increased by 100.",
        "Wake up! Wake up!, ${targetName}.",
        "${targetName}, come back! You forgot to pass me your contact details for the afterlife.",
        "I will not accept that ${targetName} actually died. ${targetHeShe} just needs some of my love.",
        "Rezzing: ${targetName}, get back to work!",
        "${targetName}, you're not done here. You missed a spot. Get back up!",
        "${targetName} has an incredible talent for bad timing. ${targetName} will live another few seconds.",
        "Sorry to break your dream, ${targetName}, but the princess ain't in another castle!",
        "You know, ${targetName}, the floor doesn't contain any floor heating, so get up and work it, baby!",
        "This ${targetName} is always resting,... Get back in your body and do your job, ${targetClass}!",
        "${targetName} has failed at living. Please deposit 50g to try again.",
        "Rezzing ${targetName}. Please no one else do this, or we could end up with a split body each and that would be unfortunate.",
        "Currently interrupting %T's love affair with the floor in 3....2....1.",
        "Here lies ${targetName}, my autumn flower. A lot less attractive now that you're all corpsified and gross.",
        "By the feeling, ${targetName} is still warm, but as I am being watched right now, i'll just ress you instead,… of other things i wanted to do",
        "${targetName} brought to life by Spirit Travels, Inc. Have you considered our Frequent Death program?",
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
        "Resurrecting ${targetName}. Please wait...",
        "I'm done with ${targetName} pretending to be dead. Come back and start cleaning the mess you've made!",
        "You're alive! And here I thought all ${playerRace} were supposed to be tough. Guess I was wrong.",
        "I swear, it's like ${playerRace} are allergic to staying alive. But I'm happy to prove that theory wrong.",
        "I'm pretty sure I just brought you back to life with the power of sheer determination. You owe me one.",
        "Looks like ${targetName} couldn't handle the heat. Good thing I'm here to cool things down.",
        "I heard the ${targetName} don't give up that easily, but I wasn't sure if that was just a rumor. Thanks for proving me right.",
        "I'm not sure if I should be proud or disappointed that I was able to bring you back to life. I guess I'll go with proud.",
        "You know, I'm starting to think that the ${targetName} is secretly trying to compete for 'most times resurrected in one raid'. You're doing a great job!",
        "Phew, that was a close one. I don't think I could have handled losing another one of my favorite ${playerRace}. Good thing I'm an expert at this whole resurrection thing.",
        "I hope you're not mad I interrupted your peaceful death. You're welcome, I guess?",
        "You're back! It's like you never left...except for the fact that you were dead a few moments ago.",
        "I know I said I'd always have your back, but did you have to test me on this so soon?",
        "If laughter is the best medicine, I prescribe to take a look at ${targetName} for a daily dose of hilarous stunts.",
        "Hey ${targetName}, I hope you recover faster your Wi-Fi connection. Sending healing vibes your way!",
        "Hey, I brought you back to life, but don't expect any thank-you gifts. I'm still trying to get over the smell.",
        "I brought ${targetName} back to life because I needed someone to carry my bags. Thanks in advance.",
        "I didn't find ${targetName}'s 'Do not resuscitate' order, so I figured I'd just go ahead and bring you back to life. You're welcome.",
    }

    if (playerClass == "Shaman") then
        table.insert(singleRessLines,
            "Ressing ${targetName} goes like: 'oo ee oo aa aa, ting, tang, walla walla bing bang'")
        table.insert(singleRessLines,
            "Congratulations, you've been resurrected by a shaman with all the grace and finesse of a startled deer. You're welcome.")
    end

    if (playerClass == "Druid") then
        table.insert(singleRessLines,
            "Congratulations, you've been resurrected by a shaman with all the grace and finesse of a startled deer. You're welcome.")
    end

    if (targetClass == "Druid") then
        table.insert(singleRessLines, "Hey ${targetName} stop growing roots there! I need you to RAWR!");
    end

    if (playerClass == "Warlock" or targetClass == "Priest") then
        table.insert(singleRessLines,
            "No kittens are being sacrificed by resurrecting ${targetName}, well, at least, no more than five.")
    end

    if (playerClass == "Warlock" or playerClass == "Priest") then
        table.insert(singleRessLines,
            "I told you, MORE DOTS, ${targetName}! This is what happens. Now I will need to resurrect you again!")
        table.insert(singleRessLines,
            "I'm not gonna lie, that resurrection was a bit like playing a game of Jenga with your soul. But hey, you're alive, right?")
    end

    -- engineering's kit
    if (NurseNancyVars.debugMode == true or spellId == 8342 or spellId == 22999 or spellId == 54732) then
        table.insert(singleRessLines, "CLEAR!");
        table.insert(singleRessLines, "Don’t struggle... I hate it when they struggle.")
        table.insert(singleRessLines, "${targetName}, you might feel a slight jolt...")
        table.insert(singleRessLines, "I'd pray for a miracle, but then ${targetName} wouldn't need these things.")
        table.insert(singleRessLines, "${targetName}'s dead...what's the worst that could happen?")
        table.insert(singleRessLines, "Don't worry, ${targetName}, I'm an Undermine, Inc. Certified Cable Jumper!")
        table.insert(singleRessLines, "I saw this on House once. Piece of cake!")
        table.insert(singleRessLines, "Have you hugged your engineer today?")
        table.insert(singleRessLines, "I can rebuild ${targetName}, but there'll be a...slight chance of explosion.")
        table.insert(singleRessLines, "One order of fried ${targetName}, comin' right up!")
        table.insert(singleRessLines, "When the Light goes out, call in an engineer!")
        table.insert(singleRessLines, "Let's see...orange to nipple, black to ground...or was it the other way around?")
        table.insert(singleRessLines, "Zappy, zappy, ending ${targetName}'s nappy!")
        table.insert(singleRessLines,
            "Huh...never noticed this warning label. 'ARCHSURGEON'S WARNING: High dosages of electricity are hazardous to one's health. Use only if patient is already dead.' Well, ${targetName} certainly fits the bill.")
        table.insert(singleRessLines,
            "Finally, no more need to ask for ${targetName}'s permission to start experimentation!")
        table.insert(singleRessLines,
            "The clamps on these cables leave some nasty bruises, but I don't think ${targetName} would prefer the alternative")
        table.insert(singleRessLines, "Don't worry, ${targetName}, this is for SCIENCE!")
        table.insert(singleRessLines, "Five gold says ${targetName} enjoys these clamps.")
        table.insert(singleRessLines, "${targetName} has encountered a fatal error. Rebooting...")
    end

    -- Holidays!
    -- -- Christmas
    if (d.month == 12 and (d.day == 25 or d.day == 26)) then
        table.insert(singleRessLines, "Merry Christmas, ${targetName}! Here's your gift: life!")
        table.insert(singleRessLines, "${targetName}'s being called for Christmas dinner! Get up!")
        table.insert(singleRessLines,
            "Santa's not the only one who can bring people back from the dead. Merry Christmas, ${targetName}!")
        table.insert(singleRessLines,
            "I heard ${targetName} was on the naughty list, but I decided to give ${targetHimHer} a second chance anyway.")
        table.insert(singleRessLines, "I hope you like your gift, ${targetName}. It's the gift of life!")
        table.insert(singleRessLines,
            "I'm not saying I'm Santa, but I did just bring ${targetName} back from the dead. Coincidence? I think not.")
        table.insert(singleRessLines, "I hope you're not allergic to second chances, ${targetName}. Merry Christmas!")
    end

    -- -- New year's eve
    if (d.month == 12 and d.day == 31 or d.month == 1 and d.day == 1) then
        table.insert(singleRessLines, "Happy New Year, ${targetName}! Here's to another year of not dying!")
        table.insert(singleRessLines,
            "I hope you're not planning on dying in the new year, ${targetName}. I'm not sure I can handle another resurrection.")
        table.insert(singleRessLines,
            "I heard ${targetName} was planning on starting the new year off with a bang. I didn't realize they meant literally.")
        table.insert(singleRessLines,
            "I hope you're not planning on making a habit of dying in the new year, ${targetName}. I'm not sure I can handle it.")
        table.insert(singleRessLines,
            "I'm not saying I'm a fortune teller, but I did predict that I'd be resurrecting ${targetName} on New Year's Eve.")
        table.insert(singleRessLines,
            "Too much champagne or not, I'm still here to bring you back from the dead, ${targetName}. Happy New Year!")
    end

    -- eastern
    if (d.month == 4 and d.day == 4) then
        table.insert(singleRessLines, "Happy Easter, ${targetName}! Here's your gift: life!")
        table.insert(singleRessLines, "${targetName}'s being called for Easter dinner! Get up!")
        table.insert(singleRessLines,
            "The Easter Bunny's not the only one who can bring people back from the dead. Happy Easter, ${targetName}!")
        table.insert(singleRessLines,
            "I'm not saying I'm the Easter Bunny, but I did just bring ${targetName} back from the dead. Coincidence? I think not.")
        table.insert(singleRessLines, "I hope you're not allergic to second chances, ${targetName}. Happy Easter!")
        table.insert(singleRessLines, "I might've cracked under pressure, but I'm hopping right back—happy Easter!")
        table.insert(singleRessLines,
            "Egg-stra! Egg-stra! Read all about it—my resurrection is as colorful as those hidden eggs!")
    end

    local pickedLine = singleRessLines[fastrandom(1, #singleRessLines)]

    return NurseNancy.Helpers.parseText(
        prefix .. pickedLine, {
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
            targetHimHer = targetHimHer,
            oppositeSex = oppositeSex,
        }
    )
end

function NurseNancy.NurseNancy.speakCombatRess(targetGUID, spellId)
    local pickedLine
    local prefix = NurseNancyVars.usePrefix == true and "[Combat ressing ${targetName}]: " or ""
    local d = C_DateAndTime.GetCalendarTimeFromEpoch(1e6 * 60 * 60 * 24)

    local playerName, playerGender, playerClass, playerRace, playerLevel = NurseNancy.Helpers.GetPlayerInformation()
    local targetName, targetGender, targetClass, targetRace = NurseNancy.Helpers.GetTargetInformationByUID(targetGUID)

    local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

    local targetHimHer = NurseNancy.Helpers.GetHimHer(targetGender);

    local zoneName = GetRealZoneText()
    local combatRessLines

    local oppositeSex = "guys"

    if (playerGender == "male") then
        oppositeSex = "girls"
    end

    combatRessLines = {
        "Ressing ${targetName} in the middle of a fight? I must be crazy!",
        "Being cremated is ${targetName}'s last hope for a smokin’ hot body.",
        "${targetName}, always deciding to enjoy the floor while fighting. Come on, ${playerManWoman}, accept the ress!",
        "${targetName}, stand up and walk!",
        "A ${targetName} flatty patty is coming right up!",
        "In Soviet ${zoneName}, life chooses ${targetName}",
        "${targetName}, please report to the land of the living. Your urgent assistance is required.",
        "Up up and ....awayyyyyyy!",
        "Get up, ${targetName}, I need you to fetch me snacks,...NOW PLEASE!",
        "Sorry, ${targetName}'s strings were a little tangled. Let me just untie them...There we go!",
        "I'm not saying I am to blame for ${targetName}'s death, but I did told ${targetHimHer} I had garlic. Luckily, ressing has plenty of distance.",
        "Resurrecting is not changing who you are, but discarding who you are not.",
        "Congratulations, ${targetName} is alive again! Just don't ask me to do it again anytime soon. It's a lot of paperwork.",
    }

    if (playerGender == "female") then
        table.insert(combatRessLines, "Arise my Champ... oh, I mean, you. Yes ${targetName}, there.")
    end

    if (playerClass == "Death Knight") then
        table.insert(combatRessLines, "Raising hell in ${zoneName},...err, I mean raising ${targetName}")
        table.insert(combatRessLines,
            "Bringing the torment of undeath to ${targetName}: slower, weaker, and only slightly less dead.")
        table.insert(combatRessLines, "Raising ${targetName} into unlife for the glory of the Lich Ki--whoops.")
        table.insert(combatRessLines, "Here, ${targetName}, have a taste of what working for the Lich King is like.")
        table.insert(combatRessLines, "Animating ${targetName}'s body, shotguns at the ready!")
        table.insert(combatRessLines, "Don't worry, ${targetName}, you'll be all dead again soon.")
        table.insert(combatRessLines, "Look, ${targetName} I'm a soulless abomination, not a miracle worker!")
        table.insert(combatRessLines,
            "${targetName}, if any of your limbs fall off after this, it's completely your fault and has nothing to do with the influence of the Lich King.")
        table.insert(combatRessLines,
            "The power of the Necromancer flows through me! Rise, my brittle little ${targetName}, and let's show these fools what real power looks like!")
    end

    if (playerClass == "Druid") then
        table.insert(combatRessLines,
            "I coulda been a bear, y'know. Or a kitty. Maybe a tree. Even one of those...whaddayacallems...owlbears. But nooooo, I had ta rez ${targetName}. Not that I'm bitter or anything.")
        table.insert(combatRessLines, "Warm fuzzy naturey things for you, ${targetName}...now get UP!")
    end

    if (playerClass == "Paladin") then
        -- table.insert(combatRessLines, "I coulda been a bear, y'know. Or a kitty. Maybe a tree. Even one of those...whaddayacallems...owlbears. But nooooo, I had ta rez ${targetName}. Not that I'm bitter or anything.")
        -- table.insert(combatRessLines, "Warm fuzzy naturey things for you, ${targetName}...now get UP!")
    end

    if (playerClass == "Warlock") then
        prefix = NurseNancyVars.usePrefix == true and "[Soulstone on ${targetName}]: " or ""
        table.insert(combatRessLines, "Do not worry, ${targetName}, this soulstone - shouldn't - hurt a bit...")
        table.insert(combatRessLines,
            "According to my Failometer, ${targetName} has a high chance of dying in the next fifteen minutes.")
        table.insert(combatRessLines,
            "I'm just gonna borrow your soul for a bit, ${targetName}, I promise I'll give it back... when you're dead.")
        table.insert(combatRessLines, "One spare soul coming straight up for you, ${targetName}.")
        table.insert(combatRessLines,
            "Soulstone on ${targetName}. It's not that I think you're going to die, honestly ${targetName}.")
        table.insert(combatRessLines,
            "Soulstoning is a routine procedure. I totally don't think ${targetName} will die in the next 15 minutes.")
        table.insert(combatRessLines, "${targetName}, this soulstone is just my way of saying `I don't trust you.`")
        table.insert(combatRessLines,
            "Soulstoning ${targetName}. I promise to not devour your soul in the next 15 minutes, if you are a tank, a healer or a fellow Warlock. Maybe.")
        table.insert(combatRessLines,
            "${targetName}, I heard you love to get stoned, so I will stone you, so you will be stoned, while you are stoned. Or something.")
        table.insert(combatRessLines, "Stoning ${targetName}. Suicide is no longer an option for you.")
        table.insert(combatRessLines,
            "Stoning ${targetName}. If you hate my rock, feel free to go to your nearest Death Knight.")
        table.insert(combatRessLines,
            "Soulstoning ${targetName}. ARCHSURGEON'S WARNING: Soulstones contain puppy hearts, and are linked to ghoul fever in laboratory tests.")
        table.insert(combatRessLines, "Package for you, ${targetName}. Contents: One(1) soul.")
        table.insert(combatRessLines, "FYI, ${targetName}, using a soulstone removes any chance of getting into heaven.")
    end

    -- eastern
    if (d.month == 4 and d.day == 4) then
        table.insert(combatRessLines, "Got afraid and hid in this egg, but now i'm back!")
        table.insert(combatRessLines, "Time to spring back into action, ${targetName}!")
        table.insert(combatRessLines, "No time for an egg nap, ${targetName}! Hop right up!")
        table.insert(combatRessLines, "Crack open a new life, ${targetName}, the battle's not over yet!")
        table.insert(combatRessLines, "Rise and shine, ${targetName}, don't keep the Easter bunny waiting!")

        if (playerClass == "Warlock") then
            table.insert(combatRessLines, "Here's some cool 'chocolate egg', ${targetName}.")
        end
    end

    pickedLine = combatRessLines[fastrandom(1, #combatRessLines)]

    return NurseNancy.Helpers.parseText(
        prefix .. pickedLine, {
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
            targetHimHer = targetHimHer,
            oppositeSex = oppositeSex,
            zoneName = zoneName
        }
    )
end

function NurseNancy.NurseNancy.speakMassRess()
    local pickedLine
    local prefix                                                         = NurseNancyVars.usePrefix == true and
        "[Mass ressing]: " or ""

    local d                                                              = C_DateAndTime.GetCalendarTimeFromEpoch(1e6 *
        60 * 60 * 24)
    local playerName, playerGender, playerClass, playerRace, playerLevel = NurseNancy.Helpers.GetPlayerInformation()

    local playerGuyGirl                                                  = NurseNancy.Helpers.GetGuyGirl(playerGender)
    local playerManWoman                                                 = NurseNancy.Helpers.GetManWoman(playerGender)
    local oppositeSex                                                    = "guys"

    if (playerGender == "male") then
        oppositeSex = "girls"
    end

    local zoneName = GetZoneText();

    local massRessLines = {
        "Go go gadget, RESSURECTION!",
        "A little less conversation, a little more action, please. All this resurrection ain't satisfactioning me",
        "Come to ${zoneName} with us they said, it will be fun, they said",
        "Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo... that's the best ambulance impression I can do.", -- Sueyen-Talnivarr, EU
        "Oh hello juicy corpses.... Your bodies are still warm... hmmmm... hmm.",
        "Death is the wish of some, the relief of many, and just a chore for me... *sigh*.",
        "The goal of all life is death...and getting resurrected by yours truly.",
        "We all die. The goal isn't to live forever, the goal is to get epics.",
        "I’ve always ressed, and I’m going to continue to ress. And that’s the way it is.",
        "Ressing was never the big motivation for me, except as a way to keep score. The real excitement is playing the game. ",
        "We will bring back our DPS. We will bring back our Healers. And we will bring back our Tanks.",
        "If you hear a disembodied voice saying 'Go into the light,' don't worry, it's just me. Unless it's not... in which case, run.",
        "I'm not saying you owe me your life... oh wait, that's exactly what I'm saying. You're welcome!",
        "Do you know how hard it is to resurrect a whole group of people? I swear, it's like herding undead cats.",
        "Wake up, sleepyheads! The elements have granted you a second chance... or maybe they just wanted me to stop bothering them about it.",
        "I have the power of a thousand Lich Kings flowing through my veins! Rise and join my army of the undead!",
        "By the power of the elements and the strength of my muscles, I command you to rise from the dead and do my bidding!",
        "Let the power of the light consume your soul and lift you from the eternal slumber! Rise, my precious little minions!",
        "Arise, my fallen comrades! We have work to do, and I need your undead hands to do it!",
        "Let the power of the light consume your soul and lift you from the eternal slumber! Rise, my precious little minions!",
        "The spirits of the dead are at my beck and call! Rise up and serve me, my dear departed friends!",
        "Let the dark energy of the Shadowlands flow through you and give you new life! Now, let's go kill some demons!",
        "I discovered to my joy, that it is life, not death, because I need to press this button, time after time.",
        "There are far, far better things ahead than I could leave behind, if it only wasn’t for the smell of your corpses.",
        "Look alive, chaps!", -- Some British bloke.
        "Don't worry about zombies, they only eat brains.",
        "When you connect to the silence within you, that is when you can make sense of the disturbance going on around you. Or it means that you're all dead...",
        "Hoping not to confuse this spell with mass necromancy... oh well, if you had brains, you wouldn’t have died anyways.",
        "Oh dear, here we go again... resurrecting EVERYONE, ... AGAIN!",
        "What is ${playerName} gonna do now, buddy? oh, well, I guess I should start getting you all up.",
        "I have a morbid interest in all of your bodies..., but I want to tell y’all my problems too,.. hmm, what to do....fine, ill ress,.. again!",
        "Roses are red, your corpses are blue, I’m incredible bored, by all of you.",
        "Unfortunatly, you are all not revered with ${playerRace} ${playerGender} ${playerClass}s to be rezzed. Lucky for you, I just stole 5g from all. Ressing now...",
        "They say the Cataclysm changed everything, but apparently not,...I'm still scraping your corpse off the pavement.",
        "Up-up-up-up-up! Everyone UP!",
        "Everybody was kung-fu fighting. They weren't fast as lightning. In fact, it was a little bit frightening. But they're all back now, so it's all good.",
        "You get a repair bill! And YOU get a repair bill! And YOU get a repair bill!", -- Oprah really plays some world of warcraft you know.
        "Group assignments make me understand why Arthas worked alone.",
        "Luckily, my profession is not dying.",
        "By accepting your ressurrection, you agree to the terms and conditions of the 'I owe ${playerName} at least 3 fudge cubes' contract.",
        "I am not paid to be an undertaken. Get up and dig your own grave first please, thank you!",
        "Apparently, the afterlife was too crowded, so you're stuck with me again.",
        "Get up, everyone! I'm running out of witty remarks for repeated mass deaths.",
        "Look at all these sleeping beauties! Time for a group wake-up call."
    }

    if (playerRace == "Dracthyr") then
        table.insert(massRessLines, "My fellow teamies drop faster than I shed my scales.")
    end

    if (playerClass == "Priest") then
        table.insert(massRessLines,
            "All right, people, listen up! The afterlife is overrated, so I'm giving you all a second chance. Don't waste it!")
        table.insert(massRessLines,
            "You're welcome for bringing you back from the dead. Just make sure to send a thank-you card or something... or, you know, donate to my holy order.")
        table.insert(massRessLines,
            "I'm pretty sure my parents didn't think 'mass resurrection' would be part of my job description when they sent me to seminary.")
    end

    if (playerClass == "Paladin") then
        table.insert(massRessLines,
            "Arise, champions of the Light! And by 'champions' I mean 'people who stood in the fire and died... again.'")
        table.insert(massRessLines,
            "I'm starting to think that 'resurrection' is just a fancy word for 'you owe me one.'")
    end

    -- eastern
    if (d.month == 4 and d.day == 4) then
        table.insert(massRessLines, "Easter's not over yet, ${playerName}! Time to bring everyone back from the dead!")
        table.insert(massRessLines, "Rise and shine, everyone! The Easter bunny has nothing on me!")
        table.insert(massRessLines, "Easter may be over, but the resurrection party is just getting started!")
        table.insert(massRessLines,
            "The Easter bunny may have hidden the eggs, but I'm the one bringing everyone back from the dead!")
        table.insert(massRessLines,
            "Easter may be a time for new beginnings, but I'm pretty sure this is the first time anyone's been resurrected on Easter!")
    end

    -- christmas
    if (d.month == 12 and (d.day == 25 or d.day == 26)) then
        table.insert(massRessLines, "Merry Christmas, everyone! Here's your gift: life!")
        table.insert(massRessLines, "Everyone's being called for Christmas dinner! Get up!")
        table.insert(massRessLines,
            "Santa's not the only one who can bring people back from the dead. Merry Christmas, everyone!")
    end

    pickedLine = massRessLines[fastrandom(1, #massRessLines)]

    return NurseNancy.Helpers.parseText(
        prefix .. pickedLine, {
            playerName = playerName,
            playerGender = playerGender,
            playerClass = playerClass,
            playerRace = playerRace,
            playerLevel = playerLevel,
            playerManWoman = playerManWoman,
            playerGuyGirl = playerGuyGirl,
            oppositeSex = oppositeSex,
            zoneName = zoneName,
        }
    )
end

local function canBroadcastParty(value)
    if (value == 1 or value == 3) then
        return true
    end

    return false
end

local function canBroadcastRaid(value)
    if (value == 2 or value == 3) then
        return true
    end

    return false
end

local function getBroadcastChannel(broadCastChannels, canBroadcastToInstance)
    local canBroadcastToParty = canBroadcastParty(broadCastChannels)
    local canBroadcastToRaid = canBroadcastRaid(broadCastChannels)
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID =
        GetInstanceInfo();
    local isInInstance = false;

    if (LfgDungeonID) then
        isInInstance = true;
    end

    local groupSetup = IsInRaid() and "raid" or "party";

    if (not (instanceType == "party" or instanceType == "raid")) then
        return nil;
    end

    if (instanceType == "party" and canBroadcastToParty == true and canBroadcastToInstance == true and isInInstance == true) then
        return "INSTANCE_CHAT"
    end

    if (instanceType == "raid" and canBroadcastToRaid == true and canBroadcastToInstance == true and isInInstance == true) then
        return "INSTANCE_CHAT"
    end

    if (instanceType == "party" and groupSetup == "party" and canBroadcastToParty == true and isInInstance == false) then
        return "PARTY"
    end

    if ((instanceType == "raid" and groupSetup == "party") and canBroadcastToParty == true and isInInstance == false) then
        return "PARTY"
    end

    if ((instanceType == "raid" and groupSetup == "raid") and canBroadcastToRaid == true and isInInstance == false) then
        return "RAID"
    end
end


local function determineChannel(feature)
    if (feature == "selfRess") then
        return getBroadcastChannel(
            NurseNancyVars.selfRess_channel,
            NurseNancyVars.selfRess_instance
        )
    end

    if (feature == "massRess") then
        return getBroadcastChannel(
            NurseNancyVars.massRess_channel,
            NurseNancyVars.massRess_instance
        )
    end

    if (feature == "singleRess") then
        return getBroadcastChannel(
            NurseNancyVars.singleRess_channel,
            NurseNancyVars.singleRess_instance
        )
    end

    if (feature == "combatRess") then
        return getBroadcastChannel(
            NurseNancyVars.combatRess_channel,
            NurseNancyVars.combatRess_instance
        )
    end

    return false;
end


function NurseNancy.NurseNancy.Run()
    local line

    NurseNancy.NurseNancy.Frame = CreateFrame("Frame")
    NurseNancy.NurseNancy.Frame:RegisterEvent("UNIT_SPELLCAST_SENT")
    NurseNancy.NurseNancy.Frame:RegisterEvent("UNIT_SPELLCAST_START")
    NurseNancy.NurseNancy.Frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    NurseNancy.NurseNancy.Frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

    NurseNancy.NurseNancy.Frame:SetScript("OnEvent", function(self, event, ...)
        if (not (NurseNancyVars.nurseNancyIsOn == true) and NurseNancyVars.debugMode == false) then
            return
        end

        -- do single ress
        if (event == "UNIT_SPELLCAST_SENT") then
            local castOrigin, target, spellGUID, spellId = ...

            if (not (castOrigin == "player")) then
                return
            end

            local unitIdentificator = UnitGUID(target or "player")

            local isCombatRess = NurseNancy.SpellIds.isCombatRess(spellId)
            local isSingleRess = NurseNancy.SpellIds.isSingleRess(spellId)
            local isSelfRess = NurseNancy.SpellIds.isSelfRess(spellId)


            local groupChannelSingleRess = determineChannel("singleRess");
            local groupChannelSelfRess = determineChannel("selfRess");
            local groupChannelCombatRess = determineChannel("combatRess");

            if (isSingleRess and groupChannelSingleRess) then
                line = NurseNancy.NurseNancy.speakSingleRess(unitIdentificator, spellId)
                SendChatMessage(line, groupChannelSingleRess, nil, index)
            elseif (isCombatRess and groupChannelCombatRess) then
                line = NurseNancy.NurseNancy.speakCombatRess(unitIdentificator, spellId)
                SendChatMessage(line, groupChannelCombatRess, nil, index)
            elseif (isSelfRess and groupChannelSelfRess) then
                line = NurseNancy.NurseNancy.speakSelfRess(unitIdentificator, spellId)
                SendChatMessage(line, groupChannelSelfRess, nil, index)
            end

            if (NurseNancyVars.debugMode == true) then
                debugPrint(feature, NurseNancy.NurseNancy.speakSingleRess(unitIdentificator, spellId));
                debugPrint(feature, NurseNancy.NurseNancy.speakCombatRess(unitIdentificator, spellId));
                debugPrint(feature, NurseNancy.NurseNancy.speakSelfRess(unitIdentificator, spellId));
            end
        end

        -- do mass ress
        if (event == "UNIT_SPELLCAST_START") then
            local unitTarget, castGUID, spellID = ...
            if (not (unitTarget == "player")) then
                return
            end

            local isMassRess = NurseNancy.SpellIds.isMassRess(spellID)
            local groupChannelMassRess = determineChannel("massRess");

            if (isMassRess and groupChannelMassRess) then
                line = NurseNancy.NurseNancy.speakMassRess()
                SendChatMessage(line, groupChannelMassRess, nil, index)
            else
                if (NurseNancyVars.debugMode == true) then
                    debugPrint(feature, NurseNancy.NurseNancy.speakMassRess());
                end
            end
        end
    end)
end

NurseNancy.NurseNancy.Run()
