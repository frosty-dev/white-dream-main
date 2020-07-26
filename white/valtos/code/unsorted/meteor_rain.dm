//Meteors probability of spawning during a given wave
GLOBAL_LIST_INIT(meteors_rain_normal, list(/obj/effect/meteor_rain/medium=3, /obj/effect/meteor_rain=8, /obj/effect/meteor_rain/big=3))

GLOBAL_LIST_INIT(meteors_rain_threatening, list(/obj/effect/meteor_rain/medium=4, /obj/effect/meteor_rain/big=8))

GLOBAL_LIST_INIT(meteors_rain_catastrophic, list(/obj/effect/meteor_rain/medium=5, /obj/effect/meteor_rain/big=75, /obj/effect/meteor_rain/tunguska = 1))

/datum/round_event_control/meteor_rain
	name = "Meteor Rain: Normal"
	typepath = /datum/round_event/meteor_rain
	weight = 16
	min_players = 5
	max_occurrences = 12
	earliest_start = 25 MINUTES

/datum/round_event_control/meteor_rain/threatening
	name = "Meteor Rain: Threatening"
	typepath = /datum/round_event/meteor_rain/threatening
	weight = 20
	min_players = 5
	max_occurrences = 6
	earliest_start = 35 MINUTES

/datum/round_event/meteor_rain/threatening
	rain_name = "threatening"

/datum/round_event_control/meteor_rain/catastrophic
	name = "Meteor Rain: Catastrophic"
	typepath = /datum/round_event/meteor_rain/catastrophic
	weight = 18
	min_players = 5
	max_occurrences = 6
	earliest_start = 45 MINUTES

/datum/round_event/meteor_rain/catastrophic
	rain_name = "catastrophic"


/datum/round_event/meteor_rain
	startWhen		= 6
	endWhen			= 66
	announceWhen	= 1
	var/list/rain_type
	var/rain_name = "normal"

/datum/round_event/meteor_rain/New()
	..()
	if(!rain_type)
		determine_rain_type()

/datum/round_event/meteor_rain/proc/determine_rain_type()
	if(!rain_name)
		rain_name = pickweight(list(
			"normal" = 50,
			"threatening" = 40,
			"catastrophic" = 10))
	switch(rain_name)
		if("normal")
			rain_type = GLOB.meteors_rain_normal
		if("threatening")
			rain_type = GLOB.meteors_rain_threatening
		if("catastrophic")
			rain_type = GLOB.meteors_rain_catastrophic
		else
			WARNING("rain name of [rain_name] not recognised.")
			kill()

/datum/round_event/meteor_rain/announce(fake)
	priority_announce("Метеоритный дождь был обнаружен на пути столкновения со станцией.", "Метеоритная тревога", 'sound/ai/meteors.ogg')

/datum/round_event/meteor_rain/tick()
	if(ISMULTIPLE(activeFor, 3))
		spawn_meteors_rain(5, rain_type)

/proc/spawn_meteors_rain(number = 10, list/meteortypes)
	for(var/i = 0; i < number; i++)
		spawn_meteor_rain(meteortypes)

/proc/spawn_meteor_rain(list/meteortypes)
	var/turf/T = locate(rand(1, 255), rand(1, 255), 5)
	var/Me = pickweight(meteortypes)
	new Me(T)

/obj/effect/meteor_rain
	name = "метеор"
	desc = "А че я смотрю на это..."
	icon = 'icons/obj/meteor.dmi'
	icon_state = "small"
	density = TRUE
	anchored = TRUE
	var/hit_power = 1

/obj/effect/meteor_rain/Initialize()
	. = ..()
	SSaugury.register_doom(src, hit_power)
	SpinAnimation()
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/openspace))
		z--
	spawn(rand(2, 5))
		explosion(src.loc, hit_power, hit_power * 1.5, hit_power * 2, hit_power * 3, 0)
		qdel(src)

/obj/effect/meteor_rain/medium
	name = "метеор"
	hit_power = 2

/obj/effect/meteor_rain/big
	name = "большой метеор"
	icon_state = "large"
	hit_power = 3

/obj/effect/meteor_rain/tunguska
	name = "тунгуска"
	icon_state = "flaming"
	hit_power = 5
