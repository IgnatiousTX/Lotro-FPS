

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

offHandItem = "buckler";
mountAnim = "horse"

-- Options Variables
offChecked = true;


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
            if thePlayer:IsInCombat() then
                isInCombat = true;
            else
                isInCombat = false;
            end
            if nextFrame > 10 then
                self.frame = 1;
                if not self.frameset.repeats then
                    currentState = 'idle';
                    self:ChangeAnimation('idle')
                    offWindow:ChangeAnimation(offHandItem .. 'idle')
                end
            else
                self.frame = nextFrame;
            end
            self:SetBackground(self.frameset[self.frame].IMAGE)
            self.LastUpdated = Turbine.Engine.GetGameTime()
        end
        if self.ExtendedUpdate then
            self:ExtendedUpdate()
        end
    end
    layer.ChangeAnimation = function(self, frameset)
        self.frameset = Frames[frameset];
        self.frame = 1;
        self.LastUpdated = Turbine.Engine.GetGameTime();
    end
    return layer
end 

mountWindow = CreateLayerWin(Frames[mountAnim], true);
    mountWindow.ExtendedUpdate = function(self)
        local isMounted = thePlayer:GetMount() ~= nil
        local selfIsVisible = self:IsVisible()
        if isMounted and not selfIsVisible then
            self:ChangeAnimation(mountAnim)
            self:SetVisible(true)
        elseif not isMounted and selfIsVisible then
            self:SetVisible(false)
        end
    end

offWindow = CreateLayerWin(Frames[offHandItem .. "idle"])
    offWindow.ExtendedUpdate = function(self)
        if offChecked == true then
            local offIsVisible = self:IsVisible()
            if not isInCombat and not offIsVisible then
                self:ChangeAnimation(offHandItem .. 'idle');
                self:SetVisible(true)
            end
            if isInCombat == false then
                if currentState == 'strike' then
                    self:ChangeAnimation(offHandItem .. 'idle');
                    self:SetVisible(true)
                end
            end
        else
            self:ChangeAnimation('invisible');
        end
    end

handsWindow = CreateLayerWin(Frames['idle']);

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
                currentState = 'strike';
            else
                currentState = 'idle';
            end
        end
        handsWindow:ChangeAnimation(currentState);
        offWindow:ChangeAnimation(offHandItem .. currentState);
    end
end

---------------------------------------------------------------------------------------------------
-------- Set up Options ----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

function DrawOptionsControl()
    options = Turbine.UI.Control();
    plugin.GetOptionsPanel = function(self) return options; end

    options:SetBackColor(Turbine.UI.Color.DimGray) -- 0 = 0, 1 = 255
    options:SetSize(250, 250)

    -- add a label for the scrollbar
    local offhandLabel = Turbine.UI.Label();
    offhandLabel:SetParent(options);
    offhandLabel:SetSize(200, 25);
    offhandLabel:SetText("Offhand Settings:");
    offhandLabel:SetPosition(10, 10)

    -- Visibility
    local offhandLabel = Turbine.UI.Label();
    offhandLabel:SetParent(options);
    offhandLabel:SetSize(200, 25);
    offhandLabel:SetText("     Visibility:");
    offhandLabel:SetPosition(10, 30)
    local offhandCheckbox = Turbine.UI.Lotro.CheckBox();
    offhandCheckbox:SetParent(options);
    offhandCheckbox:SetSize(20, 20);
    offhandCheckbox:SetPosition(150, 25)
    offhandCheckbox:SetChecked(1);
    offhandCheckbox.CheckedChanged = function(sender, args)
        offChecked = offhandCheckbox:IsChecked();
    end
end
DrawOptionsControl();
print("LotroFPS loaded...")