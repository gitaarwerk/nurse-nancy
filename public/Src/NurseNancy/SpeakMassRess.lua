function NurseNancy.NurseNancy.speakMassRess()
  local pickedLine
  local prefix = NurseNancyVars.usePrefix == true and "[Mass ressing]: " or ""
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

  local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
  local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)
  local boyGirl = "girl"
  local oppositeSex = "guys"

  if (playerGender == "male") then
    oppositeSex = "girls"
    boyGirl = "boy"
  end

  local zoneName = GetZoneText()

  local massRessLines = {
    "Go go gadget, RESSURECTION!",
    "A little less conversation, a little more action, please. All this resurrection ain't satisfactioning me",
    "Come to ${zoneName} with us they said, it will be fun, they said",
    "Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo! Wee-ooo... that's the best ambulance impression I can do.", -- Sueyen-Talnivarr, EU
    "Oh hello juicy corpses.... Your bodies are still warm... hmmmm... hmm.",
    "Death is the wish of some, the relief of many, and just a chore for me... *sigh*.",
    "The goal of all life is death...and getting resurrected by yours truly.",
    "We all die. The goal isn't to live forever, the goal is to get epics.",
    "I've always ressed, and I'm going to continue to ress. And that's the way it is.",
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
    "There are far, far better things ahead than I could leave behind, if it only wasn't for the smell of your corpses.",
    "Look alive, chaps!", -- Some British bloke.
    "Excuse me, everyone, it is time to resume our scheduled awkwardness.",
    "Quickly, everyone back, before the authorities figure out what happened!",
    "Please return to your seats, I am about to make things weird again.",
    "The countdown has begun, you have exactly ten seconds to return to your seat.",
    "You're all not getting off this easy. Back to cleaning dishes!",
    "Now is not the time to hate yourself.",
    "Phase Two has been initiated prematurely. Please return to your designated floor tiles before the room fills with liquid corporate regret.",
    "I'm not the messiah, I'm just a very naughty ${boyGirl}.",
    "Gather around, my children!, let me explain it to you one more time...",
    "Don't worry about zombies, they only eat brains.",
    "When you connect to the silence within you, that is when you can make sense of the disturbance going on around you. Or it means that you're all dead...",
    "Hoping not to confuse this spell with mass necromancy... oh well, if you had brains, you wouldn't have died anyways.",
    "Oh dear, here we go again... resurrecting EVERYONE, ... AGAIN!",
    "What is ${playerName} gonna do now, buddy? oh, well, I guess I should start getting you all up.",
    "I have a morbid interest in all of your bodies..., but I want to tell y'all my problems too,.. hmm, what to do....fine, ill ress,.. again!",
    "Roses are red, your corpses are blue, I'm incredible bored, by all of you.",
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
    "Look at all these sleeping beauties! Time for a group wake-up call.",
    "Alright, everybody back in the pool!",
  }

  if (playerRace == "Dracthyr") then
    table.insert(massRessLines, "My fellow teamies drop faster than I shed my scales.")
  end

  if (playerRace == Race.Elf or playerRace == Race.BloodElf or playerRace == Race.Nightborne) then
    table.insert(
      massRessLines,
      "Elves, please pause your 900-year skincare routine. Your cheekbones are reflecting the boss mechanics and it is distracting the rest of the meat shields."
    )
  end

  if (playerRace == Race.Dwarf or playerRace == Race.Earthen or playerRace == Race.DarkIronDwarf) then
    table.insert(
      massRessLines,
      "Dwarves, put down the liquid bread and step away from the rocks. Your tiny legs need a three-minute head start just to walk to the starting position."
    )
  end

  if (playerRace == Race.Orc or playerRace == Race.MagharOrc) then
    table.insert(
      massRessLines,
      "Orcs, please stop biting the scenery. We know you are hungry for battle, but the pillars are structurally necessary for our failure."
    )
  end

  if (playerRace == Race.Undead or playerRace == Race.Scourge) then
    table.insert(
      massRessLines,
      "Undead players, please collect any limbs you dropped during the break and glue them back on. We need you fully assembled for the slaughter."
    )
  end

  if (playerRace == Race.Human or playerRace == Race.KulTiran) then
    table.insert(
      massRessLines,
      "Humans, please cease your agonizingly average behavior. Your lack of glowing eyes or horns is bringing down the visual aesthetic of this tragedy."
    )
  end

  if (playerClass == "Priest") then
    table.insert(
      massRessLines,
      "All right, people, listen up! The afterlife is overrated, so I'm giving you all a second chance. Don't waste it!"
    )

    table.insert(
      massRessLines,
      "While you're all taking a break, I will tell you about the word of ${playerName}."
    )

    table.insert(
      massRessLines,
      "You're welcome for bringing you back from the dead. Just make sure to send a thank-you card or something... or, you know, donate to my holy order."
    )
    table.insert(
      massRessLines,
      "I'm pretty sure my parents didn't think 'mass resurrection' would be part of my job description when they sent me to seminary."
    )
  end

  if (playerClass == "Paladin") then
    table.insert(
      massRessLines,
      "Arise, champions of the Light! And by 'champions' I mean 'people who stood in the fire and died... again.'"
    )
    table.insert(
      massRessLines,
      "I'm starting to think that 'resurrection' is just a fancy word for 'you owe me one.'"
    )
  end

  -- eastern
  if (d.month == 4 and d.day == 4) then
    table.insert(
      massRessLines,
      "Easter's not over yet, ${playerName}! Time to bring everyone back from the dead!"
    )
    table.insert(massRessLines, "Rise and shine, everyone! The Easter bunny has nothing on me!")
    table.insert(
      massRessLines,
      "Easter may be over, but the resurrection party is just getting started!"
    )
    table.insert(
      massRessLines,
      "The Easter bunny may have hidden the eggs, but I'm the one bringing everyone back from the dead!"
    )
    table.insert(
      massRessLines,
      "Easter may be a time for new beginnings, but I'm pretty sure this is the first time anyone's been resurrected on Easter!"
    )
  end

  -- christmas
  if (d.month == 12 and (d.day == 25 or d.day == 26)) then
    table.insert(massRessLines, "Merry Christmas, everyone! Here's your gift: life!")
    table.insert(massRessLines, "Everyone's being called for Christmas dinner! Get up!")
    table.insert(
      massRessLines,
      "Santa's not the only one who can bring people back from the dead. Merry Christmas, everyone!"
    )
  end

  pickedLine = massRessLines[fastrandom(1, #massRessLines)]

  return NurseNancy.Helpers.parseText(prefix .. pickedLine, {
    playerName = playerName,
    playerGender = playerGender,
    playerClass = playerClass,
    playerRace = playerRace,
    playerLevel = playerLevel,
    playerManWoman = playerManWoman,
    playerGuyGirl = playerGuyGirl,
    oppositeSex = oppositeSex,
    zoneName = zoneName,
    boyGirl = boyGirl,
  })
end
