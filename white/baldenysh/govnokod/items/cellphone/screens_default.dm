/datum/phonescreen/menu/matrix/main
	id = "menu"
	name = "Меню"
	lf_menu = "Закрыть"

/datum/phonescreen/menu/matrix/main/lf_act()
	myphone.set_screen("main")

/datum/phonescreen/menu/matrix/main/regen_options()
	options = list(list())
	var/i = 1
	for(var/scr_id in myphone.screens)
		var/datum/phonescreen/PS = myphone.screens[scr_id]
		if(!PS.menuitem)
			continue
		if(options.len >= i)
			options[i] += list(list(PS.name, PS.id))
		else
			options += list(list(list(PS.name, PS.id)))
		i++
		if(i>3)
			i=1

/datum/phonescreen/menu/matrix/main/select_act(selection)
	myphone.set_screen(selection[2])

//////////////////////////////////////////////////////////////////////////////

/datum/phonescreen/recent
	id = "recent"
	name = "История"
	lf_menu = "Звонок"

/datum/phonescreen/recent/call_act()
	return

/datum/phonescreen/recent/lf_act()
	myphone.set_screen("call")
/datum/phonescreen/recent/rf_act()

/datum/phonescreen/contacts
	id = "contacts"
	name = "Контакты"
	lf_menu = "История"
	rf_menu = "Добавить"
	menuitem = TRUE

/datum/phonescreen/contacts/call_act()
	return

/datum/phonescreen/contacts/lf_act()
	myphone.set_screen("recent")
/datum/phonescreen/contacts/rf_act()

/datum/phonescreen/numinput
	id = "call"
	name = "Звонок"
	lf_menu = "Контакты"

/datum/phonescreen/numinput/call_act()
	return

/datum/phonescreen/numinput/lf_act()
	myphone.set_screen("contacts")
/datum/phonescreen/numinput/rf_act()

/datum/phonescreen/incall
	id = "incall"
	name = "Звонок"
	lf_menu = ""
	menuitem = FALSE

/datum/phonescreen/incall/hang_act()
	return

/datum/phonescreen/incall/call_act()
	return
