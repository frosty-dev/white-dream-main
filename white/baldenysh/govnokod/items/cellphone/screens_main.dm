/datum/phonescreen
	var/obj/item/cellphone/myphone

	var/id = "aaa"
	var/name = "sasai kudosai"
	var/rf_menu
	var/lf_menu
	var/menuitem = TRUE

/datum/phonescreen/proc/on_set()

/datum/phonescreen/proc/screen_data()
	return list()

/datum/phonescreen/proc/call_act()
	myphone.set_screen("recent")

/datum/phonescreen/proc/hang_act()
	myphone.set_screen("main")

/datum/phonescreen/proc/lf_act()

/datum/phonescreen/proc/rf_act()

/datum/phonescreen/proc/dpad_act(button)
	switch(button)
		if("larrow")
			return
		if("rarrow")
			return
		if("uarrow")
			return
		if("darrow")
			return
		if("enter")
			return

/datum/phonescreen/proc/numpad_act(digit)

////////////////////////////////////////////////

/datum/phonescreen/main
	id = "main"
	name = "Главная"
	lf_menu = "Меню"

/datum/phonescreen/main/lf_act()
	myphone.set_screen("menu")

/datum/phonescreen/main/hang_act()
	return
