/obj/item/gun/energy/ionrifle
	name = "ионная винтовка"
	desc = "Переносное противо бронированное оружие, предназначенное для предотвращения механических угроз на расстоянии."
	icon_state = "ionrifle"
	inhand_icon_state = null	//so the human update icon uses the icon_state instead.
	worn_icon_state = null
	shaded_charge = TRUE
	can_flashlight = TRUE
	w_class = WEIGHT_CLASS_HUGE
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/ion)
	flight_x_offset = 17
	flight_y_offset = 9

/obj/item/gun/energy/ionrifle/emp_act(severity)
	return

/obj/item/gun/energy/ionrifle/carbine
	name = "ионный карабин"
	desc = "Протонный ионный проектор MK.II - это облегченная карабинная версия большой ионной винтовки, созданная для эргономичности и эффективности."
	icon_state = "ioncarbine"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	pin = null
	flight_x_offset = 18
	flight_y_offset = 11

/obj/item/gun/energy/decloner
	name = "биологический демолекулятор"
	desc = "Пистолет, который выпускает большое количество контролируемой радиации, чтобы медленно разбить цель на составляющие элементы."
	icon_state = "decloner"
	ammo_type = list(/obj/item/ammo_casing/energy/declone)
	pin = null
	ammo_x_offset = 1

/obj/item/gun/energy/decloner/update_overlays()
	. = ..()
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	if(!QDELETED(cell) && (cell.charge > shot.e_cost))
		. += "decloner_spin"

/obj/item/gun/energy/decloner/unrestricted
	pin = /obj/item/firing_pin
	ammo_type = list(/obj/item/ammo_casing/energy/declone/weak)

/obj/item/gun/energy/floragun
	name = "цветочный луч"
	desc = "Инструмент, который выпускает контролируемое излучение, которое вызывает мутацию в растительных клетках."
	icon_state = "flora"
	inhand_icon_state = "gun"
	ammo_type = list(/obj/item/ammo_casing/energy/flora/yield, /obj/item/ammo_casing/energy/flora/mut, /obj/item/ammo_casing/energy/flora/revolution)
	modifystate = 1
	ammo_x_offset = 1
	selfcharge = 1

/obj/item/gun/energy/meteorgun
	name = "метеоритная пушка"
	desc = "Ради любви к Богу, убедитесь, что вы нацелили это правильно!"
	icon_state = "meteor_gun"
	inhand_icon_state = "c20r"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/meteor)
	cell_type = "/obj/item/stock_parts/cell/potato"
	clumsy_check = 0 //Admin spawn only, might as well let clowns use it.
	selfcharge = 1

/obj/item/gun/energy/meteorgun/pen
	name = "метеоритная ручка"
	desc = "Ручка сильнее меча."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun/energy/mindflayer
	name = "Пожиратель разума"
	desc = "Прототип оружия, найденный на руинах исследовательской станции Эпсилон."
	icon_state = "xray"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)
	ammo_x_offset = 2

/obj/item/gun/energy/kinetic_accelerator/crossbow
	name = "мини энергетический арбалет"
	desc = "Оружие, предпочитаемое синдикаторами-невидимками."
	icon_state = "crossbow"
	inhand_icon_state = "crossbow"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=2000)
	suppressed = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/bolt)
	weapon_weight = WEAPON_LIGHT
	obj_flags = 0
	overheat_time = 20
	holds_charge = TRUE
	unique_frequency = TRUE
	can_flashlight = FALSE
	max_mod_capacity = 0

/obj/item/gun/energy/kinetic_accelerator/crossbow/halloween
	name = "кукурузный арбалет"
	desc = "Любимое оружие синдикаторов \"trick-or-treaters\"."
	icon_state = "crossbow_halloween"
	inhand_icon_state = "crossbow"
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/halloween)

/obj/item/gun/energy/kinetic_accelerator/crossbow/large
	name = "энергетический арбалет"
	desc = "Реверсированное оружие, использующее технологию синдиката."
	icon_state = "crossbowlarge"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=4000)
	suppressed = null
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/large)
	pin = null


/obj/item/gun/energy/plasmacutter
	name = "плазморез"
	desc = "Горный инструмент, способный выбрасывать концентрированные плазменные вспышки. Вы можете использовать его, чтобы отрезать конечности от ксеносов! Или, знаете, копать руду."
	icon_state = "plasmacutter"
	inhand_icon_state = "plasmacutter"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	flags_1 = CONDUCT_1
	attack_verb = list("атакует", "лупит", "режет", "разрезает")
	force = 12
	sharpness = IS_SHARP
	can_charge = FALSE

	heat = 3800
	usesound = list('sound/items/welder.ogg', 'sound/items/welder2.ogg')
	tool_behaviour = TOOL_WELDER
	toolspeed = 0.7 //plasmacutters can be used as welders, and are faster than standard welders
	var/charge_weld = 25 //amount of charge used up to start action (multiplied by amount) and per progress_flash_divisor ticks of welding

