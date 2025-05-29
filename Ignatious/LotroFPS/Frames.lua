---------------------------------------------------------------------------------------------------
-------- Frame Structure --------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
ResourceDir = "Ignatious/LotroFPS/Resources/";

-- Repeats boolean, makes the animation repeat upon playing
-- isoffhand boolean, decides whether or not to render the offhand item
    -- ifoffhand = true means offhand IS shown

Frames = {
    idle = {
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
        repeats = true;
    },
        buckleridle = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerDefault.tga"); ["TIME"] = 3.5; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle1.tga"); ["TIME"] = 0.225; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle2.tga"); ["TIME"] = 0.225; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle3.tga"); ["TIME"] = 0.225; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle4.tga"); ["TIME"] = 0.225; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle5.tga"); ["TIME"] = 0.225; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle6.tga"); ["TIME"] = 0.15; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle7.tga"); ["TIME"] = 0.15; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle8.tga"); ["TIME"] = 0.15; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerIdle9.tga"); ["TIME"] = 0.2; };
            repeats = true;
        },
    strike = {
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
        repeats = false;
    },
        bucklerstrike = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerDefault.tga"); ["TIME"] = 0.1; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike1.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike2.tga"); ["TIME"] = 0.025; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike3.tga"); ["TIME"] = 0.05; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike4.tga"); ["TIME"] = 0.025; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike5.tga"); ["TIME"] = 0.05; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike6.tga"); ["TIME"] = 0.05; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike78.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike78.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStrike9.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    wave = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "DefaultFrame.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave1.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave3.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave4.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave6.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Wave9.tga"); ["TIME"] = 0.15; };
        repeats = false;
    },
        bucklerwave = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.15; };
            repeats = false;
        },
    shout = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout4.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout6.tga"); ["TIME"] = 0.25; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout7.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Shout9.tga"); ["TIME"] = 0.1; };
        repeats = false;
    },
        bucklershout = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.25; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    shoutB = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB4.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB6.tga"); ["TIME"] = 0.25; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB7.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ShoutB9.tga"); ["TIME"] = 0.1; };
        repeats = false;
    },
        bucklershoutB = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB1.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB1.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB2.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB3.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB4.tga"); ["TIME"] = 0.1; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB5.tga"); ["TIME"] = 0.2; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB6.tga"); ["TIME"] = 0.25; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB7.tga"); ["TIME"] = 0.2; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB8.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerShoutB9.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    smoke = {
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
        repeats = true;
    },
        bucklersmoke = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.15; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.15; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.15; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.3; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.4; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            repeats = true;
        },
    parry = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry4.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry6.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Parry9.tga"); ["TIME"] = 0.1; };
        repeats = false;
    },
        bucklerparry = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry1.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry1.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry2.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry3.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry4.tga"); ["TIME"] = 0.2; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry5.tga"); ["TIME"] = 0.2; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry6.tga"); ["TIME"] = 0.2; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry7.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry8.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerParry9.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    attackingA = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA2.tga"); ["TIME"] = 0.15; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA3.tga"); ["TIME"] = 0.01; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA4.tga"); ["TIME"] = 0.05; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA5.tga"); ["TIME"] = 0.05; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA6.tga"); ["TIME"] = 0.05; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA8.tga"); ["TIME"] = 0.05; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "AttackA9.tga"); ["TIME"] = 0.05; };
        repeats = false;
    },
        bucklerattackingA = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA1.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA1.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA234567.tga"); ["TIME"] = 0.15; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA234567.tga"); ["TIME"] = 0.05; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA234567.tga"); ["TIME"] = 0.05; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA234567.tga"); ["TIME"] = 0.05; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA234567.tga"); ["TIME"] = 0.05; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA234567.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA8.tga"); ["TIME"] = 0.05; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerAttackA9.tga"); ["TIME"] = 0.05; };
            repeats = false;
        },
    stabbing = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab2.tga"); ["TIME"] = 0.05; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab3.tga"); ["TIME"] = 0.05; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab4.tga"); ["TIME"] = 0; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab6.tga"); ["TIME"] = 0.1; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Stab9.tga"); ["TIME"] = 0.15; };
        repeats = false;
    },
        bucklerstabbing = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing1.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing1.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing2.tga"); ["TIME"] = 0.05; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing3.tga"); ["TIME"] = 0.05; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing45.tga"); ["TIME"] = 0.05; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing45.tga"); ["TIME"] = 0.15; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing6.tga"); ["TIME"] = 0.1; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing7.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing8.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerStabbing9.tga"); ["TIME"] = 0.15; };
            repeats = false;
        },
    point = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point2.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point4.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point5.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point6.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Point9.tga"); ["TIME"] = 0.1; };
        repeats = false;
    },
        bucklerpoint = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.2; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    punching = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch1.tga"); ["TIME"] = 0.05; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch1.tga"); ["TIME"] = 0.05; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch2.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch3.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch4.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch5.tga"); ["TIME"] = 0.1; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch6.tga"); ["TIME"] = 0.1; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch7.tga"); ["TIME"] = 0.1; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch8.tga"); ["TIME"] = 0.1; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Punch8.tga"); ["TIME"] = 0; };
        repeats = false;
    },
        bucklerpunching = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch1.tga"); ["TIME"] = 0.05; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch1.tga"); ["TIME"] = 0.05; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch2.tga"); ["TIME"] = 0.2; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch3.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch4.tga"); ["TIME"] = 0.1; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch5.tga"); ["TIME"] = 0.1; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch6.tga"); ["TIME"] = 0.1; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch789.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch789.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerPunch789.tga"); ["TIME"] = 0; };
            repeats = false;
        },
    horn = {
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
        repeats = false;
    },
        bucklerhorn = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn1.tga"); ["TIME"] = 0.075; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn2.tga"); ["TIME"] = 0.075; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn3.tga"); ["TIME"] = 0.075; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn4.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn5.tga"); ["TIME"] = 0.25; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn6.tga"); ["TIME"] = 0.3; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn7.tga"); ["TIME"] = 0.3; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn8.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn9.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "BucklerHorn1.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    lute = {
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
        repeats = false;
    },
        bucklerlute = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    luteStrike = {
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
        repeats = false;
    },
        bucklerluteStrike = {
            [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
            repeats = false;
        },
    horse = {
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
        repeats = true;
    },
    horsearmor = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm1.tga"); ["TIME"] = .15; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm2.tga"); ["TIME"] = 0.2; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm3.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm4.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm5.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm6.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm7.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm8.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm9.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "HorseArm10.tga"); ["TIME"] = 0.15; };
        repeats = true;
    },
    donkey = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey1.tga"); ["TIME"] = .15; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey2.tga"); ["TIME"] = 0.2; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey3.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey4.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey5.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey6.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey7.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey8.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey9.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Donkey10.tga"); ["TIME"] = 0.15; };
        repeats = true;
    },
    elk = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk1.tga"); ["TIME"] = .15; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk2.tga"); ["TIME"] = 0.2; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk3.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk4.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk5.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk6.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk7.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk8.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk9.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Elk10.tga"); ["TIME"] = 0.15; };
        repeats = true;
    },
    elkarmor = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm1.tga"); ["TIME"] = .15; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm2.tga"); ["TIME"] = 0.2; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm3.tga"); ["TIME"] = 0.2; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm4.tga"); ["TIME"] = 0.2; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm5.tga"); ["TIME"] = 0.2; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm6.tga"); ["TIME"] = 0.2; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm7.tga"); ["TIME"] = 0.2; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm8.tga"); ["TIME"] = 0.2; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm9.tga"); ["TIME"] = 0.2; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "ElkArm10.tga"); ["TIME"] = 0.15; };
        repeats = true;
    },
    invisible = {
        [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
        [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
        [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
        [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
        [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
        [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0.1; };
        [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0; };
        [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0; };
        [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0; };
        [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDir .. "Invisible.tga"); ["TIME"] = 0; };
        repeats = true;
    }
}