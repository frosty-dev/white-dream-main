/obj/item/gun/ballistic/revolver
	name = "\improper .357 револьвер"
	desc = "Подозрительный револьвер, использующий .357 патроны." //usually used by syndicates
	icon_state = "revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder
	fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0

/obj/item/gun/ballistic/revolver/chamber_round(spin_cylinder = TRUE)
	if(!magazine) //if it mag was qdel'd somehow.
		CRASH("revolver tried to chamber a round without a magazine!")
	if(spin_cylinder)
		chambered = magazine.get_round(TRUE)
	else
		chambered = magazine.stored_ammo[1]

/obj/item/gun/ballistic/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	..()
	chamber_round(TRUE)

/obj/item/gun/ballistic/revolver/AltClick(mob/user)
	..()
	spin()

/obj/item/gun/ballistic/revolver/verb/spin()
	set name = "барабан"
	set category = "Объект"
	set desc = "Щелкните кнопкой мыши, чтобы покрутить барабан у револьвера."

	var/mob/M = usr

	if(M.stat || !in_range(M,src))
		return

	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, "revolver_spin", 30, FALSE)
		usr.visible_message("<span class='notice'><b>[usr]</b> крутит барабан <b>[src.name]</b>.</span>", "<span class='notice'>Кручу барабан <b>[src.name]</b>.</span>")
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "Нет"] живых патронов."
	if (current_skin)
		. += "Его можно покрутить используя <b>Alt+клик</b>"

/obj/item/gun/ballistic/revolver/detective
	name = "\improper специальный кольт детектива"
	desc = "Классическое, если не устаревшее, правоохранительное оружие. Использует .38 спецпатроны."
	fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
	icon_state = "detective"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "detective",
						"Fitz Special" = "detective_fitz",
						"Police Positive Special" = "detective_police",
						"Blued Steel" = "detective_blued",
						"Stainless Steel" = "detective_stainless",
						"Gold Trim" = "detective_gold",
						"Leopard Spots" = "detective_leopard",
						"The Peacemaker" = "detective_peacemaker",
						"Black Panther" = "detective_panther"
						)

/obj/item/gun/ballistic/revolver/detective/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(magazine && magazine.caliber != initial(magazine.caliber))
		if(prob(70 - (magazine.ammo_count() * 10)))	//minimum probability of 10, maximum of 60
			playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
			to_chat(user, "<span class='userdanger'><b>[src.name]</b> приставил к лицу!</span>")
			user.take_bodypart_damage(0,20)
			user.dropItemToGround(src)
			return FALSE
	return ..()

