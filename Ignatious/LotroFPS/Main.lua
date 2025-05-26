---- Class Related Notes
-- Captain, skills work great, timing could be tweaked but transitions feel good.
-- Minstrel, the constant attack animation during combat makes the transition to range attacks rather jarring.
-- Mariner, untested.

---------------------------------------------------------------------------------------------------
-------- Imports ----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

---------------------------------------------------------------------------------------------------
-------- Misc Variables ---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
local Main = {} -- Defines the module locally.

local combatState;
    local isInMelee = false;
    local isInRanged = false;
local isIdling = true;
local idleReset = false;
local isStriking = false;
local isWaving = false;
local isShouting = false;
local isShoutingB = false;
local isParrying = false;
local isSmoking = false;
local isAttackingA = false;
local isStabbing = false;
local isPointing = false;
local isPunching = false;
local isHorning = false;
local isLuting = false;
local isLuteAttacking = false;
local isMounted = false;
    local mountChecked = false;
    local isRiding = false;

-- For RGB Testing, or for testing to Change color based on skill being used  (Change to Green when healing for instance)
local colorHeal = Turbine.UI.Color(0.5,0.04,0.41,0.09);

local timerTen = 0;
local timerEnd = 11;
local timerM = 0;
local timerMEnd = 11;
ResourceDir = "Ignatious/LotroFPS/Resources/";
thePlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
--playerClass = thePlayer:GetClass();
--allSkills = thePlayer:GetTrainedSkills();
playerName = Turbine.Gameplay.LocalPlayer.GetName();
playerMount = thePlayer:GetMount();
playerClass = thePlayer:GetClass();

Turbine.Shell.WriteLine("Lotro FPS Loaded!");

---------------------------------------------------------------------------------------------------
-------- Identifying Player States ----------------------------------------------------------------
---------------------------------------------------------------------------------------------------
function Main.getPlayerState()
    if thePlayer:IsInCombat() then
        combatState = thePlayer:IsInCombat();
        Turbine.Shell.WriteLine("The player has entered combat!");
        isIdling = false;
        isStriking = true;
        isWaving = false;
        isShouting = false;
        isSmoking = false;
    else
        combatState = thePlayer:IsInCombat();
        Turbine.Shell.WriteLine("The player is not in combat!");
        isStriking = false;
        isIdling = true;
    end
    if playerMount == nil then
		-- Not mounted
        isMounted = false;
        mountChecked = false;
        Turbine.Shell.WriteLine("The player is not mounted!");
	else
		-- Mounted 
        isMounted = true;
        Turbine.Shell.WriteLine("The player is mounted!");
    end
end

---------------------------------------------------------------------------------------------------
-------- Parsing Chat (English) -------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
----- The below table is currently unused
----- If the table could replace the many if statements below when identifying emotes
----- Then it could simply say if index# <>= #'s to reduce the number of read lines to
----- a maximum of 3 per emote animation, they are organized by animation for this reason
detectEmote = {
[1] = {"You need assistance";}; ---------- wave <-- the animation to be played
[2] = {"You decide to assist";}; --------- wave done
[3] = {"You try to bother";}; ------------ wave done
[4] = {"You wave";}; --------------------- wave done
[5] = {"follow";}; ----------------------- wave done
[6] = {"You hail";}; --------------------- wave done
[7] = {"You get angry";}; ---------------- shout done
[8] = {"You are angry";}; ---------------- shout done
[9] = {"It is time to attack";}; --------- shout done
[10] = {"You want to attack";}; ---------- shout done
[11] = {"You want to start a fight!";}; -- shout done
[12] = {"You are ready to fight";}; ------ shout done
[13] = {"You flex";}; -------------------- shout done
[14] = {"You roar your challenge";}; ----- shout done
[15] = {"You challenge";}; --------------- shout done
[16] = {"You start to charge";}; --------- shout done
[17] = {"ROAR";}; ------------------------ shout done
[18] = {"shake your fist";}; ------------- shout done
[19] = {"You cheer";}; ------------------- shout done
[21] = {"You yawn at";}; ----------------- shout B done
[22] = {"You fidget";}; ------------------ shout B done
[23] = {"fidget nervously";}; ------------ shout B done
[24] = {"You look";}; -------------------- shout B done
[25] = {"You mumble";}; ------------------ shout B done
[26] = {"You laugh";}; ------------------- shout B done
[27] = {"You shrug";}; ------------------- shout B done
[28] = {"You chatter away";}; ------------ shout B done
[29] = {"You talk with";}; --------------- shout B done
[30] = {"You beckon to";}; --------------- beg
[31] = {"You beg";}; --------------------- beg
[32] = {"You clap";}; -------------------- clap
[33] = {"You dance";}; ------------------- dance
[34] = {"You begin dancing";}; ----------- dance
[35] = {"You drink";}; ------------------- drink
[36] = {"You have a little bite";}; ------ eat
[37] = {"You peer";}; -------------------- salute
[38] = {"salute";}; ---------------------- salute
[39] = {"You point";}; ------------------- point done
[40] = {"You poke";}; -------------------- point done
[41] = {"scold";}; ----------------------- point done
[42] = {"You order your companion";}; ---- point done
[43] = {"You begin to smoke";}; ---------- smoke done
}

