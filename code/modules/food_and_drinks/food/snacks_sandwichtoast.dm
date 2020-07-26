/obj/item/reagent_containers/food/snacks/sandwich
	name = "sandwich"
	desc = "A grand creation of meat, cheese, bread, and several leaves of lettuce! Arthur Dent would be proud."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "sandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/toastedsandwich
	tastes = list("мясо" = 2, "сыр" = 1, "хлеб" = 2, "салат" = 1)
	foodtype = GRAIN | VEGETABLES
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/toastedsandwich
	name = "toasted sandwich"
	desc = "Now if you only had a pepper bar."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/carbon = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/carbon = 2)
	tastes = list("тост" = 1)
	foodtype = GRAIN
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/grilledcheese
	name = "cheese sandwich"
	desc = "Goes great with Tomato soup!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("тост" = 1, "сыр" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/jellysandwich
	name = "jelly sandwich"
	desc = "You wish you had some peanut butter to go with this..."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellysandwich"
	trash = /obj/item/trash/plate
	bitesize = 3
	tastes = list("хлеб" = 1, "желе" =1)
	foodtype = GRAIN
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/jellysandwich/slime
	bonus_reagents = list(/datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype  = GRAIN | TOXIC

/obj/item/reagent_containers/food/snacks/jellysandwich/cherry
	bonus_reagents = list(/datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/notasandwich
	name = "not-a-sandwich"
	desc = "Something seems to be wrong with this, you can't quite figure what. Maybe it's his moustache."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "notasandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("ничего подозрительного" = 1)
	foodtype = GRAIN | GROSS
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/jelliedtoast
	name = "jellied toast"
	desc = "A slice of toast covered with delicious jam."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellytoast"
	trash = /obj/item/trash/plate
	bitesize = 3
	tastes = list("тост" = 1, "желе" =1)
	foodtype = GRAIN | BREAKFAST
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/jelliedtoast/cherry
	bonus_reagents = list(/datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GRAIN | FRUIT | SUGAR | BREAKFAST

/obj/item/reagent_containers/food/snacks/jelliedtoast/slime
	bonus_reagents = list(/datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GRAIN | TOXIC | SUGAR | BREAKFAST

/obj/item/reagent_containers/food/snacks/butteredtoast
	name = "buttered toast"
	desc = "Butter lightly spread over a piece of toast."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "butteredtoast"
	bitesize = 3
	filling_color = "#FFA500"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("масло" = 1, "тост" = 1)
	foodtype = GRAIN | BREAKFAST
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/twobread
	name = "two bread"
	desc = "This seems awfully bitter."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "twobread"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("хлеб" = 2)
	foodtype = GRAIN
	value = FOOD_JUNK
