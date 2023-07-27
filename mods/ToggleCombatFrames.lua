local module = FerbTweaks:register({
    title = "Toggle Combat Frames",
    description = "Hide the player and actionbar frames out of combat. The frames will show on mouseover.",
    enabled = true,
})

module.enable = function(self)    
    -- Conditions
    local canHide = true;
    local isHidden = nil

    -- Show UI Frames
    local function ShowFrames()
        -- Player Frame
        PlayerFrame:Show()
        -- Bongos
        SlashCmdList["BongosCOMMAND"]("show all")
        SlashCmdList["BongosCOMMAND"]("hide 3")
        SlashCmdList["BongosCOMMAND"]("hide stats")

        isHidden = false
    end

    -- Hide UI Frames
    local function HideFrames()
        if (canHide == false) then
            do return end
        end
        
        -- Player Frame
        PlayerFrame:Hide()
        -- Bongos
        SlashCmdList["BongosCOMMAND"]("hide all")

        isHidden = true;
    end

    -- Events
    local hideEvents = CreateFrame("Frame", nil, UIParent)
    local showEvents = CreateFrame("Frame", nil, UIParent)
    hideEvents:RegisterEvent("PLAYER_LEAVE_COMBAT")
    hideEvents:RegisterEvent("PLAYER_REGEN_ENABLED")
    showEvents:RegisterEvent("PLAYER_REGEN_DISABLED")
    showEvents:RegisterEvent("PLAYER_ENTER_COMBAT")

    hideEvents:SetScript("OnEvent", HideFrames)
    showEvents:SetScript("OnEvent", ShowFrames)

    -- Hide frames by default
    local mainFrame = CreateFrame("Frame", nil, UIParent)
    mainFrame:RegisterEvent("PLAYER_LOGIN")
    mainFrame:SetScript("OnEvent", function()
        HideFrames()
    end);

    -- Slash Commands
    local function FerbCommands(msg, editbox)
        if msg == '' then
            if (isHidden == true) then
                canHide = false
                ShowFrames()
            else
                canHide = true;
                HideFrames()
            end
        elseif msg == 'show' then
            canHide = false
            ShowFrames()
        elseif msg == 'hide' then
            canHide = true
            HideFrames()
        end
    end
      
    SLASH_FERB1 = '/ferb'
    SlashCmdList["FERB"] = FerbCommands

end