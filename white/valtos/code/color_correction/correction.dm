/datum/client_colour/correction
	colour = list(rgb(255,15,15), rgb(-35,225,-15), rgb(-15,-15,255), rgb(0,0,0))
	priority = 5

/mob/living/Initialize()
	. = ..()
	overlay_fullscreen("noise", /obj/screen/fullscreen/noisescreen)
	add_client_colour(/datum/client_colour/correction)
