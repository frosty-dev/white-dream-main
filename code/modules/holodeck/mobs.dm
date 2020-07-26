/*
	Mobs
*/

/mob/living/simple_animal/holodeck_monkey
	name = "обезьяна"
	desc = "Голографическое создание, любящее бананы."
	icon = 'icons/mob/monkey.dmi'
	icon_state = "monkey1"
	icon_living = "monkey1"
	icon_dead = "monkey1_dead"
	speak_emote = list("chimpers")
	emote_hear = list("chimpers.")
	emote_see = list("scratches.", "looks around.")
	speak_chance = 1
	turns_per_move = 2
	butcher_results = list()
	response_help_continuous = "гладит"
	response_help_simple = "гладит"
	response_disarm_continuous = "отталкивает"
	response_disarm_simple = "отталкивает"
	response_harm_continuous = "пинает"
	response_harm_simple = "пинает"
