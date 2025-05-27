-- Damage/Heal over time skills have been excluded due to duplicate chat logs.

import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

thePlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
playerName = Turbine.Gameplay.LocalPlayer.GetName();

Turbine.Shell.WriteLine("ChatStrings Loaded!");

ChatStrings = {
	GetState = function(haystack)
		for state,chatStringTable in pairs(chatStrings) do
			for _,chatString in pairs(chatStringTable) do
				if string.find(haystack, chatString) then
					return state
				end
			end 
		end 
	end
}

local chatStrings = {
	isWaving = {
		"You need assistance",
		"You decide to assist",
		"You try to bother",
		"You wave",
		"follow",
		"You hail",
	},
	isHorning = {
		playerName .. " a benefit with Call to Arms",
		playerName .. " applied a benefit with Make Haste",
		playerName .. " applied a benefit with Belly of Brine",
	},
	isShouting = {
		"You get angry",
		"You are angry",
		"It is time to attack",
		"You want to attack",
		"You want to start a fight!",
		"You are ready to fight",
		"You flex",
		"You roar your challenge",
		"You challenge",
		"You start to charge",
		"ROAR",
		"shake your fist",
		"You cheer",
		playerName .. " applied a benefit with Rallying Cry",
		playerName .. " applied a benefit with Words of Courage",
		playerName .. " applied a benefit with Motivating Speech",
		playerName .. " applied a benefit with Shanty",
		playerName .. " scored a hit with Battle",
	},
	isShoutingB = {
		playerName .. " applied a benefit with Sea Legs",
		playerName .. " applied a benefit with Re-centre",

		playerName .. " scored a hit with Routing Cry",

		"You yawn at",
		"You fidget",
		"fidget nervously",
		"You look",
		"You mumble",
		"You laugh",
		"You shrug",
		"You chatter away",
		"You talk with",
	},
	isAttackingA = {
		playerName .. " scored a hit with Sure Strike",
		playerName .. " scored a hit with Advance",
		playerName .. " scored a hit with Aggressive Strike",
		playerName .. " scored a hit with Dramatic Flourish",
		playerName .. " scored a hit with Healer's Strike",
		playerName .. " scored a hit with Hero's Strike",
		playerName .. " scored a hit with Dissonant Strike",

	},
	isPunching = {
		playerName .. " scored a hit with Devastating Blow",
	},
	isStabbing = {
		playerName .. " scored a hit with Valiant Strike",
		playerName .. " scored a hit with Blade of Elendil",
		playerName .. " scored a hit with Thrust",
		playerName .. " scored a hit with Riposte",
		playerName .. " scored a hit with Lunge",
		playerName .. " scored a hit with Draining Strike",
		playerName .. " scored a hit with Flèche",

	},
	isLuteAttacking = {
		playerName .. " scored a hit with Minor Ballad",
		playerName .. " scored a hit with Major Ballad",
	},
--	beg = {
--		"You beckon to",
--		"You beg",
--	},
--	clap = {
--		"You clap",
--	},
--	dance = {
--		"You dance",
--		"You begin dancing",
--	},
--	drink = {
--		"You drink",
--	},
--	eat = {
--		"You have a little bite",
--	},
--	salute = {
--		"You peer",
--		"salute",
--	},
	isLuting = {
		playerName .. " applied a benefit with Minor Ballad",
		playerName .. " applied a benefit with Major Ballad",
		playerName .. " applied a benefit with Raise the Spirit",
		playerName .. " scored a hit with Coda of Fury",
		playerName .. " scored a hit with Coda of Melody",
		playerName .. " scored a hit with Piercing Cry",
	},
	isPointing = {
		playerName .. " applied a benefit with Shield",
		playerName .. " applied a benefit with Inspiriting Call",
		playerName .. " applied a benefit with Cry of Vengeance",
		playerName .. " applied a benefit with En Garde",

		"You point",
		"You poke",
		"scold",
		"You order your companion",
	},
	isParrying = {
		playerName .. " applied a benefit with Blade Shield",
	},
	isSmoking = {
		"You begin to smoke",
	},
	isInMelee = {
		playerName .. " scored a hit with a melee attack",

	}
}