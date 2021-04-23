-- fiskee/DMWC-Warlock (https://github.com/fiskee/DMWC-Warlock) 
-- schadis/DMWC-Warrior-Buff Sniper is integrated (https://github.com/schadis/DMWC-Warrior)
-- total reworked by Banana66AUT

local DMW = DMW
local Warlock = DMW.Rotations.WARLOCK
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, Pet, Buff, Debuff, Health, Spell, Target, Talent, Item, GCD, GCDRemain, CDs, HUD, Friends40Y, Friends40YC, Enemies20Y, Enemies20YC, Enemies30Y, Enemies30YC, Enemies40Y, Enemies40YC
local Attackable40Y, Attackable40YC, PVPTarget, NewTarget, ShardCount, Curse, Opener, CurrentSpell
local DefenseDrainLife = 0
local DefenseHFunnel = 0
local TickTime = DMW.Player.TickTime or GetTime()
local TickTimeRemain = TickTime - GetTime()
local WandTime = GetTime()
local PetAttackTime = GetTime()
local ItemUsage = GetTime()
local LootBlockTime = GetTime()
local waitTable = {};
local waitFrame = nil;
local BGInstance = "none"
local newBGInstance
local PlusTime = 0
local startDelayYN = 0


local SetGenAutoBuff, SetGenBUFdbPVE, SetGenBUFdbPVP, SetGenBUFdbDUN, SetGenBUFubPVE, SetGenBUFubPVP, SetGenBUFubDUN, SetGenBUFdiPVE, SetGenBUFdiPVP, SetGenBUFdiDUN, SetGenWand, SetGenAAMelee, SetGenAutoTarget, SetGenAutoTQU, PVEP, SetBSnTarPVP, SetBSnZG, SetBSnWCB, SetBSnONYNEF	
local SetPetPET, SetPetAutoAttack, SetPetHFUyn, SetPetHFUhp, SetPetSACyn, SetPetSACplhp, SetPetSACpehp 
local SetDefCHSTyn, SetDefUHSTyn, SetDefUHSThp, SetDefUHPOyn, SetDefUHPOhp, SetDefCSSTyn, SetDefUSSTpl, SetDefUDLIyn, SetDefUDLIhp, SetDefULUFyn, SetDefUINSyn, SetDefUSWAyn, SetDefUFBEyn, SetDefUFSMyn
local SetManLITyn, SetManLITOOCyn, SetManLITmp, SetManLIThp, SetManLITSAFEyn, SetManELITyn, SetManELITmp, SetManELIThp, SetManDPCyn, SetManDPCOOCyn, SetManDOCPLmp, SetManDOCPEmp, SetManUMPOyn, SetManUMPOmp
local SetDpsSHB, SetDpsSHBmp, SetDpsSPAyn, SetDpsSFyn, SetDpsMDOli, SetDpsCurse, SetDpsCurseCYyn, SetDpsAMPyn, SetDpsCORyn, SetDpsCORCYyn, SetDpsCORCYr1, SetDpsIMMyn, SetDpsIMMCYyn, SetDpsSLIyn, SetDpsSLICYyn, SetDpsSBUyn 
local SetDpsSBUttd, SetDpsSBUhp, SetDpsDLIFIyn, SetDpsDLIFIhp, SetDpsDSSyn, SetDpsDSSms, SetDpsDSSad, SetDpsDSSsp



-- Debug
local function oocdebug(message)
    if Setting("Debug OOC") then
        print(tostring("OOC: "..message))
    end
end
-- Debug
local function mmdebug(message)
    if Setting("Debug MM") then
        print(tostring("MM: "..message))
    end
end
-- Debug
local function defdebug(message)
    if Setting("Debug Def") then
        print(tostring("Def: "..message))
    end
end
-- Debug
local function dpsdebug(message)
    if Setting("Debug DPS") then
        print(tostring("DPS: "..message))
    end
end

local function DMWCprintMSG (message)
	print(tostring("DMWC: "..message))
end

-- Delay with function after x sec.
local function DMWCwait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent)
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable
      local i = 1
      while(i<=count) do
        local waitRecord = tremove(waitTable,i)
        local d = tremove(waitRecord,1)
        local f = tremove(waitRecord,1)
        local p = tremove(waitRecord,1)
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p})
          i = i + 1
        else
          count = count - 1
          f(unpack(p))
        end
      end
    end)
  end
  tinsert(waitTable,{delay,func,{...}})
  return true
end

-- DMWC Log & Debug menue
local function logbug ()

	if Setting("Debug")
	and not DMW.UI.Debug.Frame:IsShown() 
		then
        DMW.UI.Debug.Frame:Show()
    elseif not Setting("Debug")
	and DMW.UI.Debug.Frame:IsShown()
		then
		DMW.UI.Debug.Frame:Hide()	            
	end

	if Setting("Log")
	and not DMW.UI.Log.Frame:IsShown() 
		then
        DMW.UI.Log.Frame:Show()
    elseif not Setting("Log")
	and DMW.UI.Log.Frame:IsShown()
		then
		DMW.UI.Log.Frame:Hide()	            
	end	
end

local function bntLooting (stat)
	-- Block Baneto Looting
	BANETO_BLOCK_LOOTING = stat
end

local function startDelay ()
	startDelayYN = 1
end

-- Get Curse
-- OK (Locals)
local function GetCurse()	

    if SetDpsCurse ~= 1 and HUD.Curse == 1 then
        if SetDpsCurse == 2 then
            return "CurseOfAgony"
        elseif SetDpsCurse == 3 then
            return "CurseOfShadow"
        elseif SetDpsCurse == 4 then
            return "CurseOfTheElements"
        elseif SetDpsCurse == 5 then
            return "CurseOfRecklessness"
        elseif SetDpsCurse == 6 then
            return "CurseOfWeakness"
        elseif SetDpsCurse == 7 then
            return "CurseOfTongues"
        elseif SetDpsCurse == 8 then
            return "CurseOfIdiocy"
        elseif SetDpsCurse == 9 then
            return "CurseOfDoom"
        end
    elseif Target and Target.Player then
        return "CurseOfAgony"
    end
    return nil

end


-- Settings General
-- OK (Locals)
local function ReadSetupStartDelay()
	SetStartDelay = Setting("Startup Delay")
	
	HUD = DMW.Settings.profile.HUD
	if HUD.PVE_PVP == 1 then 
		PVEP = "PVE "
	elseif HUD.PVE_PVP == 2 then 
		PVEP = "PVP "
	elseif HUD.PVE_PVP == 3 then 
		PVEP = "DUN "	
	end	
	
end




