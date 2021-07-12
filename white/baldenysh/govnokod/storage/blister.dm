/obj/item/storage/blister
	name = "блистерная упаковка"
	desc = "Прозрачная."
	icon = 'white/baldenysh/icons/obj/blister.dmi'
	icon_state = "foilplastic"
	inhand_icon_state = null
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/plastic = 1000)
	w_class = WEIGHT_CLASS_TINY
	appearance_flags = KEEP_TOGETHER

	var/list/populate_pill_types = list()
	var/list/pill_positions = list()

/obj/item/storage/blister/ComponentInitialize()
	. = ..()

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = pill_positions.len
	STR.set_holdable(list(/obj/item/reagent_containers/pill))
	STR.allow_quick_empty = FALSE
	STR.quickdraw = TRUE

/obj/item/storage/blister/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	for(var/i = 1 to STR.max_items)
		var/obj/item/reagent_containers/pill/new_pill
		for(var/pill_type in populate_pill_types)
			if(populate_pill_types[pill_type] > 0)
				populate_pill_types[pill_type]--
				new_pill = new pill_type(src)
				break
		if(!new_pill)
			break

		pill_positions[i]["pill_item"] = new_pill

		var/list/curitem = pill_positions[i]
		var/list/overlays = list()
		overlays.Add(image(icon = new_pill.icon, icon_state = new_pill.icon_state, pixel_x = curitem["x"], pixel_y = curitem["y"]))
		overlays.Add(image(icon = icon, icon_state = new_pill.get_shape(), pixel_x = curitem["x"], pixel_y = curitem["y"]))
		pill_positions[i]["overlays"] = overlays
		add_overlay(overlays)

	STR.max_items = 0
	STR.set_holdable(list())

/obj/item/storage/blister/Exited(atom/movable/thing, atom/newLoc) //кудато сюда крутой звук ебнуть надо но ево у меня нет
	..()

	var/list/curitem
	for(var/list/L in pill_positions)
		if(L["pill_item"] == thing)
			curitem = L
			break

	if(!curitem)
		return

	cut_overlay(curitem["overlays"])

	var/list/overlays_broken = list()
	var/obj/item/reagent_containers/pill/P = thing
	overlays_broken.Add(image(icon = initial(icon), icon_state = "foil_broken", pixel_x = curitem["x"], pixel_y = curitem["y"]))
	overlays_broken.Add(image(icon = initial(icon), icon_state = "[P.get_shape()]_broken", pixel_x = curitem["x"], pixel_y = curitem["y"]))
	add_overlay(overlays_broken)

	pill_positions.Remove(curitem)

/obj/item/reagent_containers/pill/proc/get_shape()
	var/postfix = replacetext(icon_state, "pill", "")
	var/num = text2num(postfix)
	if(postfix == "_happy" || (num >= 7 && num <= 17))
		return "circle"
	return "capsule"
	/*
	var/icon/I = icon(icon,icon_state)
	if(I.GetPixel(20, 16, icon_state))
		return "capsule"
	return "circle"
	*/

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/storage/blister/fivecir
	populate_pill_types = list(/obj/item/reagent_containers/pill/haloperidol = 5)
	pill_positions = list(list(x = -4, y = -7), list(x = -5, y = 1), list(x = 3, y = 0), list(x = 2, y = 8), list(x = 10, y = 7))

/obj/item/storage/blister/threecap
	populate_pill_types = list(/obj/item/reagent_containers/pill/hohlomicin = 3)
	pill_positions = list(list(x = -5, y = -5), list(x = 0, y = 1), list(x = 5, y = 7))

/obj/item/storage/blister/twocap
	populate_pill_types = list(/obj/item/reagent_containers/pill/hohlomicin = 2)
	pill_positions = list(list(x = -5, y = -5), list(x = 5, y = 7))
