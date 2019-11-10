/*
/obj/item/clothing
	var/obj/item/nightvision/nvg
	//var/datum/action/item_action/nightvision/nva
/*
/obj/item/clothing/New()
	. = ..()
	if(nvg)
		nva = new(src)

/obj/item/clothing/proc/AttachNvg()
	if(nvg)
		nva = new(src)
*/

/obj/item/clothing/proc/AttachNVG(var/type = /obj/item/nightvision)
	nvg = new type(src)
	src.actions_types += new/datum/action/item_action/nightvision(src)

/obj/item/nightvision
	var/active = 0
	var/colour_matrix = /datum/client_colour/nvg	//NIGHTVISION_MATRIX_I
	actions_types = list(/datum/action/item_action/nightvision)

/datum/action/item_action/nightvision
	name = "Toggle Night Vision"

/obj/item/nightvision/advanced
	colour_matrix = /datum/client_colour/nvg2		//NIGHTVISION_MATRIX_II

/obj/item/clothing/proc/toggle_nightvision()
	var/mob/living/carbon/human/user = usr

	if (user.wear_mask != src && user.head != src)
		to_chat(usr, "Вы крутите переключатель ПНВ [src] в надежде разглядеть что-то во тьме, но у вас ничего не выходит. Может стоить надеть его?")
		playsound(usr, 'stalker/sound/nv_start.ogg', 50, 1, -1)
		//if (prob(5))
		//	to_chat(usr, "<b>Тем самым приводя устройство в состояние бесполезной тряпки!</b>")
		//	playsound(usr, 'stalker/sound/nv_off.ogg', 50, 1, -1)
		//	qdel(src)
		return

	if(!nvg)
		return

	nvg.active = !nvg.active
	update_nightvision()
	//user.seek_screen_colour()
	user.update_sight()

/obj/item/clothing/proc/update_nightvision()
	if(nvg)
		var/mob/living/carbon/human/user = usr
		if(!nvg.active)
			playsound(usr, 'stalker/sound/nv_off.ogg', 50, 1, -1)
			to_chat(usr, "Вы деактивировали оптическую матрицу [src].")
			user.remove_client_colour(nvg.colour_matrix)
			user.see_override_nva = 0
		else
			playsound(usr, 'stalker/sound/nv_start.ogg', 50, 1, -1)
			to_chat(usr, "Вы активировали оптическую матрицу [src].")
			user.add_client_colour(nvg.colour_matrix)
			user.see_override_nva = 4
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/dropped(mob/user)
	..()
	if(nvg)
		if (nvg.active)
			toggle_nightvision()

/obj/item/clothing/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/nightvision))
		toggle_nightvision()
	else
		..()
*/
