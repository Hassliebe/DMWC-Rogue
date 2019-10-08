local DMW = DMW
DMW.Rotations.ROGUE = {}
local Rogue = DMW.Rotations.ROGUE
local UI = DMW.UI

function Rogue.Settings()
    -- UI.HUD.Options = {
    --     [1] = {
    --         Test = {
    --             [1] = {Text = "HUD Test |cFF00FF00On", Tooltip = ""},
    --             [2] = {Text = "HUD Test |cFFFFFF00Sort Of On", Tooltip = ""},
    --             [3] = {Text = "HUD Test |cffff0000Disabled", Tooltip = ""}
    --         }
    --     }
    -- }
    UI.AddHeader("|cffFF6EB4General")
    UI.AddDropdown("Poisons", nil, {"|cffff0000OFF", "|cffADFF2FInstant 1", "|cffADFF2FInstant 2", "|cffADFF2FInstant 3", "|cffADFF2FInstant 4", "|cffADFF2FInstant 5", "|cffADFF2FInstant 6", "|cff00E5EEMind/Crippling"}, 1)
	UI.AddToggle("Kick")
	
    UI.AddHeader("|cffFF6EB4DPS")
    UI.AddToggle("Auto Attack", "Auto attack target in range", true)
	UI.AddToggle("Stop until energy cap", nil, true)
	UI.AddToggle("AutoStealth", nil, true)
    UI.AddToggle("Sinister Strike", nil, true)
    UI.AddToggle("Eviscerate", nil, true)
    UI.AddToggle("Slice and Dice", nil, true)
	UI.AddDropdown("Blade Flurry", nil, {"|cffff0000Off", "|cff00ff00Always", "|cffffff00AoE Only"}, 1)
	UI.AddDropdown("Adrenaline Rush", nil, {"|cffff0000Off", "|cff00ff00Always", "|cffffff00AoE Only"}, 1)
	UI.AddHeader("Opener")
	UI.AddDropdown("Opener", nil, {"|cffff0000Off", "Ambush", "Garrote", "CheapShot"}, 1)
	
	UI.AddHeader("|cffFF6EB4Defensives")
	UI.AddToggle("Vanish", "Vanish to lose aggro")
	UI.AddRange("Vanish Percent", nil, 0, 100, 1, 25)
	UI.AddToggle("Feint", "Feint to reduce Aggro / USE IN PARTY")
	UI.AddToggle("Evasion", "Make sure to set Evasion%")
	UI.AddRange("Evasion Percent", nil, 0, 100, 1, 60)
	
	UI.AddHeader("|cffFF6EB4Consumables")
	UI.AddToggle("Thistle Tea", "Use Thistle Tea")
	UI.AddToggle("Use HP Potion",nil,false,true)
	UI.AddDropdown("HP Potion to use", "Use HP Potion", {"Minor Healing Potion","Lesser Healing Potion","Healing Potion","Greater Healing Potion","Superior Healing Potion", "Major Healing Potion"}, "1",true)
	UI.AddRange("se Potion at #% HP", nil, 10, 100, 5, 50, true)
	--UI.AddToggle("Gouge")
	--UI.AddRange("Gouge Percent", nil, 0, 100, 1, 30)
	
	UI.AddHeader("|cffFF6EB4Misc")
	UI.AddToggle("Pick Pocket")
	UI.AddToggle("Sprint", "Always Sprint")
	UI.AddToggle("Open Clams", "Opens Clams DUH")
end