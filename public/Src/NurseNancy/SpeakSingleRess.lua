function NurseNancy.NurseNancy.speakSingleRess(targetGUID, spellId)
  local prefix = NurseNancyVars.usePrefix == true and "[Ressing ${targetName}]: " or ""
  local playerName, playerGender, playerClass, playerRace, playerLevel =
    NurseNancy.Helpers.GetPlayerInformation()
  local targetName, targetGender, targetClass, targetRace =
    NurseNancy.Helpers.GetTargetInformationByUID(targetGUID)
  local targetHimHer = NurseNancy.Helpers.GetHimHer(targetGender)

  local Class = AFKAnsweringMachine.Constants.Class
  local Race = AFKAnsweringMachine.Constants.Race

  -- dateFormat
  local rawTime = date("*t")
  local d = {
    day = rawTime.day,
    month = rawTime.month,
    year = rawTime.year,
  }

  local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
  local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)
  local zoneName = GetZoneText()

  local oppositeSex = "guys"

  if (playerGender == "male") then
    oppositeSex = "girls"
  end

  local singleRessLines =
    {
      "When I clap my hands, ${targetName} is back in the room!",
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
      "${targetName}, your flesh-vessel is present but your soul is clearly lost in the void. Please re-animate.",
      "${targetName}, stop defying gravity. The ancient gods are getting nervous from your aggressive hopping.",
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
    table.insert(
      singleRessLines,
      "Ressing ${targetName} goes like: 'oo ee oo aa aa, ting, tang, walla walla bing bang'"
    )
    table.insert(
      singleRessLines,
      "Congratulations, you've been resurrected by a shaman with all the grace and finesse of a startled deer. You're welcome."
    )
  end

  if (playerClass == "Druid") then
    table.insert(
      singleRessLines,
      "Congratulations, you've been resurrected by a shaman with all the grace and finesse of a startled deer. You're welcome."
    )
  end

  if (targetClass == "Druid") then
    table.insert(singleRessLines, "Hey ${targetName} stop growing roots there! I need you to RAWR!")
  end

  if (playerClass == "Warlock" or targetClass == "Priest") then
    table.insert(
      singleRessLines,
      "No kittens are being sacrificed by resurrecting ${targetName}, well, at least, no more than five."
    )
  end

  if (playerClass == "Warlock" or playerClass == "Priest") then
    table.insert(
      singleRessLines,
      "I told you, MORE DOTS, ${targetName}! This is what happens. Now I will need to resurrect you again!"
    )
    table.insert(
      singleRessLines,
      "I'm not gonna lie, that resurrection was a bit like playing a game of Jenga with your soul. But hey, you're alive, right?"
    )
  end

  -- engineering's kit
  if (NurseNancyVars.debugMode == true or spellId == 8342 or spellId == 22999 or spellId == 54732) then
    table.insert(singleRessLines, "CLEAR!")
    table.insert(singleRessLines, "Don't struggle... I hate it when they struggle.")
    table.insert(singleRessLines, "${targetName}, you might feel a slight jolt...")
    table.insert(
      singleRessLines,
      "I'd pray for a miracle, but then ${targetName} wouldn't need these things."
    )
    table.insert(singleRessLines, "${targetName}'s dead...what's the worst that could happen?")
    table.insert(
      singleRessLines,
      "Don't worry, ${targetName}, I'm an Undermine, Inc. Certified Cable Jumper!"
    )
    table.insert(singleRessLines, "I saw this on House once. Piece of cake!")
    table.insert(singleRessLines, "Have you hugged your engineer today?")
    table.insert(
      singleRessLines,
      "I can rebuild ${targetName}, but there'll be a...slight chance of explosion."
    )
    table.insert(singleRessLines, "One order of fried ${targetName}, comin' right up!")
    table.insert(singleRessLines, "When the Light goes out, call in an engineer!")
    table.insert(
      singleRessLines,
      "Let's see...orange to nipple, black to ground...or was it the other way around?"
    )
    table.insert(singleRessLines, "Zappy, zappy, ending ${targetName}'s nappy!")
    table.insert(
      singleRessLines,
      "Huh...never noticed this warning label. 'ARCHSURGEON'S WARNING: High dosages of electricity are hazardous to one's health. Use only if patient is already dead.' Well, ${targetName} certainly fits the bill."
    )
    table.insert(
      singleRessLines,
      "Finally, no more need to ask for ${targetName}'s permission to start experimentation!"
    )
    table.insert(
      singleRessLines,
      "The clamps on these cables leave some nasty bruises, but I don't think ${targetName} would prefer the alternative"
    )
    table.insert(singleRessLines, "Don't worry, ${targetName}, this is for SCIENCE!")
    table.insert(singleRessLines, "Five gold says ${targetName} enjoys these clamps.")
    table.insert(singleRessLines, "${targetName} has encountered a fatal error. Rebooting...")
  end

  -- Holidays!
  -- -- Christmas
  if (d.month == 12 and (d.day == 25 or d.day == 26)) then
    table.insert(singleRessLines, "Merry Christmas, ${targetName}! Here's your gift: life!")
    table.insert(singleRessLines, "${targetName}'s being called for Christmas dinner! Get up!")
    table.insert(
      singleRessLines,
      "Santa's not the only one who can bring people back from the dead. Merry Christmas, ${targetName}!"
    )
    table.insert(
      singleRessLines,
      "I heard ${targetName} was on the naughty list, but I decided to give ${targetHimHer} a second chance anyway."
    )
    table.insert(
      singleRessLines,
      "I hope you like your gift, ${targetName}. It's the gift of life!"
    )
    table.insert(
      singleRessLines,
      "I'm not saying I'm Santa, but I did just bring ${targetName} back from the dead. Coincidence? I think not."
    )
    table.insert(
      singleRessLines,
      "I hope you're not allergic to second chances, ${targetName}. Merry Christmas!"
    )
  end

  -- -- New year's eve
  if (d.month == 12 and d.day == 31 or d.month == 1 and d.day == 1) then
    table.insert(
      singleRessLines,
      "Happy New Year, ${targetName}! Here's to another year of not dying!"
    )
    table.insert(
      singleRessLines,
      "I hope you're not planning on dying in the new year, ${targetName}. I'm not sure I can handle another resurrection."
    )
    table.insert(
      singleRessLines,
      "I heard ${targetName} was planning on starting the new year off with a bang. I didn't realize they meant literally."
    )
    table.insert(
      singleRessLines,
      "I hope you're not planning on making a habit of dying in the new year, ${targetName}. I'm not sure I can handle it."
    )
    table.insert(
      singleRessLines,
      "I'm not saying I'm a fortune teller, but I did predict that I'd be resurrecting ${targetName} on New Year's Eve."
    )
    table.insert(
      singleRessLines,
      "Too much champagne or not, I'm still here to bring you back from the dead, ${targetName}. Happy New Year!"
    )
  end

  -- easter
  if (d.month == 4 and d.day == 4) then
    table.insert(singleRessLines, "Happy Easter, ${targetName}! Here's your gift: life!")
    table.insert(singleRessLines, "${targetName}'s being called for Easter dinner! Get up!")
    table.insert(
      singleRessLines,
      "The Easter Bunny's not the only one who can bring people back from the dead. Happy Easter, ${targetName}!"
    )
    table.insert(
      singleRessLines,
      "I'm not saying I'm the Easter Bunny, but I did just bring ${targetName} back from the dead. Coincidence? I think not."
    )
    table.insert(
      singleRessLines,
      "I hope you're not allergic to second chances, ${targetName}. Happy Easter!"
    )
    table.insert(
      singleRessLines,
      "I might've cracked under pressure, but I'm hopping right back—happy Easter!"
    )
    table.insert(
      singleRessLines,
      "Egg-stra! Egg-stra! Read all about it—my resurrection is as colorful as those hidden eggs!"
    )
  end

  local pickedLine = singleRessLines[fastrandom(1, #singleRessLines)]

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
