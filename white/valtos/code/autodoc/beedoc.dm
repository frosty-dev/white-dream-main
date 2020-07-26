/obj/machinery/organdoc
	name = "Орган-Док МК IIX"
	desc = "Полностью стационарная автоматическая шаурмечница!"
	density = TRUE
	state_open = FALSE
	icon = 'white/valtos/icons/autodoc.dmi'
	icon_state = "autodoc_machine"
	verb_say = "states"
	idle_power_usage = 50
	circuit = /obj/item/circuitboard/machine/organdoc
	var/obj/item/organ/storedorgan
	var/organ_type = /obj/item/organ
	var/processing = FALSE
	var/surgerytime = 300

/obj/machinery/organdoc/Initialize()
	. = ..()
	update_icon()

/obj/machinery/organdoc/RefreshParts()
	var/max_time = 350
	for(var/obj/item/stock_parts/L in component_parts)
		max_time -= (L.rating*10)
	surgerytime = max(max_time,10)

/obj/machinery/organdoc/examine(mob/user)
	. = ..()
	if((obj_flags & EMAGGED) && panel_open)
		. += "<span class='warning'>Хирургические протоколы нарушены!</span>"
	if(processing)
		. += "<span class='notice'>На данный момент вставляет [storedorgan] в [occupant].</span>"
	else if(storedorgan)
		. += "<span class='notice'>Готов вставить [storedorgan].</span>"

/obj/machinery/organdoc/close_machine(mob/user)
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(occupant)
		if(!iscarbon(occupant))
			occupant.forceMove(drop_location())
			occupant = null
			return
		to_chat(occupant, "<span class='notice'>Вхожу в [src.name]</span>")

		dosurgery()

/obj/machinery/organdoc/proc/dosurgery()
	if(!storedorgan && !(obj_flags & EMAGGED))
		to_chat(occupant, "<span class='notice'>Органдок не имеет имплантов.</span>")
		return

	occupant.visible_message("<span class='notice'><b>[occupant]</b> нажимает на кнопку Органдока.</span>", "<span class='notice'>Ощущаю как острые штуки протыкают меня и что-то делают с моими органами.</span>")
	playsound(get_turf(occupant), 'sound/weapons/circsawhit.ogg', 50, 1)
	processing = TRUE
	update_icon()
	var/mob/living/carbon/C = occupant
	if(obj_flags & EMAGGED)

		for(var/obj/item/bodypart/BP in reverseList(C.bodyparts)) //Chest and head are first in bodyparts, so we invert it to make them suffer more
			C.emote("scream")
			if(!HAS_TRAIT(C, TRAIT_NODISMEMBER))
				BP.dismember()
			else
				C.apply_damage(40, BRUTE, BP)
			sleep(5) //2 seconds to get outta there before dying
			if(!processing)
				return

		occupant.visible_message("<span class='warning'>Органдок нарезает на кусочки <b>[occupant]</b>!</span>", "<span class='warning'>Органдок начинает шинковать меня как салат Цезарь!</span>")

	else
		sleep(surgerytime)
		if(!processing)
			return
		var/obj/item/organ/currentorgan = C.getorganslot(storedorgan.slot)
		if(currentorgan)
			currentorgan.Remove(C)
			currentorgan.forceMove(get_turf(src))
		storedorgan.Insert(occupant)//insert stored organ into the user
		storedorgan = null
		occupant.visible_message("<span class='notice'>Органдок завершает хирургическую процедуру</span>", "<span class='notice'>Органдок вставляет орган в моё тело.</span>")
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, 0)
	processing = FALSE
	open_machine()

/obj/machinery/organdoc/open_machine(mob/user)
	if(processing)
		occupant.visible_message("<span class='notice'><b>[user]</b> отменяет процедуру Органдока</span>", "<span class='notice'>Органдок прекращает вставлять орган в моё тело.</span>")
		processing = FALSE
	if(occupant)
		occupant.forceMove(drop_location())
		occupant = null
	..(FALSE)

/obj/machinery/organdoc/interact(mob/user)
	if(panel_open)
		to_chat(user, "<span class='notice'>Закрыть бы техническую панель сначала.</span>")
		return

	if(state_open)
		close_machine()
		return

	open_machine()

/obj/machinery/organdoc/attackby(obj/item/I, mob/user, params)
	if(istype(I, organ_type))
		if(storedorgan)
			to_chat(user, "<span class='notice'>Органдок уже имеет орган для работы.</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		storedorgan = I
		I.forceMove(src)
		to_chat(user, "<span class='notice'>Вставляю [I.name] в Органдок.</span>")
	else
		return ..()

/obj/machinery/organdoc/screwdriver_act(mob/living/user, obj/item/I)
	. = TRUE
	if(..())
		return
	if(occupant)
		to_chat(user, "<span class='warning'>Органдок уже занят!</span>")
		return
	if(state_open)
		to_chat(user, "<span class='warning'>Органдок должен быть закрыт!</span>")
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		if(storedorgan)
			storedorgan.forceMove(drop_location())
			storedorgan = null
		update_icon()
		return
	return FALSE

/obj/machinery/organdoc/crowbar_act(mob/living/user, obj/item/I)
	if(default_deconstruction_crowbar(I))
		return TRUE


/obj/machinery/organdoc/update_icon()
	overlays.Cut()
	if(!state_open)
		if(processing)
			overlays += "[icon_state]_door_on"
			overlays += "[icon_state]_stack"
			overlays += "[icon_state]_smoke"
			overlays += "[icon_state]_green"
		else
			overlays += "[icon_state]_door_off"
			if(occupant)
				if(powered(AREA_USAGE_EQUIP))
					overlays += "[icon_state]_stack"
					overlays += "[icon_state]_yellow"
			else
				overlays += "[icon_state]_red"
	else if(powered(AREA_USAGE_EQUIP))
		overlays += "[icon_state]_red"
	if(panel_open)
		overlays += "[icon_state]_panel"

/obj/machinery/organdoc/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(user, "<span class='warning'>Переделываю программу в режим готовки шаурмы.</span>")

/obj/item/circuitboard/machine/organdoc
	name = "Органдок (Machine Board)"
	build_path = /obj/machinery/organdoc
	req_components = list(/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/surgicaldrill/advanced = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stock_parts/matter_bin = 1)

/datum/design/board/organdoc
	name = "Machine Design (Organdoc)"
	desc = "The circuit board for an Organdoc."
	id = "organdoc"
	build_path = /obj/item/circuitboard/machine/organdoc
	category = list("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
