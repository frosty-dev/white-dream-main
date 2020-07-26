/obj/item/bodypart/var/should_draw_white = FALSE

/mob/living/carbon/proc/draw_white_parts(undo = FALSE)
	if(!undo)
		for(var/O in bodyparts)
			var/obj/item/bodypart/B = O
			B.should_draw_white = TRUE
	else
		for(var/O in bodyparts)
			var/obj/item/bodypart/B = O
			B.should_draw_white = FALSE

/////////////////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/species/android/athena
	race = /datum/species/android/athena

/datum/species/android/athena
	name = "Athena"
	id = "athena_s"
	limbs_id = null

/datum/species/android/athena/on_species_gain(mob/living/carbon/C)
	. = ..()
	C.draw_white_parts()
	C.update_body()

/////////////////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/species/android/aandroid
	race = /datum/species/android/aandroid

/datum/species/android/aandroid
	name = "Aandroid"
	id = "aandroid"
	limbs_id = null

/datum/species/android/aandroid/on_species_gain(mob/living/carbon/C)
	. = ..()
	C.draw_white_parts()
	C.update_body()

/////////////////////////////////////////////////////////////////////////////////////////