-- Settings General
-- OK (Locals)
local function ReadSetupGEN()

	SetBSnZG = Setting("ZG") 
	SetBSnWCB = Setting("WCB") 
	SetBSnONYNEF = Setting("Ony_Nef")
	
	
	SetGenWand = Setting(PVEP.."Use Wand") or false
	SetGenAAMelee = Setting(PVEP.."Auto Attack In Melee") or false
	SetGenAutoTarget = Setting(PVEP.."Auto Target") or false
	SetGenAutoTQU =	Setting(PVEP.."Auto Target Quest Units") or false
	SetBSnTarPVP = Setting(PVEP.."Active Targeting") or false	
	
	SetSwichPVPin = Setting("Swich to PVP")
	SetSwichPVPout = Setting("Swich back from PVP")
	SetSwichPVPdelay = Setting("PVP Swich Delay")
	
	SetSwichDUNin = Setting("Swich to Dungeon")
	SetSwichDUNout = Setting("Swich back from Dungeon")
	SetSwichDUNdelay = Setting("Dungeon Swich Delay")
	
end


-- Settings General
-- OK (Locals)
local function ReadSetupBUF()

	SetGenAutoBuff = Setting("Auto Buff")
	SetGenBUFdbPVE = Setting("DB on PVE")
	SetGenBUFdbPVP = Setting("DB on PVP")
	SetGenBUFdbDUN = Setting("DB on Dungeon")
	
	SetGenBUFubPVE = Setting("UB on PVE")
	SetGenBUFubPVP = Setting("UB on PVP")
	SetGenBUFubDUN = Setting("UB on Dungeon")
	
	SetGenBUFdiPVE = Setting("DI on PVE")
	SetGenBUFdiPVP = Setting("DI on PVP")
	SetGenBUFdiDUN = Setting("DI on Dungeon")

end


-- Settings Pet
-- OK (Locals)
local function ReadSetupPET()

	SetPetPET = Setting(PVEP.."Pet")
	SetPetAutoAttack = Setting(PVEP.."Auto Pet Attack")
	SetPetHFUyn = Setting(PVEP.."Health Funnel")
	SetPetHFUhp = Setting(PVEP.."Health Funnel HP")
	SetPetSACyn =	Setting(PVEP.."Sacrifice")
	SetPetSACplhp = Setting(PVEP.."Sacrifice Player HP")
	SetPetSACpehp = Setting(PVEP.."Sacrifice Pet HP")

end 


-- Settings Defense
-- OK (Locals)
local function ReadSetupDEF()

	SetDefCHSTyn = Setting(PVEP.."Create Healthstone")
	SetDefUHSTyn = Setting(PVEP.."Use Healthstone")
	SetDefUHSThp = Setting(PVEP.."Use Healthstone HP")
	SetDefUHPOyn = Setting(PVEP.."Use Health Potion")
	SetDefUHPOhp = Setting(PVEP.."Use Health Potion HP")
	SetDefCSSTyn = Setting(PVEP.."Create Soulstone")
	SetDefUSSTpl = Setting(PVEP.."Soulstone Player")
	SetDefUDLIyn = Setting(PVEP.."Drain Life")
	SetDefUDLIhp = Setting(PVEP.."Drain Life HP")
	SetDefDECOyn = Setting(PVEP.."Death Coil")
	SetDefDECOhp = Setting(PVEP.."Death Coil HP")
	SetDefULUFyn = Setting(PVEP.."Use Luffa", "Auto use luffa trinket")
	--SetDefUINSyn = Setting(PVEP.."Use Insignia")
	SetDefUSWAyn = Setting(PVEP.."Buff Shadow Ward")
	SetDefUFBEyn = Setting(PVEP.."Fear Bonus Enemy")
	SetDefUFSMyn = Setting(PVEP.."Fear Solo Farming")

end 


-- Settings Manamanagment
-- OK (Locals)
local function ReadSetupMAN()

	SetManLITyn =	Setting(PVEP.."Life Tap")
	SetManLITOOCyn = Setting(PVEP.."Life Tap OOC")
	SetManLITmp =	Setting(PVEP.."Life Tap Mana")
	SetManLIThp =	Setting(PVEP.."Life Tap HP")
	SetManLITSAFEyn =	Setting(PVEP.."Safe Life Tap")
	SetManELITyn = Setting(PVEP.."Emergency Life Tap")
	SetManELITmp = Setting(PVEP.."Emergency Life Tap Mana")
	SetManELIThp = Setting(PVEP.."Emergency Life Tap HP")
	SetManDPCyn = Setting(PVEP.."Dark Pact")
	SetManDPCOOCyn = Setting(PVEP.."Dark Pact OOC")
	SetManDOCPLmp = Setting(PVEP.."Dark Pact Mana")
	SetManDOCPEmp = Setting(PVEP.."Dark Pact Pet Mana")
	SetManUMPOyn = Setting(PVEP.."Use Mana Potion")
	SetManUMPOmp = Setting(PVEP.."Use Mana Potion MP")

end


-- Settings Damage
-- OK (Locals)
local function ReadSetupDPS()

	SetDpsSHB =	Setting(PVEP.."Shadow Bolt Mode")
	SetDpsSHBmp = Setting(PVEP.."Shadow Bolt Mana")
	SetDpsSPAyn = Setting(PVEP.."Searing Pain")
	SetDpsSFyn = Setting(PVEP.."Soul Fire")
	SetDpsMDOli = Setting(PVEP.."Multidot Limit")
	SetDpsCurse = Setting(PVEP.."Curse")
	SetDpsCurseCYyn = Setting(PVEP.."Cycle Curse")
	SetDpsAMPyn = Setting(PVEP.."Amplify Curse")
	SetDpsCORyn = Setting(PVEP.."Corruption")
	SetDpsCORCYyn = Setting(PVEP.."Cycle Corruption")
	SetDpsCORCYr1 = Setting(PVEP.."Cycle Rank 1")
	SetDpsIMMyn = Setting(PVEP.."Immolate")
	SetDpsIMMCYyn = Setting(PVEP.."Cycle Immolate")
	SetDpsSLIyn = Setting(PVEP.."Siphon Life")
	SetDpsSLICYyn = Setting(PVEP.."Cycle Siphon Life")
	SetDpsSBUyn = Setting(PVEP.."Shadowburn")
	SetDpsSBUttd = Setting(PVEP.."Shadowburn TTD")
	SetDpsSBUhp = Setting(PVEP.."Shadowburn HP")
	SetDpsDLIFIyn = Setting(PVEP.."Drain Life Filler")
	SetDpsDLIFIhp = Setting(PVEP.."Drain Life Filler HP")
	SetDpsDSSyn = Setting(PVEP.."Drain Soul Snipe")
	SetDpsDSSms = Setting(PVEP.."Max Shards")
	SetDpsDSSad = Setting(PVEP.."Auto Delete Shards")
	SetDpsDSSsp = Setting(PVEP.."Stop DS At Max Shards")

