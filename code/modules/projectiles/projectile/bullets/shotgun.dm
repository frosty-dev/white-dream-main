/obj/projectile/bullet/shotgun_slug
	name = "12g пуля"
	damage = 60

/obj/projectile/bullet/shotgun_slug/executioner
	name = "executioner slug" // admin only, can dismember limbs
	sharpness = TRUE
	wound_bonus = 0

/obj/projectile/bullet/shotgun_slug/pulverizer
	name = "pulverizer slug" // admin only, can crush bones
	sharpness = FALSE
	wound_bonus = 0

/obj/projectile/bullet/shotgun_beanbag
	name = "резиновая пуля"
	damage = 10
	stamina = 55
	wound_bonus = 20
	sharpness = FALSE

/obj/projectile/bullet/incendiary/shotgun
	name = "поджигающая пуля"
	damage = 20

/obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "гранула драконьего дыхания"
	damage = 5

/obj/projectile/bullet/shotgun_stunslug
	name = "электропуля"
	damage = 5
	paralyze = 100
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"

/obj/projectile/bullet/shotgun_meteorslug
	name = "метеоропуля"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	paralyze = 15
	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/projectile/bullet/shotgun_meteorslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/projectile/bullet/shotgun_meteorslug/Initialize()
	. = ..()
	SpinAnimation()

/obj/projectile/bullet/shotgun_frag12
	name ="frag12 пуля"
	damage = 25
	paralyze = 50

/obj/projectile/bullet/shotgun_frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

/obj/projectile/bullet/pellet
	var/tile_dropoff = 0.75
	var/tile_dropoff_s = 0.5

/obj/projectile/bullet/pellet/shotgun_buckshot
	name = "дробинки картечи"
	damage = 12.5
	wound_bonus = -10

/obj/projectile/bullet/pellet/shotgun_rubbershot
	name = "резиновые дробинки"
	damage = 3
	stamina = 11

/obj/projectile/bullet/pellet/shotgun_incapacitate
	name = "обезвреживающие дробинки"
	damage = 1
	stamina = 6

/obj/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/pellet/shotgun_improvised
	tile_dropoff = 0.55		//Come on it does 6 damage don't be like that.
	damage = 6

/obj/projectile/bullet/pellet/shotgun_improvised/Initialize()
	. = ..()
	range = rand(1, 8)

/obj/projectile/bullet/pellet/shotgun_improvised/on_range()
	do_sparks(1, TRUE, src)
	..()

// Mech Scattershot

/obj/projectile/bullet/scattershot
	damage = 24
