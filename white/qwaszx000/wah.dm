/datum/crafting_recipe/food/wah_soup
	name = "Imperium soup"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/food/grown/tomato = 1,
		/obj/item/food/grown/potato = 1,
		/datum/reagent/water = 20,
		/datum/reagent/consumable/sodiumchloride = 10,
		/datum/reagent/consumable/blackpepper = 10
	)
	result = /obj/item/food/soup/Imperium
	subcategory = CAT_SOUP

/obj/item/food/soup/Imperium
	name = "Imperium soup"
	desc = "FOR IMPERIUM!"
	icon_state = "wishsoup"
	list_reagents = list("water" = 20, "vitamin" = 20, "nutriment" = 50, "omnizine" = 15, "ephedrine" = 25, "morphine" = 30)
