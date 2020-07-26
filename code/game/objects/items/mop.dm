/obj/item/mop
	desc = "Мир \"janitalia\" не был бы полным без швабры."
	name = "швабра"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "mop"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 8
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("моет", "лупит", "бьёт", "ударяет")
	resistance_flags = FLAMMABLE
	var/mopping = 0
	var/mopcount = 0
	var/mopcap = 15
	var/mopspeed = 15
	force_string = "крепкая... против микробов"
	var/insertable = TRUE

/obj/item/mop/Initialize()
	. = ..()
	create_reagents(mopcap)


/obj/item/mop/proc/clean(turf/A, mob/living/cleaner)
	if(reagents.has_reagent(/datum/reagent/water, 1) || reagents.has_reagent(/datum/reagent/water/holywater, 1) || reagents.has_reagent(/datum/reagent/consumable/ethanol/vodka, 1) || reagents.has_reagent(/datum/reagent/space_cleaner, 1))
		SEND_SIGNAL(A, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_MEDIUM)
		for(var/obj/effect/O in A)
			if(is_cleanable(O))
				var/obj/effect/decal/cleanable/C = O
				cleaner?.mind.adjust_experience(/datum/skill/cleaning, max(round(C.beauty/CLEAN_SKILL_BEAUTY_ADJUSTMENT,1),0)) //it is intentional that the mop rounds xp but soap does not, USE THE SACRED TOOL
				qdel(O)
	reagents.expose(A, TOUCH, 10)	//Needed for proper floor wetting.
	var/val2remove = 1
	if(cleaner?.mind)
		val2remove = round(cleaner.mind.get_skill_modifier(/datum/skill/cleaning, SKILL_SPEED_MODIFIER),0.1)
	reagents.remove_any(val2remove)			//reaction() doesn't use up the reagents


/obj/item/mop/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return

	if(reagents.total_volume < 0.1)
		to_chat(user, "<span class='warning'>Швабра сухая!</span>")
		return

	var/turf/T = get_turf(A)

	if(istype(A, /obj/item/reagent_containers/glass/bucket) || istype(A, /obj/structure/janitorialcart))
		return

	if(T)
		user.visible_message("<span class='notice'>[user] начинает мыть [T] используя [src.name].</span>", "<span class='notice'>Начинаю мыть [T] используя [src.name]...</span>")
		var/clean_speedies = user.mind.get_skill_modifier(/datum/skill/cleaning, SKILL_SPEED_MODIFIER)
		if(do_after(user, mopspeed*clean_speedies, target = T))
			to_chat(user, "<span class='notice'>Заканчиваю мыть пол.</span>")
			clean(T, user)


/obj/effect/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/mop) || istype(I, /obj/item/soap))
		return
	else
		return ..()


/obj/item/mop/proc/janicart_insert(mob/user, obj/structure/janitorialcart/J)
	if(insertable)
		J.put_in_cart(src, user)
		J.mymop=src
		J.update_icon()
	else
		to_chat(user, "<span class='warning'>Эта штука не помещается у меня в [J.name].</span>")
		return

/obj/item/mop/cyborg
	insertable = FALSE

/obj/item/mop/advanced
	desc = "Самый передовой инструмент в арсенале хранителя, в комплекте с конденсатором для смачивания! Просто подумайте обо всех внутренностях, которые вы очистите с этим!"
	name = "продвинутая швабра"
	mopcap = 10
	icon_state = "advmop"
	inhand_icon_state = "mop"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 12
	throwforce = 14
	throw_range = 4
	mopspeed = 8
	var/refill_enabled = TRUE //Self-refill toggle for when a janitor decides to mop with something other than water.
	var/refill_rate = 1 //Rate per process() tick mop refills itself
	var/refill_reagent = /datum/reagent/water //Determins what reagent to use for refilling, just in case someone wanted to make a HOLY MOP OF PURGING

/obj/item/mop/advanced/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/mop/advanced/attack_self(mob/user)
	refill_enabled = !refill_enabled
	if(refill_enabled)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj,src)
	to_chat(user, "<span class='notice'>Устанавливаю переключатель конденсатора в положение '[refill_enabled ? "ВКЛ" : "ВЫКЛ"]'.</span>")
	playsound(user, 'sound/machines/click.ogg', 30, TRUE)

/obj/item/mop/advanced/process()

	if(reagents.total_volume < mopcap)
		reagents.add_reagent(refill_reagent, refill_rate)

/obj/item/mop/advanced/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Переключатель конденсатора сейчас в положении <b>[refill_enabled ? "ВКЛ" : "ВЫКЛ"]</b>.</span>"

/obj/item/mop/advanced/Destroy()
	if(refill_enabled)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mop/advanced/cyborg
	insertable = FALSE
