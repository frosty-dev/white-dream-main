/obj/item/discovery_scanner
	name = "нюхер"
	desc = "Используется учёными для сканирования различных артифактов и неизвестных форм жизни."
	icon = 'icons/obj/device.dmi'
	icon_state = "hand_tele"
	inhand_icon_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/datum/techweb/linked_techweb

/obj/item/discovery_scanner/Initialize()
	. = ..()
	if(!linked_techweb)
		linked_techweb = SSresearch.science_tech

/obj/item/discovery_scanner/examine(mob/user)
	. = ..()
	. += "<hr><span class='notice'>Левый клик по чему угодно для начала исследований.</span>"
	. += "\n<span class='notice'>[capitalize(src.name)] имеет безлимитный радиус, можете сканировать хоть через камеры.</span>"
	. += "\n<span class='notice'>Научные очки помогут узнать что может оказаться полезным.</span>"

/obj/item/discovery_scanner/attack_obj(obj/O, mob/living/user)
	if(istype(O, /obj/machinery/computer/rdconsole))
		to_chat(user, "<span class='notice'>Привязываю [src] к [O].</span>")
		var/obj/machinery/computer/rdconsole/rdconsole = O
		linked_techweb = rdconsole.stored_research
		return
	. = ..()

/obj/item/discovery_scanner/proc/begin_scanning(mob/user, datum/component/discoverable/discoverable)
	to_chat(user, "<span class='notice'>Начинаю сканировать [discoverable.parent]...</span>")
	if(do_after(user, 50, target=get_turf(user)))
		discoverable.discovery_scan(linked_techweb, user)