----- Parsing Definitions -----
getRawText = Turbine.UI.Label();
getRawText:SetMarkupEnabled(true);

function GetRawText(textWithMarkup)
    getRawText:SetText(textWithMarkup);
    return getRawText:GetText();
end

Turbine.Chat.Received = function(sender, args)
    if (args.ChatType == Turbine.ChatType.PlayerCombat or
        args.ChatType == Turbine.ChatType.Emote or
        args.ChatType == Turbine.ChatType.Death) then

        local textWithoutMarkup = GetRawText(args.Message);
        ------- Ability Switch --------
        -------------------------------
        ---I would prefer to parse only exceptions and to identify skill by type, playing an animation
        ---designated for that skill type
        ---a current bug is the first skill used is overridden by the striking animation initiating
        ---a condition needs to be added for "critical hit" and "devastating hit"
        ---same for critical heals/buffs etc...
        local findSkillResults = string.find(textWithoutMarkup, playerName .. " applied a benefit"); 
        if (findSkillResults ~= nil) then
            local whichSkill = findSkillResults;
            -------- Parrying ---------
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Call to Arms") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Call to Arms!");
                isHorning = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Rallying Cry") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Rallying Cry!");
                isShouting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Words of Courage") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Words of Courage!");
                isShouting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Motivating Speech") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Motivating Speech!");
                isShouting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Make Haste") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Make Haste!");
                isHorning = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Shield") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Shield-Brother!");
                isPointing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Inspiriting Call") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Inspiriting Call!");
                isPointing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Cry of Vengeance") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Cry of Vengeance!");
                isPointing = true;
                Main.handInterface()
            end
            -- Mariner
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with En Garde") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used En Garde!");
                isPointing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Shanty") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Shanty!");
                isShouting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Sea Legs") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Sea Legs!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Belly of Brine") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Belly of Brine!");
                isHorning = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Re-centre") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Re-centre!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Blade Shield") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Blade Shield!");
                isParrying = true;
                Main.handInterface()
            end
            ------- Minstrel -------
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Minor Ballad") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used a Minor Ballad!");
                isLuting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Major Ballad") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used a Major Ballad!");
                isLuting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, playerName .. " applied a benefit with Raise the Spirit") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Raise the Spirit!");
                isLuting = true;
                Main.handInterface()
            end
        end
        local findSkillResults = string.find(textWithoutMarkup, playerName .. " scored a hit"); 
        if (findSkillResults ~= nil) then
            local whichSkill = findSkillResults;
            -- Identifies that the player has now entered melee combat
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with a melee attack") then
                Turbine.Shell.WriteLine("The player has entered melee combat!");
                isInMelee = true;
                Main.handInterface()
            end
            ------- Captain -------
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Battle") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you are screaming with Battle-Cry!");
                isShouting = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Routing Cry") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Routing Cry!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Sure Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Sure Strike!");
                isAttackingA = true;
                Main.handInterface()
            end
            -- DOT affect that does not work well with the code
            --if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Cutting Attack") then
            --    Turbine.Shell.WriteLine("Lotro FPS detected that you used Cutting Attack!");
            --    isAttackingA = true;
            --    Main.handInterface()
            --end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Devastating Blow") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Devastating Blow!");
                isPunching = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Valiant Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Valiant Strike!");
                isStabbing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Blade of Elendil") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Blade of Elendil!");
                isStabbing = true;
                Main.handInterface()
            end
            ------- Mariner -------
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Thrust") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Thrust!");
                isStabbing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Riposte") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Riposte!");
                isStabbing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Advance") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Advance!");
                isAttackingA = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Aggressive Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Aggressive Strike!");
                isAttackingA = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Lunge") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Lunge!");
                isStabbing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Dramatic Flourish") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Dramatic Flourish!");
                isAttackingA = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Draining Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Draining Strike!");
                isStabbing = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Flèche") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Draining Flèche!");
                isStabbing = true;
                Main.handInterface()
            end
            ------- Minstrel Ranged -------
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Minor Ballad") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used a Minor Ballad!");
                isLuteAttacking = true;
                isInMelee = false;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Major Ballad") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used a Major Ballad!");
                isLuteAttacking = true;
                isInMelee = false;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Coda of Fury") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Coda of Fury!");
                isLuting = true;
                isInMelee = false;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Coda of Melody") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Coda of Melody!");
                isLuting = true;
                isInMelee = false;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Piercing Cry") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you are screaming with Piercing Cr!");
                isShouting = true;
                isInMelee = false;
                Main.handInterface()
            end
            ------- Minstrel Melee -------
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Healer's Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Healer's Strike!");
                isAttackingA = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Hero's Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Hero's Strike!");
                isAttackingA = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Dissonant Strike") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Dissonant Strike!");
                isAttackingA = true;
                Main.handInterface()
            end
        end
        -------- Emote Switch ---------
        -------------------------------
        local findEmoteResults = string.find(textWithoutMarkup, "You");
        if (findEmoteResults ~= nil) then
            local whichEmote = findEmoteResults;
            -------- /Bored resets to Idle animation ---------
            if whichEmote == string.find(textWithoutMarkup, "You look bored") then
                Turbine.Shell.WriteLine("Resetting to Idle!");
                isWaving = false;
                idleReset = true;
                Main.getPlayerState();
                Main.animateState();
                Main.handInterface();
            end
            -------- Waving Emotes ---------
            if whichEmote == string.find(textWithoutMarkup, "You wave") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you waving!");
                isWaving = true;
                local timerTen = 0;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You need assistance") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you waving!");
                isWaving = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You decide to assist") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you waving!");
                isWaving = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You try to bother") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you waving!");
                isWaving = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You follow") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you waving!");
                isWaving = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You hail") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you waving!");
                isWaving = true;
                Main.handInterface()
            end
            -------- Shout Emotes ---------
            if whichEmote == string.find(textWithoutMarkup, "You get angry") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You want to start a fight") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You are ready to fight") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You flex") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You roar") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You start to charge") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You let out a mighty") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You shake your fist") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You cheer") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting!");
                isShouting = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You yawn at") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You fidget") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You look") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You peer") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You mumble") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You laugh") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You shrug") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You chatter") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You talk") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you shouting alternate!");
                isShoutingB = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You point") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you're pointing!");
                isPointing = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You poke") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you're pointing!");
                isPointing = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You scold") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you're pointing!");
                isPointing = true;
                Main.handInterface()
            end
            if whichEmote == string.find(textWithoutMarkup, "You order your companion") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you're pointing!");
                isPointing = true;
                Main.handInterface()
            end
            -------- Smoke Emotes ---------
            if whichEmote == string.find(textWithoutMarkup, "You begin to smoke") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you are smoking!");
                isSmoking = true;
                Main.handInterface()
            end
        end
        ------ Parry/Block/Evade ------
        -------------------------------
        local findSkillResults = string.find(textWithoutMarkup, "You"); 
        -- Need to figure out how to capture the above correctly, you is probably not sufficient like with emotes.
        -- No idea if this works as my main is a level 23 captain.
        if (findSkillResults ~= nil) then
            local whichSkill = findSkillResults;
            -------- Parrying ---------
            if whichSkill == string.find(textWithoutMarkup, "parry") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you parrying!");
                isParrying = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, "block") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you parrying!");
                isParrying = true;
                Main.handInterface()
            end
            if whichSkill == string.find(textWithoutMarkup, "evade") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you parrying!");
                isParrying = true;
                Main.handInterface()
            end
        end
        -------- Item Switch ----------
        -------------------------------
        ---As in the above, will be used to switch the state of isUsingItem or whatever
    end
