/obj/item/gun/breakopen/detonator
	name = "Детонатор"
	desc = "Гарантированный мини-крит по горящим врагам. Погодите-ка..."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "detonator"
	max_ammo = 1

/obj/item/ammo_casing/caseless/detflare
	name = "Заряд для сигнальной ракетницы"
	desc = "\"Слегка\" модифицирован для более \"зрелищного\" результата."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "detonator_casing"
	projectile_type = /obj/projectile/detflare
	caliber = "flare"
/obj/projectile/detflare
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "detonator_projectile"
	damage = 0
	var/firedamage = 10
	var/turf/prev_loc

/obj/projectile/detflare/Move(atom/newloc, direct, glide_size_override)
	//If it works...
	prev_loc = get_turf(src)
	. = ..()


/obj/projectile/detflare/on_hit(atom/target, blocked, pierce_hit)
	var/turf/tloc
	//i don't think this works like it should, but i'm actually content with how it works currently.
	//...it ain't stupid.
	if(isclosedturf(target))
		tloc = prev_loc
	else
		tloc = get_turf(src)


	for(var/dir in list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST, 0))
		var/turf/T = get_step(tloc, dir)
		if(isclosedturf(T))
			continue
		new /obj/effect/hotspot(T)
		T.hotspot_expose(600, 50, 1)
		for(var/mob/living/L in T)
			if(L.on_fire)
				L.adjustFireLoss(firedamage*1.5 ) //minicritical shit
			else
				L.adjustFireLoss(firedamage)
			L.adjust_fire_stacks(max(0, 2 - L.fire_stacks)) //sets L.fire_stacks to 2 if it's less than 2, doesn't do anything if L.fire_stacks is 3 or more.
			L.IgniteMob()

	. = ..()

/obj/item/gun/energy/nlaw
	name = "N-LAW"
	desc = "Basically, a big subwoofer with a trigger. Can incapacitate people by throwing into walls, windows, other people, open airlocks, supermatter, disposals, banana peels, AIDS-infected monkeys, lavaland megafauna, lavaland lava, permabrig and, if you're not careful enough, yourself."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "sonic_gun"
	inhand_icon_state = "sonic_gun"
	lefthand_file = 'white/RedFoxIV/icons/obj/weapons/guns_lefthand.dmi'
	righthand_file =  'white/RedFoxIV/icons/obj/weapons/guns_righthand.dmi'
	cell_type = /obj/item/stock_parts/cell/high
	charge_sections = 5
	shaded_charge = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/acoustic)
	modifystate = TRUE

/*
/obj/item/gun/energy/nlaw/garbage
	desc = "A prototype energy weapon. Most people throw it in the trash bin and bug R&D for a better one. Does not support cell changing, overcharged mode, sustained fire, windows 10."
	name = "LAW"
	cell_type = /obj/item/stock_parts/cell/nlaw
	ammo_type = list(/obj/item/ammo_casing/energy/acoustic)
*/

/obj/item/stock_parts/cell/nlaw
	name = "LAW battery"
	desc = "Good job jackass, now try to put it back in without admemes."
	charge = 4000

/obj/item/ammo_casing/energy/acoustic
	projectile_type = /obj/projectile/acoustic_wave
	e_cost = 2000
	select_name = "normal"
	pellets = 3
	caliber = "acoustic"
	variance = 60

/obj/projectile/acoustic_wave
	name = "Acoustic wave"
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "sonic_projectile"
	damage = 0
	range = 4
	speed = 1.6
	buckle_lying = 90
	max_buckled_mobs = 10
	projectile_phasing = PASSMOB
	var/prev_loc

/obj/projectile/acoustic_wave/Move(atom/newloc, direct, glide_size_override)
	prev_loc = get_turf(src)
	/*
	for(var/obj/O in prev_loc)
		if(!O.anchored)
			O.forceMove(get_step(O, angle2dir()))
	*/
	for(var/mob/living/L in prev_loc)
		if(!L.buckled && L != firer)
			//L.forceMove(get_step(L, angle2dir()))
			buckle_mob(L, force = TRUE)

	for(var/obj/O in newloc)
		if(istype(O, /obj/structure/table))
			for(var/mob/living/L in buckled_mobs)
				L.Paralyze(25)
			qdel(src)
			return
	. = ..()

/obj/projectile/acoustic_wave/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if(isclosedturf(target))
		for(var/mob/living/L in buckled_mobs)
			L.Paralyze(rand(30,60))
			L.adjustBruteLoss(rand(10,20))
	/*
	var/atom/movable/throwdir = angle2dir(Angle)
	var/atom/movable/throwtarget = get_edge_target_turf(target, throwdir)
	if(istype(target, /mob/living) && !target.anchored)
		target.throw_at(throwtarget, knock_dist+1, 4, src.firer, 1, 0, null, move_force)
		return
	if(istype(target,/obj/structure) && !target.anchored)
		target.throw_at(throwtarget, knock_dist/2, 4, src.firer, 1, 0, null, move_force)
		return
	*/

/obj/projectile/acoustic_wave/vol_by_damage()
	return 1


/*
/datum/design/nlaw
	name = "N-LAW"
	desc = "A prototype energy weapon which utilizes powerful acoustic waves to knock people around."
	id = "nlaw"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 14000, /datum/material/plasma = 6000, /datum/material/glass = 10000, /datum/material/gold = 6000 , /datum/material/iron = 25000)
	build_path = /obj/item/gun/energy/nlaw
	category = list("Вооружение")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE //убрать флаг РнД если чрезмерно охуеют
*/