/obj/item/gun/ballistic/revolver/detective/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(magazine.caliber == "38")
		to_chat(user, "<span class='notice'>Начинаю заряжать барабан <b>[src.name]</b>...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//you know the drill
			user.visible_message("<span class='danger'><b>[src.name]</b> выстрелило!</span>", "<span class='userdanger'><b>[src.name]</b> выстрелило в лицо!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>Не получается изменить его!</span>")
				return TRUE
			magazine.caliber = "357"
			fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'
			desc = "Барабан и камера выглядит измененно."
			to_chat(user, "<span class='notice'>Заряжаю барабан этим <b>[src.name]</b>. Должно стрелять .357 патронами.</span>")
	else
		to_chat(user, "<span class='notice'>Начинаю переделывать обратно в <b>[src.name]</b>...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//and again
			user.visible_message("<span class='danger'><b>[src.name]</b> выстрелило!</span>", "<span class='userdanger'><b>[src.name]</b> выстрелило в лицо!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>Не получается изменить его!</span>")
				return
			magazine.caliber = "38"
			fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
			desc = initial(desc)
			to_chat(user, "<span class='notice'>Делаю так как и было у <b>[src.name]</b>. Будет стрелять .38 патронами.</span>")
	return TRUE


/obj/item/gun/ballistic/revolver/mateba
	name = "\improper Unica 6 автоматический револьвер"
	desc = "Ретро-мощный револьвер, обычно используемый офицерами новой России. Использует .357 патроны."
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/golden
	name = "\improper золотой револьвер"
	desc = "Раритетное оружие, использующее патроны .357."
	icon_state = "goldrevolver"
	fire_sound = 'sound/weapons/resonator_blast.ogg'
	recoil = 8
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/nagant
	name = "\improper наган"
	desc = "Старая модель револьвера, использововшая в России. Можно зацепить глушитель. Использует 7.62x38mmR патроны."
	icon_state = "nagant"
	can_suppress = TRUE

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev762


// A gun to play Russian Roulette!
// You can spin the chamber to randomize the position of the bullet.

/obj/item/gun/ballistic/revolver/russian
	name = "\improper русский револьвер"
	desc = "Сделано для пьяных игр тупыми пиндосами. Использует .357 патроны, можно начинать крутить барабан и ставить в рот."
	icon_state = "russianrevolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	var/spun = FALSE

/obj/item/gun/ballistic/revolver/russian/do_spin()
	. = ..()
	if(.)
		spun = TRUE

/obj/item/gun/ballistic/revolver/russian/attackby(obj/item/A, mob/user, params)
	..()
	if(get_ammo() > 0)
		spin()
	update_icon()
	A.update_icon()
	return

/obj/item/gun/ballistic/revolver/russian/attack_self(mob/user)
	if(!spun)
		spin()
		spun = TRUE
		return
	..()

/obj/item/gun/ballistic/revolver/russian/afterattack(atom/target, mob/living/user, flag, params)
	. = ..(null, user, flag, params)

	if(flag)
		if(!(target in user.contents) && ismob(target))
			if(user.a_intent == INTENT_HARM) // Flogging action
				return

	if(isliving(user))
		if(!can_trigger_gun(user))
			return
	if(target != user)
		if(ismob(target))
			to_chat(user, "<span class='warning'>Хитрый механизм препятствует стрелять в других. Может в себя?</span>")
		return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!spun)
			to_chat(user, "<span class='warning'>Стоит покрутить барабан <b>[src.name]</b> сначала!</span>")
			return

		spun = FALSE

		if(chambered)
			var/obj/item/ammo_casing/AC = chambered
			if(AC.fire_casing(user, user))
				playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
				var/zone = check_zone(user.zone_selected)
				var/obj/item/bodypart/affecting = H.get_bodypart(zone)
				if(zone == BODY_ZONE_HEAD || zone == BODY_ZONE_PRECISE_EYES || zone == BODY_ZONE_PRECISE_MOUTH)
					shoot_self(user, affecting)
				else
					user.visible_message("<span class='danger'><b>[user.name]</b> трусливо стреляет <b>[src.name]</b> в [user.p_their()] [affecting.name]!</span>", "<span class='userdanger'>Вы трусливо выстрелили <b>[src.name]</b> в свой [affecting.name]!</span>", "<span class='hear'>Вы слышали выстрел!</span>")
				chambered = null
				return

		user.visible_message("<span class='danger'>*щёлк*</span>")
		playsound(src, dry_fire_sound, 30, TRUE)

/obj/item/gun/ballistic/revolver/russian/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	playsound(src, dry_fire_sound, 30, TRUE)
	user.visible_message("<span class='danger'><b>[user.name]</b> пытается выстрелить из <b>[src.name]</b>, но выглядит как еблан.</span>", "<span class='danger'>Механизм <b>[src.name]</b> не позволяет выстрелить!</span>")

/obj/item/gun/ballistic/revolver/russian/proc/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	user.apply_damage(300, BRUTE, affecting)
	user.visible_message("<span class='danger'><b>[user.name]</b> стреляет из <b>[src.name]</b> себе в голову!</span>", "<span class='userdanger'>Стреляю из <b>[src.name]</b> себе в голову!</span>", "<span class='hear'>Слышу выстрел!</span>")

/obj/item/gun/ballistic/revolver/russian/soul
	name = "проклятый русский револьвер"
	desc = "Чтобы играть с этим револьвером, нужно отыграть свою душу."

/obj/item/gun/ballistic/revolver/russian/soul/shoot_self(mob/living/user)
	..()
	var/obj/item/soulstone/anybody/revolver/SS = new /obj/item/soulstone/anybody/revolver(get_turf(src))
	if(!SS.transfer_soul("FORCE", user)) //Something went wrong
		qdel(SS)
		return
	user.visible_message("<span class='danger'>Душа <b>[user.name]</b> теперь принадлежит <b>[src.name]</b>!</span>", "<span class='userdanger'>Вы проиграли в азартную игру вместе с душой!</span>")

/obj/item/gun/ballistic/revolver/reverse //Fires directly at its user... unless the user is a clown, of course.
	clumsy_check = 0

/obj/item/gun/ballistic/revolver/reverse/can_trigger_gun(mob/living/user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) || (user.mind && user.mind.assigned_role == "Clown"))
		return ..()
	if(process_fire(user, user, FALSE, null, BODY_ZONE_HEAD))
		user.visible_message("<span class='warning'><b>[user]</b> стреляет себе в ебальник!</span>", "<span class='userdanger'>Стреляю себе в ебало! Заебись!</span>")
		user.emote("scream")
		user.drop_all_held_items()
		user.Paralyze(80)
