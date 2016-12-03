local GUI = { 

            
        --[[ Header Texture ]]
		{ 
			type = "texture",
			texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\shadow.blp",
			width = 512, 
			height = 256, 
			offset = 90, 
			y = 42, 
			center = true 
		},

  --Survival/Potions
  {type = 'header', text = 'Survival/Potions', align = 'center'},
  {type = 'checkbox', text = 'Fade', key = 's_F', default= false},
  {type = 'checkspin', text = 'Dispersion Usage', key = 's_D', default_check = false, default_spin = 20},
  {type = 'checkspin', text = 'Healthstone', key = 's_HS', default_check = false, default_spin = 20},
  {type = 'checkspin', text = 'Ancient Healing Potion', key = 's_AHP', default_check = false, default_spin = 20},
  {type = 'checkbox', text = 'Hero Potion of Prolonged Power', key = 's_PP', default= false},
  {type = 'ruler'},{type = 'spacer'},

  --DPS Cooldown
  {type = 'header', text = 'DPS cooldown', align = 'center'},
  {type = 'text', text = 'No Surrender to Madness Active', align = 'center'},
  {type = 'text', text = 'Check and Choose Stacks', align = 'center'},
  {type = 'checkspin', text = 'Power Infusion: Target <= 35%', key = 'c_PI', default_check = false, default_spin = 20},
  {type = 'checkspin', text = 'Power Infusion: Target > 35%', key = 'c_PI2', default_check = false, default_spin = 10},
  {type = 'checkspin', text = 'Dispersion: Target <= 35%', key = 'dps_D', default_check = false, default_spin = 35},
  {type = 'checkspin', text = 'Dispersion: Target > 35%', key = 'dps_D2', default_check = false, default_spin = 30},
  {type = 'ruler'},{type = 'spacer'},

  --AOE
  {type = 'header', text = 'AoE', align = 'center'},
  {type = 'text', text = 'When AoE is toggled on', align = 'center'},
  {type ='spinner', text = 'Mind Sear', key = 'AoE_MS', default = 3},
  {type = 'ruler'},{type = 'spacer'},

  --TRINKETS
  {type = 'header', text = 'Trinkets', align = 'center'},
  {type = 'checkbox', text = 'Top Trinket', key = 'trinket_1', default = false},
  {type = 'checkbox', text = 'Bottom Trinket', key = 'Trinket_2', default = false},
  {type = 'ruler'},{type = 'spacer'},

  --KEYBINDS
  {type = 'header', text = 'Keybinds', align = 'center'},
  {type = 'text', text = 'Left Ctrl: Mass Dispel|Alt: Pause', align = 'center'},
  {type = 'checkbox', text = 'Mass Dispel', key = 'k_MD', default = false},
  {type = 'checkbox', text = 'Pause', key = 'k_P', default = false},
  {type = 'ruler'},{type = 'spacer'},

  --MOVING
  {type = 'header', text = 'Movement', align = 'center'},
  {type = 'checkbox', text = 'Body and Soul', key = 'm_Body', default = false},
  {type = 'ruler'},{type = 'spacer'},

  --SUPPORT
  {type = 'header', text = 'Support', align = 'center'},
  {type = 'text', text = 'Protect your Allies like a good guildie ;)', align = 'center'},
  {type = 'checkspin', text = 'Gift of the Naaru', key = 'sup_GotN', default_check = false, default_spin = 20},
  {type = 'checkspin', text = 'Power Word: Shield', key = 'sup_PWS', default_check = false, default_spin = 20},




  
		
}

local exeOnLoad = function()
	
     ---------CREDITS GO TO XEER-----------
	print('|cff5F2061 ----------------------------------------------------------------------|r')
	print('|cff5F2061 --- |rPRIEST |cff5F2061Shadowtest |r')
	print('|cff5F2061 --- |rRecommended Talents1: 1/1 - 2/2 - 3/1 - 4/2 - 5/3 - 6/3 - 7/3')
	print('|cff5F2061 --- |rRecommended Talents2: 1/1 - 2/2 - 3/1 - 4/2 - 5/2 - 6/1 - 7/3')
	print('|cff5F2061 ----------------------------------------------------------------------|r')
  print('|cff5F2061 For Settings Right-Click the MasterToggle and go to Combat Routines Settings |r')
  print('|cff5F2061 Have a nice day!|r')

	