end


-- Locals
-- OK (Warlock.Rotation)
local function Locals()

    Player = DMW.Player
    Pet = DMW.Player.Pet
    Buff = Player.Buffs
    Debuff = Player.Debuffs
	Health = Player.Health
	if Pet and not Pet.Dead then PetMana = Pet.Power else PetMana = 0 end
	if Pet and not Pet.Dead then PetManaPct = Pet.PowerPct else PetManaPct = 0 end
	Spell = Player.Spells
    Talent = Player.Talents
    Item = Player.Items
    Target = Player.Target or false
    GCD = Player:GCD()
    GCDRemain = Player:GCDRemain()
    CDs = Player:CDs()
    Friends40Y, Friends40YC = Player:GetFriends(40)
	Enemies20Y, Enemies20YC = Player:GetEnemies(20)
    Enemies30Y, Enemies30YC = Player:GetEnemies(30)
	Enemies40Y, Enemies40YC = Player:GetEnemies(36)
	Attackable40Y, Attackable40YC = Player:GetAttackable(36)
    ReadSetupGEN()
	ReadSetupBUF()
	ReadSetupPET()
	ReadSetupDEF()
	ReadSetupMAN()
	ReadSetupDPS()
    TickTime = DMW.Player.TickTime or GetTime() + 0.05
    TickTimeRemain = TickTime - GetTime()
	Item.HealthPotion = Player:GetPotion("health")
    Item.ManaPotion = Player:GetPotion("mana")
    CurrentSpell = Player:CurrentCast()
	Curse = GetCurse()
	
end


-- Defens Pioriti 1
-- OK (Warlock.Rotation)
function DefensPrio1()
	
	if Player.Combat then 
		
		-- Reset DrainLifeCounter
		if Player.HP > 75 then DefenseDrainLife = 0 end
		
		-- Use Death Coil
		if SetDefDECOyn and Spell.DeathCoil:Known() and Player.HP < SetDefDECOhp and Spell.DeathCoil:Cast(Target) then defdebug("Use Death Coil") return true end

			
		-- Use Healthstone
		if SetDefUHSTyn and Player.HP < SetDefUHSThp then
			if (DMW.Time - ItemUsage) > 0.2 and  Item.MajorHealthstone and Item.MajorHealthstone:IsReady() and Item.MajorHealthstone:Use(Player) then defdebug("Use Major Healthstone IC") ItemUsage = DMW.Time return true end
			if (DMW.Time - ItemUsage) > 0.2 and  Item.GreaterHealthstone and Item.GreaterHealthstone:IsReady() and Item.GreaterHealthstone:Use(Player) then defdebug("Use Greater Healthstone IC") ItemUsage = DMW.Time return true end
			if (DMW.Time - ItemUsage) > 0.2 and  Item.Healthstone and Item.Healthstone:IsReady() and Item.Healthstone:Use(Player) then defdebug("Use Healthstone IC") ItemUsage = DMW.Time return true end
			if (DMW.Time - ItemUsage) > 0.2 and  Item.LesserHealthstone and Item.LesserHealthstone:IsReady() and Item.LesserHealthstone:Use(Player) then defdebug("Use Lesser Healthstone IC") ItemUsage = DMW.Time return true end
			if (DMW.Time - ItemUsage) > 0.2 and  Item.MinorHealthstone and Item.MinorHealthstone:IsReady() and Item.MinorHealthstone:Use(Player) then defdebug("Use Minor Healthstone IC") ItemUsage = DMW.Time return true end
		end
		
		-- Use Health Potion
        if SetDefUHPOyn and Player.HP < SetDefUHPOhp then
			if (DMW.Time - ItemUsage) > 0.2 and Item.HealthPotion and Item.HealthPotion:IsReady() and Item.HealthPotion:Use(Player) then defdebug("Use Heal Potion IC") ItemUsage = DMW.Time return true end
        end
				
		-- Use Sacrifice Player HP Low
		 if SetPetSACyn and Player.HP < SetPetSACplhp and Pet and not Pet.Dead  and (GetPetActionInfo(4) == GetSpellInfo(3716)) and Spell.Sacrifice:Cast(Player) then defdebug("Sacrifice Player HP low IC") return true end
		 
		-- Use Sacrifice Pet HP Low
		if Pet and not Pet.Dead then
			if SetPetSACyn and Pet.HP < SetPetSACpehp and (GetPetActionInfo(4) == GetSpellInfo(3716)) and Spell.Sacrifice:Cast(Player) then defdebug("Sacrifice Pet HP low IC") return true end
		end 
		
		-- Use Drain Life Player Low
		Target = Player.Target or false
		if not Player.Casting and not Player.Moving and Target then
			if SetDefUDLIyn and Player.HP < SetDefUDLIhp and Target.CreatureType ~= "Mechanical" and DefenseDrainLife <= 2 and Spell.DrainLife:Cast(Target) then DefenseDrainLife = DefenseDrainLife + 1 defdebug("Cast Drain Life HP low IC") return true end
		end
		
		-- Use Luffa
		if (DMW.Time - ItemUsage) > 0.2 and SetDefULUFyn and Item.Luffa:Equipped() and Item.Luffa:IsReady() and Player:Dispel(Item.Luffa) and Item.Luffa:Use(Player) then defdebug("Use Luffa") ItemUsage = DMW.Time return true end
	end

end


-- Do Buff
-- OK (OCC)
local function WarlockBuff()

	--Demon Buff 
	if (SetGenBUFdbPVE and  HUD.PVE_PVP == 1) or (SetGenBUFdbPVP and  HUD.PVE_PVP == 2) or (SetGenBUFdbDUN and  HUD.PVE_PVP == 3)   then
		-- Buff Demon Armor if known
		if Spell.DemonArmor:Known() then
			if  Buff.DemonArmor:Remain() < 300 and Spell.DemonArmor:Cast(Player) then oocdebug("Buff: Demon Armor") return true end
		-- or Buff Demon Armor if known
		elseif Spell.DemonSkin:Known() then
			if  Buff.DemonSkin:Remain() < 300 and Spell.DemonSkin:Cast(Player) then oocdebug("Buff: Demon Skin") return true end
		end
	end
	
	--Unending Breath
	if (SetGenBUFubPVE and  HUD.PVE_PVP == 1) or (SetGenBUFubPVP and  HUD.PVE_PVP == 2) or (SetGenBUFubDUN and  HUD.PVE_PVP == 3)   then
		-- Buff Unending Breath when swimming
		if Spell.UnendingBreath:Known() then
			if  IsSwimming() and Buff.UnendingBreath:Remain() < 30 and Spell.UnendingBreath:Cast(Player) then oocdebug("Buff: Unending Breath") return true end
		end
	end
	
	--Detect Invisibility
	if (SetGenBUFdiPVE and  HUD.PVE_PVP == 1) or (SetGenBUFdiPVP and  HUD.PVE_PVP == 2) or (SetGenBUFdiDUN and  HUD.PVE_PVP == 3)   then
	
		if Spell.DetectGreaterInvisibility:Known() then
		-- Buff Detect Greater Invisibility if knowen
			if  Buff.DetectGreaterInvisibility:Remain() < 30 and Spell.DetectGreaterInvisibility:Cast(Player) then oocdebug("Buff: Detect Invisibility") return true end
		-- Buff Detect Invisibility if knowen
		elseif Spell.DetectInvisibility:Known() then
			if  Buff.DetectInvisibility:Remain() < 30 and Spell.DetectInvisibility:Cast(Player) then oocdebug("Buff: Detect Invisibility") return true end
		--Buff Detect Lesser Invisibility if knowen
		elseif Spell.DetectLesserInvisibility:Known() then
			if  Buff.DetectLesserInvisibility:Remain() < 30 and Spell.DetectLesserInvisibility:Cast(Player) then oocdebug("Buff: Detect Lesser Invisibility") return true end
		end
	end
	
	
