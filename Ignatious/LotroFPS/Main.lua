-- Github test
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
local timerTen = 0;
local timerEnd = 11;

RESOURCEDIR = "Ignatious/LotroFPS/Resources/";
thePlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
playerClass = thePlayer:GetClass();
allSkills = thePlayer:GetTrainedSkills();
playerName = Turbine.Gameplay.LocalPlayer.GetName();

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
        end
        local findSkillResults = string.find(textWithoutMarkup, playerName .. " scored a hit"); 
        if (findSkillResults ~= nil) then
            local whichSkill = findSkillResults;
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
            if whichSkill == string.find(textWithoutMarkup,  playerName .. " scored a hit with Cutting Attack") then
                Turbine.Shell.WriteLine("Lotro FPS detected that you used Cutting Attack!");
                isAttackingA = true;
                Main.handInterface()
            end
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
            -- Mariner --
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
-------- Animating Player BASE States -------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---Other potential base states include; instruments, ...
function Main.animateState()
        -- Idling should be true when every other state is false.
    if isIdling == true then
        Frames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "DefaultFrame.tga"); ["TIME"] = 3.5; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle1.tga"); ["TIME"] = 0.225; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle2.tga"); ["TIME"] = 0.225; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle3.tga"); ["TIME"] = 0.225; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle4.tga"); ["TIME"] = 0.225; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle5.tga"); ["TIME"] = 0.225; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle6.tga"); ["TIME"] = 0.15; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle7.tga"); ["TIME"] = 0.15; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle8.tga"); ["TIME"] = 0.15; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Idle9.tga"); ["TIME"] = 0.2; };
        }
        return Main
    end
    if isStriking == true then
        Frames = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "DefaultFrame.tga"); ["TIME"] = .1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike2.tga"); ["TIME"] = 0.025; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike3.tga"); ["TIME"] = 0.05; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike4.tga"); ["TIME"] = 0.025; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike5.tga"); ["TIME"] = 0.05; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike6.tga"); ["TIME"] = 0.05; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike78.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike78.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Strike9.tga"); ["TIME"] = 0.1; };
        }
        return Main
    end
end

---------------------------------------------------------------------------------------------------
-------- Hands Window Settings and function -------------------------------------------------------
---------------------------------------------------------------------------------------------------

