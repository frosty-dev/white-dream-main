GLOBAL_LIST_INIT(petushiniy_list, list("ambrosiafumari"))

/atom
	var/zashkvareno = 0

/client
	var/petukh = 0

/proc/zashkvar_check(var/mob/M, var/atom/A) //nasral na other_mobs.dm
	if(!M || !M.client || !A || A.zashkvareno)
		return

	if(!((M.ckey in GLOB.petushiniy_list) || M.client.petukh))
		return

	A.zashkvareno = 1
	A.visible_message("<span class='danger'>[A.name] зашкваривается от петушиного касания!</span>")

	if(prob(50))
		A.name = "петушиный " + A.name
	else
		A.name = "зашкваренный " + A.name

	if(istype(A, /obj))
		var/obj/O = A
		O.force = 0
		O.throwforce = 0

	if(istype(A, /obj/item/gun))
		var/obj/item/gun/G = A
		G.chambered = new /obj/item/ammo_casing/pisun(G)
		return

	if(istype(A, /obj/item/ammo_box))
		var/obj/item/ammo_box/AB = A
		for(var/obj/item/ammo_casing/R in AB.stored_ammo)
			qdel(R.BB)
			R.BB = new /obj/projectile/bullet/pisun
		return


/obj/projectile/bullet/pisun
	name = "кожаная пуля"
	damage = 0

/obj/item/ammo_casing/pisun
	projectile_type = /obj/projectile/bullet/pisun
	fire_sound = 'sound/weapons/taser2.ogg'

/obj/item/ammo_casing/pisun/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	if(!BB)
		newshot()
	. = ..()

GLOBAL_LIST_INIT(pacifist_list, list("chillraccoon", "sasha77701", "hughdepayne"))
