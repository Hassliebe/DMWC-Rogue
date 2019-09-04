local DMW = DMW
local Rogue = DMW.Rotations.ROGUE
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Pet, Buff, Debuff, Spell, Target, Talent, Item, GCD, CDs, HUD, Enemy40Y, Enemy40YC, ComboPoints, HP, Enemy8YC, Enemy8Y, Enemy60Y, Enemy60YC
local hasMainHandEnchant,_ ,_ , _, hasOffHandEnchant = GetWeaponEnchantInfo()

local function Locals()
    Player = DMW.Player
    Pet = DMW.Player.Pet
    Buff = Player.Buffs
	HP = Player.HP
    Debuff = Player.Debuffs
    Spell = Player.Spells
    Talent = Player.Talents
    Item = Player.Items
	ComboPoints = DMW.Player.ComboPoints
    Target = Player.Target or false
    HUD = DMW.Settings.profile.HUD
    CDs = Player:CDs() and Target and Target.TTD > 5 and Target.Distance < 5
	Enemy60Y, Enemy60YC = Player:GetEnemies(60)
    Enemy40Y, Enemy40YC = Player:GetEnemies(40)
	Enemy8Y, Enemy8YC = Player:GetEnemies(8)
end

local function Poison()

	------------------
	--- Poisons --- 
	------------------
	if Setting("Instant Poison") == 2 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Instant Poison") == 2 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison")
		RunMacroText("/use 17")
            return 
        end
	if Setting("Instant Poison") == 3 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison II")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Instant Poison") == 3 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison II")
		RunMacroText("/use 17")
            return 
        end	
	if Setting("Instant Poison") == 4 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison III")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Instant Poison") == 4 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison III")
		RunMacroText("/use 17")
            return 
        end	
end
local function DEF()
	------------------
	--- Defensives ---
	------------------
	if Setting("Evasion") and HP < Setting("Evasion Percent") and Enemy8YC > 0 then
		if Spell.Evasion:Cast(Player) then
			return
		end
	end
	
	--if Setting("Gouge") and HP < Setting("Gouge Percent") then
	--	if Spell.Gouge:Cast(Target) then
	--		return
	--	end
	--end
end

function Rogue.Rotation()
    Locals()
	
	if Player.Combat then
		if DEF() then
			return true
		end
	end
	
	if not Player.Combat and not Player.Moving then
		if Poison() then
			return true
		end
	end
	-----------------
	-- DPS --
	-----------------
	-- Dont attack while Gouge
	--if Target and Target.ValidEnemy and Debuff.Gouge:Remain(Target) > 1 then
	--	stopAttack()
	--end
	-- Sprint always
	if Setting("Sprint") and not Buff.Sprint:Exist(Player) and Player.Moving then
		if Spell.Sprint:Cast(Player) then
			return 
		end
	end
	-- Stealth when Approaching 
	if Setting("AutoStealth") and Target and Target.ValidEnemy and Target.Distance > 5 and Target.Distance < 20 and not Player.Combat and not Buff.Stealth:Exist(Player) then
		if Spell.Stealth:Cast() then
			return
		end
	end
	-- Riposte
	if Target and Target.ValidEnemy then
		if Spell.Riposte:Cast(Target) then
			return
		end
	end
	-- Cheap Shot Opener
	if Setting("Opener") == 3 and Target and Target.ValidEnemy and Buff.Stealth:Exist(Player) then
		if Spell.CheapShot:Cast(Target) then
			return
		end
	end
	-- Pick Pocket
	--if Setting("Pick Pocket") and	 Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and ObjectIsBehind("player", "target") then
	--	if Spell.PickPocket:Cast(Target) then
	--		return
	--	end
	--end
	--Ambush
	if Setting("Opener") == 1 and Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and ObjectIsBehind("player", "target") then
		if Spell.Ambush:Cast(Target) then
			return
		end
	end
	--Garrote
	if Setting("Opener") == 2 and Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and ObjectIsBehind("player", "target") then
		if Spell.Garrote:Cast(Target) then
			return
		end
	end
	-- Blade Flurry
	if Setting("Blade Flurry") == 1 and Player.Power >= 25 and Player.Combat or (Setting("Blade Flurry") == 2 and Enemy8YC > 1 and Player.Combat and Player.Power >= 25) then
		if Spell.BladeFlurry:Cast(Player) then
			return
		end
	end
	-- Backstab if possible
	if Target and Target.ValidEnemy and ObjectIsBehind("player", "target") then
		if Spell.Backstab:Cast(Target) then
			return
		end
	end
		-- Eviscerate < 15%
	if Setting("Eviscerate") then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if GetComboPoints("player", "target") > 1 and Target and (Unit.TTD < 5 or Unit.HP < 15) then
				if Spell.Eviscerate:Cast(Target) then
					return
				end
			end
		end
	end
	-- maintain SnD
	if Setting("Slice and Dice") then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if GetComboPoints("player", "target") > 0 and not Buff.SliceAndDice:Exist(Player) and Unit.TTD > 5 then
				if Spell.SliceAndDice:Cast() then
					return
				end
			end
		end
	end
	-- Eviscerate @ 5 CP
	if GetComboPoints("player", "target") == 5 and Target then
		if Spell.Eviscerate:Cast(Target) then
			return
		end
	end
	-- Eviscerate > 1 CP
	if Setting("Eviscerate") then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if GetComboPoints("player", "target") > 1 and Target and Unit.TTD < Buff.SliceAndDice:Remain(Player) then
				if Spell.Eviscerate:Cast(Target) then
					return
				end
			end
		end
	end
		-- Spam Sinister Strike
	if Setting("Sinister Strike") and Target and Target.ValidEnemy and Player.Power >= 40 and GetComboPoints("player", "target") < 5 and Player.Combat then
		if Spell.SinisterStrike:Cast(Target) then
			return
		end
	end	
	-- Autoattack everything in range
    if Setting("Auto Attack") and Target and Target.ValidEnemy and Target.Distance <5 and Player.Combat then
        StartAttack()
	end
	
end