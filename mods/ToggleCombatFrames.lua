local module = FerbTweaks:register({
    title = "Toggle Combat Frames",
    description = "Hide the player and actionbar frames out of combat. The frames will show on mouseover.",
    enabled = true,
})

module.enable = function(self)
    local isHidden = nil
    local inCombat = UnitAffectingCombat("player")
    local frames = { PlayerFrame, MainActionBar }

    local function ShowFrames()
        for _, frame in pairs(frames) do
            frame:Show()
        end
        isHidden = false
    end

    local function HideFrames()
        for _, frame in pairs(frames) do
            frame:Hide()
        end
        isHidden = true
    end

    HideFrames()

    local function UpdateUI(self, event)
        print("Event", event)
        if ((event == "PLAYER_ENTER_COMBAT") or (event == "PLAYER_REGEN_DISABLED")) then
            print("FT: Player Entered Combat, Revealing UI Frames")
            ShowFrames()
        end

        if ((event == "PLAYER_LEAVE_COMBAT") or (event == "PLAYER_REGEN_ENABLED")) then
            print("FT: Player Left Combat, Hiding UI Frames")
            HideFrames()
        end
    end

    local function overlay(parent) 
        local f = CreateFrame("Button")
        f:SetAllPoints(parent)
        f:EnableMouse(true)
        f:RegisterForClicks('LeftButtonUp', 'RightButtonUp',
        'Middle Button Up', 'Button4Up', 'Button5Up')
        
        f:SetScript("OnEnter", function()
            parent:Show()
        end)

        f:SetScript("OnLeave", function() 
                parent:Hide()
        end)
    end

    for _, frame in pairs(frames) do
        overlay(frame)
    end    
    
    local hideEvents = CreateFrame("Frame", nil, UIParent)
    local showEvents = CreateFrame("Frame", nil, UIParent)
    hideEvents:RegisterEvent("PLAYER_LEAVE_COMBAT")
    hideEvents:RegisterEvent("PLAYER_REGEN_ENABLED")
    showEvents:RegisterEvent("PLAYER_REGEN_DISABLED")
    showEvents:RegisterEvent("PLAYER_ENTER_COMBAT")

    hideEvents:SetScript("OnEvent", HideFrames)
    showEvents:SetScript("OnEvent", ShowFrames)
end