/obj/item/gun/breakopen/doublebarrel
	name = "двухствольный дробовик"
	desc = "Настоящая классика."
	can_be_sawn_off = TRUE
	can_fire_all_rounds_at_once = TRUE

/obj/item/gun/ballistic/stabba_taser
	name = "Стабба тазер"
	desc = "Двухзарядный тазер, стреляющий застревающими в теле электродами."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "ballistic_taser"
	inhand_icon_state = "stabba_taser"
	lefthand_file = 'white/qwaszx000/sprites/stabba_taser_left.dmi'
	righthand_file = 'white/qwaszx000/sprites/stabba_taser_right.dmi'
	pin = /obj/item/firing_pin
	bolt_type = BOLT_TYPE_NO_BOLT
	casing_ejector = FALSE
	mag_type = /obj/item/ammo_box/magazine/internal/stabba_taser_magazine
	fire_delay = 5
	internal_magazine = TRUE

/obj/item/ammo_box/magazine/internal/stabba_taser_magazine
	name = "Магазин стабба тазера. Если вы видите это, сообщите администратору."
	icon = null
	icon_state = null
	ammo_type = /obj/item/ammo_casing/stabba
	caliber = "stabba"
	max_ammo = 2
	start_empty = FALSE

/obj/item/ammo_box/magazine/internal/stabba_taser_magazine/give_round(obj/item/ammo_casing/R, replace_spent = 1)
	return ..(R,1)

/obj/item/ammo_casing/stabba
	name = "картридж стабба тазера"
	desc = "Одноразовый картридж."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "ballistic_taser_casing"
	throwforce = 1
	projectile_type = /obj/projectile/bullet/stabba
	firing_effect_type = null
	caliber = "stabba"
	harmful = FALSE
/obj/item/trash/stabba_casing_cover
	name = "Пластиковая оболочка картриджа тазера"
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "bt_trash1"

/obj/item/trash/stabba_casing_cover/Initialize(mapload, cover)
	. = ..()
	icon_state = "bt_trash[cover]"
	pixel_x = base_pixel_x + rand(-6,6)
	pixel_y = base_pixel_y + rand(-6,6)
	transform = matrix().Turn(rand(0,360))
	SpinAnimation(loops = 1)

/obj/item/ammo_casing/stabba/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from, extra_damage, extra_penetration)
	. = ..()
	new /obj/item/trash/stabba_casing_cover(get_turf(src), 1)
	new /obj/item/trash/stabba_casing_cover(get_turf(src), 2)


/obj/projectile/bullet/stabba
	name = "Электродик Стаббы"
	desc = "Выглядит остро"
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "ballistic_taser_projectile"
	damage = 0
	nodamage = TRUE
	stamina = 8
	speed = 2
	range = 12
	embedding = list(embed_chance=100, fall_chance=0, pain_stam_pct=8, pain_mult=1, pain_chance=75)


//CRIKEY

/obj/item/gun/ballistic/smart
	name = "MK5 Smart Pistol"
	desc = "Древний артефакт. Использует особые картриджи с флешеттами, способными корректировать свою траекторию в полёте.\
	Несмотря на свою точность, линейка Smart-оружия так и не нашла широкого применения из-за чрезвычайно низкой останавливающей силы.\
	Похоже, до сего момента он хранился в ненадлежащих условиях, и электроника немного сбоит."

	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "smart_pistol"
	//bolt_type = BOLT_TYPE_STANDARD //already defined in /ballistic, thought that mentioning it here for clarity is a good idea.
	mag_type = /obj/item/ammo_box/magazine/smart
	mag_display = TRUE

/obj/item/ammo_box/magazine/smart
	name = "Мазазин от Smart-пистолета"
	desc = "Единственная особенность этого магазина - защита от дурака в виде необычной формы магазина, которая не даёт вставить обычные 9мм патроны."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "smart_pistol_magazine"
	ammo_type = /obj/item/ammo_casing/smart
	max_ammo = 12

/obj/item/ammo_casing/smart
	name = "Smart-флешетта"
	desc = "Картридж с особым патроном - флешеттой. Необычная конструкция картриджа не позволит зарядить его в обычный 9мм огнестрел."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "smart_ammo_casing"
	projectile_type = /obj/projectile/smart

/obj/projectile/bullet/smart
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "smart_flechette"
	damage = 10
	speed = 1.5
	homing_turn_speed = 20

//this is a shitcode
  //dear god
//there's more shitcode
  //no
/obj/projectile/smart/preparePixelProjectile(atom/target, atom/source, params, spread)
	if(isnull(target))
		return
	if(isliving(target) && prob(50)) //50% change to fire a homing shot when clicking directly on a mob
		set_homing_target(target)
		homing = TRUE
		return ..()

	if(!prob(35)) // 35% chance to fire a homing shot if not clicking on a mob
		return ..()

	var/list/mob/living/R = viewers(3, target)
	var/list/pt = list() //potential_targets
	var/dist
	for(var/mob/living/L in R)
		if(L == firer)
			continue
		if(isnull(dist) || dist == get_dist(L, target)) // if it's null, it means we're on our first cycle and we save in var/dist the distance to the closest mob
			pt.Add(L)
		else
			break

	dist = INFINITY // this gives me vietnam-style flashbacks about programming classes in 7th grade
	var/mob/living/ht //homing target
	for(var/mob/living/L in pt)
		var/dist_from_firer = get_dist(fired_from, L)
		if(dist_from_firer < dist)
			dist = dist_from_firer
			ht = L
		if(dist_from_firer == dist && prob(50)) //fuck it
			ht = L
	set_homing_target(ht) // fucking finally
	homing = TRUE
	return ..()









