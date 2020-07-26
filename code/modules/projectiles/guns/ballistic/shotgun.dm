/obj/item/gun/ballistic/shotgun
	name = "дробовик"
	desc = "Традиционный дробовик с деревянным прикладом."
	icon_state = "shotgun"
	worn_icon_state = null
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_icon_state = "shotgun"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	fire_sound = 'sound/weapons/gun/shotgun/shot.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	rack_sound = 'sound/weapons/gun/shotgun/rack.ogg'
	load_sound = 'sound/weapons/gun/shotgun/insert_shell.ogg'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	semi_auto = FALSE
	internal_magazine = TRUE
	casing_ejector = FALSE
	bolt_wording = "помповый механизм"
	cartridge_wording = "shell"
	tac_reloads = FALSE
	weapon_weight = WEAPON_HEAVY

	pb_knockback = 2

/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/shotgun/lethal
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal

// RIOT SHOTGUN //

/obj/item/gun/ballistic/shotgun/riot //for spawn in the armory
	name = "дробовик охраны"
	desc = "Прочный дробовик с более длинным магазином и фиксированным тактическим запасом, предназначенным для несмертельного контроля над беспорядками."
	icon_state = "riotshotgun"
	inhand_icon_state = "shotgun"
	fire_delay = 7
	mag_type = /obj/item/ammo_box/magazine/internal/shot/riot
	sawn_desc = "Пошли со мной, если хочешь жить."
	can_be_sawn_off  = TRUE

// Automatic Shotguns//

/obj/item/gun/ballistic/shotgun/automatic/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "боевой дробовик"
	desc = "Полуавтоматический дробовик с тактической фурниторой и шестиместным магазином."
	icon_state = "cshotgun"
	inhand_icon_state = "shotgun_combat"
	fire_delay = 5
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com
	w_class = WEIGHT_CLASS_HUGE

//Dual Feed Shotgun

/obj/item/gun/ballistic/shotgun/automatic/dual_tube
	name = "колёсный дробовик"
	desc = "Улучшенный дробовик с двумя раздельными трубами, что позволяет быстро выбирать между двумя различными калибрами."
	icon_state = "cycler"
	inhand_icon_state = "bulldog"
	worn_icon_state = "cshotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube
	w_class = WEIGHT_CLASS_HUGE
	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine
	semi_auto = TRUE

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click чтоб изменить это.</span>"

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/Initialize()
	. = ..()
	if (!alternate_magazine)
		alternate_magazine = new mag_type(src)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/attack_self(mob/living/user)
	if(!chambered && magazine.contents.len)
		rack()
	else
		toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/proc/toggle_tube(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "<span class='notice'>Вы выбрали трубу 'B'.</span>")
	else
		to_chat(user, "<span class='notice'>Вы выбрали трубу 'А'.</span>")

/obj/item/gun/ballistic/shotgun/automatic/dual_tube/AltClick(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	rack()

// Bulldog shotgun //

/obj/item/gun/ballistic/shotgun/bulldog
	name = "\improper дробовик''Bulldog'' "
	desc = "Полуавтоматический дробовик с магнитной подачей для боя в узких коридорах по прозвищу «Бульдог». Совместим только со специализированными 8-круглыми барабанными магазинами."
	icon_state = "bulldog"
	inhand_icon_state = "bulldog"
	worn_icon_state = "cshotgun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	mag_type = /obj/item/ammo_box/magazine/m12g
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 0
	pin = /obj/item/firing_pin/implant/pindicate
	fire_sound = 'sound/weapons/gun/shotgun/shot_alt.ogg'
	actions_types = list()
	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	special_mags = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE
	tac_reloads = TRUE


/obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	pin = /obj/item/firing_pin
/////////////////////////////
// DOUBLE BARRELED SHOTGUN //
/////////////////////////////

/obj/item/gun/ballistic/shotgun/doublebarrel
	name = "двухстволка"
	desc = "Истинная классика."
	icon_state = "dshotgun"
	inhand_icon_state = "shotgun_db"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	force = 10
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	sawn_desc = "Приход Омара!"
	obj_flags = UNIQUE_RENAME
	rack_sound_volume = 0
	unique_reskin = list("Default" = "dshotgun",
						"Dark Red Finish" = "dshotgun_d",
						"Ash" = "dshotgun_f",
						"Faded Grey" = "dshotgun_g",
						"Maple" = "dshotgun_l",
						"Rosewood" = "dshotgun_p"
						)
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	can_be_sawn_off  = TRUE
	pb_knockback = 3 // it's a super shotgun!

/obj/item/gun/ballistic/shotgun/doublebarrel/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)

