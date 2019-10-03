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
	if timeMH == nil then timeMH = DMW.Time end
	if timeOH == nil then timeOH = DMW.Time end
end

local function getapdmg(offHand)
          local useOH = offHand or false
          local wdpsCoeff = 6
          local ap = UnitAttackPower("player")
          local minDamage, maxDamage, minOffHandDamage, maxOffHandDamage, physicalBonusPos, physicalBonusNeg, percent = UnitDamage("player")
          local speed, offhandSpeed = UnitAttackSpeed("player")
          if useOH and offhandSpeed then
            local wSpeed = offhandSpeed * (1 + GetHaste() / 100)
            local wdps = (minOffHandDamage + maxOffHandDamage) / wSpeed / percent - ap / wdpsCoeff
            return (ap + wdps * wdpsCoeff) * 0.5
          else
            local wSpeed = speed * (1 + GetHaste() / 100)
            local wdps = (minDamage + maxDamage) / 2 / wSpeed / percent - ap / wdpsCoeff
            return ap + wdps * wdpsCoeff
          end
    end

local function evisDmg()
        local apMod         = getapdmg()
        local rtcoef       = 0.35
        local auramult      = 1.13
        local versmult      = (1 + ((GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)) / 100))
        if talent.deeperStratagem then dsmod = 1.05 else dsmod = 1 end 
        return(
                apMod * combo * rtcoef * auramult * dsmod * versmult
                )
    end
local function Potionuse()
	PotionName = Setting("HP Potion to use")
	if PotionName == 1 then
		PotionID = 118
	end
	if PotionName == 2 then
		PotionID = 858
	end
	if PotionName == 3 then
		PotionID = 929
	end
	if PotionName == 4 then
		PotionID = 1710
	end
	if PotionName == 5 then
		PotionID = 3928
	end
	if PotionName == 6 then
		PotionID = 13446
	end
end
local function Poison()

	------------------
	--- Poisons --- 
	------------------
	if Setting("Poisons") == 2 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Poisons") == 2 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison")
		RunMacroText("/use 17")
            return 
        end
	if Setting("Poisons") == 3 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison II")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Poisons") == 3 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison II")
		RunMacroText("/use 17")
            return 
        end	
	if Setting("Poisons") == 4 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison III")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Poisons") == 4 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison III")
		RunMacroText("/use 17")
            return 
        end	
	if Setting("Poisons") == 5 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison IV")
		RunMacroText("/use 16")
            return 
        end
	if Setting("Poisons") == 5 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison IV")
		RunMacroText("/use 17")
            return 
        end	
	if Setting("Poisons") == 6 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison V")
		RunMacroText("/use 16")
            return 
    end
	if Setting("Poisons") == 6 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison V")
		RunMacroText("/use 17")
            return 
	end	
	if Setting("Poisons") == 7 and not Spell.InstantPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Instant Poison VI")
		RunMacroText("/use 16")
            return 
    end
	if Setting("Poisons") == 7 and not Spell.InstantPoison:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Instant Poison VI")
		RunMacroText("/use 17")
            return 
    end	
	if Setting("Poisons") == 8 and not Spell.MindNumbingPoison:LastCast() and GetWeaponEnchantInfo() == false then	
        RunMacroText("/use Mind-Numbing Poison III")
		RunMacroText("/use 16")
            return 
    end
	if Setting("Poisons") == 8 and not Spell.CripplingPoison2:LastCast() and select(5, GetWeaponEnchantInfo()) == false then	
        RunMacroText("/use Crippling Poison II")
		RunMacroText("/use 17")
            return 
    end	
end
local function DEF()

	------------------
	--- Defensives ---
	------------------
	-- Evasion
	if Setting("Evasion") and Spell.Evasion:IsReady() and HP < Setting("Evasion Percent") and Enemy8YC > 0 then
		if Spell.Evasion:Cast(Player) then
			return
		end
	end
	-- Feint
	if Setting("Feint") and Spell.Feint:IsReady() and Player.Power > 20 and Player.Combat then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if Player:IsTanking(Target) then
				if Spell.Feint:Cast() then
					return
				end
			end
		end
	end
	-- Vanish in combat
	if Setting("Vanish") and Spell.Vanish:IsReady() and HP < Setting("Vanish Percent") and Player.Combat then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if Player:IsTanking(Unit) then
				if Spell.Vanish:Cast() then
					return
				end
			end
		end
	end
	-- Health Potions
	

end
local function CDs()
end
local function UsePotion()
	if Setting("Use HP Potion") then
		if GetItemCount(PotionID) >= 1 and GetItemCooldown(PotionID) == 0 then
			if HP <= Setting("Use Potion at #% HP") and Player.Combat then
				name = GetItemInfo(PotionID)
				RunMacroText("/use " .. name)
				return true
			end
		end
	end
end

