/obj/item/gun/energy/cellgun/nlaw
	name = "N-LAW"
	desc = "Basically, a big subwoofer on steroids with a trigger. Can incapacitate people by throwing into walls, windows, other people, open airlocks, supermatter, disposals, banana peels, AIDS-infected monkeys, lavaland megafauna, lavaland lava, permabrig and, if you're not careful enough, yourself."
	icon = 'white/RedFoxIV/guns/sonicgun/sonicgun.dmi'
	icon_state = "sonic_gun"
	inhand_icon_state = "sonic_gun"
	lefthand_file = 'white/RedFoxIV/guns/guns_lefthand.dmi'
	righthand_file = 'white/RedFoxIV/guns/guns_righthand.dmi'
	cell_type = /obj/item/stock_parts/cell/high
	charge_sections = 5
	shaded_charge = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/acoustic, /obj/item/ammo_casing/energy/acoustic/overcharge)
	modifystate = TRUE

/obj/item/gun/energy/cellgun/nlaw/garbage
	can_eject = FALSE
	desc = "A prototype energy weapon. Most people throw it in the trash bin and bug R&D for a better one. Does not support cell changing, overcharged mode, sustained fire, windows 10."
	name = "LAW"
	cell_type = /obj/item/stock_parts/cell/nlaw
	ammo_type = list(/obj/item/ammo_casing/energy/acoustic)


/obj/item/stock_parts/cell/nlaw
	name = "LAW battery"
	desc = "Good job jackass, now try to put it back in without admemes."
	charge = 4000

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
	icon = 'white/RedFoxIV/guns/sonicgun/sonicgun.dmi'
	icon_state = "projectile"
	damage_type = STAMINA
	damage = 20
	range = 4
	pass_flags = PASSTABLE | PASSGRILLE
	var/knock_dist = 2
	move_force = MOVE_FORCE_STRONG
	//appearance_flags = TILE_BOUND //TILE_BOUND есть практически на всём, а дефолтный PIXEL_SCALE не нужон

/obj/projectile/acoustic_wave/vol_by_damage()
	return 1


//туду: починить косой бросок при стрельбе поинт-бланk
/obj/projectile/acoustic_wave/on_hit(hitobject)
	.=..()
	var/atom/movable/targethit = hitobject
	var/atom/movable/throwdir = angle2dir(Angle)
	var/atom/movable/throwtarget = get_edge_target_turf(targethit, throwdir)
	if(istype(targethit, /mob/living) && targethit.anchored == FALSE)
		targethit.throw_at(throwtarget, knock_dist+1, 4, src.firer, 1, 0, null, move_force)
		return
	if(istype(targethit,/obj/item) && targethit.anchored == FALSE)
		targethit.throw_at(throwtarget, knock_dist*2+1, 4, src.firer, 1, 0, null, move_force)
		return
	if(istype(targethit,/obj/structure) && targethit.anchored == FALSE)
		targethit.throw_at(throwtarget, knock_dist/2, 4, src.firer, 1, 0, null, move_force)
		return

/obj/item/ammo_casing/energy/acoustic/overcharge
	projectile_type = /obj/projectile/acoustic_wave/overcharged
	e_cost = 10000
	select_name = "overcharged"
	variance = 25
	harmful = FALSE

/obj/projectile/acoustic_wave/overcharged
	damage = 75
	range = 6
	knock_dist = 6
	move_force = MOVE_FORCE_VERY_STRONG


/datum/design/nlaw
	name = "N-LAW"
	desc = "A prototype energy weapon which utilizes powerful acoustic waves to knock people around."
	id = "nlaw"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 14000, /datum/material/plasma = 6000, /datum/material/glass = 10000, /datum/material/gold = 6000 , /datum/material/iron = 25000)
	build_path = /obj/item/gun/energy/cellgun/nlaw
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE //убрать флаг РнД если чрезмерно охуеют