end


-- Do Create Healthstone
-- OK (OCC)
local function CreateHealthstone()
		PlusTime = 4
		if Spell.CreateHealthstoneMajor:Known() then
			if not Spell.CreateHealthstoneMajor:LastCast() and not Item.MajorHealthstone:InBag() and Spell.CreateHealthstoneMajor:Cast(Player) then 
				if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
				if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
				if DMWAPI == "bntapi" then bntLooting(true) end
				if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
				oocdebug("Create Major Healthstone") 
				return true 
			end
		elseif Spell.CreateHealthstoneGreater:Known() then
			if not Spell.CreateHealthstoneGreater:LastCast() and not Item.GreaterHealthstone:InBag() and Spell.CreateHealthstoneGreater:Cast(Player) then 
				if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
				if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
				if DMWAPI == "bntapi" then bntLooting(true) end
				if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
				oocdebug("Create Greater Healthstone") 
				return true 
			end
		elseif Spell.CreateHealthstone:Known() then
			if not Spell.CreateHealthstone:LastCast() and not Item.Healthstone:InBag() and Spell.CreateHealthstone:Cast(Player) then 
				if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
				if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
				if DMWAPI == "bntapi" then bntLooting(true) end
				if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
				oocdebug("Create Healthstone") 
				return true 
			end
		elseif Spell.CreateHealthstoneLesser:Known() then
			if not Spell.CreateHealthstoneLesser:LastCast() and not Item.LesserHealthstone:InBag() and Spell.CreateHealthstoneLesser:Cast(Player) then 
				if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
				if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
				if DMWAPI == "bntapi" then bntLooting(true) end
				if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
				oocdebug("Create Lesser Healthstone") 
				return true 
			end
		elseif Spell.CreateHealthstoneMinor:Known() then
			if not Spell.CreateHealthstoneMinor:LastCast() and not Item.MinorHealthstone:InBag() and Spell.CreateHealthstoneMinor:Cast(Player) then 
				if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
				if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
				if DMWAPI == "bntapi" then bntLooting(true) end
				if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
				oocdebug("Create Minor Healthstone") 
				return true 
			end
		end
		
end


-- Do Create Soulstone
-- OK (OCC)
local function CreateSoulstone()
	PlusTime = 4
    if Spell.CreateSoulstoneMajor:Known() then
        if not Spell.CreateSoulstoneMajor:LastCast() and not Item.MajorSoulstone:InBag() and Spell.CreateSoulstoneMajor:Cast(Player) then 
			if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			if DMWAPI == "bntapi" then bntLooting(true) end
			if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
			oocdebug("Create Major Soulstone") 
			return true 
		end
    elseif Spell.CreateSoulstoneGreater:Known() then
        if not Spell.CreateSoulstoneGreater:LastCast() and not Item.GreaterSoulstone:InBag() and Spell.CreateSoulstoneGreater:Cast(Player) then 
			if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			if DMWAPI == "bntapi" then bntLooting(true) end
			if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
			oocdebug("Create Greater Soulstone") 
			return true 
		end
    elseif Spell.CreateSoulstone:Known() then
        if not Spell.CreateSoulstone:LastCast() and not Item.Soulstone:InBag() and Spell.CreateSoulstone:Cast(Player) then 
			if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			if DMWAPI == "bntapi" then bntLooting(true) end
			if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
			oocdebug("Create Soulstone") 
			return true 
		end
    elseif Spell.CreateSoulstoneLesser:Known() then
        if not Spell.CreateSoulstoneLesser:LastCast() and not Item.LesserSoulstone:InBag() and Spell.CreateSoulstoneLesser:Cast(Player) then 
			if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			if DMWAPI == "bntapi" then bntLooting(true) end
			if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
			oocdebug("Create Lesser Soulstone") 
			return true 
		end
    elseif Spell.CreateSoulstoneMinor:Known() then
        if not Spell.CreateSoulstoneMinor:LastCast() and not Item.MinorSoulstone:InBag() and Spell.CreateSoulstoneMinor:Cast(Player) then 
			if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			if DMWAPI == "bntapi" then bntLooting(true) end
			if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
			oocdebug("Create Minor Soulstone") 
			return true 
		end
    end

end


-- Count Shards an Delete > Max
-- OK (OCC)
local function Shards(Max)

    Max = Max or 99
    local Count = 0
    for Bag = 0, 4, 1 do
        for Slot = 1, GetContainerNumSlots(Bag), 1 do
            local ItemID = GetContainerItemID(Bag, Slot)
            if ItemID and ItemID == 6265 then
                if Count >= Max and SetDpsDSSad then
                    PickupContainerItem(Bag, Slot)
                    DeleteCursorItem()
					oocdebug("Delete Shard to max.: "..Count)
                else
                    Count = Count + 1
                end
            end
        end
    end
    return Count

end


