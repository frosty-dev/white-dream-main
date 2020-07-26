/obj/item/storage/blister
	name = "блистерная упаковка"
	desc = "Прозрачная."
	icon = 'white/baldenysh/icons/obj/blister.dmi'
	icon_state = "foilplastic"
	inhand_icon_state = null
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/plastic = 100)
	w_class = WEIGHT_CLASS_TINY
	appearance_flags = KEEP_TOGETHER

	var/list/pill_list = list()

/obj/item/storage/blister/ComponentInitialize()
	. = ..()

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = pill_list.len
	STR.set_holdable(list(/obj/item/reagent_containers/pill))
	STR.allow_quick_empty = FALSE
	STR.quickdraw = TRUE

/obj/item/storage/blister/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)

	for(var/i = 1 to STR.max_items)
		var/pill_type = pill_list[i]["pilltype"]
		pill_list[i]["pillobj"] = new pill_type(src)
		var/list/curitem = pill_list[i]
		var/obj/curobj = curitem["pillobj"]

		var/list/overlays = list()
		overlays.Add(image(icon = curobj.icon, icon_state = curobj.icon_state, pixel_x = curitem["posx"], pixel_y = curitem["posy"]))
		overlays.Add(image(icon = icon, icon_state = curitem["pillstate"], pixel_x = curitem["posx"], pixel_y = curitem["posy"]))

		pill_list[i]["overlays"] = overlays

		add_overlay(overlays)

	STR.max_items = 0
	STR.set_holdable(list())

/obj/item/storage/blister/Exited(atom/movable/thing, atom/newLoc)
	..()

	var/list/curitem = null
	for(var/list/L in pill_list)
		if(L["pillobj"] == thing)
			curitem = L
			break

	if(!curitem)
		return

	cut_overlay(curitem["overlays"])

	var/list/overlays_broken = list()
	overlays_broken.Add(image(icon = initial(icon), icon_state = "foil_broken", pixel_x = curitem["posx"], pixel_y = curitem["posy"]))
	overlays_broken.Add(image(icon = initial(icon), icon_state = curitem["pillstate"]+"_broken", pixel_x = curitem["posx"], pixel_y = curitem["posy"]))

	add_overlay(overlays_broken)

	pill_list.Remove(curitem)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/storage/blister/hohlomicin
	name = "блистерная упаковка (Хохломицин)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/hohlomicin, pillstate = "long", posx = -5, posy = -5),
					list(pilltype = /obj/item/reagent_containers/pill/hohlomicin, pillstate = "long", posx = 0, posy = 1),
					list(pilltype = /obj/item/reagent_containers/pill/hohlomicin, pillstate = "long", posx = 5, posy = 7)
					)

/obj/item/storage/blister/haloperidol
	name = "блистерная упаковка (Галоперидол)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/haloperidol, pillstate = "round", posx = -4, posy = -7),
					list(pilltype = /obj/item/reagent_containers/pill/haloperidol, pillstate = "round", posx = -5, posy = 1),
					list(pilltype = /obj/item/reagent_containers/pill/haloperidol, pillstate = "round", posx = 3, posy = 0),
					list(pilltype = /obj/item/reagent_containers/pill/haloperidol, pillstate = "round", posx = 2, posy = 8),
					list(pilltype = /obj/item/reagent_containers/pill/haloperidol, pillstate = "round", posx = 10, posy = 7)
					)

/obj/item/storage/blister/antihol
	name = "блистерная упаковка (Антиголь)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/antihol, pillstate = "round", posx = -4, posy = -7),
					list(pilltype = /obj/item/reagent_containers/pill/antihol, pillstate = "round", posx = -5, posy = 1),
					list(pilltype = /obj/item/reagent_containers/pill/antihol, pillstate = "round", posx = 3, posy = 0),
					list(pilltype = /obj/item/reagent_containers/pill/antihol, pillstate = "round", posx = 2, posy = 8),
					list(pilltype = /obj/item/reagent_containers/pill/antihol, pillstate = "round", posx = 10, posy = 7)
					)

/obj/item/storage/blister/stimulant
	name = "блистерная упаковка (Стимулянты)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/stimulant, pillstate = "long", posx = -5, posy = -5),
					list(pilltype = /obj/item/reagent_containers/pill/stimulant, pillstate = "long", posx = 5, posy = 7)
					)

/obj/item/storage/blister/psicodine
	name = "блистерная упаковка (Псикодин)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/psicodine, pillstate = "long", posx = -5, posy = -5),
					list(pilltype = /obj/item/reagent_containers/pill/psicodine, pillstate = "long", posx = 0, posy = 1),
					list(pilltype = /obj/item/reagent_containers/pill/psicodine, pillstate = "long", posx = 5, posy = 7)
					)

/obj/item/storage/blister/potassiodide
	name = "блистерная упаковка (Йодид калия)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/potassiodide, pillstate = "round", posx = -4, posy = -7),
					list(pilltype = /obj/item/reagent_containers/pill/potassiodide, pillstate = "round", posx = -5, posy = 1),
					list(pilltype = /obj/item/reagent_containers/pill/potassiodide, pillstate = "round", posx = 3, posy = 0),
					list(pilltype = /obj/item/reagent_containers/pill/potassiodide, pillstate = "round", posx = 2, posy = 8),
					list(pilltype = /obj/item/reagent_containers/pill/potassiodide, pillstate = "round", posx = 10, posy = 7)
					)

/obj/item/storage/blister/aspirin
	name = "блистерная упаковка (Аспирин)"
	pill_list = list(
					list(pilltype = /obj/item/reagent_containers/pill/aspirin, pillstate = "round", posx = -4, posy = -7),
					list(pilltype = /obj/item/reagent_containers/pill/aspirin, pillstate = "round", posx = -5, posy = 1),
					list(pilltype = /obj/item/reagent_containers/pill/aspirin, pillstate = "round", posx = 3, posy = 0),
					list(pilltype = /obj/item/reagent_containers/pill/aspirin, pillstate = "round", posx = 2, posy = 8),
					list(pilltype = /obj/item/reagent_containers/pill/aspirin, pillstate = "round", posx = 10, posy = 7)
					)
