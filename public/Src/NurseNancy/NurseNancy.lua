-- init
NurseNancy.NurseNancy = {}
local feature = "NurseNancy"

local function str_to_bool(str)
  if str == nil then
    return false
  end
  return string.lower(str) == "true"
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

  -- LFD/LFR/battleground groups talk through instance chat.
  if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
    if not (canBroadcastToInstance == true) then
      return nil
    end

    if IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
      return canBroadcastToRaid and "INSTANCE_CHAT" or nil
    end

    return canBroadcastToParty and "INSTANCE_CHAT" or nil
  end

  if IsInRaid() then
    return canBroadcastToRaid and "RAID" or nil
  end

  if IsInGroup() then
    return canBroadcastToParty and "PARTY" or nil
  end

  return nil
end

local function determineChannel(feature)
  if (feature == "selfRess") then
    return getBroadcastChannel(NurseNancyVars.selfRess_channel, NurseNancyVars.selfRess_instance)
  end

  if (feature == "massRess") then
    return getBroadcastChannel(NurseNancyVars.massRess_channel, NurseNancyVars.massRess_instance)
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

  return false
end

function NurseNancy.NurseNancy.Run()
  local frame = CreateFrame("Frame")
  NurseNancy.NurseNancy.Frame = frame

  -- Midnight (12.0): the player's own spellcasts are explicitly non-secret, even in combat,
  -- so we can keep reacting to them. RegisterUnitEvent restricts the events to the player.
  -- UNIT_SPELLCAST_START only fires for spells with a cast time; UNIT_SPELLCAST_SUCCEEDED
  -- catches the instant ones (Raise Ally, Reincarnation, soulstone self-ress).
  -- UNIT_SPELLCAST_SENT still exists but its target parameter may be a secret value now,
  -- so it is registered defensively and only used when the name is actually readable.
  -- "pet" is included for pet-cast resurrections (hunter Stone Hound's Eternal Guardian);
  -- units controlled by the player are non-secret in Midnight too.
  pcall(frame.RegisterUnitEvent, frame, "UNIT_SPELLCAST_SENT", "player")
  frame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player", "pet")
  frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player", "pet")

  local lastSentTargetName, lastSentCastGUID
  local lastAnnouncedKey, lastAnnouncedTime = nil, 0

  local function resolveTargetGUID(castGUID)
    -- Target name captured from UNIT_SPELLCAST_SENT (covers click-casting on raid frames).
    if (lastSentTargetName and (castGUID == nil or lastSentCastGUID == nil or castGUID == lastSentCastGUID)) then
      local ok, guid = pcall(UnitGUID, lastSentTargetName)
      if (ok and guid) then
        return guid
      end
    end

    if (UnitExists("mouseover") and UnitIsPlayer("mouseover") and UnitIsFriend(
      "player",
      "mouseover"
    ) and UnitIsDeadOrGhost("mouseover")) then
      return UnitGUID("mouseover")
    end

    if (UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target")) then
      return UnitGUID("target")
    end

    return UnitGUID("player")
  end

  local function announceRess(castGUID, spellID)
    local ressType
    if NurseNancy.SpellIds.isMassRess(spellID) then
      ressType = "massRess"
    elseif NurseNancy.SpellIds.isCombatRess(spellID) then
      ressType = "combatRess"
    elseif NurseNancy.SpellIds.isSingleRess(spellID) then
      ressType = "singleRess"
    elseif NurseNancy.SpellIds.isSelfRess(spellID) then
      ressType = "selfRess"
    end

    if not ressType then return end

    -- A spell with a cast time fires START and then SUCCEEDED for the same cast;
    -- announce it only once.
    local dedupeKey = castGUID or ("spell:" .. tostring(spellID))
    if (dedupeKey == lastAnnouncedKey and (GetTime() - lastAnnouncedTime) < 10) then return end

    local channel = determineChannel(ressType)
    if not channel then
      debugPrint(
        feature,
        "No broadcast channel for " .. ressType .. " (not in a group, or channel disabled in /nn)."
      )
      return
    end

    local targetGUID = resolveTargetGUID(castGUID)

    -- pcall keeps Midnight's secret-value restrictions from throwing Lua errors mid-fight;
    -- worst case the announcement is skipped.
    -- Retry up to 5 times if the generated line exceeds the 254-char chat limit.
    local ok, line
    for _ = 1, 5 do
      ok, line = pcall(function()
        if (ressType == "massRess") then
          return NurseNancy.NurseNancy.speakMassRess()
        elseif (ressType == "combatRess") then
          return NurseNancy.NurseNancy.speakCombatRess(targetGUID, spellID)
        elseif (ressType == "singleRess") then
          return NurseNancy.NurseNancy.speakSingleRess(targetGUID, spellID)
        end

        return NurseNancy.NurseNancy.speakSelfRess(targetGUID, spellID)
      end)

      if ok and type(line) == "string" and #line <= 245 then
        break
      end
      line = nil
    end

    if (not ok or type(line) ~= "string") then
      debugPrint(feature, "Could not build a line for spell " .. tostring(spellID))
      return
    end

    lastAnnouncedKey = dedupeKey
    lastAnnouncedTime = GetTime()

    -- Midnight blocks addon chat during boss encounters, keystone runs and PvP matches.
    if (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown()) then
      debugPrint(feature, "Chat messaging lockdown active; skipped: " .. line)
      return
    end

    local sent = pcall(SendChatMessage, line, channel)
    debugPrint(feature, "[" .. channel .. "] " .. line .. (sent and "" or " (send failed)"))
  end

  frame:SetScript("OnEvent", function(self, event, ...)
    if not NurseNancyVars then return end

    if (not (NurseNancyVars.nurseNancyIsOn == true) and not (NurseNancyVars.debugMode == true)) then return end

    if (event == "UNIT_SPELLCAST_SENT") then
      local unitTarget, arg2, arg3 = ...
      lastSentTargetName, lastSentCastGUID = nil, nil

      -- The SENT payload changed in Midnight: the target name parameter may be gone or
      -- secret. Only keep it when it is a readable name (cast GUIDs start with "Cast-").
      pcall(function()
        if (type(arg2) == "string" and arg2 ~= "" and not arg2:find("^Cast%-")) then
          lastSentTargetName = arg2
          lastSentCastGUID = arg3
        else
          lastSentCastGUID = arg2
        end
      end)
      return
    end

    if (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED") then
      local unitTarget, castGUID, spellID = ...

      if (not (unitTarget == "player" or unitTarget == "pet") or not spellID) then return end

      announceRess(castGUID, spellID)
    end
  end)
end

NurseNancy.NurseNancy.Run()
