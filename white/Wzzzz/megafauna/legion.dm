/**
  *LEGION
  *
  *Legion spawns from the necropolis gate in the far north of lavaland. It is the guardian of the Necropolis and emerges from within whenever an intruder tries to enter through its gate.
  *Whenever Legion emerges, everything in lavaland will receive a notice via color, audio, and text. This is because Legion is powerful enough to slaughter the entirety of lavaland with little effort. LOL
  *
  *It has three attacks.
  *Spawn Skull. Most of the time it will use this attack. Spawns a single legion skull.
  *Spawn Sentinel. The legion will spawn up to three sentinels, depending on its size.
  *CHARGE! The legion starts spinning and tries to melee the player. It will try to flick itself towards the player, dealing some damage if it hits.
  *
  *When Legion dies, it will split into three smaller skulls up to three times.
  *If you kill all of the smaller ones it drops a staff of storms, which allows its wielder to call and disperse ash storms at will and functions as a powerful melee weapon.
  *
  *Difficulty: Medium
  *
  *SHITCODE AHEAD. BE ADVISED. Also comment extravaganza
  */
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz
	name = "Legion"
	health = 800
	maxHealth = 800
	icon_state = "legion"
	icon_living = "legion"
	desc = "One of many."
	icon = 'white/Wzzzz/disneyland/legion.dmi'
	attack_sound = 'sound/magic/demon_attack1.ogg'
	speak_emote = list("echoes")
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	armour_penetration = 50
	melee_damage_lower = 25
	melee_damage_upper = 25
	speed = 2
	ranged = 1
	del_on_death = 1
	retreat_distance = 5
	minimum_distance = 5
	ranged_cooldown_time = 20
	var/size = 5
	var/charging = FALSE
	pixel_y = -90
	pixel_x = -75
	loot = list(/obj/item/stack/sheet/bone = 3)
	vision_range = 13
	wander = FALSE
	elimination = 1
	appearance_flags = 0
	mouse_opacity = MOUSE_OPACITY_ICON

/datum/action/innate/megafauna_attack/create_skull
	name = "Create Legion Skull"
	icon_icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	button_icon_state = "legion_head"
	chosen_message = "<span class='colossus'>You are now creating legion skulls.</span>"
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/charge_target
	name = "Charge Target"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	chosen_message = "<span class='colossus'>You are now charging at your target.</span>"
	chosen_attack_num = 2

/datum/action/innate/megafauna_attack/create_turrets
	name = "Create Sentinels"
	icon_icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	button_icon_state = "legion_turret"
	chosen_message = "<span class='colossus'>You are now creating legion sentinels.</span>"
	chosen_attack_num = 3

/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/OpenFire(the_target)
	if(charging)
		return
	ranged_cooldown = world.time + ranged_cooldown_time

//SKULLS

///Attack proc. Spawns a singular legion skull.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/proc/create_legion_skull()
	var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/A = new(loc)
	A.GiveTarget(target)
	A.friends = friends
	A.faction = faction

//CHARGE

///Attack proc. Gives legion some movespeed buffs and switches the AI to melee. At lower sizes, this also throws the skull at the player.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/proc/charge_target()
	visible_message("<span class='warning'><b>[src] charges!</b></span>")
	SpinAnimation(speed = 20, loops = 3, parallel = FALSE)
	ranged = FALSE
	retreat_distance = 0
	minimum_distance = 0
	set_varspeed(0)
	charging = TRUE
	addtimer(CALLBACK(src, .proc/reset_charge), 60)
	var/mob/living/L = target
	if(!istype(L) || L.stat != DEAD) //I know, weird syntax, but it just works.
		addtimer(CALLBACK(src, .proc/throw_thyself), 20)

///This is the proc that actually does the throwing. Charge only adds a timer for this.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/proc/throw_thyself()
	playsound(src, 'sound/weapons/sonic_jackhammer.ogg', 50, TRUE)
	throw_at(target, 7, 1.1, src, FALSE, FALSE, CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/effects/meteorimpact.ogg', 50 * size, TRUE, 2), INFINITY)

///Deals some extra damage on throw impact.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/throw_impact(mob/living/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(istype(hit_atom))
		playsound(src, attack_sound, 100, TRUE)
		hit_atom.apply_damage(22 * size / 2) //It gets pretty hard to dodge the skulls when there are a lot of them. Scales down with size
		hit_atom.safe_throw_at(get_step(src, get_dir(src, hit_atom)), 2) //Some knockback. Prevent the legion from melee directly after the throw.

///This makes sure that the legion door opens on taking damage, so you can't cheese this boss.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if(GLOB.necropolis_gate && true_spawn)
		GLOB.necropolis_gate.toggle_the_gate(null, TRUE) //very clever.
	return ..()

///In addition to parent functionality, this will also turn the target into a small legion if they are unconcious.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/L = target
		if(L.stat == UNCONSCIOUS)
			var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/A = new(loc)
			A.infest(L)

///Resets the charge buffs.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/proc/reset_charge()
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	set_varspeed(2)
	charging = FALSE

///Special snowflake death() here. Can only die if size is 1 or lower and HP is 0 or below.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/death()
	//Make sure we didn't get cheesed
	if(health > 0)
		return
	if(Split())
		return
	//We check what loot we should drop.
	var/last_legion = TRUE
	for(var/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/other in GLOB.mob_living_list)
		if(other != src)
			last_legion = FALSE
			break
	if(last_legion)
		loot = list(/obj/item/staff/storm)
		elimination = FALSE
	else if(prob(20)) //20% chance for sick lootz.
		loot = list(/obj/structure/closet/crate/necropolis/tendril)
		if(!true_spawn)
			loot = null
	return ..()

///Splits legion into smaller skulls.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/proc/Split()
	size--
	if(size < 1)
		return FALSE
	adjustHealth(-maxHealth) //We heal in preparation of the split
	switch(size) //Yay, switches
		if(3 to INFINITY)
			icon = initial(icon)
			pixel_x = initial(pixel_x)
			pixel_y = initial(pixel_y)
			maxHealth = initial(maxHealth)
		if(2)
			icon = 'icons/mob/lavaland/64x64megafauna.dmi'
			pixel_x = -16
			pixel_y = -8
			maxHealth = 350
		if(1)
			icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
			pixel_x = 0
			pixel_y = 0
			maxHealth = 200
	adjustHealth(0) //Make the health HUD look correct.
	visible_message("<span class='boldannounce'>This is getting out of hands. Now there are three of them!</span>")
	for(var/i in 1 to 2) //Create three skulls in total
		var/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/L = new(loc)
		L.setVarsAfterSplit(src)
	return TRUE

///Sets the variables for new legion skulls. Usually called after splitting.
/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/proc/setVarsAfterSplit(var/mob/living/simple_animal/hostile/megafauna/legionold/wzzzz/L)
	maxHealth = L.maxHealth
	updatehealth()
	size = L.size
	icon = L.icon
	pixel_x = L.pixel_x
	pixel_y = L.pixel_y
	faction = L.faction.Copy()
	GiveTarget(L.target)

//Loot

/obj/item/staff/storm

/mob/living/simple_animal/hostile/megafauna/hierophant/wzzzz
	icon = 'white/Wzzzz/disneyland/hierophant.dmi'
	icon_state = "hierophant"
	icon_living = "hierophant"
