

local GUI = {  
        --[[ Header Texture ]]
		{ 
			type = "texture",
			texture = "Interface\\AddOns\\Nerdpack-Yobleed\\media\\holy.blp",
			width = 512, 
			height = 256, 
			offset = 90, 
			y = 42, 
			center = true 
		},

    -- GUI Moving
	{type = 'header', text = 'Movement', align = 'center'},
	{type = 'checkbox', text = 'Angelic Feather', key = 'm_AF', default = false},
	{type = 'checkbox', text = 'Body and Soul', key = 'm_Body', default = false},
	{type = 'ruler'}, {type = 'spacer'},

    --Fade
    {type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Fade on Aggro', key = 'fade', default = false},
	{type = 'ruler'},{type = 'spacer'},

    --Resurrection
	{type = 'header', text = 'Ressurection', align = 'center'},
	{type = 'checkbox', text = 'Auto Ress out of combat', key = 'rezz', default = false},
	{type = 'ruler'},{type = 'spacer'},

    --TRINKETS
    {type = 'header', text = 'Trinkets', align = 'center'},
    {type = 'checkbox', text = 'Top Trinket', key = 'trinket_1', default = false},
    {type = 'checkbox', text = 'Bottom Trinket', key = 'Trinket_2', default = false},
    {type = 'ruler'},{type = 'spacer'},

	--KEYBINDS
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'text', text = 'Left Shift: Power Word: Barrier|Left Ctrl: Mass Dispel|Alt: Pause', align = 'center'},
	{type = 'checkbox', text = 'Power Word: Barrier', key = 'k_PWB', default = false},
	{type = 'checkbox', text = 'Mass Dispel', key = 'k_MD', default = false},
	{type = 'checkbox', text = 'Pause', key = 'k_P', default = false},
	{type = 'ruler'},{type = 'spacer'},

	--POTIONS
	{type = 'header', text = 'Potions', align = 'center'},
	{type = 'text', text = 'Check to enable Potions', align = 'center'},
	{type = 'checkspin', text = 'Healthstone', key = 'p_HS', default_check = false, default_spin = 25},
	{type = 'checkspin', text = 'Ancient Healing Potion', key = 'p_AHP', default_check = false, default_spin = 25},
	{type = 'checkspin', text = 'Ancient Mana Potion', key = 'p_AMP', default_check = false, default_spin = 20},
	{type = 'ruler'},{type = 'spacer'},

	--Full DPS
	{type = 'header', text = 'Full DPS', align = 'center'},
	{type = 'text', text = 'Player health values', align = 'center'},
	{type = 'spinner', text = 'Gift of the Naaru', key = 'full_Gift', default = 20},
	{type = 'spinner', text = 'Shadow Mend', key = 'full_mend', default = 40},
	{type = 'spinner', text = 'Power Word: Shield', key = 'full_PWS', default = 60},
	{type = 'ruler'},{type = 'spacer'},
    

	--LOWEST
	{type = 'header', text = 'Lowest', align = 'center'},
	{type = 'text', text = 'apply Atonement', align = 'center'},
	{type = 'checkbox', text = 'Power Word: Shield', key = 'l_appPWS', default = false},
	{type = 'text', text = 'Try to reapply Atonement', align = 'center'},
	{type = 'checkbox', text = 'Plea', key = 'l_appplea', default = false},
	{type = 'text', text = 'Lowest health values', align = 'center'},
	{type = 'spinner', text = 'Power Word: Shield', key = 'l_PWS', default = 70},
	{type = 'spinner', text = 'Shadow Mend', key = 'l_mend', default = 60},
	{type = 'ruler'},{type = 'spacer'},

}

local exeOnLoad = function()
	
    
	print('|cffFACC2E Discipline Priest Rotation loaded|r')
	print('|cffFACC2E For Settings Right-Click the MasterToggle and go to Combat Routines Settings |r')
	print('|cffFACC2E Have a nice day!|r')

		NeP.Interface:AddToggle({
		key = 'xDPS',
		name = 'Full DPS!',
		text = 'ON/OFF using Full DPS in rotation',
		icon = 'Interface\\ICONS\\spell_holy_holysmite', --toggle(xDPS)
	})

	NeP.Interface:AddToggle({
		key = 'disp',
		name = 'Dispell',
		text = 'ON/OFF Dispel All',
		icon = 'Interface\\ICONS\\spell_holy_dispelmagic', --toggle(disp)
	})


end


local Trinkets = {
	--Top Trinket usage if UI enables it.
	{'#trinket1', 'UI(trinket_1)'},
	--Bottom Trinket usage if UI enables it.
	{'#trinket2', 'UI(trinket_2)'}
}