end

---------------------------------------------------------------------------------------------------
-------- Frame Structure --------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
    ChainIdleFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "DefaultFrame.tga"); ["TIME"] = 3.5; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle1.tga"); ["TIME"] = 0.225; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle2.tga"); ["TIME"] = 0.225; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle3.tga"); ["TIME"] = 0.225; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle4.tga"); ["TIME"] = 0.225; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle5.tga"); ["TIME"] = 0.225; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle6.tga"); ["TIME"] = 0.15; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle7.tga"); ["TIME"] = 0.15; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle8.tga"); ["TIME"] = 0.15; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Idle9.tga"); ["TIME"] = 0.2; };
    }
    ChainStrikeFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "DefaultFrame.tga"); ["TIME"] = .1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike2.tga"); ["TIME"] = 0.025; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike3.tga"); ["TIME"] = 0.05; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike4.tga"); ["TIME"] = 0.025; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike5.tga"); ["TIME"] = 0.05; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike6.tga"); ["TIME"] = 0.05; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike78.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike78.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Strike9.tga"); ["TIME"] = 0.1; };
    }
    ChainWaveFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "DefaultFrame.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave3.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave4.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave6.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave9.tga"); ["TIME"] = 0.15; };
    }
    ChainsShoutFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout4.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout6.tga"); ["TIME"] = 0.25; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout7.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout9.tga"); ["TIME"] = 0.1; };
    }
    ChainShoutBFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB4.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB6.tga"); ["TIME"] = 0.25; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB7.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB9.tga"); ["TIME"] = 0.1; };
    }
    ChainPipeFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "PipeDefault.tga"); ["TIME"] = 1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe1.tga"); ["TIME"] = 0.15; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe2.tga"); ["TIME"] = 0.15; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe3.tga"); ["TIME"] = 0.15; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe4.tga"); ["TIME"] = 0.3; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe5.tga"); ["TIME"] = 0.2 };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe6.tga"); ["TIME"] = 0.4; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe7.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe8.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Pipe9.tga"); ["TIME"] = 0.2; };
    }
    ChainParryFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry4.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry6.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry9.tga"); ["TIME"] = 0.1; };
    }
    ChainIsAttackingAFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA2.tga"); ["TIME"] = 0.15; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA3.tga"); ["TIME"] = 0; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA4.tga"); ["TIME"] = 0.05; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA5.tga"); ["TIME"] = 0.05; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA6.tga"); ["TIME"] = 0.05; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA8.tga"); ["TIME"] = 0.05; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA9.tga"); ["TIME"] = 0.05; };
    }
    ChainStabFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab2.tga"); ["TIME"] = 0.05; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab3.tga"); ["TIME"] = 0.05; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab4.tga"); ["TIME"] = 0; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab6.tga"); ["TIME"] = 0.1; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab9.tga"); ["TIME"] = 0.15; };
    }
    ChainPointFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point4.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point6.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point9.tga"); ["TIME"] = 0.1; };
    }
    ChainPunchFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch1.tga"); ["TIME"] = 0; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch2.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch4.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch5.tga"); ["TIME"] = 0.1; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch6.tga"); ["TIME"] = 0.1; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch8.tga"); ["TIME"] = 0; };
    }
    ChainHornFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn1.tga"); ["TIME"] = 0.075; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn2.tga"); ["TIME"] = 0.075; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn3.tga"); ["TIME"] = 0.075; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn4.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn5.tga"); ["TIME"] = 0.25; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn6.tga"); ["TIME"] = 0.3; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn7.tga"); ["TIME"] = 0.3; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn8.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn9.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horn10.tga"); ["TIME"] = 0.1; };
    }
    ChainLuteFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute1.tga"); ["TIME"] = 0.1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute2.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute3.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute4.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute5.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute6.tga"); ["TIME"] = 0.1; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute7.tga"); ["TIME"] = 0.1; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute8.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute9.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Lute9.tga"); ["TIME"] = 0.1; };
    }
    ChainLuteStrikeFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike1.tga"); ["TIME"] = 0.1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike2.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike3.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike4.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike5.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike6.tga"); ["TIME"] = 0.1; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike7.tga"); ["TIME"] = 0.1; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike8.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike9.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "LuteStrike9.tga"); ["TIME"] = 0.1; };
    }
    ---------------------------------------------------------------------------------------------------
    -------- Horse Default ----------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
    HorseFrames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse1.tga"); ["TIME"] = .15; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse2.tga"); ["TIME"] = 0.2; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse3.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse4.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse5.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse6.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse7.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse8.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse9.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Horse1.tga"); ["TIME"] = 0.15; };
    }

