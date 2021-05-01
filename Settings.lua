local DMW = DMW
DMW.Rotations.WARLOCK = {}
local Warlock = DMW.Rotations.WARLOCK
local UI = DMW.UI

function Warlock.Settings()
    UI.HUD.Options = {
        [1] = {
            Curse = {
                [1] = {Text = "Curse |cFF00FF00Enabled", Tooltip = ""},
                [2] = {Text = "Curse |cffff0000Disabled", Tooltip = ""}
            }
        },
		[2] = {
            PVE_PVP = {
                [1] = {Text = "PVE_PVP |cff00ffffPVE", Tooltip = ""},
                [2] = {Text = "PVE_PVP |cffFF4500PVP", Tooltip = ""},
				[3] = {Text = "PVE_PVP |cffDA70D6Dungeon", Tooltip = ""}
            }
        }
    }
	
	--UI.AddTextBox("Test Text", "Test Text", 0.9, nil, true)
	
	--
	-- General
	UI.AddHeader("General")
	UI.AddBlank(true)
	UI.AddHeader("This is an for Baneto Bot optimiced")
	UI.AddHeader("Warlock Combat-Routine")
	UI.AddHeader("https://baneto-bot.com/")
	UI.AddBlank(true)
	UI.AddHeader("!! Important: Turn of Combat Routine in your Bot !!")
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("Startup Delay")
	UI.AddBlank(true)
	UI.AddRange("Startup Delay", "Give Bot a chance to load on startup or reload", 0, 120, 1, 15, true)
	UI.AddHeader(".................................................................................................................................")
	UI.AddHeader("Tributes")
	UI.AddBlank(true)
	UI.AddHeader("fiskee's Rotation")
	UI.AddHeader("completely reworked by Banana66AUT")
	UI.AddHeader("https://github.com/fiskee")
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("schadis/DMWC - Buff Sniper integrated")
	UI.AddHeader("https://github.com/schadis")
	
	-- Special Menue
	UI.AddTab("Specials")
	UI.AddHeader("Looting")
	UI.AddBlank(true)
	UI.AddToggle("Mass Loot","Do a Mass loot 5 yards around the Player", false, false)
	UI.AddToggle("Fast Loot","Activate a Faster-Looting-System, helps on looting problems", true, false)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("Addon Support")
	UI.AddBlank(true)
	UI.AddToggle("Zygor Auto Talent Advisor","Automatic lerning Talent on Zygor Talent Advisor", false, false)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("Mounting on Baneto")
	UI.AddToggle("Force Mounting","Do Mounting on CR if Baneto do not", true, true)
	UI.AddRange("Destination Distance to Mount", "Distance to the Destination to mount up", 20, 200, 1, 50, true)
	UI.AddRange("Time OOC to block Mount", "Time out of combat before mont up", 0, 240, 1, 15, true)
	
	--
	--Auto Swich
	UI.AddTab(" ")
	UI.AddTab("Auto Swich")
	UI.AddHeader("Auto Swich")
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("Swich to PVP","Automatic Swich to PVP stetting on Battlegroung", true, true)
	UI.AddToggle("Swich back from PVP","Automatic Swich back to PVE on leaving Battlegroung", true, true)
	UI.AddRange("PVP Swich Delay", "Time before Swich - Give Bot a chance to load", 0, 120, 1, 15, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("Swich to Dungeon","Automatic Swich to DUN stetting on Dungeon", true, true)
	UI.AddToggle("Swich back from Dungeon","Automatic Swich back to PVE on leaving Dungeon", true, true)
	UI.AddRange("Dungeon Swich Delay", "Time before Swich - Give Bot a chance to load", 0, 120, 1, 15, true)
	
	--
	--Auto Buff
	UI.AddTab("Auto Buff")
	UI.AddHeader("Buff's")
	UI.AddBlank(true)
	UI.AddToggle("Auto Buff", "Auto buff if knowen", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("Demon Skin/Armor if knowen")
	UI.AddBlank(true)
	UI.AddToggle("DB on PVE", "Will Buff Demon Skin/Armor if knowen", true, true)
	UI.AddToggle("DB on PVP", "Will Buff Demon Skin/Armor if knowen", true, true)
	UI.AddToggle("DB on Dungeon", "Will Buff Demon Skin/Armor if knowen", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("Unending Breath on swimming if knowen")
	UI.AddBlank(true)
	UI.AddToggle("UB on PVE", "Unending Breath on swimming if knowen", true, true)
	UI.AddToggle("UB on PVP", "Unending Breath on swimming if knowen", false, true)
	UI.AddToggle("UB on Dungeon", "Unending Breath on swimming if knowen", false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddHeader("Detect Invisibility if knowen")
	UI.AddBlank(true)
	UI.AddToggle("DI on PVE", "Detect Invisibility (Greater or lesser) if knowen", false, true)
	UI.AddToggle("DI on PVP", "Detect Invisibility (Greater or lesser) if knowen", true, true)
	UI.AddToggle("DI on Dungeon", "Detect Invisibility (Greater or lesser) if knowen", false, true)
	
	--
	--PVE
	UI.AddTab("  ")	
	UI.AddTab("PVE Pet Settings")
	UI.AddHeader("PVE Pet Settings")
	UI.AddDropdown("PVE Pet", nil, {"Disabled", "Imp", "Voidwalker", "Succubus", "Felhunter"}, 3, true)
	UI.AddToggle("PVE Auto Pet Attack", "Auto cast pet attack on target", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Health Funnel", "Activate Health Funnel, will only use if player HP above 60", false, true)
    UI.AddRange("PVE Health Funnel HP", "Pet HP to cast Health Funnel", 0, 100, 1, 20, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Sacrifice", "Activate Sacrifice", true, true)
	UI.AddRange("PVE Sacrifice Player HP", "Player HP to cast Sacrifice", 0, 100, 1, 20)
	UI.AddRange("PVE Sacrifice Pet HP", "Player HP to cast Sacrifice", 0, 100, 1, 5)

	UI.AddTab("PVE Defense")
	UI.AddHeader("PVE Defense")
	UI.AddToggle("PVE Create Healthstone", nil, true, true)
	UI.AddToggle("PVE Use Healthstone", nil, true, true)
	UI.AddRange("PVE Use Healthstone HP", nil, 0, 100, 1, 25, true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Use Health Potion", "Enable/Disable Using Health Potion", 1, true)
	UI.AddRange("PVE Use Health Potion HP", nil, 0, 100, 1, 20, true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Create Soulstone", nil, true, true)
	UI.AddToggle("PVE Soulstone Player", "Auto Soulstone on player outside instances", true, true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Drain Life", nil, true, true)
    UI.AddRange("PVE Drain Life HP", nil, 0, 100, 1, 30, true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Death Coil", "Auto Cast Death Coil if knowen", nil, true, true)
	UI.AddRange("PVE Death Coil HP", nil, 0, 100, 1, 50, true)
	UI.AddBlank(true)
    UI.AddToggle("PVE Use Luffa", "Auto use luffa trinket", true, true)
	--UI.AddToggle("PVE Use Insignia", "Auto use luffa trinket", true, true)
	UI.AddBlank(true)
    UI.AddToggle("PVE Buff Shadow Ward", "Auto cast shadow ward when targeting priest or warlock players", false, true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Fear Bonus Enemy", "Auto fear non target enemies", true, true)
    UI.AddToggle("PVE Fear Solo Farming", "Auto fear target, useful for higher level chars using voidwalker", false, true)
		
	UI.AddTab("PVE Manamanagemnt")
	UI.AddHeader("PVE Manamanagemnt")
	UI.AddToggle("PVE Life Tap", nil, true, true)
    UI.AddToggle("PVE Life Tap OOC", "Activate Life Tap usage outside combat", false, true)
    UI.AddRange("PVE Life Tap Mana", "Mana pct to use Life Tap", 0, 100, 1, 60, true)
    UI.AddRange("PVE Life Tap HP", "Minimum player hp to use Life Tap", 0, 100, 1, 60, true)
	UI.AddToggle("PVE Safe Life Tap", "Do not Life Tap if you have aggro", nil, false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Emergency Life Tap", "If you run out of Mana, also used on Aggro", true, true)
    UI.AddRange("PVE Emergency Life Tap Mana", "Mana pct to use Life Tap", 5, 30, 1, 10, true)
    UI.AddRange("PVE Emergency Life Tap HP", "Minimum player hp to use Life Tap", 0, 100, 1, 30, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
    UI.AddToggle("PVE Dark Pact", nil, false, true)
    UI.AddToggle("PVE Dark Pact OOC", "Activate Dark Pact usage outside combat", false, true)
    UI.AddRange("PVE Dark Pact Mana", "Mana pct to use Dark Pact", 0, 100, 1, 60, true)
    UI.AddRange("PVE Dark Pact Pet Mana", "Pet mana pct to use Dark Pact", 0, 100, 1, 35, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Use Mana Potion", "Enable/Disable Using Mana Potion", 1, true)
	UI.AddRange("PVE Use Mana Potion MP", nil, 0, 100, 1, 35, true)
	
	UI.AddTab("PVE Damage")
	UI.AddHeader("PVE Damage")
	UI.AddDropdown("PVE Shadow Bolt Mode", "Select Shadow Bolt mode", {"Disabled", "Always", "Only Nightfall"}, 3)
    UI.AddRange("PVE Shadow Bolt Mana", "Minimum mana pct to cast Shadow Bolt", 0, 100, 1, 35)
	UI.AddToggle("PVE Searing Pain", "Use Searing Pain when Shadow Bolt is disabled or not castable", false)
	UI.AddToggle("PVE Soul Fire", "Use Soulfire on CD - only if not AGGRO because longe casttime", false)
	UI.AddBlank(true)
	UI.AddRange("PVE Multidot Limit", "Max number of units to dot", 1, 10, 1, 3, true)
    UI.AddDropdown("PVE Curse", nil, {"Disabled", "Curse of Agony", "Curse of Shadow", "Curse of the Elements", "Curse of Recklessness", "Curse of Weakness", "Curse of Tongues", "Curse of Idiocy", "Curse of Doom"}, 2)
    UI.AddToggle("PVE Cycle Curse", "Spread Curse to all enemies", true)
	UI.AddToggle("PVE Amplify Curse", "Use Amplify Curse on CD", true, true)
	UI.AddToggle("PVE Corruption", nil, true)
    UI.AddToggle("PVE Cycle Corruption", "Spread Corruption to all enemies", true)
	UI.AddBlank()
    UI.AddToggle("PVE Cycle Rank 1", "Use rank 1 corruption for multi dotting", false)
    UI.AddToggle("PVE Immolate", nil, true)
    UI.AddToggle("PVE Cycle Immolate", "Spread Immolate to all enemies", true)
    UI.AddToggle("PVE Siphon Life", nil, true)
    UI.AddToggle("PVE Cycle Siphon Life", "Spread Siphon Life to all enemies", true)
	UI.AddBlank(true)
    UI.AddToggle("PVE Shadowburn", "Shadowburn execute on max shards", false, true)
    UI.AddRange("PVE Shadowburn TTD", "TTD to use Shadowburn", 0, 15, 1, 3)
    UI.AddRange("PVE Shadowburn HP", "Health percent to use Shadowburn", 0, 15, 1, 3)
	UI.AddToggle("PVE Drain Life Filler", "Use Drain Life as filler over wanding, use this for drain tanking", true)
    UI.AddRange("PVE Drain Life Filler HP", "Player HP to start using drain life over wanding", 0, 100, 1, 80)
	UI.AddBlank(true)
	UI.AddToggle("PVE Drain Soul Snipe", "Try to auto snipe enemies with drain soul, useful for shard farming or Improved Drain Soul talent", true, true)
    UI.AddRange("PVE Max Shards", "Control max number of shards in bag", 0, 30, 1, 5, true)
	UI.AddToggle("PVE Auto Delete Shards", "Activate automatic deletion of shards from bags, set max below", false, true)
	UI.AddToggle("PVE Stop DS At Max Shards", "Stop using Drain Soul when max shards reached", true, true)
	
	UI.AddTab("PVE Special")
	UI.AddHeader("PVE Special Settings")
	UI.AddBlank(true)
	UI.AddToggle("PVE Use Wand", "Turn on/off Wand using", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Auto Attack In Melee", "Will use normal attack over wand if target is in melee range", false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVE Auto Target", "Auto target units when in combat and target dead/missing", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
    UI.AddToggle("PVE Auto Target Quest Units", nil, false, true)
	
    
	--
	--PVP
	UI.AddTab("   ")
	UI.AddTab("PVP Pet Settings")
	UI.AddHeader("PVP Pet Settings")
	UI.AddDropdown("PVP Pet", nil, {"Disabled", "Imp", "Voidwalker", "Succubus", "Felhunter"}, 5, true)
	UI.AddToggle("PVP Auto Pet Attack", "Auto cast pet attack on target", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Health Funnel", "Activate Health Funnel, will only use if player HP above 60", false, true)
    UI.AddRange("PVP Health Funnel HP", "Pet HP to cast Health Funnel", 0, 100, 1, 20, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Sacrifice", "Activate Sacrifice", false, true)
	UI.AddRange("PVP Sacrifice Player HP", "Player HP to cast Sacrifice", 0, 100, 1, 20)
	UI.AddRange("PVP Sacrifice Pet HP", "Player HP to cast Sacrifice", 0, 100, 1, 5)
	
	UI.AddTab("PVP Defense")
	UI.AddHeader("PVP Defense")
	UI.AddToggle("PVP Create Healthstone", nil, false, true)
	UI.AddToggle("PVP Use Healthstone", nil, true, true)
	UI.AddRange("PVP Use Healthstone HP", nil, 0, 100, 1, 35, true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Use Health Potion", "Enable/Disable Using Health Potion", 1, false)
	UI.AddRange("PVP Use Health Potion HP", nil, 0, 100, 1, 35, true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Create Soulstone", nil, false, true)
	UI.AddToggle("PVP Soulstone Player", "Auto Soulstone on player outside instances", false, true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Death Coil", "Auto Cast Death Coil if knowen", nil, true, true)
	UI.AddRange("PVP Death Coil HP", nil, 0, 100, 1, 50, true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Drain Life", nil, true, true)
    UI.AddRange("PVP Drain Life HP", nil, 0, 100, 1, 40, true)
	UI.AddBlank(true)
    UI.AddToggle("PVP Use Luffa", "Auto use luffa trinket", false, true)
	--UI.AddToggle("PVP Use Insignia", "Auto use luffa trinket", true, true)
	UI.AddBlank(true)
    UI.AddToggle("PVP Buff Shadow Ward", "Auto cast shadow ward when targeting priest or warlock players", true, true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Fear Bonus Enemy", "Auto fear non target enemies", false, true)
    UI.AddToggle("PVP Fear Solo Farming", "Auto fear target, useful for higher level chars using voidwalker", false, true)
		
	UI.AddTab("PVP Manamanagemnt")
	UI.AddHeader("PVP Manamanagemnt")
	UI.AddToggle("PVP Life Tap", nil, true, true)
    UI.AddToggle("PVP Life Tap OOC", "Activate Life Tap usage outside combat", false, true)
    UI.AddRange("PVP Life Tap Mana", "Mana pct to use Life Tap", 0, 100, 1, 60, true)
    UI.AddRange("PVP Life Tap HP", "Minimum player hp to use Life Tap", 0, 100, 1, 80, true)
	UI.AddToggle("PVP Safe Life Tap", "Do not Life Tap if you have aggro", nil, true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Emergency Life Tap", "If you run out of Mana, also used on Aggro", true, true)
    UI.AddRange("PVP Emergency Life Tap Mana", "Mana pct to use Life Tap", 5, 30, 1, 10, true)
    UI.AddRange("PVP Emergency Life Tap HP", "Minimum player hp to use Life Tap", 0, 100, 1, 50, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
    UI.AddToggle("PVP Dark Pact", nil, false, true)
    UI.AddToggle("PVP Dark Pact OOC", "Activate Dark Pact usage outside combat", false, true)
    UI.AddRange("PVP Dark Pact Mana", "Mana pct to use Dark Pact", 0, 100, 1, 60, true)
    UI.AddRange("PVP Dark Pact Pet Mana", "Pet mana pct to use Dark Pact", 0, 100, 1, 35, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Use Mana Potion", "Enable/Disable Using Mana Potion", 1, false)
	UI.AddRange("PVP Use Mana Potion MP", nil, 0, 100, 1, 35, true)
	
	UI.AddTab("PVP Damage")
	UI.AddHeader("PVP Damage")
	UI.AddDropdown("PVP Shadow Bolt Mode", "Select Shadow Bolt mode", {"Disabled", "Always", "Only Nightfall"}, 3)
    UI.AddRange("PVP Shadow Bolt Mana", "Minimum mana pct to cast Shadow Bolt", 0, 100, 1, 35)
	UI.AddToggle("PVP Searing Pain", "Use Searing Pain when Shadow Bolt is disabled or not castable", true)
	UI.AddToggle("PVP Soul Fire", "Use Soulfire on CD - only if not AGGRO because longe casttime", true)
	UI.AddBlank(true)
	UI.AddRange("PVP Multidot Limit", "Max number of units to dot", 1, 10, 1, 5, true)
    UI.AddDropdown("PVP Curse", nil, {"Disabled", "Curse of Agony", "Curse of Shadow", "Curse of the Elements", "Curse of Recklessness", "Curse of Weakness", "Curse of Tongues", "Curse of Idiocy", "Curse of Doom"}, 2)
    UI.AddToggle("PVP Cycle Curse", "Spread Curse to all enemies", true)
	UI.AddToggle("PVP Amplify Curse", "Use Amplify Curse when using CDs", true, true)
	UI.AddToggle("PVP Corruption", nil, true)
    UI.AddToggle("PVP Cycle Corruption", "Spread Corruption to all enemies", true)
	UI.AddBlank()
    UI.AddToggle("PVP Cycle Rank 1", "Use rank 1 corruption for multi dotting", false)
    UI.AddToggle("PVP Immolate", nil, false)
    UI.AddToggle("PVP Cycle Immolate", "Spread Immolate to all enemies", false)
    UI.AddToggle("PVP Siphon Life", nil, true)
    UI.AddToggle("PVP Cycle Siphon Life", "Spread Siphon Life to all enemies", true)
	UI.AddBlank(true)
    UI.AddToggle("PVP Shadowburn", "Shadowburn execute on max shards", false, true)
    UI.AddRange("PVP Shadowburn TTD", "TTD to use Shadowburn", 0, 15, 1, 3)
    UI.AddRange("PVP Shadowburn HP", "Health percent to use Shadowburn", 0, 15, 1, 3)
	UI.AddToggle("PVP Drain Life Filler", "Use Drain Life as filler over wanding, use this for drain tanking", false)
    UI.AddRange("PVP Drain Life Filler HP", "Player HP to start using drain life over wanding", 0, 100, 1, 80)
	UI.AddBlank(true)
	UI.AddToggle("PVP Drain Soul Snipe", "Try to auto snipe enemies with drain soul, useful for shard farming or Improved Drain Soul talent", false, true)
    UI.AddRange("PVP Max Shards", "Control max number of shards in bag", 0, 30, 1, 5, true)
	UI.AddToggle("PVP Auto Delete Shards", "Activate automatic deletion of shards from bags, set max below", false, true)
	UI.AddToggle("PVP Stop DS At Max Shards", "Stop using Drain Soul when max shards reached", false, true)
    
	UI.AddTab("PVP Special")
	UI.AddHeader("PVP Special Settings")
	UI.AddBlank(true)
	UI.AddToggle("PVP Use Wand", "Turn on/off Wand using", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Auto Attack In Melee", "Will use normal attack over wand if target is in melee range", false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("PVP Auto Target", "Auto target units when in combat and target dead/missing", false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
    UI.AddToggle("PVP Active Targeting", "If player running away, take next Target in Range", true, true)
	
	--
	--DUN
	UI.AddTab("    ")	
	UI.AddTab("DUN Pet Settings")
	UI.AddHeader("DUN Pet Settings")
	UI.AddDropdown("DUN Pet", nil, {"Disabled", "Imp", "Voidwalker", "Succubus", "Felhunter"}, 2, true)
	UI.AddToggle("DUN Auto Pet Attack", "Auto cast pet attack on target", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Health Funnel", "Activate Health Funnel, will only use if player HP above 60", false, true)
    UI.AddRange("DUN Health Funnel HP", "Pet HP to cast Health Funnel", 0, 100, 1, 20, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Sacrifice", "Activate Sacrifice", true, true)
	UI.AddRange("DUN Sacrifice Player HP", "Player HP to cast Sacrifice", 0, 100, 1, 20)
	UI.AddRange("DUN Sacrifice Pet HP", "Player HP to cast Sacrifice", 0, 100, 1, 5)

	UI.AddTab("DUN Defense")
	UI.AddHeader("DUN Defense")
	UI.AddToggle("DUN Create Healthstone", nil, true, true)
	UI.AddToggle("DUN Use Healthstone", nil, true, true)
	UI.AddRange("DUN Use Healthstone HP", nil, 0, 100, 1, 25, true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Use Health Potion", "Enable/Disable Using Health Potion", 1, true)
	UI.AddRange("DUN Use Health Potion HP", nil, 0, 100, 1, 20, true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Create Soulstone", nil, true, true)
	UI.AddToggle("DUN Soulstone Player", "Auto Soulstone on player outside instances", false, true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Drain Life", nil, true, true)
    UI.AddRange("DUN Drain Life HP", nil, 0, 100, 1, 30, true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Death Coil", "Auto Cast Death Coil if knowen", nil, false, true)
	UI.AddRange("DUN Death Coil HP", nil, 0, 100, 1, 50, true)
	UI.AddBlank(true)
    UI.AddToggle("DUN Use Luffa", "Auto use luffa trinket", false, true)
	--UI.AddToggle("DUN Use Insignia", "Auto use luffa trinket", true, true)
	UI.AddBlank(true)
    UI.AddToggle("DUN Buff Shadow Ward", "Auto cast shadow ward when targeting priest or warlock players", false, true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Fear Bonus Enemy", "Auto fear non target enemies", false, true)
    UI.AddToggle("DUN Fear Solo Farming", "Auto fear target, useful for higher level chars using voidwalker", false, true)
		
	UI.AddTab("DUN Manamanagemnt")
	UI.AddHeader("DUN Manamanagemnt")
	UI.AddToggle("DUN Life Tap", nil, true, true)
    UI.AddToggle("DUN Life Tap OOC", "Activate Life Tap usage outside combat", false, true)
    UI.AddRange("DUN Life Tap Mana", "Mana pct to use Life Tap", 0, 100, 1, 60, true)
    UI.AddRange("DUN Life Tap HP", "Minimum player hp to use Life Tap", 0, 100, 1, 60, true)
	UI.AddToggle("DUN Safe Life Tap", "Do not Life Tap if you have aggro", nil, false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Emergency Life Tap", "If you run out of Mana, also used on Aggro", true, true)
    UI.AddRange("DUN Emergency Life Tap Mana", "Mana pct to use Life Tap", 5, 30, 1, 10, true)
    UI.AddRange("DUN Emergency Life Tap HP", "Minimum player hp to use Life Tap", 0, 100, 1, 30, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
    UI.AddToggle("DUN Dark Pact", nil, false, true)
    UI.AddToggle("DUN Dark Pact OOC", "Activate Dark Pact usage outside combat", false, true)
    UI.AddRange("DUN Dark Pact Mana", "Mana pct to use Dark Pact", 0, 100, 1, 60, true)
    UI.AddRange("DUN Dark Pact Pet Mana", "Pet mana pct to use Dark Pact", 0, 100, 1, 35, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Use Mana Potion", "Enable/Disable Using Mana Potion", 1, true)
	UI.AddRange("DUN Use Mana Potion MP", nil, 0, 100, 1, 35, true)
	
	UI.AddTab("DUN Damage")
	UI.AddHeader("DUN Damage")
	UI.AddDropdown("DUN Shadow Bolt Mode", "Select Shadow Bolt mode", {"Disabled", "Always", "Only Nightfall"}, 3)
    UI.AddRange("DUN Shadow Bolt Mana", "Minimum mana pct to cast Shadow Bolt", 0, 100, 1, 35)
	UI.AddToggle("DUN Searing Pain", "Use Searing Pain when Shadow Bolt is disabled or not castable", false)
	UI.AddToggle("DUN Soul Fire", "Use Soulfire on CD - only if not AGGRO because longe casttime", false)
	UI.AddBlank(true)
	UI.AddRange("DUN Multidot Limit", "Max number of units to dot", 1, 10, 1, 3, true)
    UI.AddDropdown("DUN Curse", nil, {"Disabled", "Curse of Agony", "Curse of Shadow", "Curse of the Elements", "Curse of Recklessness", "Curse of Weakness", "Curse of Tongues", "Curse of Idiocy", "Curse of Doom"}, 2)
    UI.AddToggle("DUN Cycle Curse", "Spread Curse to all enemies", true)
	UI.AddToggle("DUN Amplify Curse", "Use Amplify Curse on CD", true, true)
	UI.AddToggle("DUN Corruption", nil, true)
    UI.AddToggle("DUN Cycle Corruption", "Spread Corruption to all enemies", true)
	UI.AddBlank()
    UI.AddToggle("DUN Cycle Rank 1", "Use rank 1 corruption for multi dotting", false)
    UI.AddToggle("DUN Immolate", nil, true)
    UI.AddToggle("DUN Cycle Immolate", "Spread Immolate to all enemies", true)
    UI.AddToggle("DUN Siphon Life", nil, true)
    UI.AddToggle("DUN Cycle Siphon Life", "Spread Siphon Life to all enemies", true)
	UI.AddBlank(true)
    UI.AddToggle("DUN Shadowburn", "Shadowburn execute on max shards", false, true)
    UI.AddRange("DUN Shadowburn TTD", "TTD to use Shadowburn", 0, 15, 1, 3)
    UI.AddRange("DUN Shadowburn HP", "Health percent to use Shadowburn", 0, 15, 1, 3)
	UI.AddToggle("DUN Drain Life Filler", "Use Drain Life as filler over wanding, use this for drain tanking", true)
    UI.AddRange("DUN Drain Life Filler HP", "Player HP to start using drain life over wanding", 0, 100, 1, 80)
	UI.AddBlank(true)
	UI.AddToggle("DUN Drain Soul Snipe", "Try to auto snipe enemies with drain soul, useful for shard farming or Improved Drain Soul talent", true, true)
    UI.AddRange("DUN Max Shards", "Control max number of shards in bag", 0, 30, 1, 5, true)
	UI.AddToggle("DUN Auto Delete Shards", "Activate automatic deletion of shards from bags, set max below", false, true)
	UI.AddToggle("DUN Stop DS At Max Shards", "Stop using Drain Soul when max shards reached", true, true)
	
	UI.AddTab("DUN Special")
	UI.AddHeader("DUNGEON Special Settings")
	UI.AddBlank(true)
	UI.AddToggle("DUN Use Wand", "Turn on/off Wand using", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Auto Attack In Melee", "Will use normal attack over wand if target is in melee range", false, true)
	UI.AddBlank(true)
	UI.AddBlank(true)
	UI.AddToggle("DUN Auto Target", "Auto target units when in combat and target dead/missing", true, true)
	UI.AddBlank(true)
	UI.AddBlank(true)

	UI.AddTab("DUN AggroManager")
	UI.AddHeader("I am working on it, its comming soon")
	
    --
	--Buff Sniper
	UI.AddTab("     ")
	UI.AddTab("Buff Sniper")
	UI.AddHeader("If World buff drops log off")
	UI.AddHeader("Only select one")
	UI.AddToggle("WCB", "If Warchiefsblessing is on you log off", false, true)
	UI.AddBlank(true)
	UI.AddToggle("Ony_Nef", "If Dragonslayer is on you log off", false, true)
	UI.AddBlank(true)
	UI.AddToggle("ZG", "If Spirit of Zandalar is on you log off", false, true)
    --
	--Debug/Print
	UI.AddTab("Debug/Print")
	UI.AddHeader("Debug")
	UI.AddToggle("Log","enables LOG", false)
	UI.AddToggle("Debug","enables Debug", false)
	UI.AddBlank(true)
	UI.AddHeader("Print")
	UI.AddBlank(true)
	UI.AddToggle("Debug OOC","enables Debug out of combat", false, true)
	UI.AddBlank(true)
	UI.AddToggle("Debug MM","enables Debug manamanagment", false, true)
	UI.AddBlank(true)
	UI.AddToggle("Debug Def","enables Debug Defense", false, true)
	UI.AddBlank(true)
	UI.AddToggle("Debug DPS","enables Debug DPS", false, true)
	
    DMW.Helpers.Rotation.CastingCheck = false
end