end

local Trinkets = {
  --Top Trinket usage if UI enables it.
  {'#trinket1', 'UI(trinket_1)'},
  --Bottom Trinket usage if UI enables it.
  {'#trinket2', 'UI(trinket_2)'}
}

local Keybinds = {
  --Mass Dispel on cursor ground. Left Control when checked in UI.
  {'/cast [@cursor] !Mass Dispel', 'keybind(lcontrol) & UI(k_MD)'},
  --Pause on left alt when checked in UI.
  {'%pause', 'keybind(lalt)& UI(k_P)'}
}

local Potions = {
  --Healthstone when player below or if UI value and checked when not casting Void Torrent.
  {"#Healthstone", "player.health <= UI(s_HS_spin) & UI(s_HS_check) & !player.channeling(Void Torrent)"},
  --Ancient Healing Potion when player below or if UI value and checked when not casting Void Torrent.
  {"#Ancient Healing Potion", "player.health <= UI(s_AHP_spin) & UI(s_AHP_check) & !player.channeling(Void Torrent)"},
  --Potion of Prolonged Power if player has hero/bloodlust and checked in UI with no Potion of Prolonged Power buff. 
  {"#Potion of Prolonged Power", "player.hashero & !player.buff(Potion of Prolonged Power) & !player.channeling(Void Torrent) & UI(s_PP)"},

}

local SurMov = {
  --Dispersion when Player health is below or if UI value.
  {'!Dispersion', 'player.health <= UI(s_D_spin) & UI(s_D_check)'},
  --Fade when you have threat on target and is checked in UI.
  {'Fade', 'target.threat = 100 & UI(s_F)'},
  --Gift of the Naaru when player health below or 40% Health.
  {'Gift of the Naaru', 'player.health <= 40'},
  --Gift of the Naaru support if Lowest Health is below or equal to UI value and checked.
  {'Gift of the Naaru', 'lowest.health <= UI(sup_GotN_spin) & UI(sup_GotN_check)', 'lowest'},
  --Power Word: Shield if player health is below or 30% Health.
  {'Power Word: Shield', 'player.health <= 30'},
  --Power Word: Shield support if lowest Health is below or equal to UI value and checked.
  {'Power Word: Shield', 'lowest.health <= UI(sup_PWS_spin) & UI(sup_PWS_check)', 'lowest'},

}

local Insight = { 
  --Mind Blast on CD when Voidbolt is on CD.
  {'!Mindblast', '!spell(Void Eruption).cooldown = 0'}, 

}

local Moving = {
  --Power Word: Shield if player is moving for 1 or more and talent body and soul is active when UI checked.
  {'Power Word: Shield', 'player.movingfor >= 1 & talent(Body and Soul) & UI(m_Body)', 'player'},

}

local Emergency = {
  --Dispersion when SWD charges are 0 and VF stacks are 95 or higher and insanity is below or equal to 50%.
  {'!Dispersion', 'player.spell(Shadow Word: Death).charges < 1 & player.buff(voidform).count >= 95 & player.insanity <= 50'},
  --Power Infusion if talent active and VF stacks are 70 or higher if SWD charges are 0 and insanity is 50% or below.
  {'!Power Infusion', 'talent(Power Infusion) & player.buff(voidform).count >= 70 & spell(Shadow Word: Death).charges < 1 & player.insanity <= 50'},
  --Power Infusion if talent active and VF stacks are 75 or higher.
  {'!Power Infusion', 'talent(Power Infusion) & player.buff(voidform).count >= 75'},

}