-- Out of Combat
-- OK (Warlock.Rotation)
local function OOC()

    if not Player.Casting and not Player.Combat then 
	
			
		DefenseDrainLife = 0
		DefenseHFunnel = 0
	
		-- Buff 
		if SetGenAutoBuff and WarlockBuff() then oocdebug("Auto Buff") return true end
		
		-- Count and delete Shards
        ShardCount = Shards(SetDpsDSSms)
		
		-- Summon Pet
		if ShardCount > 0 then
			if (not Pet or Pet.Dead) and SetPetPET ~= 1 then
				PlusTime = 11
				if Spell.FelDomination:Known() and (Spell.FelDomination:CD() == 0 or Spell.FelDomination:CD() == nil) and not Spell.FelDomination:LastCast() and Spell.FelDomination:Cast(Player) then
					PlusTime = 6
					return true
				end
				
				if SetPetPET == 2 and not Spell.SummonImp:LastCast() and Spell.SummonImp:Cast(Player) then 
					if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
					if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
					if DMWAPI == "bntapi" then bntLooting(true) end
					if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
					oocdebug("Soummon Imp")
					return true
				elseif SetPetPET == 3 and not Spell.SummonVoidwalker:LastCast() and Spell.SummonVoidwalker:Cast(Player) then  
					if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
					if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
					if DMWAPI == "bntapi" then bntLooting(true) end
					if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
					oocdebug("Soummon Voidwalker") 
					return true
				elseif SetPetPET == 4 and not Spell.SummonSuccubus:LastCast() and Spell.SummonSuccubus:Cast(Player) then  
					if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
					if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
					if DMWAPI == "bntapi" then bntLooting(true) end
					if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
					oocdebug("Soummon Succubus") 
					return true
				elseif SetPetPET == 5 and not Spell.SummonFelhunter:LastCast() and Spell.SummonFelhunter:Cast(Player) then  
					if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
					if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
					if DMWAPI == "bntapi" then bntLooting(true) end
					if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
					oocdebug("Soummon Felhunter") 
					return true
				end				
			end

		else
			if (not Pet or Pet.Dead) and SetPetPET ~= 1 then
				PlusTime = 12
				if Spell.FelDomination:Known() and (Spell.FelDomination:CD() == 0 or Spell.FelDomination:CD() == nil) and not Spell.FelDomination:LastCast() and Spell.FelDomination:Cast(Player) then
					PlusTime = 6
					return true
				end
				if SetPetPET ~= 1 and not Spell.SummonImp:LastCast() and Spell.SummonImp:Cast(Player) then 
					if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
					if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
					if DMWAPI == "bntapi" then bntLooting(true) end
					if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
					oocdebug("Soummon Imp - no Shards") 
					return true 
				end
			end

		end
				
		-- If Shards then Create Heal- or Soulstone
		if ShardCount > 0 then
			if SetDefCHSTyn and CreateHealthstone() then oocdebug("Create Healthstone") return true end
			if SetDefCSSTyn and CreateSoulstone() then oocdebug("Create Soulstone") return true end
        end
		
		-- Soulstone Player is Option
		if SetDefUSSTpl and Player.Instance == "none" and (DMW.Time - ItemUsage) > 0.2 and not Buff.SoulstoneResurrection:Exist(Player) and (Item.MajorSoulstone:Use(Player) or Item.GreaterSoulstone:Use(Player) or Item.Soulstone:Use(Player) or Item.LesserSoulstone:Use(Player) or Item.MinorSoulstone:Use(Player)) then
			PlusTime = 4
			if DMWAPI == "bntapi" then BANETO_DELAY_MESHPATHING = GetTime()+PlusTime end
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			if DMWAPI == "bntapi" then bntLooting(true) end
			if DMWAPI == "bntapi" then DMWCwait(PlusTime, bntLooting, false) end
			ItemUsage = DMW.Time
			oocdebug("Soulstone on yourself")
			return true
        end
		
		-- Dark Pact OOC
		if Pet and not Pet.Dead and SetManDPCOOCyn and not Player.Moving and Player.PowerPct <= SetManDOCPLmp and PetManaPct > SetManDOCPEmp and Spell.DarkPact:Cast(Player) then oocdebug("Dark Pact OOC") mmdebug("Dark Pact OOC") return true end
		
		-- Life Tap OOC
        if SetManLITOOCyn and not Player.Moving and Player.HP >= SetManLIThp and Player.PowerPct <= SetManLITmp and Spell.LifeTap:Cast(Player) then oocdebug("Life Tap OOC") mmdebug("Life Tap OOC") return true end
	  
        -- Auto Target Quest Units
		if SetGenAutoTQU then
            if Player:AutoTargetQuest(30, true) then oocdebug("Auto Target Quest Unit") return true end
        end
     end

end


-- Manamanagment
-- OK (Warlock.Rotation)
local function Manamanagment ()

	if not Player.Casting and Player.Combat then 
		-- Dark Pact
		if Pet and not Pet.Dead and SetManDPCyn and Player.PowerPct <= SetManDOCPLmp and Pet:PowerPct() > SetManDOCPEmp and Spell.DarkPact:Cast(Player) then mmdebug("Dark Pact IC") return true end
	
		-- Life Tap
		if SetManLITSAFEyn then
			if SetManLITyn and Player.HP >= SetManLIThp and Player.PowerPct <= SetManLITmp and not Debuff.LivingBomb:Exist(Player) and Spell.LifeTap:Cast(Player) then mmdebug("Life Tap IC") return true end
		else
			if SetManLITyn and Player.HP >= SetManLIThp and Player.PowerPct <= SetManLITmp and not Debuff.LivingBomb:Exist(Player) and not Player:IsTanking() and Spell.LifeTap:Cast(Player) then mmdebug("Life Tap IC Safe") return true end
		end 
				
		-- Life Tap Emergency
        if SetManELITyn and Player.HP >= SetManELIThp and Player.PowerPct <= SetManELITmp and not Debuff.LivingBomb:Exist(Player) and Spell.LifeTap:Cast(Player) then mmdebug("Emergency Life Tap IC") return true end
		
		
		-- Mana Potion
        if SetManUMPOyn and Item.ManaPotion and Item.ManaPotion:IsReady() and Player.PowerPct < SetManUMPOmp then
            if Item.ManaPotion:Use() then mmdebug("Use Mana Potion") return true end
        end
	end

end


