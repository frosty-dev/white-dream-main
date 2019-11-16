/obj/item/gun/energy/cell/NLAW
	name = "N-LAW"
	desc = "A prototype energy weapon which was nicknamed the \"Sonic Blaster\" for looking like a giant fucking subwoofer with a trigger and a handle. Uses standard power cells which can be found all around the station."
	icon = 'code/shitcode/RedFoxIV/guns/sonicgun/sonicgun.dmi'
	icon_state = "sonic_gun"
	item_state = "sonic_gun"
	lefthand_file = 'code/shitcode/RedFoxIV/guns/guns_lefthand.dmi'
	righthand_file = 'code/shitcode/RedFoxIV/guns/guns_righthand.dmi'
	cell_type = /obj/item/stock_parts/cell/high/nlaw
	charge_sections = 5 
	shaded_charge = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/acoustic, /obj/item/ammo_casing/energy/acoustic/overcharge)
	modifystate = TRUE



/obj/item/stock_parts/cell/high/nlaw
	name = "NLAW battery"
	desc = "A special battery designed for the NLAW. Overall identical to a high-capacity power cell. So identical it can be used as a regular battery."


/obj/item/ammo_casing/energy/acoustic
	projectile_type = /obj/projectile/acoustic_wave
	e_cost = 2000
	harmful = FALSE
	select_name = "normal"
	pellets = 6
	caliber = "acoustic"
	variance = 90

/obj/projectile/acoustic_wave
	name = "Acoustic wave"
	icon = 'code/shitcode/RedFoxIV/guns/sonicgun/sonicgun.dmi'
	icon_state = "projectile"
	damage_type = STAMINA
	damage = 40
	range = 4
	pass_flags = PASSTABLE | PASSGRILLE
	var/knock_distance = 2	
	move_force = MOVE_FORCE_NORMAL
	//appearance_flags = TILE_BOUND //TILE_BOUND есть практически на всём, а дефолтный PIXEL_SCALE не нужон
	
/obj/projectile/acoustic_wave/vol_by_damage()
	return 1


/obj/projectile/acoustic_wave/on_hit(target)
	..()
	var/mob/living/living = target
	if(istype(living))
		var/throwdir = angle2dir(Angle)
		var/throwtarget = get_edge_target_turf(living, throwdir)
		living.throw_at(throwtarget, knock_distance, 4, src.firer, 1, 0, null, move_force)



/obj/item/ammo_casing/energy/acoustic/overcharge
	projectile_type = /obj/projectile/acoustic_wave/overcharged
	e_cost = 10000
	select_name = "overcharged"
	variance = 25
	harmful = FALSE

/obj/projectile/acoustic_wave/overcharged
	damage = 125
	range = 7
	knock_distance = 6
	move_force = MOVE_FORCE_OVERPOWERING


/datum/design/nlaw
	name = "N-LAW"
	desc = "A prototype energy weapon which utilizes powerful acoustic waves to knock people around."
	id = "nlaw"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 14000, /datum/material/plasma = 6000, /datum/material/glass = 10000, /datum/material/gold = 6000 , /datum/material/iron = 25000)
	build_path = /obj/item/gun/energy/cell/NLAW
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE //убрать флаг РнД если чрезмерно охуеют
