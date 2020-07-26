/datum/reagent/consumable/ethanol/boyarka
	name = "Boyarka"
	description = "Boyarka"
	color = "#880000"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 75
	taste_description = "вишня и Россия"
	glass_name = "glass of boyar"
	glass_desc = "Glass of berry alcohol. "

/datum/reagent/consumable/ethanol/boyarka/on_mob_life(mob/living/M)
	M.reagents.add_reagent(get_random_reagent_id(),1)
	M.reagents.add_reagent(/datum/reagent/toxin/rotatium,1)
	..()

/datum/reagent/consumable/ethanol/boyarka/traitor
	boozepwr = 80

/datum/reagent/consumable/ethanol/boyarka/traitor/on_mob_life(mob/living/M)
	M.reagents.add_reagent(get_random_reagent_id(),10)
	M.reagents.add_reagent(/datum/reagent/toxin/rotatium,2)
	spawn(0)
		new /datum/hallucination/delusion(M, TRUE, "demon",600,0)
	to_chat(M, "<span class='warning'>KILL THEM ALL</span>")

/obj/item/reagent_containers/pill/boyar_t
	name = "true boyar pill"
	desc = "TRUE BOYAR."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/consumable/ethanol/boyarka/traitor = 50)
	//roundstart = 1

/datum/uplink_item/stealthy_weapons/boyar_t_pill
	name = "True boyar pill"
	desc = "Oh no! Its TRUE boyar pill!!!"
	item = /obj/item/reagent_containers/pill/boyar_t
	cost = 2

/datum/chemical_reaction/boyar
	results = list(/datum/reagent/consumable/ethanol/boyarka = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 10, /datum/reagent/consumable/berryjuice = 1)

/obj/item/reagent_containers/food/drinks/boyarka
	name = "Boyarka"
	desc = "Твой новый лучший друг"
	icon = 'white/hule/icons/obj/boyarka.dmi'
	icon_state = "boyarka"
	list_reagents = list(/datum/reagent/consumable/ethanol/boyarka = 30)
	foodtype = ALCOHOL | FRUIT
