/datum/reagent/toxin/hohlomicin
	name = "Hohlomicin"
	description = "Pizdec"
	color = "#00FF00"
	toxpwr = 0
	taste_description = "сало"
	metabolization_rate = 0.05 * REAGENTS_METABOLISM

/datum/reagent/toxin/hohlomicin/on_mob_life(mob/living/L)
	..()
	if(current_cycle == 100)
		ADD_TRAIT(L, TRAIT_UKRAINISH, type)
		playsound(L,'white/baldenysh/sounds/cs/holyshit.wav', 100, 5, pressure_affected = FALSE)

/datum/reagent/medicine/aspirin
	name = "Aspirin"
	description = "Увеличивает скорость метаболизма, сопротивляемость температурам и скорость кровотечения."
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/medicine/aspirin/on_mob_add(mob/living/M)
	..()
	M.metabolism_efficiency *= 1.6
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.physiology.bleed_mod *= 2
		H.physiology.heat_mod *= 0.5

/datum/reagent/medicine/aspirin/on_mob_end_metabolize(mob/living/M)
	..()
	M.metabolism_efficiency *= 0.625
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.physiology.bleed_mod *= 0.5
		H.physiology.heat_mod *= 2



