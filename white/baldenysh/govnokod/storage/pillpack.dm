/obj/item/storage/box/pillpack
	name = "пачка таблеток"
	desc = "Картонная пачка."
	icon = 'white/baldenysh/icons/obj/pillpack.dmi'
	icon_state = "pillpack"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	illustration = "haloperidol"
	w_class = WEIGHT_CLASS_SMALL
	var/list/blister_list = list()

/obj/item/storage/box/pillpack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = blister_list.len
	STR.set_holdable(list(/obj/item/storage/blister))
	STR.locked = TRUE

/obj/item/storage/box/pillpack/PopulateContents()
	for(var/type in blister_list)
		new type(src)

/obj/item/storage/box/pillpack/attack_self(mob/user)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR.locked)
		icon_state += "_open"
		user.visible_message("<span class='notice'>[user] открывает [src].</span>", "<span class='notice'>Ты открываешь [src].</span>")
		STR.locked = FALSE
		if(contents.len)
			return
	else
		icon_state = initial(icon_state)
		user.visible_message("<span class='notice'>[user] закрывает [src].</span>", "<span class='notice'>Ты закрываешь [src].</span>")
		STR.locked = TRUE
		return

	..()