////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//до фикса проблемы с лимитом файлов эта хуйня будет жить здесь
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/item/circuitboard/machine/chem_seller
	name = "Chem seller circuitboard"
	build_path = /obj/machinery/chem_seller
	req_components = list(
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/sheet/glass = 1
	)

/obj/machinery/chem_seller
	name = "синтезатор медикаментов"
	desc = "Синтезирует медикаменты и прочие реагенты за кредиты. В отличии от обычного химика, не потратит 30 минут на приготовление мультивера."
	icon = 'white/RedFoxIV/icons/obj/weapons/misc.dmi'
	icon_state = "chem_seller"
	density = TRUE
	var/icon_work = "chem_seller_work"
	var/icon_deny = "chem_seller_deny"
	var/icon_nopower = "chem_seller_nopower"
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	var/dispense_power_usage = 250
	/*
	var/global/list/users_interacted = list() //сбор данных гуглом
	*/
	var/last_shopper
	//to track the cooldown on messages
	var/last_say_time = 0
	//how long the cooldown for messages lasts
	var/obj/item/reagent_containers/beaker = null
	var/currently_selected
	var/list/available_chems = list(
		/datum/reagent/medicine/c2/libital = 0.25,
		/datum/reagent/medicine/c2/aiuri = 0.25,
		/datum/reagent/medicine/c2/hercuri = 0.25,
		/datum/reagent/medicine/c2/convermol = 0.25,
		/datum/reagent/medicine/c2/multiver = 0.25,
		/datum/reagent/medicine/c2/synthflesh = 0.25,
		/datum/reagent/medicine/sal_acid = 0.33,
		/datum/reagent/medicine/oxandrolone = 0.33,
		/datum/reagent/medicine/cryoxadone = 0.2,
		/datum/reagent/medicine/c2/penthrite = 1,
		//misc//
		/datum/reagent/medicine/leporazine = 0.33,
		/datum/reagent/consumable/doctor_delight = 0.066 //15u, since, you know, why the fuck not
	)
/obj/machinery/chem_seller/Initialize()
	. = ..()
	currently_selected = available_chems[1]
	update_icon() //for subtypes which use overlays to look different

/obj/machinery/chem_seller/process() //wtf

/obj/machinery/chem_seller/proc/get_price(chem_typepath)
	var/price = available_chems[chem_typepath]
	return price < 1 ? 1 : price

/obj/machinery/chem_seller/proc/get_price_text(chem_typepath)
	var/price = available_chems[chem_typepath]
	return "[price < 1 ? "[round(1/price, 1)]u/1cr" : "1u/[price]cr"]"

/obj/machinery/chem_seller/proc/get_dispense_amount()
	if(!beaker)
		return
	var/datum/reagents/R = beaker.reagents
	var/free = R.maximum_volume - R.total_volume
	var/unit = available_chems[currently_selected] //for now it holds the price per unit from available_chems list
	unit = unit < 1 ? round(1/unit, 1) : 1 //and here it turns into actual unit measurement
	return min(free, unit)

/obj/machinery/chem_seller/attackby(obj/item/I, mob/user, params)
	if(default_unfasten_wrench(user, I))
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_icon()
		return
	if(default_deconstruction_crowbar(I))
		return
	if(istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container())
		var/obj/item/reagent_containers/B = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(B, src))
			return
		replace_beaker(user, B)
		to_chat(user, "<span class='notice'>Добавил [B] в [src].</span>")
		updateUsrDialog()
	else if(user.a_intent != INTENT_HARM && !istype(I, /obj/item/card/emag))
		to_chat(user, "<span class='warning'>Не могу загрузить [I] в [src]!</span>")
		return ..()
	else
		return ..()

