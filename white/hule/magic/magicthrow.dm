/obj/item/book/granter/spell/assacc
	spell = /obj/effect/proc_holder/spell/aimed/ass_accelerator
	spellname = "Ass Accelerator"
	icon_state ="bookfireball"
	desc = "Выглядит ПрИкОлЬнО"
	remarks = list()


/obj/effect/proc_holder/spell/aimed/ass_accelerator
	name = "Ускоритель <s>М</s>асс"
	desc = "Позволяет метать плитку еще более смертоносно и ускорять межстанционную баллистическую арматуру до огромных скоростей"
	school = "College of руснявый humor, Manayamirok state, USA"
	charge_max = 60
	clothes_req = FALSE
	invocation = "KA VO"
	invocation_type = "shout"
	range = 20
	cooldown_min = 20 //10 deciseconds reduction per rank
	projectile_type = 0
	projectile_amount = 5
	base_icon_state = "fireball"
	action_icon_state = "fireball0"
	sound = 'white/hule/SFX/anekdot_delimiter.ogg'
	active_msg = "Теперь ты будешь ускорять всю хуйню."
	deactive_msg = "Ты больше не ускоряешь всю хуйню."
	active = FALSE

/obj/effect/proc_holder/spell/aimed/ass_accelerator/cast(list/targets, mob/living/user)
	var/obj/item/I = user.get_active_held_item()
	if (istype(I, /obj/item/stack/rods)||istype(I, /obj/item/stack/tile))
		var/obj/item/stack/S = I
		if(istype(I, /obj/item/stack/rods))
			projectile_type = /obj/projectile/magic/rodacc
		else
			projectile_type = /obj/projectile/magic/tileacc
		S.amount--
		if(S.amount <= 0)
			qdel(S)
	else
		to_chat(usr,"<span class='notice'>В руке должна быть плитка или арматура</span>")
		return
	if (projectile_type == /obj/projectile/magic/tileacc)
		if(current_amount < 5)
			to_chat(usr,"<span class='notice'>Недостаточно зарядов для запуска плитки</span>")
			return
		else
			current_amount -= 4

	. = ..()
	projectile_type = 0

/obj/projectile/magic/rodacc
	name = "accelerating rod"
	icon = 'white/hule/icons/projectiles/magicthrow.dmi'
	icon_state = "rod"
	range = 500
	damage = 10
	damage_type = BRUTE
	nodamage = FALSE
	armour_penetration = 0
	speed = 2
	flag = "magic"
	hitsound = 'sound/weapons/barragespellhit.ogg'
	var/acc = 0.2

/obj/projectile/magic/rodacc/process()
	damage += 7
	if(speed > 0.1)
		speed -= acc
		if(speed <= 0.4)
			icon_state = "rod_fast"
			acc = 0.05
	. = ..()

/obj/projectile/magic/rodacc/on_hit(atom/target)
	if(speed <= 0.6)
		if(istype(target, /obj/mecha))
			target.ex_act(EXPLODE_HEAVY)
		if(istype(target, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/A = target
			A.CanAtmosPass = ATMOS_PASS_YES
			A.desc += "\nОго, да в нем дырень! Эта штука уже точно не спасет от разгерметизации."
	. = ..()

/obj/projectile/magic/tileacc
	name = "spinning tile"
	icon = 'white/hule/icons/projectiles/magicthrow.dmi'
	icon_state = "tile"
	damage = 20
	damage_type = BRUTE
	nodamage = FALSE
	armour_penetration = 0
	flag = "magic"
	hitsound = 'sound/weapons/barragespellhit.ogg'
	dismemberment = 50
	var/crit = 0

/obj/projectile/magic/tileacc/Initialize()
	if(prob(33))
		name += " of death"
		icon_state = "tile_crit"
		crit = 1
	. = ..()

/obj/projectile/magic/tileacc/on_hit(atom/target)
	. = ..()
	if(crit)
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/head/head = C.get_bodypart(BODY_ZONE_HEAD)
			head.drop_limb()
			playsound(src,'white/hule/SFX/csSFX/headshot.wav', 100, 5, pressure_affected = FALSE)