-- Cycle Damage
-- OK (Damage)
local function Cycle()

	-- Cycle Siphon Life
    if SetDpsSLIyn and SetDpsSLICYyn and Debuff.SiphonLife:Count() <= SetDpsMDOli then
        for _, Unit in ipairs(Enemies30Y) do
            if not Debuff.SiphonLife:Exist(Unit) and Unit.TTD > 10 and Unit.CreatureType ~= "Totem" and Spell.SiphonLife:Cast(Unit) then dpsdebug("Cycle Siphon Life: "..Debuff.SiphonLife:Count()) return true end
        end
    end
	
	-- Cycle Corruption
    if SetDpsCORyn and SetDpsCORCYyn and (not Player.Moving or Talent.ImprovedCorruption.Rank == 5) and Debuff.Corruption:Count() <= SetDpsMDOli then
        for _, Unit in ipairs(Enemies30Y) do
            if (not Spell.Corruption:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7) or not UnitIsUnit(Spell.Corruption.LastBotTarget, Unit.Pointer)) and Unit.CreatureType ~= "Totem" and (Unit.Facing or (Talent.ImprovedCorruption.Rank == 5 and DMW.Settings.profile.Enemy.AutoFace)) and not Debuff.Corruption:Exist(Unit) and Unit.TTD > 7 and ((SetDpsCORCYr1 and Spell.Corruption:Cast(Unit, 1)) or Spell.Corruption:Cast(Unit)) then dpsdebug("Cycle Corruption: "..Debuff.Corruption:Count()) return true end
        end
    end
	
	-- Cycle Curse
    if Curse and SetDpsCurseCYyn and Debuff[Curse]:Count() <= SetDpsMDOli then
        for _, Unit in ipairs(Enemies30Y) do
            if not Debuff[Curse]:Exist(Unit) and Unit.TTD > 10 and Unit.CreatureType ~= "Totem" and Spell[Curse]:Cast(Unit) then dpsdebug("Cycle Curse: "..Debuff[Curse]:Count()) return true end
        end
    end
	
	-- Cycle Immolate
    if SetDpsIMMyn and SetDpsIMMCYyn and not Player.Moving and Debuff.Immolate:Count() <= SetDpsMDOli then
        for _, Unit in ipairs(Enemies30Y) do
            if (not Spell.Immolate:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7) or not UnitIsUnit(Spell.Immolate.LastBotTarget, Unit.Pointer)) and Unit.CreatureType ~= "Totem" and Unit.Facing and not Debuff.Immolate:Exist(Unit) and Unit.TTD > 10 and Spell.Immolate:Cast(Unit) then dpsdebug("Cycle Immolate: "..Debuff.Immolate:Count()) return true end
        end
    end

end


-- Single Damage
-- OK (Damage)
local function Single()

	-- Cast Corruption
	Target = Player.Target or false
    if SetDpsCORyn and (not Player.Moving or Talent.ImprovedCorruption.Rank == 5) and (not Spell.Corruption:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7) or not UnitIsUnit(Spell.Corruption.LastBotTarget, Target.Pointer)) and Target.CreatureType ~= "Totem" and (Target.Facing or (Talent.ImprovedCorruption.Rank == 5 and DMW.Settings.profile.Enemy.AutoFace)) and not Debuff.Corruption:Exist(Target) and Target.TTD > 7 and Spell.Corruption:Cast(Target) then dpsdebug("Single Corruption") return true end
    
	-- Cast Curse
	Target = Player.Target or false
	if Curse and Target.CreatureType ~= "Totem" and Target.TTD > 10 and not Debuff[Curse]:Exist(Target) then
		-- Amplify Curse
        if SetDpsAMPyn and Target.TTD > 15 and Target.Distance <= Spell[Curse].MaxRange and Spell.AmplifyCurse:Cast(Player) then dpsdebug("Use Amplify Curse") return true end
        
		-- Cast Curse
		if Spell[Curse]:Cast(Target) then dpsdebug("Single Curse") return true end
    end
	
	-- Cast Siphon Life
	Target = Player.Target or false
    if SetDpsSLIyn and not Debuff.SiphonLife:Exist(Target) and Target.TTD > 10 and Target.CreatureType ~= "Totem" and not Spell.SiphonLife:LastCast() and Spell.SiphonLife:Cast(Target) then dpsdebug("Single Siphon Life") return true end
    		
	-- Cast Immolate
	Target = Player.Target or false
	if (SetDpsIMMyn or Spell.ShadowBolt:CD() > 2) and not Player.Moving and (not Spell.Immolate:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7) or not UnitIsUnit(Spell.Immolate.LastBotTarget, Target.Pointer)) and Target.CreatureType ~= "Totem" and Target.Facing and not Debuff.Immolate:Exist(Target) and Target.TTD > 10 and Spell.Immolate:Cast(Target) then dpsdebug("Single Immolate") return true end

end


-- Wand 
-- OK (Damage)
local function Wand()
	Target = Player.Target or false
    if not Player.Moving and not DMW.Helpers.Queue.Spell and not IsAutoRepeatSpell(Spell.Shoot.SpellName) and (DMW.Time - WandTime) > 0.7 and  not SetGenAAMelee and
    (Player.PowerPct < 10 or Spell.ShadowBolt:CD() > 2 or ((not Curse or not Spell[Curse]:Known() or Debuff[Curse]:Exist(Target) or Target.TTD < 10 or Target.CreatureType == "Totem") and 
    (not SetDpsIMMyn or not Spell.Immolate:Known() or Debuff.Immolate:Exist(Target) or Target.TTD < 10 or Target.CreatureType == "Totem") and 
    (not SetDpsCORyn or not Spell.Corruption:Known() or Debuff.Corruption:Exist(Target) or Target.TTD < 7 or Target.CreatureType == "Totem") and
    (not SetDpsSLIyn or not Spell.SiphonLife:Known() or Debuff.SiphonLife:Exist(Target) or Target.TTD < 10 or Target.CreatureType == "Totem") and
    (SetDpsSHB == 1 or not Spell.ShadowBolt:Known() or Player.PowerPct < SetDpsSHBmp or Target.TTD < Spell.ShadowBolt:CastTime()) and
    (not SetDpsDLIFIyn or not Spell.DrainLife:Known() or Player.HP > SetDpsDLIFIhp or Target.CreatureType == "Mechanical" or (not Target.Player and Target.TTD < 3) or Target.Distance > Spell.DrainLife.MaxRange)))
    and Spell.Shoot:Cast(Target) then
		dpsdebug("Use Wand")
        WandTime = DMW.Time
        return true
    end

end


