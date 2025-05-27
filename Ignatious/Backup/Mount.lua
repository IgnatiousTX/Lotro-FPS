---------------------------------------------------------------------------------------------------
-------- Imports ----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

local isMounted = false;
    local mountChecked = false;
    local isRiding = false;
local TimerM = 0;
local TimerMEnd = 11;

ResourceDirM = "Ignatious/LotroFPS/Resources/";

local thePlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
local playerMount = thePlayer:GetMount();

Turbine.Shell.WriteLine("Mount Interface Loaded!");

---------------------------------------------------------------------------------------------------
-------- Mounted State ----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
function getMountState()
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
-------- Frame Directory --------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
NothingFrames = {
    [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
    [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Invisible.tga"); ["TIME"] = 0.1; };
}
HorseFrames = {
    [1] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse1.tga"); ["TIME"] = .15; };
    [2] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse2.tga"); ["TIME"] = 0.2; };
    [3] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse3.tga"); ["TIME"] = 0.2; };
    [4] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse4.tga"); ["TIME"] = 0.2; };
    [5] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse5.tga"); ["TIME"] = 0.2; };
    [6] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse6.tga"); ["TIME"] = 0.2; };
    [7] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse7.tga"); ["TIME"] = 0.2; };
    [8] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse8.tga"); ["TIME"] = 0.2; };
    [9] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse9.tga"); ["TIME"] = 0.2; };
    [10] = { ["IMAGE"] = Turbine.UI.Graphic(ResourceDirM .. "Horse1.tga"); ["TIME"] = 0.15; };
}

---------------------------------------------------------------------------------------------------
-------- Mount Interface --------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
function MountInterface()
    mountWindow = Turbine.UI.Window();
    mountWindow:SetSize(1414, 1075);
    mountWindow:SetWantsUpdates(true);
    mountWindow.frameM = 10;
    mountWindow.LastUpdated = Turbine.Engine.GetGameTime();
    mountWindow.Update = function(sender, args)
        local deltaM = Turbine.Engine.GetGameTime() - mountWindow.LastUpdated;

        if (deltaM > Frames[mountWindow.frameM]["TIME"]) then
            mountWindow.frameM = mountWindow.frameM + 1;
            if (mountWindow.frameM > 10) then
                mountWindow.frameM = 1;
            end
            mountWindow:SetBackground(Frames[mountWindow.frameM]["IMAGE"]);
            mountWindow.LastUpdated = Turbine.Engine.GetGameTime();
            playerMount = nil;
            playerMount = thePlayer:GetMount();
            if (playerMount ~= nil) then
			    isMounted = true
		    else
			    isMounted = false;
		    end
            if (mountChecked == false) then
                if isMounted == true then
                    mountChecked = true;
                    isRiding = true;
                        Frames = HorseFrames
                else
                    Frames = NothingFrames
                end   
            else
                if (isRiding == true) then
                    if (mountChecked == true) then
                        if (isMounted == false) then
                                Frames = NothingFrames
                            getMountState();
                            MountInterface()
                            isRiding = false;
                        end
                    end
                end
            end
        end
    end

    mountWindow:SetVisible(true);
    mountWindow:SetPosition(1920 / 2 - mountWindow:GetWidth() / 2, 1080 - mountWindow:GetHeight());
    mountWindow:SetMouseVisible(0);
    mountWindow:SetZOrder(-2);
end
---------------------------------------------------------------------------------------------------
-------- End Commands (First played functions) ----------------------------------------------------
---------------------------------------------------------------------------------------------------
getMountState();
MountInterface()
---------------------------------------------------------------------------------------------------