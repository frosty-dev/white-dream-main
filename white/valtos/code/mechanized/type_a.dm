//WIP

/obj/mecha/mechanized
	var/left_arm = 428
	var/right_arm = 428
	var/legs = 646

/obj/mecha/mechanized/Initialize()
	RegisterSignal(src, COMSIG_PROJECTILE_PREHIT, .proc/prehit)
	. = ..()

/obj/mecha/mechanized/proc/prehit(obj/projectile/source, list/signal_args)
	if(prob(deflect_chance))
		visible_message("<span class='red'>[src] уворачивается от [source].</span>")
		qdel(source)
	switch(rand(1,4))
		if(1)
			left_arm -= source.damage
		if(2)
			right_arm -= source.damage
		if(3)
			legs -= source.damage
		if(4)
			max_integrity -= source.damage
	qdel(source)

/obj/mecha/mechanized/type_a
	name = "TYPE-A Mech"
	desc = "БЕГИ!!!"
	icon = 'white/valtos/icons/mechanized/type_a.dmi'
	icon_state = "type_a"
	pixel_x = -16
	step_in = 2
	resistance_flags = FIRE_PROOF | ACID_PROOF
	layer = ABOVE_MOB_LAYER
	force = 25
	normal_step_energy_drain = 100
	step_energy_drain = 100
	melee_energy_drain = 150
	overload_step_energy_drain_min = 1000
	max_integrity = 982
	deflect_chance = 25
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 40, "bio" = 40, "rad" = 40, "fire" = 100, "acid" = 100)
	bumpsmash = TRUE
	max_equip = 5
	stepsound = 'white/valtos/sounds/mechanized/type_a_move.wav'
	turnsound = 'white/valtos/sounds/mechanized/type_a_move.wav'
	melee_cooldown = 15
	enter_delay = 150
	exit_delay = 100
	hud_possible = list (DIAG_STAT_HUD, DIAG_BATT_HUD, DIAG_MECH_HUD, DIAG_TRACK_HUD)

/obj/item/mecha_parts/mecha_equipment/drill/lance
	name = "энергокопьё KR1"
	desc = "Че смотришь? БЕГИ!!!"
	icon = 'white/valtos/icons/mechanized/type_a.dmi'
	icon_state = "kr1"
	equip_cooldown = 35
	energy_drain = 1000
	force = 90
	harmful = TRUE
	tool_behaviour = TOOL_DRILL
	toolspeed = 1.9
	drill_delay = 3
	drill_level = 2
	var/icon/lance_overlay

/obj/item/mecha_parts/mecha_equipment/drill/lance/attach(obj/mecha/M)
	..()
	lance_overlay = new(src.icon, icon_state = "kr1")
	M.add_overlay(lance_overlay)

/obj/item/mecha_parts/mecha_equipment/drill/lance/can_attach(obj/mecha/M as obj)
	if(istype(M, /obj/mecha/mechanized) && M.equipment.len<M.max_equip)
		return TRUE
	return FALSE

/obj/item/mecha_parts/mecha_equipment/drill/lance/detach(obj/mecha/M)
	..()
	M.cut_overlay(lance_overlay)

/obj/item/mecha_parts/mecha_equipment/drill/lance/action(atom/target)
	if(!action_checks(target))
		return
	if(isspaceturf(target))
		return
	if(isobj(target))
		var/obj/target_obj = target
		if(target_obj.resistance_flags & UNACIDABLE)
			return
	target.visible_message("<span class='warning'>[chassis] starts to drill [target].</span>", \
					"<span class='userdanger'>[chassis] starts to drill [target]...</span>", \
					 "<span class='hear'>You hear drilling.</span>")

	if(do_after_cooldown(target))
		set_ready_state(FALSE)
		log_message("Started drilling [target]", LOG_MECHA)
		if(isturf(target))
			var/turf/T = target
			T.drill_act(src)
			set_ready_state(TRUE)
			return
		while(do_after_mecha(target, drill_delay))
			if(isliving(target))
				drill_mob(target, chassis.occupant)
				playsound(src,'white/valtos/sounds/mechanized/kr1.wav',40,TRUE)
			else if(isobj(target))
				var/obj/O = target
				O.take_damage(15, BRUTE, 0, FALSE, get_dir(chassis, target))
				playsound(src,'white/valtos/sounds/mechanized/kr1.wav',40,TRUE)
			else
				set_ready_state(TRUE)
				return
		set_ready_state(TRUE)
