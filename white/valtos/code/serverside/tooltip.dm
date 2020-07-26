/client/MouseEntered(object, location)
	..()
	if(istype(object, /atom) && !isnewplayer(mob) && (prefs.w_toggles & TOOLTIP_USER_UP) && !(prefs.w_toggles & TOOLTIP_USER_RETRO))
		var/atom/A = object
		if(mob.hud_used.tooltip)
			var/obj_name = A.name
			if(mob.hud_used.tooltip.last_word == obj_name)
				return
			mob.hud_used.tooltip.maptext = "<span class='maptext reallybig yell' style='text-align: center;'>[r_uppertext(obj_name)]</span>"
	else if(mob.hud_used.tooltip)
		mob.hud_used.tooltip.maptext = ""

/obj/screen/tooltip
	name = ""
	screen_loc = "NORTH,CENTER-4:16"
	maptext_width = 480
	maptext_x = -112
	maptext_y = 18
	layer = 23
	plane = 23

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Game, toggle_tooltip_up)()
	set name = " 🔄 Название предметов"
	set category = "Настройки"
	set desc = "Имена предметов"
	usr.client.prefs.w_toggles ^= TOOLTIP_USER_UP
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.w_toggles & TOOLTIP_USER_UP)
		to_chat(usr, "Я буду видеть названия предметов.")
	else
		to_chat(usr, "Я не буду видеть названия предметов.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Tooltip Up", "[usr.client.prefs.w_toggles & TOOLTIP_USER_UP ? "Вкл" : "Выкл"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/Game/toggle_tooltip_up/Get_checked(client/C)
	return C.prefs.w_toggles & TOOLTIP_USER_UP

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Game, toggle_tooltip_pos)()
	set name = " 🔄 Позиция названий предметов"
	set category = "Настройки"
	set desc = "Позиция имён предметов"
	usr.client.prefs.w_toggles ^= TOOLTIP_USER_POS
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.w_toggles & TOOLTIP_USER_POS)
		to_chat(usr, "Теперь панель будет внизу.")
		usr.hud_used.tooltip.screen_loc = "SOUTH+1,CENTER-4:16"
	else
		to_chat(usr, "Теперь панель будет сверху.")
		usr.hud_used.tooltip.screen_loc = "NORTH,CENTER-4:16"
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Tooltip Pos", "[usr.client.prefs.w_toggles & TOOLTIP_USER_POS ? "Верх" : "Низ"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/Game/toggle_tooltip_pos/Get_checked(client/C)
	return C.prefs.w_toggles & TOOLTIP_USER_POS

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings/Game, toggle_tooltip_retro)()
	set name = " 🔄 Ретро-названия"
	set category = "Настройки"
	set desc = "Ретро-статусбар"
	usr.client.prefs.w_toggles ^= TOOLTIP_USER_RETRO
	usr.client.prefs.save_preferences()
	if(usr.client.prefs.w_toggles & TOOLTIP_USER_RETRO)
		to_chat(usr, "Я буду видеть названия предметов как раньше.")
		winset(usr, "mainwindow", "is-maximized=false")
		winset(usr, "mainwindow", "statusbar = false;statusbar = true")
		winset(usr, "mainwindow", "is-maximized=true")
	else
		to_chat(usr, "Я не буду видеть названия предметов как раньше.")
		winset(usr, "mainwindow", "is-maximized=false")
		winset(usr, "mainwindow", "statusbar = true;statusbar = false")
		winset(usr, "mainwindow", "is-maximized=true")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Tooltip Retro", "[usr.client.prefs.w_toggles & TOOLTIP_USER_RETRO ? "Вкл" : "Выкл"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/Game/toggle_tooltip_retro/Get_checked(client/C)
	return C.prefs.w_toggles & TOOLTIP_USER_RETRO
