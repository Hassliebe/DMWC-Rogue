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
    UI.AddHeader("General")
    UI.AddDropdown("Poisons", nil, {"OFF", "Instant 1", "Instant 2", "Instant 3", "Instant 4", "Instant 5", "Instant 6", "Mind/Crippling"}, 1)
	UI.AddToggle("Kick")
    UI.AddHeader("DPS")
    UI.AddToggle("Auto Attack", "Auto attack target in range", true)
	UI.AddToggle("AutoStealth", nil, true)
    UI.AddToggle("Sinister Strike", nil, true)
    UI.AddToggle("Eviscerate", nil, true)
    UI.AddToggle("Slice and Dice", nil, true)
	UI.AddDropdown("Blade Flurry", nil, {"Off", "Always", "AoE Only"}, 1)
	UI.AddDropdown("Adrenaline Rush", nil, {"Off", "Always", "AoE Only"}, 1)
	UI.AddHeader("Opener")
	UI.AddDropdown("Opener", nil, {"Off", "Ambush", "Garrote", "CheapShot"}, 1)
	UI.AddHeader("Defensives")
	UI.AddToggle("Vanish", "Vanish to lose aggro")
	UI.AddRange("Vanish Percent", nil, 0, 100, 1, 99)
	UI.AddToggle("Feint", "Feint to reduce Aggro / USE IN PARTY")
	UI.AddToggle("Evasion", "Make sure to set Evasion%")
	UI.AddRange("Evasion Percent", nil, 0, 100, 1, 99)
	--UI.AddToggle("Gouge")
	--UI.AddRange("Gouge Percent", nil, 0, 100, 1, 30)
	UI.AddHeader("Misc")
	UI.AddToggle("Pick Pocket")
	UI.AddToggle("Sprint", "Always Sprint")
	UI.AddToggle("Open Clams", "Opens Clams DUH")
end