-- Damage
-- OK (Warlock.Rotation)
local function Damage ()

	-- Swich to new Target if Target in Fear
	Target = Player.Target or false
    if Player.Casting and Player.Casting == Spell.Fear.SpellName and NewTarget then
        TargetUnit(NewTarget.Pointer)
        DMW.Player.Target = NewTarget
        NewTarget = false
		dpsdebug("New Target after Fear")
    end
	
	-- PVP active Targeting
	Target = Player.Target or false
	if HUD.PVE_PVP == 2 and SetBSnTarPVP then
		if Target.Distance > 30 then
			if DMWAPI == "bntapi" or DMWAPI == "wmbapi" then StopMoving() end
			for i, Unit in ipairs(Enemies20Y) do
                if i > 1 and Unit.TTD > 3 then PVPTarget = Unit return true end
            end
		end		
		if PVPTarget then
			TargetUnit(PVPTarget.Pointer)
			DMW.Player.Target = PVPTarget
			PVPTarget = false
			dpsdebug("New PVP Target")
		end
	end 
	
	-- Auto Target in Combat
	Target = Player.Target or false
	if Player.Combat and SetGenAutoTarget and HUD.PVE_PVP == 1 then
		if Player:AutoTarget(30, true) then dpsdebug("Auto Target IC") return true end
    end

	if not Player.Casting then
		-- Force Schadow Bolt on Shadow Trance
        if SetDpsSHB ~= 1 and Buff.ShadowTrance:Exist(Player) and Buff.ShadowTrance:Remain(Player) < 2 and Player.PowerPct >= SetDpsSHBmp and Spell.ShadowBolt:Cast(Target) then dpsdebug("Force Schadow Bolt on Shadow Trance") return true end
        
        --Force refresh Corruption on fear
        if SetDpsCORyn and Debuff.Fear:Exist(Target) and (Spell.Fear:LastCast() or Spell.Fear:LastCast(2)) and Debuff.Corruption:Remain(Target) < Target.TTD and (not Player.Moving or Talent.ImprovedCorruption.Rank == 5) and Spell.Corruption:Cast(Target) then dpsdebug("Force Corruption on Fear") return true end
    end
	
	-- Drain Soul 
	Target = Player.Target or false
	if not Player.Moving and not Target.Player and SetDpsDSSyn and (not SetDpsDSSsp or ShardCount < SetDpsDSSms) and (not Player.Casting or (Player.Casting ~= Spell.DrainSoul.SpellName and Player.Casting ~= Spell.Hellfire.SpellName and Player.Casting ~= Spell.RainOfFire.SpellName)) and Spell.DrainSoul:CD() < 0.2 and Debuff.Shadowburn:Count() == 0 then
        for _, Unit in ipairs(Enemies30Y) do
            if Unit.Facing and Unit.Level > DMW.Enums.GrayLvl[Player.Level] and not Unit.Player and (Unit.TTD < 3 or Unit.HP < 8) and not Unit:IsBoss() and not UnitIsTapDenied(Unit.Pointer) then
                if Spell.DrainSoul:Cast(Unit) then dpsdebug("Drain Soul") WandTime = DMW.Time return true end
            end
        end
    end
	
	-- Shadowburn
	Target = Player.Target or false
    if SetDpsSBUyn and ShardCount >= SetDpsDSSms and (not Player.Casting or (Player.Casting ~= Spell.DrainSoul.SpellName and Player.Casting ~= Spell.Hellfire.SpellName and Player.Casting ~= Spell.RainOfFire.SpellName)) and Spell.Shadowburn:IsReady() then
        for _, Unit in ipairs(Enemies30Y) do
            if Unit.Facing and (Unit.TTD < SetDpsSBUttd or Unit.HP < SetDpsSBUhp ) and not Unit:IsBoss() and not UnitIsTapDenied(Unit.Pointer) then
                if Player.Casting then SpellStopCasting() end
                if Spell.Shadowburn:Cast(Unit) then dpsdebug("Shadowburn") return true end
            end
        end
    end
	
    if not Player.Casting then
		-- Fear Bonus Enemy
		Target = Player.Target or false
        if not Player.Moving and SetDefUFBEyn and Spell.Fear:IsReady() and Debuff.Fear:Count() == 0 and (not Spell.Fear:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7)) then
            local CreatureType = Target.CreatureType
            if Enemies20YC > 1 and not Player.InGroup and not (CreatureType == "Undead" or CreatureType == "Mechanical" or CreatureType == "Totem") and Target.TTD > 3 and not Target:IsBoss() and
            (not SetDpsIMMyn or not Spell.Immolate:Known() or Debuff.Immolate:Exist(Target) or Target.TTD < 10) and 
            (not SetDpsCORyn or not Spell.Corruption:Known() or Debuff.Corruption:Exist(Target) or Target.TTD < 7) and
            (not SetDpsSLIyn or not Spell.SiphonLife:Known() or Debuff.SiphonLife:Exist(Target) or Target.TTD < 10) and 
            (not Curse or not Spell[Curse]:Known() or Debuff[Curse]:Exist(Target) or Target.TTD < 10 ) then                    
                for i, Unit in ipairs(Enemies20Y) do
                    if i > 1 and Unit.TTD > 3 and Spell.Fear:Cast(Target) then dpsdebug("Fear Bonus Enemy") NewTarget = Unit return true end
                end
            end
        end
		
		-- Pet Attack
		Target = Player.Target or false
        if SetPetAutoAttack and Pet and not Pet.Dead and not UnitIsUnit(Target.Pointer, "pettarget") and DMW.Time > (PetAttackTime + 1) then
            PetAttackTime = DMW.Time
            PetAttack()
			dpsdebug("Pet Attack")
        end
		
		-- Start Autoattack if no Wand or Setting:Auto Attack In Melee
		Target = Player.Target or false
        if not SetGenWand and (not DMW.Player.Equipment[18] or (Target.Distance <= 1 and SetGenAAMelee)) and not IsCurrentSpell(Spell.Attack.SpellID) then
            StartAttack()
			dpsdebug("Auto Attack if no Wand or no Setup")
        end
		
		
		
		-- Start Single-Damage Rotation
		Target = Player.Target or false
        if Single() then return true end
		
		-- Start Soul Fire on CD
		Target = Player.Target or false
        if SetDpsSFyn and Spell.SoulFire:Known() and not Player:IsTanking() and Target.TTD > 20 and not Player.Moving and  Spell.SoulFire:Cast(Target) then dpsdebug("Soul Fire") return true end
					
		-- Start Cycle-Damage Rotation
		Target = Player.Target or false
        if Cycle() then return true end
		
        -- Fear on Solo Farming
		Target = Player.Target or false
		if SetDefUFSMyn and not Player.Moving and Target.TTD > 3 and #DMW.Friends.Units < 2 and not (Target.CreatureType == "Undead" or Target.CreatureType == "Mechanical" or Target.CreatureType == "Totem") and (SetDpsSHB ~= 2 or Player.PowerPct < SetDpsSHBmp or Spell.ShadowBolt:LastCast() or (Spell.ShadowBolt:LastCast(2) and (Spell.LifeTap:LastCast() or Spell.DarkPact:LastCast()))) and Debuff.Fear:Count() == 0 and (not Spell.Fear:LastCast() or (DMW.Player.LastCast[1].SuccessTime and (DMW.Time - DMW.Player.LastCast[1].SuccessTime) > 0.7)) and Spell.Fear:Cast(Target) then dpsdebug("Fear Solo Farming") return true end
        
		-- Use Shadow Bolt on Always
		Target = Player.Target or false
		if SetDpsSHB == 2 and Target.Facing and (not Player.Moving or Buff.ShadowTrance:Exist(Player)) and Player.PowerPct > SetDpsSHBmp and (Target.TTD > Spell.ShadowBolt:CastTime() or (Target.Distance > 5 and not DMW.Player.Equipment[18])) and Spell.ShadowBolt:Cast(Target) then dpsdebug("Schadow Bolt Always") return true end
        
		-- Use Shadow Bolt on Shadow Trance
		Target = Player.Target or false
		if SetDpsSHB == 3 and Target.Facing and Player.PowerPct > SetDpsSHBmp and Buff.ShadowTrance:Exist(Player) and Spell.ShadowBolt:Cast(Target) then dpsdebug("Shadow Bolt on Shadow Trance") return true end
        
		-- Searing Pain on CD or Always
		Target = Player.Target or false
		if SetDpsSPAyn and Target.Facing and not Player.Moving and (SetDpsSHB ~= 2 or Spell.ShadowBolt:CD() > 2 or Target.TTD < Spell.ShadowBolt:CastTime()) and Spell.SearingPain:Cast(Target) then dpsdebug("Searing Pain") return true end
		
		-- Drain Life as Filler
		Target = Player.Target or false
        if SetDpsDLIFIyn and not Player.Moving and Player.HP <= SetDpsDLIFIhp and Target.CreatureType ~= "Mechanical" and (Target.Player or Target.TTD > 3) and Spell.DrainLife:Cast(Target) then dpsdebug("Drain Life as Filler") return true end

		-- Use Wand
		Target = Player.Target or false
		if SetGenWand and DMW.Player.Equipment[18] and Target.Facing and Wand() then return true end
    end
	