---------------------------------------------------------------------------------------------------
-------- Animating Player BASE States -------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---Other potential base states include; instruments, ...
function Main.animateState()
        -- Idling should be true when every other state is false.
    if isIdling == true then
        Frames = ChainIdleFrames
        return Main
    end
    -- isStriking has conditions for ranged classes to determine whether they should be playing the melee loop
    if isStriking == true then
        if playerClass == 31 then -- 31 = Minstrel
            if isInMelee == true then
                Frames = ChainStrikeFrames
            return Main
            end
        else -- Non-ranged classes do not require this condition
            Frames = ChainStrikeFrames
            return Main
        end
    end
end

---------------------------------------------------------------------------------------------------
-------- Window Settings and Functions -----=====--------------------------------------------------
---------------------------------------------------------------------------------------------------
function Main.handInterface()
    ----------- Hands Interface ---------------------
    handsWindow = Turbine.UI.Window();
    handsWindow:SetSize(1414, 1075);
    handsWindow:SetWantsUpdates(true);
    -- I tried to set the parent here in an attempt to get them both to animate simultaneously.
    -- For some reason all this did was move the position of the windows
    --mountWindow:SetParent(handsWindow);
    handsWindow.frame = 10;
    handsWindow.LastUpdated = Turbine.Engine.GetGameTime();
    handsWindow.Update = function(sender, args)
        local delta = Turbine.Engine.GetGameTime() - handsWindow.LastUpdated;

        if (delta > Frames[handsWindow.frame]["TIME"]) then
            handsWindow.frame = handsWindow.frame + 1;
            if timerTen ~= 0 then
                Turbine.Shell.WriteLine("Timer Ten " .. timerTen);
            end
            if (handsWindow.frame > 10) then
                handsWindow.frame = 1;
            end
            -- load the new background image
            handsWindow:SetBackground(Frames[handsWindow.frame]["IMAGE"]);
            handsWindow.LastUpdated = Turbine.Engine.GetGameTime();
            ----------
            -- Add state logic below for window updates
            ----------
            if combatState ~= thePlayer:IsInCombat() then
                Main.getPlayerState();
                Main.animateState();
                Main.handInterface();
            end
            -- Each animation state sets idleReset back to true...
            -- The idea is that now that it is back in true, it will count up 10 frames
            -- and then reanimate the state
            -- This causes a very harsh transition due to a skip in animation
            if idleReset == true then
                if (timerTen >= timerEnd) then
                    idleReset = false;
                    timerTen = 0;
                    timerEnd = 10;
                    Main.getPlayerState();
                    Main.animateState();
                    Main.handInterface();
                    Turbine.Shell.WriteLine("idleReset is True!")
                else
                    timerTen = timerTen + 1;
                end
            end
            if isWaving == true then
                isWaving = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainWaveFrames
            end
            if isShouting == true then
                isShouting = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainsShoutFrames
            end
            if isShoutingB == true then
                isShoutingB = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainShoutBFrames
            end
            if isSmoking == true then
                isSmoking = false;
                -- Below is set to isIdling, this will cause for a state change to reset back to idle
                -- Although, the animation will still play on loop if no state change
                -- If there is a way to determine if we walk, or the emote stops playing (in 3rd person)
                -- then that would be the best way to end this, otherwise, it can loop.
                -- If there is a way to have a backup frame as defaultFrame.tga between this reload this would fix it
                -- I think
                isIdling = true;
                timerEnd = timerTen + 9;
                    Frames = ChainPipeFrames
            end
            if isParrying == true then
                isParrying = false;
                isIdling = true;
                timerEnd = timerTen + 9;
                    Frames = ChainParryFrames
            end
            if isAttackingA == true then
                isAttackingA = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainIsAttackingAFrames
            end
            if isStabbing == true then
                isStabbing = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainStabFrames
            end
            if isPointing == true then
                isPointing = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainPointFrames
            end
            if isPunching == true then
                isPunching = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainPunchFrames
            end
            if isHorning == true then
                isHorning = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainHornFrames
            end
            if isLuting == true then
                isLuting = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainLuteFrames
            end
            if isLuteAttacking == true then
                isLuteAttacking = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                    Frames = ChainLuteStrikeFrames
            end
        end
    end

