function NurseNancy.NurseNancy.speakCombatRess(targetGUID, spellId)
  local pickedLine
  local prefix = NurseNancyVars.usePrefix == true and "[Combat ressing ${targetName}]: " or ""
  local Class = AFKAnsweringMachine.Constants.Class
  local Race = AFKAnsweringMachine.Constants.Race

  -- dateFormat
  local rawTime = date("*t")
  local d = {
    day = rawTime.day,
    month = rawTime.month,
    year = rawTime.year,
  }

  local playerName, playerGender, playerClass, playerRace, playerLevel =
    NurseNancy.Helpers.GetPlayerInformation()
  local targetName, targetGender, targetClass, targetRace =
    NurseNancy.Helpers.GetTargetInformationByUID(targetGUID)

  local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
  local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

  local targetHimHer = NurseNancy.Helpers.GetHimHer(targetGender)

  local zoneName = GetRealZoneText()
  local combatRessLines

  local oppositeSex = "guys"

  if (playerGender == "male") then
    oppositeSex = "girls"
  end

  combatRessLines =
    {
      "Ressing ${targetName} in the middle of a fight? I must be crazy!",
      "Being cremated is ${targetName}'s last hope for a smokin' hot body.",
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
    table.insert(
      combatRessLines,
      "Raising hell in ${zoneName},...err, I mean raising ${targetName}"
    )
    table.insert(
      combatRessLines,
      "Bringing the torment of undeath to ${targetName}: slower, weaker, and only slightly less dead."
    )
    table.insert(
      combatRessLines,
      "Raising ${targetName} into unlife for the glory of the Lich Ki--whoops."
    )
    table.insert(
      combatRessLines,
      "Here, ${targetName}, have a taste of what working for the Lich King is like."
    )
    table.insert(combatRessLines, "Animating ${targetName}'s body, shotguns at the ready!")
    table.insert(combatRessLines, "Don't worry, ${targetName}, you'll be all dead again soon.")
    table.insert(
      combatRessLines,
      "Look, ${targetName} I'm a soulless abomination, not a miracle worker!"
    )
    table.insert(
      combatRessLines,
      "${targetName}, if any of your limbs fall off after this, it's completely your fault and has nothing to do with the influence of the Lich King."
    )
    table.insert(
      combatRessLines,
      "The power of the Necromancer flows through me! Rise, my brittle little ${targetName}, and let's show these fools what real power looks like!"
    )
  end

  if (playerClass == "Druid") then
    table.insert(
      combatRessLines,
      "I coulda been a bear, y'know. Or a kitty. Maybe a tree. Even one of those...whaddayacallems...owlbears. But nooooo, I had ta rez ${targetName}. Not that I'm bitter or anything."
    )
    table.insert(combatRessLines, "Warm fuzzy naturey things for you, ${targetName}...now get UP!")
  end

  if (playerClass == "Paladin") then
    -- table.insert(combatRessLines, "I coulda been a bear, y'know. Or a kitty. Maybe a tree. Even one of those...whaddayacallems...owlbears. But nooooo, I had ta rez ${targetName}. Not that I'm bitter or anything.")
    -- table.insert(combatRessLines, "Warm fuzzy naturey things for you, ${targetName}...now get UP!")
  end

  if (playerClass == "Warlock") then
    prefix = NurseNancyVars.usePrefix == true and "[Soulstone on ${targetName}]: " or ""
    table.insert(
      combatRessLines,
      "Sacraficing this rare Labubu in order to ressurrect ${targetName}."
    )
    table.insert(
      combatRessLines,
      "Do not worry, ${targetName}, this soulstone - shouldn't - hurt a bit..."
    )
    table.insert(
      combatRessLines,
      "According to my Failometer, ${targetName} has a high chance of dying in the next fifteen minutes."
    )
    table.insert(
      combatRessLines,
      "I'm just gonna borrow your soul for a bit, ${targetName}, I promise I'll give it back... when you're dead."
    )
    table.insert(combatRessLines, "One spare soul coming straight up for you, ${targetName}.")
    table.insert(
      combatRessLines,
      "Soulstone on ${targetName}. It's not that I think you're going to die, honestly ${targetName}."
    )
    table.insert(
      combatRessLines,
      "Soulstoning is a routine procedure. I totally don't think ${targetName} will die in the next 15 minutes."
    )
    table.insert(
      combatRessLines,
      "${targetName}, this soulstone is just my way of saying `I don't trust you.`"
    )
    table.insert(
      combatRessLines,
      "Soulstoning ${targetName}. I promise to not devour your soul in the next 15 minutes, if you are a tank, a healer or a fellow Warlock. Maybe."
    )
    table.insert(
      combatRessLines,
      "${targetName}, I heard you love to get stoned, so I will stone you, so you will be stoned, while you are stoned. Or something."
    )
    table.insert(combatRessLines, "Stoning ${targetName}. Suicide is no longer an option for you.")
    table.insert(
      combatRessLines,
      "Stoning ${targetName}. If you hate my rock, feel free to go to your nearest Death Knight."
    )
    table.insert(
      combatRessLines,
      "Soulstoning ${targetName}. ARCHSURGEON'S WARNING: Soulstones contain puppy hearts, and are linked to ghoul fever in laboratory tests."
    )
    table.insert(combatRessLines, "Package for you, ${targetName}. Contents: One(1) soul.")
    table.insert(
      combatRessLines,
      "FYI, ${targetName}, using a soulstone removes any chance of getting into heaven."
    )
  end

  -- eastern
  if (d.month == 4 and d.day == 4) then
    table.insert(combatRessLines, "Got afraid and hid in this egg, but now i'm back!")
    table.insert(combatRessLines, "Time to spring back into action, ${targetName}!")
    table.insert(combatRessLines, "No time for an egg nap, ${targetName}! Hop right up!")
    table.insert(
      combatRessLines,
      "Crack open a new life, ${targetName}, the battle's not over yet!"
    )
    table.insert(
      combatRessLines,
      "Rise and shine, ${targetName}, don't keep the Easter bunny waiting!"
    )

    if (playerClass == "Warlock") then
      table.insert(combatRessLines, "Here's some cool 'chocolate egg', ${targetName}.")
    end
  end

  pickedLine = combatRessLines[fastrandom(1, #combatRessLines)]

  return NurseNancy.Helpers.parseText(prefix .. pickedLine, {
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
    zoneName = zoneName,
  })
end