end


-- Defense Prio2
-- OK (Warlock.Rotation)
local function DefensePrio2 ()
	if Player.Combat then
	  
		-- Cast Shodow Ward on Target by Priest or Warlock 
		if Player.Target and (Target.Class == "PRIEST" or Target.Class == "WARLOCK") and SetDefUSWAyn and Spell.ShadowWard:Cast(Player) then defdebug("Shodow Ward") return true end
		
		-- Health Funnel to Pet - If Player HP > 60
		if not Player.Casting and not Player.Moving and SetPetHFUyn and Pet and DefenseHFunnel <= 1 and not Pet.Dead and Pet.HP < SetPetHFUhp and Player.HP > 60 and Spell.HealthFunnel:Cast(Pet) then defdebug(" Health Funnel to Pet") return true end
	end
end


-- Buff Sniper
-- OK (Warlock.Rotation)
local function Buffsniper()
local worldbufffound = false
	
	if (SetBSnWCB or SetBSnONYNEF or SetBSnZG)
		then
		if SetBSnWCB 
		and not SetBSnONYNEF
		and not SetBSnZG
		then
			
			for i = 1, 40 do
				if select(10, UnitAura("player", i)) == 16609 then
				worldbufffound = true
				break end
			end	
		elseif SetBSnONYNEF
		and not SetBSnWCB 
		and not SetBSnZG
		then
			
			for i = 1, 40 do
				if select(10, UnitAura("player", i)) == 22888 then
				worldbufffound = true
				break end
			end	
		elseif SetBSnZG
		and not SetBSnWCB 
		and not SetBSnONYNEF		
		then
			
			for i = 1, 40 do
				if select(10, UnitAura("player", i)) == 24425 then
				worldbufffound = true
				break end
			end			
		end
		
		if worldbufffound then		
		DMW.Settings.profile.Rotation.WCB = false
		DMW.Settings.profile.Rotation.Ony_Nef = false
		DMW.Settings.profile.Rotation.ZG = false
		Logout()
		end
	end	
end


-- Auto Swich
-- OK (Warlock.Rotation)
function AutoSwich()
	-- Auto swich to PVP/Dungeon on enter an BG/Dungeon and swich back if leave
	local SwichDELAYtime
	newBGInstance = Player.Instance
	
	if newBGInstance == nil then newBGInstance = "none" end
	if newBGInstance == "raid"  then newBGInstance = "party" end
	
	
	if BGInstance == "party" then SwichDELAYtime = SetSwichDUNdelay end
	if BGInstance == "pvp" then SwichDELAYtime = SetSwichPVPdelay end
	if BGInstance == "none" then
		if newBGInstance == "party" then SwichDELAYtime = SetSwichDUNdelay end
		if newBGInstance == "pvp" then SwichDELAYtime = SetSwichPVPdelay end
	end	
	
	if BGInstance ~= newBGInstance then
		DMWCwait(SwichDELAYtime ,AutoSwichDelay)
	end
end

-- Auto Swich
-- OK (Warlock.Rotation)
function AutoSwichDelay()
	-- Auto swich to PVP on enter an BG and swich back if leave
	
	newBGInstance = Player.Instance
	
	if newBGInstance == "raid" then newBGInstance = "party" end
	
	if BGInstance ~= newBGInstance then
		DMWCprintMSG("Auto Swich")
	end
	
	if BGInstance ~= newBGInstance then
		BGInstance = newBGInstance
		if newBGInstance == "pvp" then 
			if SetSwichPVPin then
				if HUD.PVE_PVP ~= 2 then
					HUD.PVE_PVP = 2
					DMWHUDPVE_PVP:Toggle(2)
					if Pet and not Pet.Dead then
						if Setting("PVP Pet") ~= Setting("PVE Pet") then RunMacroText("/petdismiss") end
					end
				end
			end
		elseif newBGInstance == "party" then
		    if SetSwichDUNin then
				if HUD.PVE_PVP ~= 3 then
					HUD.PVE_PVP = 3
					DMWHUDPVE_PVP:Toggle(3)
					if Pet and not Pet.Dead then
						if Setting("DUN Pet") ~= Setting("PVE Pet") then RunMacroText("/petdismiss") end
					end
				end
			end
		elseif newBGInstance == "none" then
			if (HUD.PVE_PVP == 3 and SetSwichDUNout) or (HUD.PVE_PVP == 2 and SetSwichPVPout) then
				if HUD.PVE_PVP ~= 1 then
					HUD.PVE_PVP = 1
					DMWHUDPVE_PVP:Toggle(1)
					if Pet and not Pet.Dead then
						if Setting("PVP Pet") ~= Setting("PVE Pet") or ("DUN Pet") ~= Setting("PVE Pet") then RunMacroText("/petdismiss") end
					end
				end
			end
		end
		
	end
end

-- WARLOCK Rotation
function Warlock.Rotation()	
	ReadSetupStartDelay()
	--print(tostring(startDelayYN))
	if startDelayYN == 0 then DMWCwait(SetStartDelay, startDelay) end -- give Bot time to load on login
	logbug ()
	if startDelayYN == 1 then
		Locals()
		AutoSwich()	
		DefensPrio1()
		OOC()
		Manamanagment()
		if Target and Target.ValidEnemy and Target.Distance < 36 then Damage() end
		DefensePrio2()
		Buffsniper()
	end 
end