local Keybinds = {
    -- Power Word: Barrier on left shift when checked in UI.
    {'!Power Word: Barrier', 'keybind(lshift) & UI(k_PWB)', 'mouseover.ground' },
	--Mass Dispel on Mouseover target Left Control when checked in UI.
	{'!Mass Dispel', 'keybind(lcontrol) & UI(k_PWB)', 'mouseover.ground' },
	-- Power Word: Barrier on left shift when checked in UI.
    {'!Power Word: Barrier', 'keybind(lshift) & UI(k_MD) & !advanced', 'cursor.ground' },
	--Mass Dispel on Mouseover target Left Control when checked in UI.
	{'!Mass Dispel', 'keybind(lcontrol) & UI(k_MD) & !advanced', 'cursor.ground' },
	-- Pause on left alt when checked in UI.
	{'%pause', 'keybind(lalt)& UI(k_P)'}
} 

local Potions = {
	--Health Stone below 20% health. Active when NOT channeling Divine Hymn.
	{'#Healthstone', 'UI(p_HS_check) & player.health <= UI(p_HS_spin) & !player.channeling(Divine Hymn)'},
	--Ancient Healing Potion below 20% health. Active when NOT channeling Divine Hymn.
	{'#Ancient Healing Potion', 'UI(p_AHP_check) & player.health <= UI(p_AHP_spin) & !player.channeling(Divine Hymn)'},
	--Ancient Mana Potion below 20% mana. Active when NOT channeling Divine Hymn.
	{'#Ancient Mana Potion', 'UI(p_AMP_check) & player.mana <= UI(p_AMP_spin) & !player.channeling(Divine Hymn)'}
}

local FullDPS = {
    --PI on CD if toggled.
	{'Power Infusion', 'talent(Power Infusion) & toggle(cooldowns)', 'target'},
	--Shadowfiend on CD if toggled.
	{'Shadowfiend', 'toggle(cooldowns)', 'target'},
    --PWS if player health is below or if UI value.
	{'Power Word: Shield', 'player.health <= UI(full_PWS)', 'player'},
    --Shadow Mend if player health is below or if UI value.
	{'Shadow Mend', 'player.health <= UI(full_mend)', 'player'},
    --Gift of the Naaru if player health is below or if UI value.
	{'Gift of the Naaru', 'player.health <= UI(full_Gift)', 'player'},
    --Purge the Wicked if talent and not on target.
	{'Purge the Wicked', 'talent(Purge the Wicked) & !target.debuff(Purge the Wicked)', 'target'},
	--Schism on cooldown.
	{'Schism', 'talent(Schism) & !moving', 'target'},
	--Penance on cooldown if target has Purge the Wicked or Shadow Word: Pain.
	{'Penance', 'target.debuff(Purge the Wicked) || target.debuff(Shadow Word: Pain)', 'target'},
    --Power Word: Solace on cooldown if talent.
	{'Power Word: Solace', 'talent(Power Word: Solace)', 'target'},
	--Divine Star if moving.
	{'Divine Star', 'talent(Divine Star) & player.area(24).enemies.infront >= 1 & moving'},
	--Smite on CD.
	{'Smite', nil, 'target'},
	
}

local Atonement = {
	--Shadowfiend on CD if toggled.
	{'Shadowfiend', 'toggle(cooldowns)', 'target'},
    --Purge the Wicked if talent and not on target.
	{'Purge the Wicked', 'talent(Purge the Wicked) & !target.debuff(Purge the Wicked)', 'target'},
	--Schism on cooldown.
	{'Schism', 'talent(Schism) & !moving', 'target'},
	--Penance on cooldown if target has Purge the Wicked or Shadow Word: Pain.
	{'Penance', 'target.debuff(Purge the Wicked) || target.debuff(Shadow Word: Pain)', 'target'},
    --Power Word: Solace on cooldown if talent.
	{'Power Word: Solace', 'talent(Power Word: Solace)', 'target'},
	--Divine Star if moving.
	{'Divine Star', 'talent(Divine Star) & player.area(24).enemies.infront >= 1 & moving'},
	--Smite on CD.
	{'Smite', nil, 'target'},

}