local cooldowns = {
  --Power infusion if talent is active, not in Dispersion and not in S2M when VF stacks are above or equal to UI value and checked if target below or equal to 35% health.
  --{'!Power Infusion', 'talent(Power Infusion) & !player.buff(Dispersion) & !player.buff(Surrender to Madness) & player.buff(voidform).count >= UI(c_PI_spin) & UI(c_PI_check) & target.health <= 35' },
  --Power infusion if talent is active, not in Dispersion and not in S2M when VF stacks are above or equal to UI value and checked if target above or 35% health.
 -- {'!Power Infusion', 'talent(Power Infusion) & !player.buff(Dispersion) & !player.buff(Surrender to Madness) & player.buff(voidform).count >= UI(c_PI2_spin) & UI(c_PI2_check) & target.health > 35' },
  --Mindbender if talent is active on CD in S2M.
  {'!Mindbender', 'talent(Mindbender) & player.buff(Surrender to Madness)'},
  --Mind Bender if talent is active and not in S2M if VF stacks are above 5.
  {'!Mindbender', 'talent(Mindbender) & !player.buff(Surrender to Madness) & player.buff(voidform).count > 5'},
  --Shadowfiend if Void Bolt is on CD and VF stacks are above 10 when Power Infusion talent is not active.
  {'!Shadowfiend', '!spell(Void Eruption).cooldown = 0 & player.buff(voidform).count > 10 & !talent(Power Infusion)'},
  --Shadowfiend if Void Bolt is on CD and VF stacks are above or equal to 15 and Power Infusion talent is active.
  {'!Shadowfiend', '!spell(Void Eruption).cooldown = 0 & player.buff(voidform).count >= 15 & talent(Power Infusion)'},

}

local ST1 = {
  --Void Eruption if VT on target is 13seconds or higher and SWP on target and in S2M.
  {'!Void Eruption','target.debuff(Vampiric Touch).duration > 13 & player.buff(Surrender to Madness) & target.debuff(Vampiric Touch) & target.debuff(Shadow Word: Pain)'},
  --Void Eruption if VT on target is 6seconds or higher and SWP on target and no S2M.
  {'!Void Eruption', 'target.debuff(Vampiric Touch).duration > 6 & !player.buff(Surrender to Madness) & target.debuff(Vampiric Touch) & target.debuff(Shadow Word: Pain)'},
  --Mind Blast if player is channeling Mind Flay.
  {'!Mind Blast', 'player.channeling(Mind Flay)'},
  --Mind Blast on CD.
  {'Mind Blast'},
  --Shadow Word: Pain if target debuff duration is below 3 seconds OR if target has no SWP.
  {'!Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration < 3 || !target.debuff(Shadow Word: Pain)'},
  --Vampiric Touch if target debuff duration is below 3 seconds OR if target has no Vampiric Touch.
  {'!Vampiric Touch', 'target.debuff(Vampiric Touch).duration <= 3 || !target.debuff(Vampiric Touch)'}, 
  --Mind Flay if Mind Blast is on cooldown
  {'Mind Flay', '!spell(Mind Blast).cooldown = 0 & target.debuff(Shadow Word: Pain) & target.debuff(Vampiric Touch) & !toggle(AOE)'},

}

local lotv1 = {
  --Dispersion if VF stacks are above or equal to UI value and checked and SWD charges are 0 and if insanity is below 40% and Target Health is below or equal to 35% health.
  {'!Dispersion', 'player.buff(voidform).count >= UI(dps_D_spin) & UI(dps_D_check) & spell(Shadow Word: Death).charges < 1 & player.insanity <= 40 & target.health <= 35'},
  --Dispersion if VF stacks are above or equal to UI value and checked and if insanity is below 40% and Target Health is above 35% health.
  {'!Dispersion', 'player.buff(voidform).count >= UI(dps_D2_spin) & UI(dps_D2_check) & !player.buff(Surrender to Madness) & player.insanity <= 40 & target.health > 35'},
  --Torrent on CD.
  {'!Void Torrent'},
  --SWD if target is below or equal to 35% Health and player insanity is below or equal to 65%.
  {'!Shadow Word: Death', 'target.health <= 35 & player.insanity <= 65'},
  --Void Bolt on CD not interrupting casting MB.
  {'!Void Eruption', '!player.channeling(Mind Blast)'}, 
  --Mind Blast on CD if VB is on CD.
  {'!Mind Blast', '!player.spell(Void Eruption).cooldown = 0'},
  --Shadow Word: Pain if target debuff duration is below 3 seconds OR if target has no SWP.
  {'!Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration < 3 || !target.debuff(Shadow Word: Pain)'},
  --Vampiric Touch if target debuff duration is below 3 seconds OR if target has no Vampiric Touch.
  {'!Vampiric Touch', 'target.debuff(Vampiric Touch).duration <= 3 || !target.debuff(Vampiric Touch)'}, 
  --Mind Flay if Dots are up and VB and MB are on CD.
  {'Mind Flay', '!player.spell(Void Eruption).cooldown = 0 & !player.spell(Mind Blast).cooldown = 0 & target.debuff(Shadow Word: Pain) & target.debuff(Vampiric Touch)'},

}

