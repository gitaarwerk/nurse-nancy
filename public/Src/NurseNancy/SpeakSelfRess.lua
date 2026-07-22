function NurseNancy.NurseNancy.speakSelfRess(_, spellId)
  local pickedLine
  local prefix = NurseNancyVars.usePrefix == true and "[Self ress]: " or ""
  local playerName, playerGender, playerClass, playerRace, playerLevel =
    NurseNancy.Helpers.GetPlayerInformation()
  local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
  local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)
  local playerHimHer = NurseNancy.Helpers.GetHimHer(playerGender)
  local zoneName = GetZoneText()
  local oppositeSex = "guys"

  local Class = AFKAnsweringMachine.Constants.Class
  local Race = AFKAnsweringMachine.Constants.Race

  -- dateFormat
  local rawTime = date("*t")
  local d = {
    day = rawTime.day,
    month = rawTime.month,
    year = rawTime.year,
  }

  if (playerGender == "male") then
    oppositeSex = "girls"
  end

  local selfRessLines =
    {
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
      "Your long national nightmare is over. I am back.",
      "Please, no flash photography, I'm just passing through.",
      "I'm back, and I brought snacks!",
      "Ha! Death can't keep me down for long!",
      "Please lower your heads in a moment of silence... I have returned.",
      "I have arrived, and I am already regretting it.",
      "Hello everyone, I am back. Please act like I was never gone.",
      "I am back! Let the awkward silence commence.",
      "I’m back. And I brought a vague sense of dread.",
      "Mission accomplished.",
      "By your powers combined, I AM CAPTAIN ${playerName}!",
      "I am back and fully operational. Please update your records.",
      "My presence is requested, and unfortunately, I have delivered.",
      "I've came back to say I'm dissapointed, that absolutely NONE of you, ate cake. Here, have some [${playerName}'s Cake]",
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
    table.insert(
      selfRessLines,
      "Like the night, I return. And I promise, no more moonlight serenades... for now."
    )
  end

  if (playerRace == "Worgen") then
    table.insert(selfRessLines, "I'm back, and hairier than ever!")
  end

  if (playerRace == "Undead") then
    table.insert(selfRessLines, "The dead can't die twice, right? Right?")
  end

  if (playerClass == "Shaman") then
    table.insert(selfRessLines, "Nobody believed in Reincarnation. Well, here's the proof!'")
    table.insert(
      selfRessLines,
      "I'm like a phoenix, rising from the ashes of my own death. Except less fiery and more wet."
    )
    table.insert(
      selfRessLines,
      "Reincarnation is great, but I'm not sure I want to come back as myself again. I mean, once was enough, am I right?"
    )
    table.insert(
      selfRessLines,
      "Reincarnating in WoW is like playing a game of Russian roulette, except instead of a bullet, you might come back as a gnome. Scary stuff."
    )
    table.insert(
      selfRessLines,
      "I hoped that when I reincarnated, I got to keep all the loot and XP I earned in my previous life. It's like a rewards program for dying."
    )
    table.insert(
      selfRessLines,
      "I heard that if you reincarnate enough times in WoW, you eventually unlock a secret achievement called 'The Immortal'. I'm still working on it."
    )
    table.insert(
      selfRessLines,
      "Well, that was a refreshing trip to the spirit world. I almost didn't want to come back!"
    )
    table.insert(
      selfRessLines,
      "I'm like a phoenix, rising from the ashes of my own death. Except less fiery and more wet."
    )
    table.insert(selfRessLines, "Death thought it had me, but the elements said 'hold my beer'.")
    table.insert(selfRessLines, "That was a real 'hold my totem' moment, but I made it work.")
    table.insert(
      selfRessLines,
      "I'm not just a Shaman, I'm a one-person resurrection army. Who needs healers anyway?"
    )
  end

  -- eastern
  if (d.month == 4 and d.day == 4) then
    table.insert(selfRessLines, "Got afraid and hid in this egg, but now i'm back!")
    table.insert(
      selfRessLines,
      "Risen like a chocolate bunny in spring—no meltdown can hold me down!"
    )
  end

  pickedLine = selfRessLines[fastrandom(1, #selfRessLines)]

  return NurseNancy.Helpers.parseText(prefix .. pickedLine, {
    playerName = playerName,
    playerGender = playerGender,
    playerClass = playerClass,
    playerRace = playerRace,
    playerLevel = playerLevel,
    playerManWoman = playerManWoman,
    playerGuyGirl = playerGuyGirl,
    playerHimHer = playerHimHer,
    oppositeSex = oppositeSex,
    zoneName = zoneName,
  })
end
