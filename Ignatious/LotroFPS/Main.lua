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
import "Ignatious.LotroFPS.Frames"
import "Ignatious.LotroFPS.ChatStrings"

---------------------------------------------------------------------------------------------------

local currentState = 'idle'
local thePlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
local isInCombat = false;

local print = function(str)
    Turbine.Shell.WriteLine(tostring(str))
end

---------------------------------------------------------------------------------------------------
-------- Create windows ---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

local function CreateLayerWin(frameset, isHorse)
    local layer = Turbine.UI.Window()
    layer:SetSize(1414, 1075)
    layer:SetWantsUpdates(true)
    layer:SetVisible(true)
    layer:SetPosition(1920 / 2 - layer:GetWidth() / 2, 1080 - layer:GetHeight())
    layer:SetMouseVisible(false)
    layer:SetZOrder(-1)
    layer:SetBackground(frameset[1].IMAGE)
    layer.frameset = frameset
    layer.frame = 1
    layer.isHorse = isHorse
    layer.LastUpdated = Turbine.Engine.GetGameTime()
    layer.Update = function(self, args)
        local delta = Turbine.Engine.GetGameTime() - self.LastUpdated
        if delta > self.frameset[self.frame].TIME then
            local nextFrame = self.frame + 1
          --Turbine.Shell.WriteLine(self.frame);
          --Skipping here, counting 1,3,5,7,9
            if thePlayer:IsInCombat() then
                isInCombat = true;
            else
                isInCombat = false;
            end
            if self.frameset.repeats then
                self.frame = (nextFrame % 10) + 1 -- loops back to 1 after 10
            else
                if nextFrame > #frameset then
                    self:ChangeAnimation('idle')
                else
                   self.frame = nextFrame
                end
            end
            self:SetBackground(self.frameset[self.frame].IMAGE)
            self.LastUpdated = Turbine.Engine.GetGameTime()
        end
        if isInCombat == false then
            if currentState == 'strike' then
                currentState = 'idle';
                offWindow:ChangeAnimation('buckleridle')
            end
        end
        if isHorse then -- probably not the best way to do this
            local isMounted = thePlayer:GetMount() ~= nil
            local selfIsVisible = self:IsVisible()
            if isMounted and not selfIsVisible then
                self:ChangeAnimation('horse')
                self:SetVisible(true)
            elseif not isMounted and selfIsVisible then
                self:SetVisible(false)
            end
        end
    end
    layer.ChangeAnimation = function(self, frameset)
        self.frameset = Frames[frameset]
        self.frame = 1
        self.LastUpdated = Turbine.Engine.GetGameTime()
    end
    return layer
end 

mountWindow = CreateLayerWin(Frames['horse'], true)
offWindow = CreateLayerWin(Frames["buckler" .. 'idle'])
handsWindow = CreateLayerWin(Frames['idle'])

---------------------------------------------------------------------------------------------------
-------- Set up chat parsing ----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

local getRawText = Turbine.UI.Label();
getRawText:SetMarkupEnabled(true);
function GetRawText(textWithMarkup)
    getRawText:SetText(textWithMarkup);
    return getRawText:GetText();
end

Turbine.Chat.Received = function(sender, args)
    if (args.ChatType == Turbine.ChatType.PlayerCombat or
        args.ChatType == Turbine.ChatType.Emote or
        args.ChatType == Turbine.ChatType.Death) then

        -- change hand animation based on chat output
        local textWithoutMarkup = GetRawText(args.Message);
        currentState = ChatStrings.GetState(textWithoutMarkup)
        if currentState == nil then 
            if isInCombat == true then
                currentState = 'strike'
            else
                currentState = 'idle'
            end
        end
        handsWindow:ChangeAnimation(currentState)
        if currentState.isoffhand == true then
            offWindow:SetVisible(true);
                    print("Lotro FPS detected that your state is: `"..currentState.."`");
            offWindow:ChangeAnimation("buckler" .. currentState)
        else
            offWindow:SetVisible(false);
        end
    end
end