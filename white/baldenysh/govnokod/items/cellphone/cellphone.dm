#define DEFAULT_SCREEN_TYPES list(\
									/datum/phonescreen/main,\
									/datum/phonescreen/menu/matrix/main,\
									/datum/phonescreen/recent,\
									/datum/phonescreen/contacts,\
									/datum/phonescreen/numinput,\
									/datum/phonescreen/incall\
								)

/obj/item/cellphone
	name = "Мобилка"
	desc = "Алло, вам звонит Лёха."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "suspiciousphone"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("звонит")
	slot_flags = ITEM_SLOT_ID | ITEM_SLOT_BELT

	var/obj/item/card/id/idc
	var/obj/item/card/data/calling/cc

	var/uplink_num

	var/list/screens = list()
	var/curscreen = "main"

/obj/item/cellphone/Initialize()
	. = ..()

	cc = new

	for(var/PStype in DEFAULT_SCREEN_TYPES)
		var/datum/phonescreen/PS = new PStype
		screens[PS.id] = PS
		PS.myphone = src

/obj/item/cellphone/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/card/id))
		var/obj/item/card/id/idcard = I
		if(!idcard.registered_name)
			to_chat(user, "<span class='warning'>\The [src] rejects the ID!</span>")
			return
		InsertID(idcard)

/obj/item/cellphone/AltClick(mob/user)
	..()
	RemoveID()

/obj/item/cellphone/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Cellphone", name)
		ui.open()

/obj/item/cellphone/ui_data(mob/user)
	var/list/data = list()

	var/datum/phonescreen/PS = screens[curscreen]

	data["screen"] = PS.id

	data["lf_menu"] = PS.lf_menu
	data["rf_menu"] = PS.rf_menu

	data += PS.screen_data()

	return data

/obj/item/cellphone/ui_act(action, params)
	if(..())
		return
	if(!screens[curscreen])
		return
	var/datum/phonescreen/PS = screens[curscreen]
	. = TRUE
	switch(action)
		if("call")
			PS.call_act()
		if("hang")
			PS.hang_act()
		if("leftfunc")
			PS.lf_act()
		if("rightfunc")
			PS.rf_act()
		if("dpad")
			PS.dpad_act(params["button"])
		if("numpad")
			PS.numpad_act(params["digit"])

/obj/item/cellphone/proc/set_screen(id)
	var/datum/phonescreen/PS = screens[id]
	if(!PS)
		return
	curscreen = id
	PS.on_set()
	if(ismob(loc))
		var/mob/user = loc
		ui_interact(user)

/obj/item/cellphone/GetAccess()
	if(idc)
		return idc.GetAccess()
	else
		return ..()

/obj/item/cellphone/GetID()
	return idc

/obj/item/cellphone/RemoveID()
	if(!idc)
		return
	. = idc
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc
		C.put_in_hands(idc)
	else
		idc.forceMove(get_turf(src))
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.sec_hud_set_ID()

/obj/item/cellphone/InsertID(obj/item/inserting_item)
	var/obj/item/card/id/inserting_id = inserting_item.RemoveID()
	if(!inserting_id)
		return FALSE
	inserting_id.forceMove(src)
	idc = inserting_id
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.sec_hud_set_ID()
	if(inserting_id in contents)
		return TRUE
	return FALSE
