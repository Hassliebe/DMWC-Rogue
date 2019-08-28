local DMW = DMW
local Rogue = DMW.Rotations.ROGUE
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Pet, Buff, Debuff, Spell, Target, Talent, Item, GCD, CDs, HUD, Enemy40Y, Enemy40YC

local function Locals()
    Player = DMW.Player
    Pet = DMW.Player.Pet
    Buff = Player.Buffs
    Debuff = Player.Debuffs
    Spell = Player.Spells
    Talent = Player.Talents
    Item = Player.Items
	ComboPoints = DMW.Player.ComboPoints
    Target = Player.Target or false
    HUD = DMW.Settings.profile.HUD
    CDs = Player:CDs()
    Enemy40Y, Enemy40YC = Player:GetEnemies(40)
end

function Rogue.Rotation()
    Locals()
	-----------------
	-- DPS --
	-----------------
	-- Stealth when Approaching 
	if Setting("AutoStealth") and Target and Target.ValidEnemy and Target.Distance > 5 and Target.Distance < 20 and not Player.Combat and not Buff.Stealth:Exist(Player) then
		if Spell.Stealth:Cast() then
			return
		end
	end
	--Ambush
	if Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and not ObjectIsFacing("target", "player") then
		if Spell.Ambush:Cast(Target) then
			return
		end
	end
	--Garrote
	if Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and not ObjectIsFacing("target", "player") then
		if Spell.Garrote:Cast(Target) then
			return
		end
	end
	-- Backstab if possible
	if Target and Target.ValidEnemy and not ObjectIsFacing("target", "player") then
		if Spell.Backstab:Cast(Target) then
			return
		end
	end
	-- maintain SnD
	if Setting("Slice and Dice") and GetComboPoints("player", "target") > 0 and not Buff.SliceAndDice:Exist(Player) then
		if Spell.SliceAndDice:Cast() then
			return
		end
	end
	-- Eviscerate @ 5 CP
	if GetComboPoints("player", "target") == 5 then
		if Spell.Eviscerate:Cast(Target) then
			return
		end
	end
		-- Spam Sinister Strike
	if Setting("Sinister Strike") and Target and Target.ValidEnemy and Player.Power > 40 then
		if Spell.SinisterStrike:Cast(Target) then
			return
		end
	end	
	-- Autoattack everything in range
    if Setting("Auto Attack") and Target and Target.ValidEnemy and Player.Combat and Target.Distance < 5 then
        StartAttack()
	end
	------------------
	--- Defensives ---
	------------------
	--if Setting("Evasion") and 
		--if Spell.Evasion:Cast() then
		--	return
		--end
	--end
		
end