/obj/item/gun/energy/plasmacutter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 105, 0, 'sound/weapons/plasma_cutter.ogg')
	AddElement(/datum/element/update_icon_blocker)
	AddElement(/datum/element/tool_flash, 1)

/obj/item/gun/energy/plasmacutter/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>[capitalize(src.name)] заряжен на [round(cell.percent())]%.</span>"

/obj/item/gun/energy/plasmacutter/attackby(obj/item/I, mob/user)
	var/charge_multiplier = 0 //2 = Refined stack, 1 = Ore
	if(istype(I, /obj/item/stack/sheet/mineral/plasma))
		charge_multiplier = 2
	if(istype(I, /obj/item/stack/ore/plasma))
		charge_multiplier = 1
	if(charge_multiplier)
		if(cell.charge == cell.maxcharge)
			to_chat(user, "<span class='notice'>Пытаюсь вставить [I] в [src.name], но он полностью заряжен.</span>") //my cell is round and full
			return
		I.use(1)
		cell.give(500*charge_multiplier)
		to_chat(user, "<span class='notice'>Вставляю [I] в [src.name], перезаряжая его.</span>")
	else
		..()

// Can we weld? Plasma cutter does not use charge continuously.
// Amount cannot be defaulted to 1: most of the code specifies 0 in the call.
/obj/item/gun/energy/plasmacutter/tool_use_check(mob/living/user, amount)
	if(QDELETED(cell))
		to_chat(user, "<span class='warning'>[capitalize(src.name)] не имеет батарейки и не может быть использован!</span>")
		return FALSE
	// Amount cannot be used if drain is made continuous, e.g. amount = 5, charge_weld = 25
	// Then it'll drain 125 at first and 25 periodically, but fail if charge dips below 125 even though it still can finish action
	// Alternately it'll need to drain amount*charge_weld every period, which is either obscene or makes it free for other uses
	if(amount ? cell.charge < charge_weld * amount : cell.charge < charge_weld)
		to_chat(user, "<span class='warning'>Требуется чуточку больше заряда!</span>")
		return FALSE

	return TRUE

/obj/item/gun/energy/plasmacutter/use(amount)
	return (!QDELETED(cell) && cell.use(amount ? amount * charge_weld : charge_weld))

/obj/item/gun/energy/plasmacutter/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	if(amount)
		. = ..()
	else
		. = ..(amount=1)

/obj/item/gun/energy/plasmacutter/adv
	name = "продвинутый плазморез"
	icon_state = "adv_plasmacutter"
	inhand_icon_state = "adv_plasmacutter"
	force = 15
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv)

/obj/item/gun/energy/wormhole_projector
	name = "блюспейс проектор червоточин"
	desc = "Проектор, который излучает квантовые лучи высокой плотности с синей связью. Требуется ядро блюспейс аномалии для функционирования."
	ammo_type = list(/obj/item/ammo_casing/energy/wormhole, /obj/item/ammo_casing/energy/wormhole/orange)
	inhand_icon_state = null
	icon_state = "wormhole_projector"
	var/obj/effect/portal/p_blue
	var/obj/effect/portal/p_orange
	var/atmos_link = FALSE
	var/firing_core = FALSE

/obj/item/gun/energy/wormhole_projector/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/assembly/signaler/anomaly/bluespace))
		to_chat(user, "<span class='notice'>Вставляю [C] в проектор червоточин и оружие нежно оживает.</span>")
		firing_core = TRUE
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		qdel(C)
		return

/obj/item/gun/energy/wormhole_projector/can_shoot()
	if(!firing_core)
		return FALSE
	return ..()

/obj/item/gun/energy/wormhole_projector/shoot_with_empty_chamber(mob/living/user)
	. = ..()
	to_chat(user, "<span class='danger'>Дисплей сообщает, 'НЕ УСТАНОВЛЕНО ЯДРО'.</span>")

/obj/item/gun/energy/wormhole_projector/update_icon_state()
	icon_state = inhand_icon_state = "[initial(icon_state)][select]"

/obj/item/gun/energy/wormhole_projector/update_ammo_types()
	. = ..()
	for(var/i in 1 to ammo_type.len)
		var/obj/item/ammo_casing/energy/wormhole/W = ammo_type[i]
		if(istype(W))
			W.gun = src
			var/obj/projectile/beam/wormhole/WH = W.BB
			if(istype(WH))
				WH.gun = src

/obj/item/gun/energy/wormhole_projector/process_chamber()
	..()
	select_fire()

