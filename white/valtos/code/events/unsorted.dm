/datum/round_event_control/syndicate_assault
	name = "Syndicate Assault"
	typepath = /datum/round_event/syndicate_assault
	weight = 15
	max_occurrences = 1
	min_players = 5

/datum/round_event/syndicate_assault
	announceWhen	= 400

	var/spawncount = 1


/datum/round_event/syndicate_assault/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
	spawncount = rand(5, 8)

/datum/round_event/syndicate_assault/announce(fake)
	priority_announce("Синдикат решил ограбить [station_name()]. Нам не удалось задержать их осадную флотилию. Держитесь.", "Вторжение на борт", 'sound/ai/announcer/assault.ogg')


/datum/round_event/syndicate_assault/start()
	var/list/spawners = list()
	for(var/obj/machinery/door/airlock/external/arlock in GLOB.airlocks)
		if(QDELETED(arlock))
			continue
		if(is_station_level(arlock.loc.z))
			spawners += arlock

	while((spawncount >= 1) && spawners.len)
		var/obj/spawner_dot = pick(spawners)
		var/spawn_type = /mob/living/simple_animal/hostile/syndicate/ranged/space
		if(prob(66))
			spawn_type = /mob/living/simple_animal/hostile/syndicate/ranged/shotgun/space
		announce_to_ghosts(spawn_atom_to_turf(spawn_type, spawner_dot, 1, FALSE))
		spawners -= spawner_dot
		spawncount--