function Rogue.Rotation()
    Locals()
	Potionuse()
	
	if UsePotion() then
		return true
	end
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
	
	if Target and Debuff.Gouge:Exist(Target) then
		print("123")
    	RunMacroText("/stopattack")
    	return true 
    end
	if GetKeyState(0x10) then
        return true
    end
	-----------------
	-- DPS --
	-----------------
	-- Dont attack while Gouge
	--if Target and Target.ValidEnemy and Debuff.Gouge:Remain(Target) > 1 then
	--	stopAttack()
	--end
	-- Sprint always
	
	-- Open Clams
	if Setting("Open Clams") and not Player.Combat then
		RunMacroText("/script l=5;m=0;f=string.find;for b=0,4,1 do for s=1,GetContainerNumSlots(b),1 do n=GetContainerItemLink(b,s);if n and f(n,\"Clam\")then if f(n,\"Clam \")or f(n,\"Clams\")then b=b else l=b;m=s;end;end;end;end;if l<5 and m>0 then UseContainerItem(l,m)end")
			return
	end
	-- Kick (only target because CP)
	if Setting("Kick") and Spell.Kick:IsReady() and Target and Target.ValidEnemy and Target:Interrupt() then
		if Spell.Kick:Cast(Target) then
			return
		end
	end
	-- Sprint
	if Setting("Sprint") and Spell.Sprint:IsReady() and not Buff.Sprint:Exist(Player) and Player.Moving then
		if Spell.Sprint:Cast(Player) then
			return 
		end
	end
	-- Stealth when Approaching 
	if Setting("AutoStealth") and Spell.Stealth:IsReady() and Target and Target.ValidEnemy and Target.Distance > 5 and Target.Distance < 20 and not Player.Combat and not Buff.Stealth:Exist(Player) then
		if Spell.Stealth:Cast() then
			return
		end
	end
	-- Riposte
	if Target and Spell.Riposte:IsReady() and Target.ValidEnemy then
		if Spell.Riposte:Cast(Target) then
			return
		end
	end
	-- Pick Pocket
	if Setting("Pick Pocket") and Spell.PickPocket:IsReady() and Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and Target.CreatureType == "Humanoid" then
		if Spell.PickPocket:Cast(Target) then
			return
		end
	end
	-- Cheap Shot Opener
	if Setting("Opener") == 4 and Spell.CheapShot:IsReady() and Target and Target.ValidEnemy and Buff.Stealth:Exist(Player) then
		if Spell.CheapShot:Cast(Target) then
			return
		end
	end
	--Ambush
	if Setting("Opener") == 2 and Spell.Ambush:IsReady() and Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and ObjectIsBehind("player", "target") then
		if Spell.Ambush:Cast(Target) then
			return
		end
	end
	--Garrote
	if Setting("Opener") == 3 and Spell.Garrote:IsReady() and Buff.Stealth:Exist(Player) and Target and Target.ValidEnemy and ObjectIsBehind("player", "target") then
		if Spell.Garrote:Cast(Target) then
			return
		end
	end
	-- Adrenaline Rush
	if Setting("Adrenaline Rush") == 2 and Spell.AdrenalineRush:IsReady() and Player.Combat and Buff.SliceAndDice:Exist(Player) or (Setting("Adrenaline Rush") == 3 and Enemy8YC > 1 and Player.Combat and Buff.SliceAndDice:Exist(Player)) then
		if Spell.AdrenalineRush:Cast(Player) then
			return
		end
	end
	-- Blade Flurry
	if Setting("Blade Flurry") == 2 and Spell.BladeFlurry:IsReady() and Player.Power >= 25 and Player.Combat and Buff.SliceAndDice:Exist(Player) or (Setting("Blade Flurry") == 3 and Enemy8YC > 1 and Player.Combat and Buff.SliceAndDice:Exist(Player) and Player.Power >= 25) then
		if Spell.BladeFlurry:Cast(Player) then
			return
		end
	end
	-- Backstab if possible
	if Target and Target.ValidEnemy and Spell.Backstab:IsReady() and ObjectIsBehind("player", "target") then
		if Spell.Backstab:Cast(Target) then
			return
		end
	end
		-- Eviscerate < 15%
	if Setting("Eviscerate") and Spell.Eviscerate:IsReady() then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if GetComboPoints("player", "target") > 1 and Target and (Unit.TTD < 5 or Unit.HP < 15) and Enemy8YC < 2 and Buff.SliceAndDice:Remain(Player) > 4 then
				if Spell.Eviscerate:Cast(Target) then
					return
				end
			end
		end
	end
	-- maintain SnD
	if Setting("Slice and Dice") and Spell.SliceAndDice:IsReady() then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if GetComboPoints("player", "target") > 0 and not Buff.SliceAndDice:Exist(Player) and Unit.TTD > 5 then
				if Spell.SliceAndDice:Cast() then
					return
				end
			end
		end
	end
	-- Eviscerate @ 5 CP
	if GetComboPoints("player", "target") == 5 and Spell.Eviscerate:IsReady() and Target then
		if Spell.Eviscerate:Cast(Target) then
			return
		end
	end
	-- Eviscerate > 1 CP
	if Setting("Eviscerate") and Spell.Eviscerate:IsReady() then
		for _,Unit in ipairs(Player:GetEnemies(5)) do
			if GetComboPoints("player", "target") > 1 and Target and Unit.TTD < Buff.SliceAndDice:Remain(Player) then
				if Spell.Eviscerate:Cast(Target) then
					return
				end
			end
		end
	end
		-- Autoattack everything in range
    if Setting("Auto Attack") and Target and Target.ValidEnemy and Target.Distance <5 then
        StartAttack()
	end
	-- Stop until Swing
	if Setting("Stop until swing") then
    	if (Player.SwingMH > 0 and Player.SwingMH < 0.9 * UnitAttackSpeed("player") and (Player.Power < 80 or Player.SwingMH <= Player.NextTick)) and Target and Target.TTD and Target.TTD >= 2 then
    		return true
    	end
    end
		-- Spam Sinister Strike
	if Setting("Sinister Strike") and Spell.SinisterStrike:IsReady() and Target and Target.ValidEnemy and Player.Power >= 40 and GetComboPoints("player", "target") < 5 then
		if Spell.SinisterStrike:Cast(Target) then
			return
		end
	end	

	
end