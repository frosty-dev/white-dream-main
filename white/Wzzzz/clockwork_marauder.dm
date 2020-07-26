/mob/living/simple_animal/hostile/clockwork/marauder
	name = "clockwork marauder"
	desc = "The stalwart apparition of a soldier, blazing with crimson flames. It's armed with a gladius and shield."
	icon_state = "clockwork_marauder"
	health = 150
	maxHealth = 150
	force_threshold = 8
	speed = 0
	obj_damage = 40
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_sound = 'sound/weapons/bladeslice.ogg'
	weather_immunities = list("lava")
	movement_type = FLYING
	light_range = 2
	light_power = 1.1
	var/deflect_chance = 40 //Chance to deflect any given projectile (non-damaging energy projectiles are always deflected)
