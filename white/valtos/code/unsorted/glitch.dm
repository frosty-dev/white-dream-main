/atom/var/glitched = FALSE

/atom/proc/glitch_me(var/amount = 4, speed_min = 1, speed_max = 2, count = 1)
	if(glitched || HAS_TRAIT(src, TRAIT_HACKER))
		return FALSE
	filters += filter(type="drop_shadow", x = rand(-1, 1), color = "#ff0000")
	filters += filter(type="drop_shadow", x = rand(-1, 1), color = "#00ffff")
	filters += filter(type = "displace", icon = 'white/valtos/icons/glitch_mask.png', size = amount)
	animate(filters[filters.len], size = rand(1, amount), x = rand(1, amount), y = rand(1, amount), time = rand(speed_min, speed_max), loop = count, easing = SINE_EASING)
	animate(size = 0, x = 0, y = 0, time = rand(speed_min, speed_max))

/atom/proc/unglitch_me()
	if(!glitched)
		return FALSE
	filters = null
	glitched = FALSE

/obj/item/gun/magic/glitch
	name = "Глитч-ган"
	desc = "Вите надо выйти..."
	max_charges = 3
	can_charge = TRUE
	recharge_rate = 1
	fire_sound = 'white/valtos/sounds/mechanized/kr1.wav'
	ammo_type = /obj/item/ammo_casing/magic/glitch

/obj/item/gun/magic/glitch/Initialize()
	. = ..()
	glitch_me(count = -1)

/obj/item/ammo_casing/magic/glitch
	projectile_type = /obj/projectile/magic/glitch

/obj/projectile/magic/glitch
	name = "заряд глитчей"
	icon_state = "ice_1"
	damage = 0
	damage_type = BURN
	nodamage = TRUE

/obj/projectile/magic/glitch/on_hit(atom/GA)
	. = ..()
	if(!GA.glitched)
		GA.glitch_me(count = -1)
		GA.glitched = TRUE
	qdel(src)
