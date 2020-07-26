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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/storage/box/pillpack/hohlomicin
	name = "Хохломицин"
	desc = "Таблетки содержат правий сиктор."
	illustration = "hohlomicin"
	custom_price = 6666
	blister_list = list(
						/obj/item/storage/blister/hohlomicin,
						/obj/item/storage/blister/hohlomicin
						)

/obj/item/storage/box/pillpack/haloperidol
	name = "Галоперидол"
	desc = "Шутки кончились."
	illustration = "haloperidol"
	custom_price = 200
	blister_list = list(
						/obj/item/storage/blister/haloperidol
						)


/obj/item/storage/box/pillpack/antihol
	name = "Антиголь"
	illustration = "antihol"
	custom_price = 100
	blister_list = list(
						/obj/item/storage/blister/antihol,
						/obj/item/storage/blister/antihol
						)

/obj/item/storage/box/pillpack/psicodine
	name = "Псикодин"
	illustration = "psicodine"
	custom_price = 300
	blister_list = list(
						/obj/item/storage/blister/psicodine,
						/obj/item/storage/blister/psicodine
						)

/obj/item/storage/box/pillpack/potassiodide
	name = "Йодид калия"
	illustration = "potassiodide"
	custom_price = 100
	blister_list = list(
						/obj/item/storage/blister/potassiodide
						)

/obj/item/storage/box/pillpack/stimulant
	name = "Стимулянты"
	illustration = "stimulant"
	custom_price = 1000
	blister_list = list(
						/obj/item/storage/blister/stimulant
						)

/obj/item/storage/box/pillpack/aspirin
	name = "Аспирин"
	illustration = "aspirin"
	custom_price = 400
	blister_list = list(
						/obj/item/storage/blister/aspirin,
						/obj/item/storage/blister/aspirin
						)