/obj/machinery/chem_seller/AltClick(mob/living/user)
	. = ..()
	if(!can_interact(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	replace_beaker(user)

/obj/machinery/chem_seller/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(!user)
		return FALSE
	if(beaker)
		try_put_in_hand(beaker, user)
		beaker = null
	if(new_beaker)
		beaker = new_beaker
	update_icon()
	return TRUE

/obj/machinery/chem_seller/update_icon_state()
	icon_state = "[!powered() ? icon_nopower : initial(icon_state)]"

/obj/machinery/chem_seller/update_overlays()
	. = ..()
	if(panel_open)
		. += mutable_appearance(icon, "[initial(icon_state)]_panel-o")

	if(beaker)
		var/mutable_appearance/b_o = mutable_appearance('icons/obj/chemical.dmi', "disp_beaker")
		b_o.pixel_y = -4
		b_o.pixel_x = -9
		. += b_o

/obj/machinery/chem_seller/ui_interact(mob/user, datum/tgui/ui)
	/*
	if(!(user in users_interacted)) //google analytics
		users_interacted.Add(user)
		to_chat(user,"<br><span class='notice'><b>hurr durr early access, work in progress, alpha build и так далее. Человек, который работал над этим аппаратом, не шарит во внутриигровой экономике, поэтому выставил цены от балды. Убедительная просьба написать в дискорд канале #suggestions, стоит ли их повысить/занизить/оставить, как есть и почему. Заранее спасибо[prob(20) ? ", ебать!" : "!"]</b></span>")
	*/
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChemSeller")
		ui.open()

/obj/machinery/chem_seller/ui_data(mob/user)
	var/list/data = list()

	var/chemicals[0]
	for(var/ass in available_chems)
		var/datum/reagent/chemical = GLOB.chemical_reagents_list[ass]
		chemicals.Add(list(list("title" = chemical.name, "price" = get_price_text(ass),  "typepath" = "[chemical.type]" )))
	data["chemicals"] = chemicals

	var/selected[0] //do i have to do this?
	var/datum/reagent/temp = GLOB.chemical_reagents_list[currently_selected]
	selected.Add(list(list("title" = temp.name, "desc" = temp.description, "price" = get_price_text(currently_selected), "typepath" = "[temp.type]" )))
	data["selected"] = selected
	/*
	data["energy"] = cell.charge ? cell.charge * powerefficiency : "0" //To prevent NaN in the UI.
	data["maxEnergy"] = cell.maxcharge * powerefficiency
	*/
	data["isBeakerLoaded"] = beaker ? 1 : 0
	//if no beaker is inserted, these two don't get updated and will be passed like that to the tgui. this is fine.
	data["beakerReagentAmount"] = 0
	data["beakerVolume"] = 1
	if(beaker)
		var/total_volume = 0
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			total_volume += R.volume
		data["beakerReagentAmount"] = total_volume
		data["beakerVolume"] = beaker.volume
	return data

/obj/machinery/chem_seller/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!is_operational)
		return FALSE
	switch(action)
		if("dispense")
			if(currently_selected in available_chems) //if this fails, either an admin fucked with it or something has gone terribly wrong.
				return try_dispense()
			else
				message_admins("[ADMIN_LOOKUPFLW(usr)] tried to dispense a chemical in [src.name] that is not in the list of selectable chemicals. Possible exploit fuckery?")
				return FALSE

		if("select")
			var/typepath = text2path(params["reagent"])
			if(!typepath)
				return FALSE
			if(typepath in available_chems)
				currently_selected = typepath
				return TRUE
			else
				message_admins("[ADMIN_LOOKUPFLW(usr)] tried to select a chemical in [src.name] that is not in the list of selectable chemicals. Possible exploit fuckery?")
				return FALSE
		if("eject")
			replace_beaker(usr)
			return TRUE

/obj/machinery/chem_seller/proc/try_dispense()
	. = FALSE
	if(!beaker)
		return
	if(!verify())
		return
	var/disp = get_dispense_amount()
	if(!disp)
		cd_say("Beaker is full!", 1 SECONDS)
		flick(icon_deny, src)
		return
	flick(icon_work, src)
	use_power(dispense_power_usage)
	beaker.reagents.add_reagent(currently_selected, disp, DEFAULT_REAGENT_TEMPERATURE)
	return TRUE

/obj/machinery/chem_seller/proc/verify()
	var/obj/item/card/id/C
	if(isliving(usr))
		var/mob/living/L = usr
		C = L.get_idcard(TRUE)
	if(!C)
		cd_say("Sorry, you don't seem to have a card on you!", 3 SECONDS)
		flick(icon_deny, src)
		return
	else if (!C.registered_account)
		cd_say("No account found associated with your card. How interesting!", 3 SECONDS)
		flick(icon_deny, src)
		return
	else if(!C.registered_account.account_job)
		cd_say("I am sorry, but departamental accounts were blacklisted from personal expenses!", 3 SECONDS)
		flick(icon_deny, src)
		return

	var/datum/bank_account/account = C.registered_account
	var/price_to_use = get_price(currently_selected)
	if(price_to_use && !account.adjust_money(-price_to_use))
		cd_say("I am so sorry, but you do not have enough funds!", 3 SECONDS)
		flick(icon_deny, src)
		return
	SSblackbox.record_feedback("amount", "vending_spent", price_to_use)
	var/datum/reagent/chemical = GLOB.chemical_reagents_list[currently_selected]
	log_econ("[price_to_use] credits were inserted into [name] by [account] to buy [get_dispense_amount()]u [chemical.enname ? "[chemical.enname]" : "[chemical.name]"].")
	if(last_shopper != usr)
		cd_say("Thank you for your patronage!", 5 SECONDS)
		last_shopper = usr //if someone uses this machine a second after someone else buys a reagent they won't be thanked for their purchase. still, i think it's alright because noone fucking cares about these messages and it will prevent the machine from spamming useless text in the chatbox.
	return TRUE

/obj/machinery/chem_seller/proc/cd_say(message, cooldown = 1 SECONDS)
	if(last_say_time < world.time)
		say(message)
		last_say_time = world.time + cooldown


/obj/item/circuitboard/machine/chem_seller/engineering
	name = "Engineering chem seller circuitboard"
	build_path = /obj/machinery/chem_seller/engineering
/obj/machinery/chem_seller/engineering
	name = "Раздатчик WD-40"
	desc = "Транспортирует чудодейственную кровь богов по блуспейс каналу прямо к тебе в стакан. Не за спасибо, разумеется. Так же воспроизводит некоторые другие химикаты, полезные в работе инженера."
	circuit = /obj/item/circuitboard/machine/chem_seller/engineering
	available_chems = list(
		/datum/reagent/fuel/oil/wd40 = 146,
		/datum/reagent/medicine/c2/aiuri = 0.25,
		/datum/reagent/medicine/potass_iodide = 0.11, //9u per 1cr
		/datum/reagent/consumable/ethanol/screwdrivercocktail = 0.033 //30u per 1cr
	)

/obj/machinery/chem_seller/engineering/update_overlays()
	. = ..()
	. += mutable_appearance(icon, "[initial(icon_state)]_engineering") //because i'm using icon_states for flicker()s. yeah, this is dumb.
/datum/reagent/fuel/oil/wd40
	name = "ВД-40"
	enname = "WD-40"
	description = "Количество применений этого вещества стремится к бесконечности. Достаточно лишь одной единицы, чтобы произошло чудо. Например, улучшение работы компонентов различных устройств."
	burning_temperature = 2400
	burning_volume = 0.15

/datum/reagent/fuel/oil/wd40/expose_obj(obj/exposed_obj, reac_volume)
	//maybe another time

	if(istype(exposed_obj, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/cell = exposed_obj
		// out of all the things i've made, THIS probably wins the competition of dumb:
		// the mere thought of the amount of ways to abuse this throws me into a rather distressed state.
		// still, it KINDA does it's job right, scaling up with reac_volume and scaling down after multiple uses.
		// but hey, it costs a lot, and the only /reliable/ way of getting a lot of it is syndie's 1TC briefcase.
		// so yeah, fuck it. i'm just gonna slap a 0.75* in there just to make sure it doesn't go out of hand too much.
		var/ratio = 1 + (0.75 * initial(cell.maxcharge) * round(reac_volume) / cell.maxcharge)
		var/ass = ""
		switch(ratio)
			if(1.751 to INFINITY)
				ass = "невероятно"
			if(1.75)
				ass = "заметно"
			if(1.5 to 1.74) //2.1(6)
				ass = "немного"
			if(1.2 to 1.49)
				ass = "чуть-чуть"
			else
				ass = "почти никак не"
		cell.visible_message("<span class='hypnophrase'>Чудодейственное вещество проникает в щели и отверстия [cell.name], [ass] увеличивая энергоёмкость батареи.</span>")
		cell.desc = initial(cell.desc) + " Обладаёт лёгким и неописуемым ароматом."
		return ..()

	if(istype(exposed_obj, /obj/item/stock_parts))
		var/obj/item/stock_parts/SP = exposed_obj
		var/new_rating = min(SP.rating + round(reac_volume), 8)
		if(SP.rating !=new_rating)
			var/ass = ""
			switch(new_rating - SP.rating)
				if(2)
					ass = "двукратно"
				if(3)
					ass = "троекратно"
				if(4 to INFINITY)
					ass = "<i>многократно</i>"
			SP.rating = new_rating
			SP.visible_message("<span class='hypnophrase'>Чудодейственное вещество проникает в щели и отверстия [SP.name], [ass] оптимизируя и улучшая его работу! </span>")
		SP.desc = initial(SP.desc) + " Обладаёт лёгким и неописуемым ароматом."
		return ..()


/datum/outfit/artist
	name = "Костюм Артиста"

	uniform = /obj/item/clothing/under/color/grey/artist
	shoes = /obj/item/clothing/shoes/combat/artist
	r_hand = /obj/item/storage/toolbox/mechanical

/obj/effect/mob_spawn/human/artist/create(ckey, newname)
	if(ckey)
		var/client/C = GLOB.directory[ckey]
		if(C?.prefs)
			hairstyle =  C.prefs.hairstyle
			facial_hairstyle = C.prefs.facial_hairstyle
			skin_tone = C.prefs.skin_tone
	. = ..()


//artists equipment
//has NODROP trait, deletes itself when dropped (so the dust(drop_items = TRUE) proc doesn't spam jumpsuits on the floor)
//artist's version of gray jumpsuit
/obj/item/clothing/under/color/grey/artist
	name = "Одежда артиста"
	resistance_flags = INDESTRUCTIBLE
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL

/obj/item/clothing/under/color/grey/artist/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "Initialize")

//artist's version of boots
/obj/item/clothing/shoes/combat/artist
	name = "сапоги артиста"
	resistance_flags = INDESTRUCTIBLE
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL

/obj/item/clothing/shoes/combat/artist/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "Initialize")

/*
//artist's version of toolset implant
/obj/item/organ/cyberimp/arm/toolset/artist

/obj/item/organ/cyberimp/arm/toolset/artist/Initialize()
	. = ..()
	START_PROCESSING(SSmachines, src)

/obj/item/organ/cyberimp/arm/toolset/artist/Destroy()
	START_PROCESSING(SSmachines, src)
	. = ..()
*/

/obj/effect/mob_spawn/human/artist
	name = "Экстрактор"
	desc = "Вытягивает заблудшие души с того света и конвертирует их в дешёвую рабочую силу."
	icon = 'white/valtos/icons/prison/prison.dmi'
	icon_state = "spwn"
	roundstart = FALSE
	death = FALSE
	permanent = TRUE
	uses = -1
	short_desc = "Я артист. Я работаю на развлечение публики."
	flavour_text = "Будущее цирковых технологий. Развлекайте публику на станции любыми возможными способами, не покидая <b><i>Цирк</i></b>."
	outfit = /datum/outfit/artist
	assignedrole = "Artist"

	//mobs that were spawned from /this/ one instance of the spawner
	var/list/mob/living/spawned_mobs = list()

	//shared across all spawners
	var/global/list/round_banned_ckeys = list()
	var/global/amount = 0

/obj/effect/mob_spawn/human/artist/Initialize()
	. = ..()
	round_banned_ckeys += "sanecman"
	START_PROCESSING(SSprocessing, src)

/obj/effect/mob_spawn/human/artist/Destroy()
	START_PROCESSING(SSprocessing, src)
	. = ..()

/obj/effect/mob_spawn/human/artist/attack_ghost(mob/user)
	if(user.ckey in round_banned_ckeys)
		to_chat(user, "<span class='warning'>А хуй тебе!</span>")
		return
	. = ..()

/obj/effect/mob_spawn/human/artist/create(ckey, newname)
	. = ..()
	var/mob/living/L = .
	spawned_mobs += L
	spawned_mobs[L] = L.ckey

/obj/effect/mob_spawn/human/artist/special(mob/living/L)
	amount += 1
	L.real_name = "Артист #[amount]"
	if(L.ckey == "redfoxiv")
		L.real_name = "Ali Rezun"
		L.say("Убивать.")
	L.name = L.real_name


//stolen from CTF code
/obj/effect/mob_spawn/human/artist/process(delta_time)
	for(var/i in spawned_mobs)
		if(!i)
			spawned_mobs -= i
			continue
		var/mob/living/artist = i
		if(HAS_TRAIT(artist, TRAIT_CRITICAL_CONDITION) || artist.stat == DEAD || !artist.key)
			spawned_mobs.Remove(artist)
			artist.alpha = 0 //because dust animation does not hide the body while playing, which look really fuckiing weird
			artist.dust(drop_items = TRUE)
			continue
		var/area/A = get_area(artist)
		if(!istype(A, /area/centcom/circus) && !istype(A, /area/centcom/outdoors/circus)) //just in case
			round_banned_ckeys.Add(spawned_mobs[artist])
			spawned_mobs.Remove(artist)
			to_chat(artist, "<span class='userdanger'>Ох, лучше бы я не покидал Цирк...</span>") //let them know they fucked up
			message_admins("Игрок [artist.ckey], будучи Артистом, каким-то образом сбежал из цирка, за что был казнён и лишён доступа к спавнеру до конца раунда. Такого быть не должно: выясните, как он этого добился и передайте кодербасу. Если же это произошло по вине админбаса, удалите сикей игрока из переменной спавнера (round_banned_ckeys). Позиция игрока на момент обнаружения побега: x=[artist.x], y=[artist.y], z=[artist.z], название зоны - [get_area_name(artist)]")
			artist.pooition = 10000
			artist.emote("scream")


			for(var/s=1,s<51,s++)
				addtimer(CALLBACK(artist, /mob/proc/emote, "poo"), 1+2*log(s) SECONDS)
			spawn(8.7 SECONDS)
				artist.visible_message("<span class='hypnophrase'>[artist.name] распидорасило: похоже, за побег из Цирка он был отправлен в бессрочную ссылку на [pick("Цитадель", "Флаффи", "Скайрэт", "Опух", "парашу")]. [pick("Прикольно", "Страшно", "Помянем", "Ужасно", "Кошмар", "Грустно", "Смешно")].</span>")
				artist.gib(TRUE)
			continue
		/*
		else
			artist.adjustBruteLoss(-2.5 * delta_time)
			artist.adjustFireLoss(-2.5 * delta_time)
		*/

#define DUEL_NODUEL 0
#define DUEL_PENDING 1
#define DUEL_IN_PROGRESS 2

#define DUEL_TIMEOUT 1
#define DUEL_PENDING_TIMEOUT 2
#define DUEL_FINISH 3
#define DUEL_ERROR 4


/area/duel
	icon_state = "duel"
	area_flags = NO_ALERTS | ABDUCTOR_PROOF | BLOCK_SUICIDE | HIDDEN_AREA | NOTELEPORT | UNIQUE_AREA
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
/area/duel/arena
	icon_state = "duel_arena"

/obj/effect/landmark/duel_spawnpoint


//GENERAL_PROTECT_DATUM(/obj/effect/duel_controller) // счастливой отладки // счастливой иди нахуй 
/obj/effect/duel_controller
	name = "Duel Controller"
	desc = "Controls duels."
	icon = 'white/valtos/icons/prison/prison.dmi'
	icon_state = "spwn"

	invisibility = INVISIBILITY_OBSERVER
	var/duel_outfit = /datum/outfit/artist
	var/duel_status = DUEL_NODUEL
	var/list/mob/living/carbon/human/duelists
	var/bet
	/// Время на каждый бой. Не меньше 30 секунд.
	var/duel_timelimit = 60
	/// Здесь хранится ID таймера на таймаут.
	var/timeout_timer
	/// Станы любого рода считаются за поражение.
	var/stun_is_deadly = FALSE

	var/list/first_spawnpoint = list(-3,3)
	var/list/second_spawnpoint	 = list(3,-3)
	var/list/banned_ckeys = list()

	var/list/announcement_timers = list()

/obj/effect/duel_controller/Initialize(mapload)
	. = ..()
	banned_ckeys += "sanecman"

/obj/effect/duel_controller/attack_ghost(mob/user)
	if(banned_ckeys.Find(user.ckey))
		to_chat(user, "<span class='warning'>runtime error: cannot read null.stat.<br><br> \
						proc name: attack_ghost (/obj/effect/duel_controller/attack_ghost)<br> \
						usr: [user.ckey] ([user.type])<br> \
						src: [src.name] ([src.type])<br> \
						src.loc: null</span>")
		return
	if(!SSticker.HasRoundStarted() || !loc)
		return

	if(!(GLOB.ghost_role_flags & GHOSTROLE_SPAWNER) && !(flags_1 & ADMIN_SPAWNED_1))
		to_chat(user, "<span class='warning'>Администраторы временно отключили гост-роли.</span>")
		return


	if(duel_status == DUEL_IN_PROGRESS)
		to_chat(user, "Эта комната уже занята!")
		return

	if(duel_status == DUEL_PENDING)
		if(duelists.Find(user))
			CRASH("A ghost tried to join a duel when he already was in the list of duelists. WTF?")
		var/alert = alert("Точно хочешь поучавствовать в дуэли на [bet] метакэша?",,"Да","Нет")
		if(alert == "Да")
			spawn_user()
		return

	var/ghost_role = alert("Точно хочешь начать дуэль? (Ты не сможешь вернуться в своё прошлое тело, так что выбирай с умом!)",,"Да","Нет")
	if(ghost_role == "Нет" || !loc || QDELETED(user))
		return
	var/betinput = input("Сколько метакэша готов поставить? (Не меньше 50!)", "1XBET", 50) as num
	if(betinput < 0)
		banned_ckeys += user.ckey
		to_chat(user, "ебать ты умный нахуй")
	if(betinput < 50)
		return
	if(betinput > user.client.mc_cached)
		to_chat(user, "Где деньги, Лебовски?")
		return
	if(duel_status != DUEL_NODUEL)
		to_chat(user, "Ты опоздал, дружок!")
		return
	if(duelists.Find(user))
		CRASH("A ghost tried to initiate a duel when he already was in the list of duelists. WTF?")
	bet = betinput
	duel_status = DUEL_PENDING
	inc_metabalance(user, -bet, TRUE, "Оплатил входной билет.")
	spawn_user(user, bet)
	to_chat(user, "<span class='notice'>Создали предложение о дуэли. Если никто не откликнется за 30 секунд, дуэль будет отменена и вам вернут деньги.</span>")
	notify_ghosts("[user.name] ([user.ckey]) приглашает всех желающих поучавствовать в дуэли на [bet] метакэша.", source = src, action = NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_SPLITPERSONALITY)
	timeout_timer = addtimer(CALLBACK(src, .proc/timeout), 30 SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)


/obj/effect/duel_controller/proc/spawn_user(mob/user)
	if(duelists.len >= 2)
		stack_trace("Duel controller tried to spawn a new participant when it already had [duelists.len] duelists. There never should be more than 2 participants.")
		return

	var/mob/living/carbon/human/H = new(get_turf(src))
	H.equipOutfit()
	H.ckey = user.ckey
	duelists.Add(H)
	if(duelists.len == 2)
		start_duel()
	START_PROCESSING(SSfastprocess, src)

/obj/effect/duel_controller/proc/start_duel()
	if(duelists.len != 2)
		stack_trace("Duel controller tried to start a duel with [duelists.len] duelists. It should only do that with 2 duelists.")
		finish_duel() // bad keyword argument
		return
	deltimer(timeout_timer)
	duel_status = DUEL_IN_PROGRESS

	if(duel_timelimit< 30)
		duel_timelimit = 30

	// i fucking hate this
	timeout_timer = addtimer(CALLBACK(src, .proc/timeout), duel_timelimit SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "30 секунд до окончания боя!"), (duel_timelimit-30) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "15 секунд до окончания боя!"), (duel_timelimit-15) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "10 секунд до окончания боя!"), (duel_timelimit-10) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)

	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "5..."), (duel_timelimit-5) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "4..."), (duel_timelimit-4) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "3..."), (duel_timelimit-3) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "2..."), (duel_timelimit-2) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)
	announcement_timers += addtimer(CALLBACK(src, .proc/announce, "1..."), (duel_timelimit-1) SECONDS, TIMER_STOPPABLE | TIMER_UNIQUE | TIMER_DELETE_ME)

	var/mob/M1 = duelists[1]
	var/mob/M2 = duelists[2]

	M1.forceMove(locate(x+first_spawnpoint[1], y+first_spawnpoint[2], z))   // undefined proc "forceMove" on /list
	M2.forceMove(locate(x+second_spawnpoint[1], y+second_spawnpoint[2], z)) // undefined proc "forceMove" on /list
	for(var/mob/living/D in duelists)
		D.Paralyze(3 SECONDS)
		to_chat(D, "<span class='alert'>Дуэль начнётся через 3 секунды...</span>")
		spawn(3 SECONDS)
			to_chat(D, "<span class='hypnophrase'>Дуэль началась!</span>")