local Lowest = {
	
	--Gift of the Naaru if lowest health is below or if 20%.
	{'Gift of the Naaru', 'lowest.health <= 20 ', 'lowest'},
	--Power Word: Shield on UI value if Atonement won't make it.
    {'!Power Word: Shield', 'lowest.health <= UI(l_PWS) & !lowest.buff(Power Word: Shield)', 'lowest'},
	--Shadow Mend on UI value if PWS don't make it.
    {'!Shadow Mend', 'lowest.health <= UI(l_mend)', 'lowest'},
    --Plea on UI value if no 6 atonements are active.
    --{'!Plea', 'lowest.health <= UI(l_plea) & {!lowest1.buff(Atonement) & !lowest2.buff(Atonement) & !lowest3.buff(Atonement) &!lowest4.buff(Atonement) &!lowest5.buff(Atonement) &!lowest6.buff(Atonement)}', 'lowest'},

    --Power Word: Shield on CD if not Atonement.
    {'!Power Word: Shield', 'lowest1.health <= 100 & !lowest1.buff(Atonement) & UI(l_appPWS)', 'lowest1'},
    {'!Power Word: Shield', 'lowest2.health <= 100 & !lowest2.buff(Atonement) & UI(l_appPWS)', 'lowest2'},
    {'!Power Word: Shield', 'lowest3.health <= 100 & !lowest3.buff(Atonement) & UI(l_appPWS)', 'lowest3'},
    {'!Power Word: Shield', 'lowest4.health <= 100 & !lowest4.buff(Atonement) & UI(l_appPWS)', 'lowest4'},
    {'!Power Word: Shield', 'lowest5.health <= 100 & !lowest5.buff(Atonement) & UI(l_appPWS)', 'lowest5'},
    --Plea to reaplly Atonement if Power Word: Shield dropped off.
    {'!Plea', 'lowest1.health <= 100 & lowest1.buff(Atonement).duration <= 2 & !lowest1.buff(Power Word: Shield) & UI(l_appplea)', 'lowest1'},
    {'!Plea', 'lowest2.health <= 100 & lowest2.buff(Atonement).duration <= 2 & !lowest2.buff(Power Word: Shield) & UI(l_appplea)', 'lowest2'},
    {'!Plea', 'lowest3.health <= 100 & lowest3.buff(Atonement).duration <= 2 & !lowest3.buff(Power Word: Shield) & UI(l_appplea)', 'lowest3'},
    {'!Plea', 'lowest4.health <= 100 & lowest4.buff(Atonement).duration <= 2 & !lowest4.buff(Power Word: Shield) & UI(l_appplea)', 'lowest4'},
    {'!Plea', 'lowest5.health <= 100 & lowest5.buff(Atonement).duration <= 2 & !lowest5.buff(Power Word: Shield) & UI(l_appplea)', 'lowest5'},
}

local Moving = {
	--Angelic Feather if player is moving for 2 seconds or longer and Missing Angelic Feather and if UI enables it.
	{'Angelic Feather', 'player.movingfor >= 2 & !player.buff(Angelic Feather) & spell(Angelic Feather).charges >= 1 & UI(m_AF)', 'player.ground'},
	-- Body and Soul usage if enabled in UI.
	{'!Power Word: Shield', 'talent(Body and Soul) & player.movingfor >= 1 & UI(m_Body)', 'player'},

}

                                          

local inCombat = { --194384 Atonement
    {Potions},
    {'%dispelall', 'toggle(disp) & spell(Purify).cooldown = 0'},
	--Fade when you get aggro.
	{'fade', 'aggro & UI(fade)'},
    {Trinkets},
	{Keybinds},
	--Power Word: Radiance if lowest and 2 or more arround lowest have 85% health or below.
	{'Power Word: Radiance', 'lowest.area(20, 95).heal > 2 & toggle(AOE) & !toggle(xDPS) & !lowest1.buff(Atonement) & !lowest2.buff(Atonement) & !lowest3.buff(Atonement)', 'lowest'},
	{Moving, 'moving'},
	--Halo if player has talent and at least 4 or more people within a 30yd range are below or equal to 85% health.
	{'Halo','talent(Halo) & player.area(30, 90).heal >= 4 & toggle(AOE) & !toggle(xDPS)'},
	--Divine Star if player has talent and at least 1 enemy is in front with a range of 24yds and at least 3 or higher players with health below or equal to 95% are in front with a range of 24yds.
    {'Divine Star', 'talent(Divine Star) & player.area(24, 95).heal.infront >= 3 & toggle(AOE) & !toggle(xDPS)'},
    {Lowest, '!toggle(xDPS)'},
    {Atonement, '!lowest.health <= UI(l_mend) & !toggle(xDPS)'},
    {FullDPS, 'toggle(xDPS)'},

	--{{
	--    {Lowest, 'lowest.health < 100 & !toggle(xDPS)'},
	--	{Tank, 'tank.health < 100 & !toggle(xDPS)'},
	--	{Player, 'health < 100 & !toggle(xDPS)'},
	--	{FullDPS, 'toggle(xDPS) & target.range <= 40'},
	--	{DPS, 'lowest.health > 90 & !toggle(xDPS)'},
	--}, '!moving & !player.channeling(Divine Hymn) & !player.channeling(Prayer of Healing)'},

	

}

local outCombat = {

	{Keybinds},
	{Moving, 'moving'},
	{'%ressdead(Resurrection)', 'UI(rezz)'},
}


NeP.CR:Add(256, {
    name = '|cff58FAF4 [Yobleed]|r Priest - |cff58FAF4Discipline|r',
      ic = inCombat,
     ooc = outCombat,
     gui = GUI,
    load = exeOnLoad
})