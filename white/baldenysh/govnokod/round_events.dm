/datum/round_event_control/stationvania
	name = "Stationvania"
	typepath = /datum/round_event/stationvania
	weight = 5

	min_players = 10
	max_occurrences = 1

/datum/round_event/stationvania
	announceWhen	= 21
	endWhen			= 1000
	var/list/obj/structure/sign/painting/paintings = list()
	var/mob/living/simple_animal/hostile/mimic/copy/paintingsAlive = list()

/datum/round_event/stationvania/announce(fake)
	priority_announce(scramble_message_replace_chars("[station_name()] входит в зону повышенной активности аномалии 4N1-M3.", 50), \
		 "Произошло 4N1-M3", 'sound/ai/announcer/artificial.ogg')

/datum/round_event/stationvania/start()
	for(var/obj/structure/sign/painting/P in world)
		if(!is_station_level(P.z))
			continue
		paintings.Add(P)
		if(prob(70))
			paintingsAlive.Add(P.animate_painting())

/datum/round_event/stationvania/tick()
	//запелить чета