function Main.handInterface()
    handsWindow = Turbine.UI.Window();
    handsWindow:SetSize(1414, 1075);
    handsWindow:SetWantsUpdates(true);
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
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "DefaultFrame.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave2.tga"); ["TIME"] = 0.1; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave3.tga"); ["TIME"] = 0.2; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave4.tga"); ["TIME"] = 0.2; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave5.tga"); ["TIME"] = 0.2; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave6.tga"); ["TIME"] = 0.2; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave7.tga"); ["TIME"] = 0.1; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave8.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Wave9.tga"); ["TIME"] = 0.15; };
                }
            end
            if isShouting == true then
                isShouting = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout2.tga"); ["TIME"] = 0.1; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout3.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout4.tga"); ["TIME"] = 0.1; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout5.tga"); ["TIME"] = 0.2; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout6.tga"); ["TIME"] = 0.25; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout7.tga"); ["TIME"] = 0.2; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout8.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Shout9.tga"); ["TIME"] = 0.1; };
                }
            end
            if isShoutingB == true then
                isShoutingB = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB2.tga"); ["TIME"] = 0.1; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB3.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB4.tga"); ["TIME"] = 0.1; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB5.tga"); ["TIME"] = 0.2; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB6.tga"); ["TIME"] = 0.25; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB7.tga"); ["TIME"] = 0.2; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB8.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "ShoutB9.tga"); ["TIME"] = 0.1; };
                }
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
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "PipeDefault.tga"); ["TIME"] = 1; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe1.tga"); ["TIME"] = 0.15; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe2.tga"); ["TIME"] = 0.15; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe3.tga"); ["TIME"] = 0.15; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe4.tga"); ["TIME"] = 0.3; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe5.tga"); ["TIME"] = 0.2 };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe6.tga"); ["TIME"] = 0.4; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe7.tga"); ["TIME"] = 0.2; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe8.tga"); ["TIME"] = 0.2; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Pipe9.tga"); ["TIME"] = 0.2; };
                }
            end
            if isParrying == true then
                isParrying = false;
                isIdling = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry2.tga"); ["TIME"] = 0.1; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry3.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry4.tga"); ["TIME"] = 0.2; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry5.tga"); ["TIME"] = 0.2; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry6.tga"); ["TIME"] = 0.2; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry7.tga"); ["TIME"] = 0.1; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry8.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Parry9.tga"); ["TIME"] = 0.1; };
                }
            end
            if isAttackingA == true then
                isAttackingA = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA2.tga"); ["TIME"] = 0.15; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA3.tga"); ["TIME"] = 0; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA4.tga"); ["TIME"] = 0.05; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA5.tga"); ["TIME"] = 0.05; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA6.tga"); ["TIME"] = 0.05; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA7.tga"); ["TIME"] = 0.1; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA8.tga"); ["TIME"] = 0.05; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "AttackA9.tga"); ["TIME"] = 0.05; };
                }
            end
            if isStabbing == true then
                isStabbing = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab2.tga"); ["TIME"] = 0.1; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab3.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab4.tga"); ["TIME"] = 0; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab5.tga"); ["TIME"] = 0.2; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab6.tga"); ["TIME"] = 0.2; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab7.tga"); ["TIME"] = 0.15; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab8.tga"); ["TIME"] = 0.15; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Stab9.tga"); ["TIME"] = 0.15; };
                }
            end
            if isPointing == true then
                isPointing = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point2.tga"); ["TIME"] = 0.1; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point3.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point4.tga"); ["TIME"] = 0.2; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point5.tga"); ["TIME"] = 0.2; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point6.tga"); ["TIME"] = 0.2; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point7.tga"); ["TIME"] = 0.1; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point8.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Point9.tga"); ["TIME"] = 0.1; };
                }
            end
            if isPunching == true then
                isPunching = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch1.tga"); ["TIME"] = 0; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch1.tga"); ["TIME"] = 0.1; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch2.tga"); ["TIME"] = 0.2; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch3.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch4.tga"); ["TIME"] = 0.1; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch5.tga"); ["TIME"] = 0.1; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch6.tga"); ["TIME"] = 0.1; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch7.tga"); ["TIME"] = 0.1; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch8.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Punch8.tga"); ["TIME"] = 0; };
                }
            end
            if isHorning == true then
                isHorning = false;
                idleReset = true;
                timerEnd = timerTen + 9;
                Frames = {
                    [1] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn1.tga"); ["TIME"] = 0.06; };
                    [2] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn2.tga"); ["TIME"] = 0.06; };
                    [3] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn3.tga"); ["TIME"] = 0.06; };
                    [4] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn4.tga"); ["TIME"] = 0.1; };
                    [5] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn5.tga"); ["TIME"] = 0.3; };
                    [6] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn6.tga"); ["TIME"] = 0.3; };
                    [7] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn7.tga"); ["TIME"] = 0.3; };
                    [8] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn8.tga"); ["TIME"] = 0.1; };
                    [9] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn9.tga"); ["TIME"] = 0.1; };
                    [10] = { ["IMAGE"] = Turbine.UI.Graphic(RESOURCEDIR .. "Horn10.tga"); ["TIME"] = 0.1; };
                }
            end
        end
    end
    handsWindow:SetVisible(true);
    handsWindow:SetPosition(1920 / 2 - handsWindow:GetWidth() / 2, 1080 - handsWindow:GetHeight());
    handsWindow:SetMouseVisible(0);
    handsWindow:SetZOrder(-1);
end
---------------------------------------------------------------------------------------------------
-------- End Commands (First played functions) ----------------------------------------------------
---------------------------------------------------------------------------------------------------
Main.getPlayerState();
Main.animateState();
Main.handInterface();
---------------------------------------------------------------------------------------------------
