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
		playerName .. " applied a benefit with Call to Arms",
		playerName .. " applied a benefit with Make Haste",
		playerName .. " applied a benefit with Belly of Brine",
	},
	shout = {
		playerName .. " applied a benefit with Rallying Cry",
		playerName .. " applied a benefit with Words of Courage",
		playerName .. " applied a benefit with Motivating Speech",
		playerName .. " applied a benefit with Shanty",
		playerName .. " scored a hit with Battle",
		playerName .. " scored a critical hit with Battle",
		playerName .. " scored a devastating hit with Battle",

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
		playerName .. " applied a benefit with Sea Legs",
		playerName .. " applied a benefit with Re-centre",
		playerName .. " scored a hit with Routing Cry",
		playerName .. " scored a critical hit with Routing Cry",
		playerName .. " scored a devastating hit with Routing Cry",

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
		playerName .. " scored a hit with Sure Strike",
		playerName .. " scored a critical hit with Sure Strike",
		playerName .. " scored a devastating hit with Sure Strike",
		playerName .. " scored a hit with Advance",
		playerName .. " scored a critical hit with Advance",
		playerName .. " scored a devastating hit with Advance",
		playerName .. " scored a hit with Aggressive Strike",
		playerName .. " scored a critical hit with Aggressive Strike",
		playerName .. " scored a devastating hit with Aggressive Strike",
		playerName .. " scored a hit with Dramatic Flourish",
		playerName .. " scored a critical hit with Dramatic Flourish",
		playerName .. " scored a devastating hit with Dramatic Flourish",
		playerName .. " scored a hit with Healer's Strike",
		playerName .. " scored a critical hit with Healer's Strike",
		playerName .. " scored a devastating hit with Healer's Strike",
		playerName .. " scored a hit with Hero's Strike",
		playerName .. " scored a critical hit with Hero's Strike",
		playerName .. " scored a devastating hit with Hero's Strike",
		playerName .. " scored a hit with Dissonant Strike",
		playerName .. " scored a critical hit with Dissonant Strike",
		playerName .. " scored a devastating hit with Dissonant Strike",
	},
	punching = {
		playerName .. " scored a hit with Devastating Blow",
		playerName .. " scored a critical hit with Devastating Blow",
		playerName .. " scored a devastating hit with Devastating Blow",
	},
	stabbing = {
		playerName .. " scored a hit with Valiant Strike",
		playerName .. " scored a critical hit with Valiant Strike",
		playerName .. " scored a devastating hit with Valiant Strike",
		playerName .. " scored a hit with Blade of Elendil",
		playerName .. " scored a critical hit with Blade of Elendil",
		playerName .. " scored a devastating hit with Blade of Elendil",
		playerName .. " scored a hit with Thrust",
		playerName .. " scored a critical hit with Thrust",
		playerName .. " scored a devastating hit with Thrust",
		playerName .. " scored a hit with Riposte",
		playerName .. " scored a critical hit with Riposte",
		playerName .. " scored a devastating hit with Riposte",
		playerName .. " scored a hit with Lunge",
		playerName .. " scored a critical hit with Lunge",
		playerName .. " scored a devastating hit with Lunge",
		playerName .. " scored a hit with Draining Strike",
		playerName .. " scored a critical hit with Draining Strike",
		playerName .. " scored a devastating hit with Draining Strike",
		playerName .. " scored a hit with Flèche",
		playerName .. " scored a critical hit with Flèche",
		playerName .. " scored a devastating hit with Flèche",
	},
	luteStrike = {
		playerName .. " scored a hit with Minor Ballad",
		playerName .. " scored a critical hit with Minor Ballad",
		playerName .. " scored a devastating hit with Minor Ballad",
		playerName .. " scored a hit with Major Ballad",
		playerName .. " scored a critical hit with Major Ballad",
		playerName .. " scored a devastating hit with Major Ballad",
		playerName .. " scored a hit with Coda of Fury",
		playerName .. " scored a critical hit with Coda of Fury",
		playerName .. " scored a devastating hit with Coda of Fury",
		playerName .. " scored a hit with Coda of Melody",
		playerName .. " scored a critical hit with Coda of Melody",
		playerName .. " scored a devastating hit with Coda of Melody",
		playerName .. " scored a hit with Piercing Cry",
		playerName .. " scored a critical hit with Piercing Cry",
		playerName .. " scored a devastating hit with Piercing Cry",
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
		playerName .. " applied a benefit with Minor Ballad",
		playerName .. " applied a benefit with Major Ballad",
		playerName .. " applied a benefit with Raise the Spirit",
	},
	point = {
		playerName .. " applied a benefit with Shield",
		playerName .. " applied a benefit with Inspiriting Call",
		playerName .. " applied a benefit with Cry of Vengeance",
		playerName .. " applied a benefit with En Garde",

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
	},
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