/obj/effect/duel_controller/proc/timeout()
	if(duelists.len != 1)
		stack_trace("Duel controller timed out with [duelists.len] duelists instead of 2.")
		finish_duel() // bad keyword argument
	switch(duel_status)
		if(DUEL_NODUEL)
			stack_trace("Duel controller timed out with with duel_status equal to NODUEL. This is dumb.")
			finish_duel(state = DUEL_ERROR)
		if(DUEL_PENDING)
			to_chat(duelists[1], "Никто не принял твой вызов за 30 секунд.")
			finish_duel(state = DUEL_PENDING_TIMEOUT)
		if(DUEL_IN_PROGRESS)
			announce("Время вышло! Никто не победил.")
			finish_duel(state = DUEL_TIMEOUT)


/obj/effect/duel_controller/proc/announce(msg)
	visible_message("<span class='alert'>[msg]</span>")

/obj/effect/duel_controller/proc/finish_duel(mob/loser, state = DUEL_FINISH)
	//дичайшее говнище
	var/pay_mul = 1
	var/msg
	switch(state)
		if(DUEL_ERROR)
			msg = "Дуэль была прервана по непредвиденным обстоятельствам."
		if(DUEL_FINISH)
			if(!loser)
				CRASH("finish_duel called on duel finish but no loser was passed to the proc. The duel controller is going to seize up, good luck fixing that lol.")
			msg = "Победа в дуэли!"
			pay_mul = 2
		if(DUEL_PENDING_TIMEOUT)
			msg = "Никто так и не принял мой вызов."
		if(DUEL_TIMEOUT)
			msg = "Время вышло, никто так и не победил. Деньги ушли в фонд борьбы с Валтосом."
			pay_mul = 0

	for(var/mob/living/D in duelists)
		if(D != loser)
			inc_metabalance(D, bet*pay_mul, TRUE, msg)

	deltimer(timeout_timer)
	for(var/mob/living/D in duelists)
		D.dust(FALSE, FALSE, TRUE)
	for(var/t in announcement_timers)
		deltimer(t)
	announcement_timers.Cut()
	duelists.Cut()
	duel_status = DUEL_NODUEL
	bet = null
	STOP_PROCESSING(SSfastprocess, src)

