-- %w* ?
-- %w* checks for 0 or more alphanumeric characters, followed by  ? 0 or 1 spaces.

local thePlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
local playerName = thePlayer:GetName();
local chatStrings = {
	wave = {
		"You need assistance",
		"You decide to assist",
		"You try to bother",
		"You wave",
		"follow",
		"You hail",
	},
	horn = {
		playerName .. " applied a %w* ?benefit with Call to Arms",
		playerName .. " applied a %w* ?benefit with Make Haste",
		playerName .. " applied a %w* ?benefit with Belly of Brine",
	},
	shout = {
		playerName .. " applied a %w* ?benefit with Rallying Cry",
		playerName .. " applied a %w* ?benefit with Motivating Speech",
		playerName .. " applied a %w* ?benefit with Shanty",
		playerName .. " scored a %w* ?hit with Battle",

		"You get angry",
		"You are angry",
		"It is time to attack",
		"You want to attack",
		"You want to start a fight",
		"You are ready to fight",
		"You flex",
		"You roar your challenge",
		"You challenge",
		"You start to charge",
		"You roar",
		"You shake your fist",
		"You let out a mighty",
		"You cheer",
	},
	shoutB = {
		playerName .. " applied a %w* ?benefit with Sea Legs",
		playerName .. " applied a %w* ?benefit with Re-centre",
		playerName .. " scored a %w* ?hit with Routing Cry",

		"You yawn at",
		"You fidget",
		"You look",
		"You mumble",
		"You laugh",
		"You shrug",
		"You chatter",
		"You peer",
		"You talk",
	},
	attackingA = {
		playerName .. " scored a %w* ?hit with Sure Strike",
		playerName .. " scored a %w* ?hit with Advance",
		playerName .. " scored a %w* ?hit with Aggressive Strike",
		playerName .. " scored a %w* ?hit with Dramatic Flourish",
		playerName .. " scored a %w* ?hit with Healer's Strike",
		playerName .. " scored a %w* ?hit with Hero's Strike",	
		playerName .. " scored a %w* ?hit with Dissonant Strike",
	},
	punching = {
		playerName .. " scored a %w* ?hit with Devastating Blow",
	},
	stabbing = {
		playerName .. " scored a %w* ?hit with Valiant Strike",
		playerName .. " scored a %w* ?hit with Blade of Elendil",
		playerName .. " scored a %w* ?hit with Thrust",
		playerName .. " scored a %w* ?hit with Riposte",
		playerName .. " scored a %w* ?hit with Lunge",
		playerName .. " scored a %w* ?hit with Draining Strike",
		playerName .. " scored a %w* ?hit with Flèche",
	},
	luteStrike = {
		playerName .. " scored a %w* ?hit with Minor Ballad",
		playerName .. " scored a %w* ?hit with Major Ballad",
		playerName .. " scored a %w* ?hit with Coda of Fury",
		playerName .. " scored a %w* ?hit with Coda of Melody",
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
	lute = {
		playerName .. " applied a %w* ?benefit with Minor Ballad",
		playerName .. " applied a %w* ?benefit with Major Ballad",
		playerName .. " applied a %w* ?benefit with Perfect Ballad",
		playerName .. " applied a %w* ?benefit with Raise the Spirit",
		playerName .. " scored a %w* ?hit with Perfect Ballad",
	},
	point = {
		playerName .. " applied a %w* ?benefit with Shield",
		playerName .. " applied a %w* ?benefit with Inspiriting Call",
		playerName .. " applied a %w* ?benefit with Cry of Vengeance",
		playerName .. " applied a %w* ?benefit with En Garde",
		playerName .. " applied a %w* ?benefit with Words of Courage",

		"You point",
		"You poke",
		"You scold",
		"You order your companion",
	},
	parry = {
		playerName .. " applied a benefit with Blade Shield",
	-- Parrying/Blocking/Evading happens from the EnemyCombat not PlayerCombat.
--		playerName .. " but he parried the attempt",
--		playerName .. " but she parried the attempt",
--		playerName .. " but he blocked the attempt",
--		playerName .. " but she blocked the attempt",
--		playerName .. " but he evaded the attempt",
--		playerName .. " but she evaded the attempt",
	},
	smoke = {
		"You begin to smoke",
	},vff
	-- Deprecated with new structure
--	melee = {
--		playerName .. " scored a hit with a melee attack",
--	}
}

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