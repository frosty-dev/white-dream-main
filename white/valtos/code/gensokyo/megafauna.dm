/mob/living/simple_animal/hostile/megafauna/colossus/reimu
	name = "Reimu Hakurei"
	desc = "Wow, cute anime girl."
	health = 1250
	maxHealth = 1250
	attack_verb_continuous = "вхуячивает"
	attack_verb_simple = "въёбывает"
	attack_sound = 'sound/magic/clockwork/ratvar_attack.ogg'
	icon_state = "reimu"
	icon_living = "reimu"
	icon_dead = ""
	friendly_verb_continuous = "презрительно смотрит"
	friendly_verb_simple = "презрительно смотрит"
	icon = 'white/valtos/icons/gensokyo/96x96megafauna.dmi'
	speak_emote = list("рассуждает")
	armour_penetration = 40
	melee_damage_lower = 40
	melee_damage_upper = 40
	speed = 8
	move_to_delay = 8
	ranged = TRUE
	pixel_x = -32
	del_on_death = TRUE
	gps_name = "Reimu Signal"
	achievement_type = /datum/award/achievement/boss/reimu_kill
	crusher_achievement_type = /datum/award/achievement/boss/reimu_crusher
	score_achievement_type = /datum/award/score/reimu_score
	crusher_loot = list(/obj/structure/closet/crate/necropolis/colossus/crusher)
	loot = list(/obj/structure/closet/crate/necropolis/colossus)
	deathmessage = "испаряется оставляя после себя что-то."
	deathsound = 'sound/magic/demon_dies.ogg'
	attack_action_types = list(/datum/action/innate/megafauna_attack/spiral_attack,
							   /datum/action/innate/megafauna_attack/aoe_attack,
							   /datum/action/innate/megafauna_attack/shotgun,
							   /datum/action/innate/megafauna_attack/alternating_cardinals)
	small_sprite_type = /datum/action/small_sprite/megafauna/colossus

/mob/living/simple_animal/hostile/megafauna/colossus/reimu/shoot_projectile(turf/marker, set_angle)
	if(!isnum(set_angle) && (!marker || marker == loc))
		return
	var/turf/startloc = get_turf(src)
	var/obj/projectile/P = new /obj/projectile/colossus/reimu(startloc)
	P.preparePixelProjectile(marker, startloc)
	P.firer = src
	if(target)
		P.original = target
	P.fire(set_angle)

/obj/projectile/colossus/reimu
	name ="удар смерти"
	icon_state= "ice_2"
	damage = 15
	armour_penetration = 60
	speed = 3
	eyeblur = 0
	damage_type = BRUTE
	pass_flags = PASSTABLE