/obj/effect/duel_controller/process(delta_time)
	for(var/mob/living/D in duelists)
		if(!istype(get_area(D), /area/duel/arena))
			to_chat(D, "<span class='warning'><b>Вы покинули арену. [pick("Очень глупо с вашей стороны.", "Мнда.", "Лох..")]</b></span>")
			finish_duel(D)
			return

		if( (D.status_traits.Find("floored") && stun_is_deadly) || HAS_TRAIT(D, TRAIT_CRITICAL_CONDITION) || D.stat == DEAD || !D.key)
			D.dust(FALSE, FALSE, TRUE)
			if(duel_status == DUEL_PENDING)
				announce("<b>Вы проиграли до начала дуэли. [pick("Впечатляюще.", "Поразительно.", "Поздравляю...")]</b>")
				finish_duel(D)
				return
			else
				announce("<b>Вы проиграли. [pick("Повезёт в следующий раз.", "Лох.", "На это было смешно смотреть.")]</b>")
				finish_duel(D)
				return


#undef DUEL_NODUEL
#undef DUEL_PENDING
#undef DUEL_IN_PROGRESS

/*
/datum/map_template/duel
	name = "Classic Duel arena"
	mappath = "_maps/map_files/duels/duel_classic.dmm"
*/


/obj/item/cum_jar
	name = "подозрительная банка"
	desc = "Внутри что-то плескается. На ощупь тёплая."
	icon = 'white/RedFoxIV/icons/obj/bags.dmi'
	icon_state = "cum"
	resistance_flags = INDESTRUCTIBLE | ACID_PROOF | LAVA_PROOF
	var/mob/living/prisoner