--------------------------------------------------LEGENDARY BELT-----------------------------------------------------------------------------------------------------------
local ST2 = { 
  --Void Eruption if VT on target is 13seconds or higher and SWP on target and in S2M.
  {'!Void Eruption','target.debuff(Vampiric Touch).duration > 13 & player.buff(Surrender to Madness) & target.debuff(Vampiric Touch) & target.debuff(Shadow Word: Pain)'},
  --Void Eruption if VT on target is 6seconds or higher and SWP on target and no S2M.
  {'!Void Eruption', 'target.debuff(Vampiric Touch).duration > 6 & !player.buff(Surrender to Madness) & target.debuff(Vampiric Touch) & target.debuff(Shadow Word: Pain)'},
  --Mind Blast if player is channeling Mind Flay.
  {'!Mind Blast', 'player.channeling(Mind Flay)'},
  --Mind Blast if target has SWP and VT.
  {'Mind Blast', 'target.debuff(Shadow Word: Pain) & target.debuff(Vampiric Touch)'},
  --Mind Blast if target doesnt have SWP and VT and wasn't last cast.
  {'Mind Blast', '!target.debuff(Shadow Word: Pain) & !target.debuff(Vampiric Touch) & !lastcast(Mind Blast)'},
  --Shadow Word: Pain if target debuff duration is below 3 seconds OR if target has no SWP.
  {'!Shadow Word: Pain', 'target.debuff(Shadow Word: Pain).duration < 3 || !target.debuff(Shadow Word: Pain)'},
  --Vampiric Touch if target debuff duration is below 3 seconds OR if target has no Vampiric Touch.
  {'!Vampiric Touch', 'target.debuff(Vampiric Touch).duration <= 3 || !target.debuff(Vampiric Touch)'}, 
  --Mind Flay if Mind Blast is on cooldown
  {'Mind Flay', '!spell(Mind Blast).cooldown = 0 & target.debuff(Shadow Word: Pain) & !toggle(AOE)'},

}

   

local inCombat = {
  --Shadowform if no voidform and no shadowform.
  {'Shadowform', '!player.buff(Voidform) & !player.buff(Shadowform)'},
  -- S2M when in Xavius Dreamstate.
  {"Surrender to Madness", "player.debuff(Dream Simulacrum)"},
  {Emergency, '!player.channeling(Void Torrent)'},
  {Potions, '!player.channeling(Void Torrent)'},
  {SurMov, '!player.channeling(Void Torrent) & !player.buff(Surrender to Madness)'},
  {cooldowns, 'player.buff(voidform) & !player.channeling(Void Torrent) & toggle(cooldowns)'}, 
  {Insight, 'player.buff(Shadowy Insight) & !player.channeling(Void Torrent)'},  
  {Keybinds},
  {Trinkets, '!player.channeling(Void Torrent)'},
  {lotv1, "!equipped(Mangaza's Madness) & talent(Legacy of the Void) & player.buff(voidform) & !toggle(AOE) & !player.channeling(Void Torrent)"}, 
  {ST2, "equipped(Mangaza's Madness) & !player.buff(voidform) & !toggle(AOE)"}, 
  {ST1, "!equipped(Mangaza's Madness) & !player.buff(voidform) & !toggle(AOE)"}, 

}

local outCombat = {
  {'Shadowform', '!player.buff(Shadowform)'},
  {Keybinds},
  {Moving, '!player.buff(Surrender to Madness'}, 
  {"%ressdead(Resurrection)"},

}

NeP.CR:Add(258, {
    name = '|cff5F2061 [Yobleed]|r Priest - |cff5F2061Shadowtest|r', 
      ic = inCombat,
     ooc = outCombat,
     gui = GUI,
    load = exeOnLoad
})


--NOTES:
 --equipped('item_name') or equipped (itemID)
 --'advanced' --advanced unlocker condition