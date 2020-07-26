/obj/item/gun/energy/e_gun
	name = "Е-Ган"
	desc = "Базовая гибридная энергетическая пушка с двумя настройками: оглушить и убить."
	icon_state = "energy"
	inhand_icon_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	modifystate = 1
	can_flashlight = TRUE
	ammo_x_offset = 3
	flight_x_offset = 15
	flight_y_offset = 10
	dual_wield_spread = 60

/obj/item/gun/energy/e_gun/mini
	name = "миниатюрный Е-Ган"
	desc = "Маленькая энергетическая пушка размером с пистолет со встроенным фонариком. У него есть две настройки: оглушить и убить."
	icon_state = "mini"
	inhand_icon_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell/mini_egun
	ammo_x_offset = 2
	charge_sections = 3
	can_flashlight = FALSE // Can't attach or detach the flashlight, and override it's icon update
	gunlight_state = "mini-light"
	flight_x_offset = 19
	flight_y_offset = 13

/obj/item/gun/energy/e_gun/mini/Initialize()
	gun_light = new /obj/item/flashlight/seclite(src)
	return ..()

/obj/item/gun/energy/e_gun/stun
	name = "тактический Е-Ган"
	desc = "Военный выпуск энергетической пушки, способен стрелять оглушающими патронами."
	icon_state = "energytac"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/e_gun/old
	name = "ПЭП"
	desc = "NT-P:01 Прототип Энергетической Пушки. Ранняя стадия разработки уникальной лазерной винтовки с многогранной энергетической линзой, позволяющей оружию изменять форму снаряда, стреляющего по команде."
	icon_state = "protolaser"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/electrode/old)

/obj/item/gun/energy/e_gun/mini/practice_phaser
	name = "тренировочный фазер"
	desc = "Модифицированная версия основного фазерного оружия, эта стреляет менее концентрированными энергетическими выстрелами, предназначенными для целевой практики."
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/practice)
	icon_state = "decloner"

/obj/item/gun/energy/e_gun/hos
	name = "\improper X-01 МультиФазовый Е-Ган"
	desc = "Это дорогой, современный образец старинной лазерной пушки. У этого оружия есть несколько уникальных режимов огня, но ему не хватает времени на перезарядку."
	cell_type = /obj/item/stock_parts/cell/hos_gun
	icon_state = "hoslaser"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/ion/hos)
	ammo_x_offset = 4
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/e_gun/dragnet
	name = "ЦАПсеть"
	desc = "\"Целевое Автоматизированное Правосудие\" стреляет сеткой и упрощает работу сотрудникам безопасности."
	icon_state = "dragnet"
	inhand_icon_state = "dragnet"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/net, /obj/item/ammo_casing/energy/trap)
	can_flashlight = FALSE
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/dragnet/snare
	name = "сеткомёт"
	desc = "Выстреливает энергетическую ловушку, которая замедляет цель."
	ammo_type = list(/obj/item/ammo_casing/energy/trap)

/obj/item/gun/energy/e_gun/turret
	name = "гибридная турельная-пушка"
	desc = "Тяжелая гибридная энергетическая пушка с двумя настройками: оглушить и убить."
	icon_state = "turretlaser"
	inhand_icon_state = "turretlaser"
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_HEAVY
	can_flashlight = FALSE
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/nuclear
	name = "продвинутый Е-Ган"
	desc = "Энергетическая пушка с экспериментальным миниатюрным ядерным реактором, который автоматически заряжает внутреннюю силовую ячейку."
	icon_state = "nucgun"
	inhand_icon_state = "nucgun"
	charge_delay = 5
	pin = null
	can_charge = FALSE
	ammo_x_offset = 1
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/disabler)
	selfcharge = 1
	var/reactor_overloaded
	var/fail_tick = 0
	var/fail_chance = 0

/obj/item/gun/energy/e_gun/nuclear/process()
	if(fail_tick > 0)
		fail_tick--
	..()

/obj/item/gun/energy/e_gun/nuclear/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	failcheck()
	update_icon()
	..()

/obj/item/gun/energy/e_gun/nuclear/proc/failcheck()
	if(prob(fail_chance) && isliving(loc))
		var/mob/living/M = loc
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				M.rad_act(40)
				to_chat(M, "<span class='userdanger'>Мой [name] начинает нагреваться.</span>")
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				M.rad_act(80)
				reactor_overloaded = TRUE
				to_chat(M, "<span class='userdanger'>Мой [name] перегружается!</span>")

/obj/item/gun/energy/e_gun/nuclear/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/gun/energy/e_gun/nuclear/update_overlays()
	. = ..()
	if(reactor_overloaded)
		. += "[icon_state]_fail_3"
	else
		switch(fail_tick)
			if(0)
				. += "[icon_state]_fail_0"
			if(1 to 150)
				. += "[icon_state]_fail_1"
			if(151 to INFINITY)
				. += "[icon_state]_fail_2"