/obj/item/gun/ballistic/shotgun/doublebarrel/sawoff(mob/user)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM

// IMPROVISED SHOTGUN //

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised
	name = "кустарный дробовик"
	desc = "Труба, сделанная под дробовик."
	icon_state = "ishotgun"
	inhand_icon_state = "ishotgun"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	slot_flags = null
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	sawn_desc = "I'm just here for the gasoline."
	unique_reskin = null
	var/slung = FALSE

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		var/obj/item/stack/cable_coil/C = A
		if(C.use(10))
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, "<span class='notice'>Привязываю кабель к дробовику, теперь можно носить дробовик на спине.</span>")
			slung = TRUE
			update_icon()
		else
			to_chat(user, "<span class='warning'>Требуется минимум десять длин кабеля, если мне нужно сделать стропу!</span>")

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/update_icon_state()
	. = ..()
	if(slung)
		inhand_icon_state = "ishotgunsling"
	if(sawn_off)
		inhand_icon_state = "ishotgun_sawn"

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/update_overlays()
	. = ..()
	if(slung)
		. += "ishotgunsling"
	if(sawn_off)
		. += "ishotgun_sawn"

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/sawoff(mob/user)
	. = ..()
	if(. && slung) //sawing off the gun removes the sling
		new /obj/item/stack/cable_coil(get_turf(src), 10)
		slung = 0
		update_icon()
		lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
		righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'

/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/sawn
	name = "импровизированный обрез"
	desc = "Делает одиночный выстрел. Не промахнись."
	icon_state = "ishotgun_sawn"
	inhand_icon_state = "ishotgun_sawn"
	worn_icon_state = "gun"
	worn_icon = null
	w_class = WEIGHT_CLASS_NORMAL
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/ballistic/shotgun/doublebarrel/hook
	name = "модифицированный крюком обрез"
	desc = "Дальность не проблема, когда вы можете притянуть жертву к себе."
	icon_state = "hookshotgun"
	inhand_icon_state = "shotgun"
	load_sound = 'sound/weapons/gun/shotgun/insert_shell.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/bounty
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	can_be_sawn_off = FALSE
	force = 16 //it has a hook on it
	attack_verb = list("slashed", "hooked", "stabbed")
	hitsound = 'sound/weapons/bladeslice.ogg'
	//our hook gun!
	var/obj/item/gun/magic/hook/bounty/hook
	var/toggled = FALSE

/obj/item/gun/ballistic/shotgun/doublebarrel/hook/Initialize()
	. = ..()
	hook = new /obj/item/gun/magic/hook/bounty(src)

/obj/item/gun/ballistic/shotgun/doublebarrel/hook/AltClick(mob/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(toggled)
		to_chat(user,"<span class='notice'>Вы собрались стрелять.</span>")
		fire_sound = initial(fire_sound)
	else
		to_chat(user,"<span class='notice'>Вы будете использовать крюк.</span>")
		fire_sound = 'sound/weapons/batonextend.ogg'
	toggled = !toggled

/obj/item/gun/ballistic/shotgun/doublebarrel/hook/examine(mob/user)
	. = ..()
	if(toggled)
		. += "<span class='notice'>Alt-click чтобы приготовиться стрелять.</span>"
	else
		. += "<span class='notice'>Alt-click чтобы начать использовать крюк.</span>"

/obj/item/gun/ballistic/shotgun/doublebarrel/hook/afterattack(atom/target, mob/living/user, flag, params)
	if(toggled)
		hook.afterattack(target, user, flag, params)
	else
		return ..()