/obj/item/cum_jar/Initialize(mapload)
	. = ..()
	if(!isliving(loc))
		qdel(src)
		return
	prisoner = loc
	visible_message("Под [prisoner.name] появляется банка и засасывает его внутрь!")
	src.forceMove(get_turf(prisoner))
	prisoner.forceMove(src)
	ADD_TRAIT(prisoner, TRAIT_EMOTEMUTE, "cumjarred")
	ADD_TRAIT(prisoner, TRAIT_MUTE, "cumjarred")
	ADD_TRAIT(prisoner, TRAIT_NEARSIGHT, "cumjarred")
	ADD_TRAIT(prisoner, TRAIT_CLUMSY, "cumjarred")
	ADD_TRAIT(prisoner, TRAIT_HANDS_BLOCKED, "cumjarred")
	ADD_TRAIT(prisoner, TRAIT_IMMOBILIZED, "cumjarred")
	ADD_TRAIT(prisoner, TRAIT_NODEATH, "cumjarred")

/obj/item/cum_jar/Destroy()
	if(isnull(prisoner))
		return ..()
	prisoner.forceMove(drop_location())
	REMOVE_TRAIT(prisoner, TRAIT_EMOTEMUTE, "cumjarred")
	REMOVE_TRAIT(prisoner, TRAIT_MUTE, "cumjarred")
	REMOVE_TRAIT(prisoner, TRAIT_NEARSIGHT, "cumjarred")
	REMOVE_TRAIT(prisoner, TRAIT_HANDS_BLOCKED, "cumjarred")
	REMOVE_TRAIT(prisoner, TRAIT_IMMOBILIZED, "cumjarred")
	REMOVE_TRAIT(prisoner, TRAIT_NODEATH, "cumjarred")
	prisoner.Paralyze(15 SECONDS)
	prisoner.Knockdown(45 SECONDS)
	visible_message("[name] пропадает, оставляя за собой [prisoner.name], обмазанного чем-то белым и вонючим!")
	. = ..()

		
