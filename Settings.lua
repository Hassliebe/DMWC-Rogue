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
    UI.AddDropdown("Poisons", nil, {"Instant Poison", "Deadly Poison", "Wound Poison"}, 1)
    UI.AddHeader("DPS")
    UI.AddToggle("Auto Attack", "Auto attack target in range", true)
	UI.AddToggle("AutoStealth", nil, true)
    UI.AddToggle("Sinister Strike", nil, true)
    UI.AddToggle("Eviscerate", nil, true)
    UI.AddToggle("Slice and Dice", nil, true)
	UI.AddHeader("Defensives")
	UI.AddToggle("Evasion")
end