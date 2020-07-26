
//COPY-PASTE MASTA

/turf/open/floor/plating/partyhard/cave
	var/length = 100
	var/list/mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goldgrub = 1, /mob/living/simple_animal/hostile/asteroid/goliath = 5, /mob/living/simple_animal/hostile/asteroid/basilisk = 4, /mob/living/simple_animal/hostile/asteroid/hivelord = 3)
	var/list/flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2)
	var/list/terrain_spawn_list = list(/obj/structure/geyser/random = 1)
	var/sanity = 1
	var/forward_cave_dir = 1
	var/backward_cave_dir = 2
	var/going_backwards = TRUE
	var/has_data = FALSE
	var/data_having_type = /turf/open/floor/plating/partyhard/cave/has_data
	var/turf_type = /turf/open/floor/plating/partyhard/cave

/turf/open/floor/plating/partyhard/cave/has_data
	has_data = TRUE

/turf/open/floor/plating/partyhard/cave/Initialize()
	. = ..()
	if(!has_data)
		produce_tunnel_from_data()

/turf/open/floor/plating/partyhard/cave/proc/get_cave_data(set_length, exclude_dir = -1)
	// If set_length (arg1) isn't defined, get a random length; otherwise assign our length to the length arg.
	if(!set_length)
		length = rand(25, 50)
	else
		length = set_length

	// Get our directiosn
	forward_cave_dir = pick(GLOB.alldirs - exclude_dir)
	// Get the opposite direction of our facing direction
	backward_cave_dir = angle2dir(dir2angle(forward_cave_dir) + 180)

/turf/open/floor/plating/partyhard/cave/proc/produce_tunnel_from_data(tunnel_length, excluded_dir = -1)
	get_cave_data(tunnel_length, excluded_dir)
	// Make our tunnels
	make_tunnel(forward_cave_dir)
	if(going_backwards)
		make_tunnel(backward_cave_dir)
	// Kill ourselves by replacing ourselves with a normal floor.
	SpawnFloor(src)

/turf/open/floor/plating/partyhard/cave/proc/make_tunnel(dir)
	var/turf/closed/mineral/tunnel = src
	var/next_angle = pick(45, -45)

	for(var/i = 0; i < length; i++)
		if(!sanity)
			break

		var/list/L = list(45)
		if(ISODD(dir2angle(dir))) // We're going at an angle and we want thick angled tunnels.
			L += -45

		// Expand the edges of our tunnel
		for(var/edge_angle in L)
			var/turf/closed/mineral/edge = get_step(tunnel, angle2dir(dir2angle(dir) + edge_angle))
			if(istype(edge))
				SpawnFloor(edge)

		if(!sanity)
			break

		// Move our tunnel forward
		tunnel = get_step(tunnel, dir)

		if(istype(tunnel))
			// Small chance to have forks in our tunnel; otherwise dig our tunnel.
			if(i > 3 && prob(20))
				if(!istype(tunnel.loc, /area/partyhard/outdoors/unexplored))
					sanity = 0
					break
				var/turf/open/floor/plating/partyhard/cave/C = tunnel.ChangeTurf(data_having_type, null, CHANGETURF_IGNORE_AIR)
				C.going_backwards = FALSE
				C.produce_tunnel_from_data(rand(10, 15), dir)
			else
				SpawnFloor(tunnel)
		else //if(!istype(tunnel, parent)) // We hit space/normal/wall, stop our tunnel.
			break

		// Chance to change our direction left or right.
		if(i > 2 && prob(33))
			// We can't go a full loop though
			next_angle = -next_angle
			setDir(angle2dir(dir2angle(dir) )+ next_angle)

/turf/open/floor/plating/partyhard/cave/proc/SpawnFloor(turf/T)
	for(var/S in RANGE_TURFS(1, src))
		var/turf/NT = S
		if(!NT || isspaceturf(NT) || !istype(NT.loc, /area/partyhard/outdoors/unexplored))
			sanity = 0
			break
	if(!sanity)
		return
	SpawnFlora(T)
	// SpawnTerrain(T)
	SpawnMonster(T)
	T.ChangeTurf(turf_type, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/partyhard/cave/proc/SpawnMonster(turf/T)
	if(prob(30))
		if(!istype(loc, /area/partyhard/outdoors/unexplored))
			return
		var/randumb = pickweight(mob_spawn_list)
		while(randumb == 6)
			randumb = pickweight(mob_spawn_list)

		for(var/mob/living/simple_animal/hostile/H in urange(12,T)) //prevents mob clumps
			if(ispath(randumb, /mob/living/simple_animal/hostile/asteroid) || istype(H, /mob/living/simple_animal/hostile/asteroid))
				return //if the random is a standard mob, avoid spawning if there's another one within 12 tiles

		new randumb(T)
	return

/turf/open/floor/plating/partyhard/cave/proc/SpawnFlora(turf/T)
	if(prob(12))
		if(!istype(loc, /area/partyhard/outdoors/unexplored))
			return
		var/randumb = pickweight(flora_spawn_list)
		for(var/obj/structure/flora/ash/F in range(4, T)) //Allows for growing patches, but not ridiculous stacks of flora
			if(!istype(F, randumb))
				return
		new randumb(T)

/turf/open/floor/plating/partyhard/cave/proc/SpawnTerrain(turf/T)
	if(prob(2))
		if(!istype(loc, /area/partyhard/outdoors/unexplored))
			return
		var/randumb = pickweight(terrain_spawn_list)
		for(var/obj/structure/geyser/F in range(7, T))
			if(istype(F, randumb))
				return
		new randumb(T)
