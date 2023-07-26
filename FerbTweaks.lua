message = function(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00" .. ( msg or "nil" ))
  end
print = message

error = function(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000".. (msg or "nil" ))
  end
seterrorhandler(error)

FerbTweaks = CreateFrame("Frame")
FerbTweaks.mods = {}

print("FerbTweaks Loaded!")

FerbTweaks:RegisterEvent("VARIABLES_LOADED")
FerbTweaks:SetScript("OnEvent", function()
    for title, mod in pairs(FerbTweaks.mods) do
        print("FerbTweaks Event")
        mod:enable()
    end
end)

FerbTweaks.register = function(self, mod)
    print("Mod Registered")
    FerbTweaks.mods[mod.title] = mod
    return FerbTweaks.mods[mod.title]
end