----------- Mount Interface ---------------------
---- Currently works for getting on the horse, but no off the horse
--- Does not animate both windows at the same time
--- Overriding the animation with another such as an emote overrides the mount window entirely
    mountWindow = Turbine.UI.Window();
    mountWindow:SetSize(1414, 1075);
    mountWindow:SetWantsUpdates(true);
    mountWindow.frameM = 10;
    mountWindow.LastUpdated = Turbine.Engine.GetGameTime();
    mountWindow.Update = function(sender, args)
        local deltaM = Turbine.Engine.GetGameTime() - mountWindow.LastUpdated;

        if (deltaM > Frames[mountWindow.frameM]["TIME"]) then
            mountWindow.frameM = mountWindow.frameM + 1;
            if timerM ~= 0 then
                Turbine.Shell.WriteLine("Timer TenM " .. timerMEnd);
            end
            if (mountWindow.frameM > 10) then
                mountWindow.frameM = 1;
            end
            mountWindow:SetBackground(Frames[mountWindow.frameM]["IMAGE"]);
            mountWindow.LastUpdated = Turbine.Engine.GetGameTime();

            playerMount = nil;
            playerMount = thePlayer:GetMount();
            if (playerMount ~= nil) then
			    isMounted = true;
		    else
			    isMounted = false;
		    end
            if (mountChecked == false) then
                if isMounted == true then
                    mountChecked = true;
                    isRiding = true;
                        Frames = HorseFrames
                end
            else
                if (isRiding == true) then
                    if (mountChecked == true) then
                        if (isMounted == false) then
                            Main.getPlayerState();
                            Main.animateState();
                            Main.handInterface();
                            isRiding = false;
                        end
                    end
                end
            end
        end
    end

    handsWindow:SetVisible(true);
    handsWindow:SetPosition(1920 / 2 - handsWindow:GetWidth() / 2, 1080 - handsWindow:GetHeight());
    handsWindow:SetMouseVisible(0);
    handsWindow:SetZOrder(-1);

    mountWindow:SetVisible(true);
    mountWindow:SetPosition(1920 / 2 - mountWindow:GetWidth() / 2, 1080 - mountWindow:GetHeight());
    mountWindow:SetMouseVisible(0);
    mountWindow:SetZOrder(-2);
end
---------------------------------------------------------------------------------------------------
-------- End Commands (First played functions) ----------------------------------------------------
---------------------------------------------------------------------------------------------------
Main.getPlayerState();
Main.animateState();
Main.handInterface();
---------------------------------------------------------------------------------------------------