/obj/item/gun/energy/wormhole_projector/proc/on_portal_destroy(obj/effect/portal/P)
	if(P == p_blue)
		p_blue = null
	else if(P == p_orange)
		p_orange = null

/obj/item/gun/energy/wormhole_projector/proc/has_blue_portal()
	if(istype(p_blue) && !QDELETED(p_blue))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/has_orange_portal()
	if(istype(p_orange) && !QDELETED(p_orange))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/crosslink()
	if(!has_blue_portal() && !has_orange_portal())
		return
	if(!has_blue_portal() && has_orange_portal())
		p_orange.link_portal(null)
		return
	if(!has_orange_portal() && has_blue_portal())
		p_blue.link_portal(null)
		return
	p_orange.link_portal(p_blue)
	p_blue.link_portal(p_orange)

/obj/item/gun/energy/wormhole_projector/proc/create_portal(obj/projectile/beam/wormhole/W, turf/target)
	var/obj/effect/portal/P = new /obj/effect/portal(target, 300, null, FALSE, null, atmos_link)
	RegisterSignal(P, COMSIG_PARENT_QDELETING, .proc/on_portal_destroy)
	if(istype(W, /obj/projectile/beam/wormhole/orange))
		qdel(p_orange)
		p_orange = P
		P.icon_state = "portal1"
	else
		qdel(p_blue)
		p_blue = P
	crosslink()

/obj/item/gun/energy/wormhole_projector/core_inserted
    firing_core = TRUE

/* 3d printer 'pseudo guns' for borgs */

/obj/item/gun/energy/printer
	name = "\"LMG\" киборга"
	desc = "LMG, который стреляет в 3D-напечатанные флешеттами. Они медленно пополняются, используя внутренний источник энергии киборга."
	icon_state = "l6_cyborg"
	icon = 'icons/obj/guns/projectile.dmi'
	cell_type = "/obj/item/stock_parts/cell/secborg"
	ammo_type = list(/obj/item/ammo_casing/energy/c3dbullet)
	can_charge = FALSE
	use_cyborg_cell = TRUE

/obj/item/gun/energy/printer/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/gun/energy/printer/emp_act()
	return

/obj/item/gun/energy/temperature
	name = "температурная пушка"
	icon_state = "freezegun"
	desc = "Пушка, которая меняет температуру."
	ammo_type = list(/obj/item/ammo_casing/energy/temp, /obj/item/ammo_casing/energy/temp/hot)
	cell_type = "/obj/item/stock_parts/cell/high"
	pin = null

/obj/item/gun/energy/temperature/security
	name = "температурная пушка охраны"
	desc = "Оружие, которое может быть полностью использовано только действительно крутым человеком."
	pin = /obj/item/firing_pin

/obj/item/gun/energy/laser/instakill
	name = "винтовка InstaKill"
	icon_state = "instagib"
	inhand_icon_state = "instagib"
	desc = "Специализированная лазерная винтовка ASMD, способная уничтожать большинство целей одним попаданием."
	ammo_type = list(/obj/item/ammo_casing/energy/instakill)
	force = 60
	charge_sections = 5
	ammo_x_offset = 2
	shaded_charge = FALSE

/obj/item/gun/energy/laser/instakill/red
	desc = "Специализированная лазерная винтовка ASMD, способная уничтожать большинство целей одним попаданием. Красненькая."
	icon_state = "instagibred"
	inhand_icon_state = "instagibred"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/red)

/obj/item/gun/energy/laser/instakill/blue
	desc = "Специализированная лазерная винтовка ASMD, способная уничтожать большинство целей одним попаданием. Синенькая."
	icon_state = "instagibblue"
	inhand_icon_state = "instagibblue"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/blue)

/obj/item/gun/energy/laser/instakill/emp_act() //implying you could stop the instagib
	return

/obj/item/gun/energy/gravity_gun
	name = "одноточечный гравитационный манипулятор"
	desc = "Экспериментальное многорежимное устройство, которое запускает заряд энергии нулевой точки, вызывая локальные искажения в гравитации. Требуется ядро гравитационной аномалии для функционирования."
	ammo_type = list(/obj/item/ammo_casing/energy/gravity/repulse, /obj/item/ammo_casing/energy/gravity/attract, /obj/item/ammo_casing/energy/gravity/chaos)
	inhand_icon_state = "gravity_gun"
	icon_state = "gravity_gun"
	var/power = 4
	var/firing_core = FALSE

/obj/item/gun/energy/gravity_gun/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/assembly/signaler/anomaly/grav))
		to_chat(user, "<span class='notice'>Нежно вставляю [C] в гравитационный манипулятор и оружие нежно оживает.</span>")
		firing_core = TRUE
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		qdel(C)
		return
	return ..()

/obj/item/gun/energy/gravity_gun/can_shoot()
	if(!firing_core)
		return FALSE
	return ..()

