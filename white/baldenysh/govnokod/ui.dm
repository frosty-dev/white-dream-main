#define ui_main "EAST-1:28,SOUTH+2:8"
#define ui_special "EAST-1:44,SOUTH+2:8"
#define ui_settings "EAST-1:44,SOUTH+2:24"
#define ui_admin "EAST-1:28,SOUTH+2:24"

/datum/hud/proc/extend(mob/owner)
	var/obj/screen/using

	if(owner.client.holder)
		using = new /obj/screen/verbbutton/admin()
		//using.icon = ui_style
		using.screen_loc = ui_admin
		using.hud = src
		infodisplay += using

	using = new /obj/screen/verbbutton/special()
	//using.icon = ui_style
	using.screen_loc = ui_special
	using.hud = src
	infodisplay += using

	using = new /obj/screen/verbbutton/settings()
	//using.icon = ui_style
	using.screen_loc = ui_settings
	using.hud = src
	infodisplay += using

	using = new /obj/screen/verbbutton/main()
	//using.icon = ui_style
	using.screen_loc = ui_main
	using.hud = src
	infodisplay += using

////////////////////////////////////////////////////////////

/mob/proc/get_all_verbs()
	var/list/verblist = list()
	for(var/verb_M in verbs)
		if(verb_M in verblist)
			continue
		verblist += verb_M
	/*
	for(var/obj/item/I in contents)
		for(var/verb_I in I.verbs)
			if(verb_I in verblist)
				continue
			verblist += verb_I
	*/
	if(client)
		for(var/verb_C in client.verbs)
			if(verb_C in verblist)
				continue
			verblist += verb_C
	return verblist

/mob/proc/get_verb_categories()
	var/list/categories = list()
	for(var/verb_item in get_all_verbs())
		if(verb_item:category && !(verb_item:category in categories))
			categories += verb_item:category
	return categories

/proc/text2color(text)
	var/num = hex2num(copytext(md5(text), 1, 7))
	var/rgb = hsv2rgb(num % 360, (num / 360) % 10 / 100 + 0.48, num / 360 / 10 % 15 / 100 + 0.35)
	return rgb

///////////////////////////////////////////////////////////////////

/obj/screen/verbbutton
	name = "Верб кнопка прикол"
	var/list/allowed_categories = list(
								"IC", "OOC", "Объект", "Призрак", "Особенное", "Настройки",
								"Адм", "Адс", "Дбг", "Срв", "Фан"
							)
	var/ui_x = 450
	var/ui_y = 400

/obj/screen/verbbutton/Click()
	ui_interact(usr)

/obj/screen/verbbutton/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.always_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "VerbMenu", name, ui_x, ui_y, master_ui, state)
		ui.open()

/obj/screen/verbbutton/ui_status(mob/user)
	return UI_INTERACTIVE

/obj/screen/verbbutton/ui_data(mob/user)
	var/list/data = list()
	data["verbs"] = list()

	for(var/verb_item in user.get_all_verbs())
		if(!verb_item:hidden && verb_item:category && (verb_item:category in allowed_categories))
			var/list/L = splittext("[verb_item]", "/")
			var/verbpath = L[L.len]
			var/verbcolor = text2color(verbpath)
			data["verbs"][verb_item:category] += list(list(verb_item:name, verbpath, verbcolor))
	return data

/obj/screen/verbbutton/ui_act(action, params)
	if(..())
		return
	//регекс для поиска пидорасов: proc\/[\w\s]+\([\w\s]+as[\w\s]+\)[\w\s="]+set category
	if(hascall(usr, action))
		call(usr, action)()
	else if (hascall(usr.client, action))
		call(usr.client, action)()

////////////////////////////////////////////////////

/obj/screen/verbbutton/admin
	name = "Админ"
	icon = 'white/baldenysh/icons/ui/midnight_extended.dmi'
	icon_state = "admin"
	screen_loc = ui_admin
	allowed_categories = list("Адм", "Адс", "Дбг", "Срв", "Фан", "Маппинг", "Профайл")
	ui_y = 500

/obj/screen/verbbutton/admin/Click()
	if(usr.client.holder)
		ui_interact(usr)

/obj/screen/verbbutton/main
	name = "Действия"
	icon = 'white/baldenysh/icons/ui/midnight_extended.dmi'
	icon_state = "main"
	screen_loc = ui_main
	allowed_categories = list("IC", "OOC", "Объект", "Призрак")
	ui_y = 300

/obj/screen/verbbutton/special
	name = "Особое"
	icon = 'white/baldenysh/icons/ui/midnight_extended.dmi'
	icon_state = "special"
	screen_loc = ui_special
	allowed_categories = list("Особенное")

/obj/screen/verbbutton/settings
	name = "Настройки"
	icon = 'white/baldenysh/icons/ui/midnight_extended.dmi'
	icon_state = "settings"
	screen_loc = ui_settings
	allowed_categories = list("Настройки")

/obj/screen/verbbutton/settings/ui_data(mob/user)
	var/list/data = list()
	data["verbs"] = list()
	data["verbs"]["Основное"] = list()

	for(var/verb_item in user.get_all_verbs())
		if(verb_item:category && (verb_item:category in allowed_categories))
			var/list/L = splittext("[verb_item]", "/")
			var/verbpath = L[L.len]
			var/verbcolor = text2color(verbpath)
			if(findtext(verb_item:name, "🔄"))
				data["verbs"]["Предпочтения"] += list(list(verb_item:name, verbpath, verbcolor))
			else
				data["verbs"]["Основное"] += list(list(verb_item:name, verbpath, verbcolor))
	return data
