//Pastry is a food that is made from dough which is made from wheat or rye flour.
//This file contains pastries that don't fit any existing categories.
////////////////////////////////////////////DONUTS////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/donut
	name = "donut"
	desc = "Goes great with robust coffee."
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donut"
	bitesize = 5
	bonus_reagents = list(/datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/sugar = 2)
	filling_color = "#D2691E"
	tastes = list("пончик" = 1)
	foodtype = JUNKFOOD | GRAIN | FRIED | SUGAR | BREAKFAST
	var/decorated_icon = "donut_homer"
	var/is_decorated = FALSE
	var/extra_reagent = null
	var/decorated_adjective = "sprinkled"

/obj/item/reagent_containers/food/snacks/donut/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)
	if(prob(30))
		decorate_donut()

/obj/item/reagent_containers/food/snacks/donut/proc/decorate_donut()
	if(is_decorated || !decorated_icon)
		return
	is_decorated = TRUE
	name = "[decorated_adjective] [name]"
	icon_state = decorated_icon //delish~!
	reagents.add_reagent(/datum/reagent/consumable/sprinkles, 1)
	filling_color = "#FF69B4"
	return TRUE

/// Returns the sprite of the donut while in a donut box
/obj/item/reagent_containers/food/snacks/donut/proc/in_box_sprite()
	return "[icon_state]_inbox"

/obj/item/reagent_containers/food/snacks/donut/checkLiked(fraction, mob/M)	//Sec officers always love donuts
	if(last_check_time + 50 < world.time)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(HAS_TRAIT(H.mind, TRAIT_LAW_ENFORCEMENT_METABOLISM) && !HAS_TRAIT(H, TRAIT_AGEUSIA))
				to_chat(H,"<span class='notice'>Вполне вкусно!</span>")
				H.adjust_disgust(-5 + -2.5 * fraction)
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "fav_food", /datum/mood_event/favorite_food)
				last_check_time = world.time
				return
	..()

/obj/item/reagent_containers/food/snacks/donut/plain
	value = FOOD_JUNK
	//Use this donut ingame

/obj/item/reagent_containers/food/snacks/donut/chaos
	name = "chaos donut"
	desc = "Like life, it never quite tastes the same."
	icon_state = "donut_chaos"
	bitesize = 10
	tastes = list("пончик" = 3, "хаос" = 1)
	is_decorated = TRUE
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/chaos/Initialize()
	. = ..()
	extra_reagent = pick(/datum/reagent/consumable/nutriment, /datum/reagent/consumable/capsaicin, /datum/reagent/consumable/frostoil, /datum/reagent/drug/krokodil, /datum/reagent/toxin/plasma, /datum/reagent/consumable/coco, /datum/reagent/toxin/slimejelly, /datum/reagent/consumable/banana, /datum/reagent/consumable/berryjuice, /datum/reagent/medicine/omnizine)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/food/snacks/donut/meat
	name = "Meat Donut"
	desc = "Tastes as gross as it looks."
	icon_state = "donut_meat"
	bonus_reagents = list(/datum/reagent/consumable/ketchup = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/ketchup = 2)
	tastes = list("мясо" = 1)
	foodtype = JUNKFOOD | MEAT | GROSS | FRIED | BREAKFAST
	is_decorated = TRUE
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/donut/berry
	name = "pink donut"
	desc = "Goes great with a soy latte."
	icon_state = "donut_pink"
	bonus_reagents = list(/datum/reagent/consumable/berryjuice = 3, /datum/reagent/consumable/sprinkles = 1) //Extra sprinkles to reward frosting
	filling_color = "#E57d9A"
	decorated_icon = "donut_homer"
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/donut/trumpet
	name = "spaceman's donut"
	desc = "Goes great with a cold beaker of malk."
	icon_state = "donut_purple"
	bonus_reagents = list(/datum/reagent/medicine/polypyr = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("пончик" = 3, "фиалки" = 1)
	is_decorated = TRUE
	filling_color = "#8739BF"
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/apple
	name = "apple donut"
	desc = "Goes great with a shot of cinnamon schnapps."
	icon_state = "donut_green"
	bonus_reagents = list(/datum/reagent/consumable/applejuice = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("пончик" = 3, "зелёные яблоки" = 1)
	is_decorated = TRUE
	filling_color = "#6ABE30"
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/donut/caramel
	name = "caramel donut"
	desc = "Goes great with a mug of hot coco."
	icon_state = "donut_beige"
	bonus_reagents = list(/datum/reagent/consumable/caramel = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("пончик" = 3, "маслянистая сладость" = 1)
	is_decorated = TRUE
	filling_color = "#D4AD5B"
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/choco
	name = "chocolate donut"
	desc = "Goes great with a glass of warm milk."
	icon_state = "donut_choc"
	bonus_reagents = list(/datum/reagent/consumable/hot_coco = 3, /datum/reagent/consumable/sprinkles = 1) //the coco reagent is just bitter.
	tastes = list("пончик" = 4, "горечь" = 1)
	decorated_icon = "donut_choc_sprinkles"
	filling_color = "#4F230D"
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/donut/blumpkin
	name = "blumpkin donut"
	desc = "Goes great with a mug of soothing drunken blumpkin."
	icon_state = "donut_blue"
	bonus_reagents = list(/datum/reagent/consumable/blumpkinjuice = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("пончик" = 2, "blumpkin" = 1)
	is_decorated = TRUE
	filling_color = "#2788C4"
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/bungo
	name = "bungo donut"
	desc = "Goes great with a mason jar of hippie's delight."
	icon_state = "donut_yellow"
	bonus_reagents = list(/datum/reagent/consumable/bungojuice = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("пончик" = 3, "тропическая сладость" = 1)
	is_decorated = TRUE
	filling_color = "#DEC128"
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/matcha
	name = "matcha donut"
	desc = "Goes great with a cup of tea."
	icon_state = "donut_olive"
	bonus_reagents = list(/datum/reagent/toxin/teapowder = 3, /datum/reagent/consumable/sprinkles = 1)
	tastes = list("пончик" = 3, "matcha" = 1)
	is_decorated = TRUE
	filling_color = "#879630"
	value = FOOD_EXOTIC

//////////////////////JELLY DONUTS/////////////////////////

/obj/item/reagent_containers/food/snacks/donut/jelly
	name = "jelly donut"
	desc = "You jelly?"
	icon_state = "jelly"
	decorated_icon = "jelly_homer"
	bonus_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	extra_reagent = /datum/reagent/consumable/berryjuice
	tastes = list("желе" =1, "пончик" = 3)
	foodtype = JUNKFOOD | GRAIN | FRIED | FRUIT | SUGAR | BREAKFAST

// Jelly donuts don't have holes, but look the same on the outside
/obj/item/reagent_containers/food/snacks/donut/jelly/in_box_sprite()
	return "[replacetext(icon_state, "jelly", "donut")]_inbox"

/obj/item/reagent_containers/food/snacks/donut/jelly/Initialize()
	. = ..()
	if(extra_reagent)
		reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/food/snacks/donut/jelly/plain //use this ingame to avoid inheritance related crafting issues.
	value = FOOD_JUNK

/obj/item/reagent_containers/food/snacks/donut/jelly/berry
	name = "pink jelly donut"
	desc = "Goes great with a soy latte."
	icon_state = "jelly_pink"
	bonus_reagents = list(/datum/reagent/consumable/berryjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //Extra sprinkles to reward frosting.
	filling_color = "#E57d9A"
	decorated_icon = "jelly_homer"
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/donut/jelly/trumpet
	name = "spaceman's jelly donut"
	desc = "Goes great with a cold beaker of malk."
	icon_state = "jelly_purple"
	bonus_reagents = list(/datum/reagent/medicine/polypyr = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "фиалки" = 1)
	is_decorated = TRUE
	filling_color = "#8739BF"
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/donut/jelly/apple
	name = "apple jelly donut"
	desc = "Goes great with a shot of cinnamon schnapps."
	icon_state = "jelly_green"
	bonus_reagents = list(/datum/reagent/consumable/applejuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "зелёные яблоки" = 1)
	is_decorated = TRUE
	filling_color = "#6ABE30"
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/donut/jelly/caramel
	name = "caramel jelly donut"
	desc = "Goes great with a mug of hot coco."
	icon_state = "jelly_beige"
	bonus_reagents = list(/datum/reagent/consumable/caramel = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "маслянистая сладость" = 1)
	is_decorated = TRUE
	filling_color = "#D4AD5B"
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/donut/jelly/choco
	name = "chocolate jelly donut"
	desc = "Goes great with a glass of warm milk."
	icon_state = "jelly_choc"
	bonus_reagents = list(/datum/reagent/consumable/hot_coco = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //the coco reagent is just bitter.
	tastes = list("желе" = 1 , "пончик" = 4, "горечь" = 1)
	decorated_icon = "jelly_choc_sprinkles"
	filling_color = "#4F230D"
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/donut/jelly/blumpkin
	name = "blumpkin jelly donut"
	desc = "Goes great with a mug of soothing drunken blumpkin."
	icon_state = "jelly_blue"
	bonus_reagents = list(/datum/reagent/consumable/blumpkinjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 2, "blumpkin" = 1)
	is_decorated = TRUE
	filling_color = "#2788C4"
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/jelly/bungo
	name = "bungo jelly donut"
	desc = "Goes great with a mason jar of hippie's delight."
	icon_state = "jelly_yellow"
	bonus_reagents = list(/datum/reagent/consumable/bungojuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "тропическая сладость" = 1)
	is_decorated = TRUE
	filling_color = "#DEC128"
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/jelly/matcha
	name = "matcha jelly donut"
	desc = "Goes great with a cup of tea."
	icon_state = "jelly_olive"
	bonus_reagents = list(/datum/reagent/toxin/teapowder = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "matcha" = 1)
	is_decorated = TRUE
	filling_color = "#879630"
	value = FOOD_EXOTIC

//////////////////////////SLIME DONUTS/////////////////////////

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly
	name = "jelly donut"
	desc = "You jelly?"
	icon_state = "jelly"
	extra_reagent = /datum/reagent/toxin/slimejelly
	foodtype = JUNKFOOD | GRAIN | FRIED | TOXIC | SUGAR | BREAKFAST
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/berry
	name = "pink jelly donut"
	desc = "Goes great with a soy latte."
	icon_state = "jelly_pink"
	bonus_reagents = list(/datum/reagent/consumable/berryjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //Extra sprinkles to reward frosting
	filling_color = "#E57d9A"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/trumpet
	name = "spaceman's jelly donut"
	desc = "Goes great with a cold beaker of malk."
	icon_state = "jelly_purple"
	bonus_reagents = list(/datum/reagent/medicine/polypyr = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "фиалки" = 1)
	is_decorated = TRUE
	filling_color = "#8739BF"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/apple
	name = "apple jelly donut"
	desc = "Goes great with a shot of cinnamon schnapps."
	icon_state = "jelly_green"
	bonus_reagents = list(/datum/reagent/consumable/applejuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "зелёный apples" = 1)
	is_decorated = TRUE
	filling_color = "#6ABE30"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/caramel
	name = "caramel jelly donut"
	desc = "Goes great with a mug of hot coco."
	icon_state = "jelly_beige"
	bonus_reagents = list(/datum/reagent/consumable/caramel = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "маслянистая сладость" = 1)
	is_decorated = TRUE
	filling_color = "#D4AD5B"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/choco
	name = "chocolate jelly donut"
	desc = "Goes great with a glass of warm milk."
	icon_state = "jelly_choc"
	bonus_reagents = list(/datum/reagent/consumable/hot_coco = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //the coco reagent is just bitter.
	tastes = list("желе" = 1, "пончик" = 4, "горечь" = 1)
	decorated_icon = "jelly_choc_sprinkles"
	filling_color = "#4F230D"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/blumpkin
	name = "blumpkin jelly donut"
	desc = "Goes great with a mug of soothing drunken blumpkin."
	icon_state = "jelly_blue"
	bonus_reagents = list(/datum/reagent/consumable/blumpkinjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 2, "blumpkin" = 1)
	is_decorated = TRUE
	filling_color = "#2788C4"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/bungo
	name = "bungo jelly donut"
	desc = "Goes great with a mason jar of hippie's delight."
	icon_state = "jelly_yellow"
	bonus_reagents = list(/datum/reagent/consumable/bungojuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "тропическая сладость" = 1)
	is_decorated = TRUE
	filling_color = "#DEC128"

/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/matcha
	name = "matcha jelly donut"
	desc = "Goes great with a cup of tea."
	icon_state = "jelly_olive"
	bonus_reagents = list(/datum/reagent/toxin/teapowder = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("желе" = 1, "пончик" = 3, "matcha" = 1)
	is_decorated = TRUE
	filling_color = "#879630"
////////////////////////////////////////////MUFFINS////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/muffin
	name = "muffin"
	desc = "A delicious and spongy little cake."
	icon_state = "muffin"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#F4A460"
	tastes = list("оладья" = 1)
	foodtype = GRAIN | SUGAR | BREAKFAST
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/muffin/berry
	name = "berry muffin"
	icon_state = "berrymuffin"
	desc = "A delicious and spongy little cake, with berries."
	tastes = list("оладья" = 3, "ягода" = 1)
	foodtype = GRAIN | FRUIT | SUGAR | BREAKFAST
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/muffin/booberry
	name = "booberry muffin"
	icon_state = "berrymuffin"
	alpha = 125
	desc = "My stomach is a graveyard! No living being can quench my bloodthirst!"
	tastes = list("оладья" = 3, "страх" = 1)
	foodtype = GRAIN | FRUIT | SUGAR | BREAKFAST
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/chawanmushi
	name = "chawanmushi"
	desc = "A legendary egg custard that makes friends out of enemies. Probably too hot for a cat to eat."
	icon_state = "chawanmushi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#FFE4E1"
	tastes = list("заварной крем" = 1)
	foodtype = GRAIN | MEAT | VEGETABLES
	value = FOOD_EXOTIC

////////////////////////////////////////////WAFFLES////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/waffles
	name = "waffles"
	desc = "Mmm, waffles."
	icon_state = "waffles"
	trash = /obj/item/trash/waffles
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#D2691E"
	tastes = list("вафли" = 1)
	foodtype = GRAIN | SUGAR | BREAKFAST
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/soylentgreen
	name = "\improper Soylent Green"
	desc = "Not made of people. Honest." //Totally people.
	icon_state = "soylent_green"
	trash = /obj/item/trash/waffles
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#9ACD32"
	tastes = list("вафли" = 7, "люди" = 1)
	foodtype = GRAIN | MEAT
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/soylenviridians
	name = "\improper Soylent Virdians"
	desc = "Not made of people. Honest." //Actually honest for once.
	icon_state = "soylent_yellow"
	trash = /obj/item/trash/waffles
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#9ACD32"
	tastes = list("вафли" = 7, "зелёный цвет" = 1)
	foodtype = GRAIN
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/rofflewaffles
	name = "roffle waffles"
	desc = "Waffles from Roffle. Co."
	icon_state = "rofflewaffles"
	trash = /obj/item/trash/waffles
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/drug/mushroomhallucinogen = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#00BFFF"
	tastes = list("вафля" = 1, "грибы" = 1)
	foodtype = GRAIN | VEGETABLES | SUGAR | BREAKFAST
	value = FOOD_EXOTIC
////////////////////////////////////////////DONK POCKETS////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/donkpocket
	name = "\improper Donk-pocket"
	desc = "The food of choice for the seasoned traitor."
	icon_state = "donkpocket"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm
	filling_color = "#CD853F"
	tastes = list("мясо" = 2, "тесто" = 2, "лень" = 1)
	foodtype = GRAIN
	value = FOOD_JUNK

/obj/item/reagent_containers/food/snacks/donkpocket/warm
	name = "warm Donk-pocket"
	desc = "The heated food of choice for the seasoned traitor."
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 3) //The original donk pocket has the most omnizine, can't beat the original on everything...
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 3)
	cooked_type = null
	tastes = list("мясо" = 2, "тесто" = 2, "лень" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/dankpocket
	name = "\improper Dank-pocket"
	desc = "The food of choice for the seasoned botanist."
	icon_state = "dankpocket"
	list_reagents = list(/datum/reagent/toxin/lipolicide = 3, /datum/reagent/drug/space_drugs = 3, /datum/reagent/consumable/nutriment = 4)
	filling_color = "#00FF00"
	tastes = list("мясо" = 2, "тесто" = 2)
	foodtype = GRAIN | VEGETABLES
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/donkpocket/spicy
	name = "\improper Spicy-pocket"
	desc = "The classic snack food, now with a heat-activated spicy flair."
	icon_state = "donkpocketspicy"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/capsaicin = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/spicy
	filling_color = "#CD853F"
	tastes = list("мясо" = 2, "тесто" = 2, "пряность" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/spicy
	name = "warm Spicy-pocket"
	desc = "The classic snack food, now maybe a bit too spicy."
	icon_state = "donkpocketspicy"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/capsaicin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/capsaicin = 2)
	tastes = list("мясо" = 2, "тесто" = 2, "странные специи" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/teriyaki
	name = "\improper Teriyaki-pocket"
	desc = "An east-asian take on the classic stationside snack."
	icon_state = "donkpocketteriyaki"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/soysauce = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/teriyaki
	filling_color = "#CD853F"
	tastes = list("мясо" = 2, "тесто" = 2, "соевый соус" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/teriyaki
	name = "warm Teriyaki-pocket"
	desc = "An east-asian take on the classic stationside snack, now steamy and warm."
	icon_state = "donkpocketteriyaki"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/soysauce = 2)
	tastes = list("мясо" = 2, "тесто" = 2, "соевый соус" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/pizza
	name = "\improper Pizza-pocket"
	desc = "Delicious, cheesy and surprisingly filling."
	icon_state = "donkpocketpizza"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/tomatojuice = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/pizza
	filling_color = "#CD853F"
	tastes = list("мясо" = 2, "тесто" = 2, "сыр"= 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/pizza
	name = "warm Pizza-pocket"
	desc = "Delicious, cheesy, and even better when hot."
	icon_state = "donkpocketpizza"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/tomatojuice = 2)
	tastes = list("мясо" = 2, "тесто" = 2, "плавленый сыр"= 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/honk
	name = "\improper Honk-pocket"
	desc = "The award-winning donk-pocket that won the hearts of clowns and humans alike."
	icon_state = "donkpocketbanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/banana = 4)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/honk
	filling_color = "#XXXXXX"
	tastes = list("банан" = 2, "тесто" = 2, "детские антибиотики" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/honk
	name = "warm Honk-pocket"
	desc = "The award-winning donk-pocket, now warm and toasty."
	icon_state = "donkpocketbanana"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/laughter = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/banana = 4, /datum/reagent/consumable/laughter = 3)
	tastes = list("тесто" = 2, "детские антибиотики" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/berry
	name = "\improper Berry-pocket"
	desc = "A relentlessly sweet donk-pocket first created for use in Operation Dessert Storm."
	icon_state = "donkpocketberry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/berryjuice = 3)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/berry
	filling_color = "#CD853F"
	tastes = list("тесто" = 2, "джем" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/berry
	name = "warm Berry-pocket"
	desc = "A relentlessly sweet donk-pocket, now warm and delicious."
	icon_state = "donkpocketberry"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/consumable/berryjuice = 3)
	tastes = list("тесто" = 2, "тёплый джем" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/gondola
	name = "\improper Gondola-pocket"
	desc = "The choice to use real gondola meat in the recipe is controversial, to say the least." //Only a monster would craft this.
	icon_state = "donkpocketgondola"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/tranquility = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/donkpocket/warm/gondola
	filling_color = "#CD853F"
	tastes = list("мясо" = 2, "тесто" = 2, "внутренний мир" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/donkpocket/warm/gondola
	name = "warm Gondola-pocket"
	desc = "The choice to use real gondola meat in the recipe is controversial, to say the least."
	icon_state = "donkpocketgondola"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 1, /datum/reagent/tranquility = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/omnizine = 1, /datum/reagent/tranquility = 5)
	tastes = list("мясо" = 2, "тесто" = 2, "внутренний мир" = 1)
	foodtype = GRAIN

////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/cookie
	name = "cookie"
	desc = "COOKIE!!!"
	icon_state = "COOKIE!!!"
	bitesize = 1
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	filling_color = "#F0E68C"
	tastes = list("печенька" = 1)
	foodtype = GRAIN | SUGAR
	value = FOOD_WORTHLESS

/obj/item/reagent_containers/food/snacks/cookie/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/cookie/sleepy
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/chloralhydrate = 10)

/obj/item/reagent_containers/food/snacks/fortunecookie
	name = "fortune cookie"
	desc = "A true prophecy in each cookie!"
	icon_state = "fortune_cookie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	filling_color = "#F4A460"
	tastes = list("печенька" = 1)
	foodtype = GRAIN | SUGAR
	value = FOOD_JUNK

/obj/item/reagent_containers/food/snacks/poppypretzel
	name = "poppy pretzel"
	desc = "It's all twisted up!"
	icon_state = "poppypretzel"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#F0E68C"
	tastes = list("крендель" = 1)
	foodtype = GRAIN | SUGAR
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/plumphelmetbiscuit
	name = "plump helmet biscuit"
	desc = "This is a finely-prepared plump helmet biscuit. The ingredients are exceptionally minced plump helmet, and well-minced dwarven wheat flour."
	icon_state = "phelmbiscuit"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#F0E68C"
	tastes = list("грибы" = 1, "бисквит" = 1)
	foodtype = GRAIN | VEGETABLES
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/plumphelmetbiscuit/Initialize()
	var/fey = prob(10)
	if(fey)
		name = "exceptional plump helmet biscuit"
		desc = "Microwave is taken by a fey mood! It has cooked an exceptional plump helmet biscuit!"
		bonus_reagents = list(/datum/reagent/medicine/omnizine = 5, /datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	. = ..()
	if(fey)
		reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)

/obj/item/reagent_containers/food/snacks/cracker
	name = "cracker"
	desc = "It's a salted cracker."
	icon_state = "cracker"
	bitesize = 1
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	filling_color = "#F0E68C"
	tastes = list("крэкер" = 1)
	foodtype = GRAIN
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/hotdog
	name = "hotdog"
	desc = "Fresh footlong ready to go down on."
	icon_state = "hotdog"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/ketchup = 3, /datum/reagent/consumable/nutriment/vitamin = 3)
	filling_color = "#8B0000"
	tastes = list("булка" = 3, "мясо" = 2)
	foodtype = GRAIN | MEAT | VEGETABLES
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/meatbun
	name = "meat bun"
	desc = "Has the potential to not be Dog."
	icon_state = "meatbun"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#8B0000"
	tastes = list("булка" = 3, "мясо" = 2)
	foodtype = GRAIN | MEAT | VEGETABLES
	value = FOOD_EXOTIC

/obj/item/reagent_containers/food/snacks/khachapuri
	name = "khachapuri"
	desc = "Bread with egg and cheese?"
	icon_state = "khachapuri"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#FFFF4D"
	tastes = list("хлеб" = 1, "яйцо" = 1, "сыр" = 1)
	foodtype = GRAIN | MEAT | DAIRY
	value = FOOD_RARE


/obj/item/reagent_containers/food/snacks/sugarcookie
	name = "sugar cookie"
	desc = "Just like your little sister used to make."
	icon_state = "sugarcookie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)
	filling_color = "#CD853F"
	tastes = list("сладость" = 1)
	foodtype = GRAIN | JUNKFOOD | SUGAR
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/sugarcookie/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/chococornet
	name = "chocolate cornet"
	desc = "Which side's the head, the fat end or the thin end?"
	icon_state = "chococornet"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#FFE4C4"
	tastes = list("бисквит" = 3, "шоколад" = 1)
	foodtype = GRAIN | JUNKFOOD
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/oatmealcookie
	name = "oatmeal cookie"
	desc = "The best of both cookie and oat."
	icon_state = "oatmealcookie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#D2691E"
	tastes = list("печенька" = 2, "овсянка" = 1)
	foodtype = GRAIN
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/oatmealcookie/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/raisincookie
	name = "raisin cookie"
	desc = "Why would you put raisins on a cookie?"
	icon_state = "raisincookie"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#F0E68C"
	tastes = list("печентка" = 1, "причины" = 1)
	foodtype = GRAIN | FRUIT
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/raisincookie/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/cherrycupcake
	name = "cherry cupcake"
	desc = "A sweet cupcake with cherry bits."
	icon_state = "cherrycupcake"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#F0E68C"
	tastes = list("торт" = 3, "вишня" = 1)
	foodtype = GRAIN | FRUIT | SUGAR
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/bluecherrycupcake
	name = "синий cherry cupcake"
	desc = "Blue cherries inside a delicious cupcake."
	icon_state = "bluecherrycupcake"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#F0E68C"
	tastes = list("торт" = 3, "синяя вишня" = 1)
	foodtype = GRAIN | FRUIT | SUGAR
	value = FOOD_RARE

/obj/item/reagent_containers/food/snacks/honeybun
	name = "honey bun"
	desc = "A sticky pastry bun glazed with honey."
	icon_state = "honeybun"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/honey = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/honey = 5)
	filling_color = "#F2CE91"
	tastes = list("кондитерские изделия" = 1, "сладость" = 1)
	foodtype = GRAIN | SUGAR
	value = FOOD_RARE

#define PANCAKE_MAX_STACK 10

/obj/item/reagent_containers/food/snacks/pancakes
	name = "pancake"
	desc = "A fluffy pancake. The softer, superior relative of the waffle."
	icon_state = "pancakes_1"
	inhand_icon_state = "pancakes"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#D2691E"
	tastes = list("блинчики" = 1)
	foodtype = GRAIN | SUGAR | BREAKFAST
	value = FOOD_FAST

/obj/item/reagent_containers/food/snacks/pancakes/blueberry
	name = "blueberry pancake"
	desc = "A fluffy and delicious blueberry pancake."
	icon_state = "bbpancakes_1"
	inhand_icon_state = "bbpancakes"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("блинчики" = 1, "черника" = 1)

/obj/item/reagent_containers/food/snacks/pancakes/chocolatechip
	name = "chocolate chip pancake"
	desc = "A fluffy and delicious chocolate chip pancake."
	icon_state = "ccpancakes_1"
	inhand_icon_state = "ccpancakes"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("блинчики" = 1, "шоколад" = 1)

/obj/item/reagent_containers/food/snacks/pancakes/Initialize()
	. = ..()
	update_icon()

/obj/item/reagent_containers/food/snacks/pancakes/update_icon()
	if(contents.len)
		name = "stack of pancakes"
	else
		name = initial(name)
	if(contents.len < LAZYLEN(overlays))
		overlays-=overlays[overlays.len]

/obj/item/reagent_containers/food/snacks/pancakes/examine(mob/user)
	var/ingredients_listed = ""
	var/pancakeCount = contents.len
	switch(pancakeCount)
		if(0)
			desc = initial(desc)
		if(1 to 2)
			desc = "A stack of fluffy pancakes."
		if(3 to 6)
			desc = "A fat stack of fluffy pancakes!"
		if(7 to 9)
			desc = "A grand tower of fluffy, delicious pancakes!"
		if(PANCAKE_MAX_STACK to INFINITY)
			desc = "A massive towering spire of fluffy, delicious pancakes. It looks like it could tumble over!"
	var/originalBites = bitecount
	if (pancakeCount)
		var/obj/item/reagent_containers/food/snacks/S = contents[pancakeCount]
		bitecount = S.bitecount
	. = ..()
	if (pancakeCount)
		for(var/obj/item/reagent_containers/food/snacks/pancakes/ING in contents)
			ingredients_listed += "[ING.name], "
		. += "It contains [contents.len?"[ingredients_listed]":"no ingredient, "]on top of a [initial(name)]."
	bitecount = originalBites

/obj/item/reagent_containers/food/snacks/pancakes/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks/pancakes/))
		var/obj/item/reagent_containers/food/snacks/pancakes/P = I
		if((contents.len >= PANCAKE_MAX_STACK) || ((P.contents.len + contents.len) > PANCAKE_MAX_STACK) || (reagents.total_volume >= volume))
			to_chat(user, "<span class='warning'>You can't add that many pancakes to [src]!</span>")
		else
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, "<span class='notice'>You add the [I] to the [name].</span>")
			P.name = initial(P.name)
			contents += P
			update_snack_overlays(P)
			if (P.contents.len)
				for(var/V in P.contents)
					P = V
					P.name = initial(P.name)
					contents += P
					update_snack_overlays(P)
			P = I
			P.contents.Cut()
		return
	else if(contents.len)
		var/obj/O = contents[contents.len]
		return O.attackby(I, user, params)
	..()

/obj/item/reagent_containers/food/snacks/pancakes/update_snack_overlays(obj/item/reagent_containers/food/snacks/P)
	var/mutable_appearance/pancake = mutable_appearance(icon, "[P.inhand_icon_state]_[rand(1,3)]")
	pancake.pixel_x = rand(-1,1)
	pancake.pixel_y = 3 * contents.len - 1
	add_overlay(pancake)
	update_icon()

/obj/item/reagent_containers/food/snacks/pancakes/attack(mob/M, mob/user, def_zone, stacked = TRUE)
	if(user.a_intent == INTENT_HARM || !contents.len || !stacked)
		return ..()
	var/obj/item/O = contents[contents.len]
	. = O.attack(M, user, def_zone, FALSE)
	update_icon()

#undef PANCAKE_MAX_STACK

/obj/item/reagent_containers/food/snacks/cannoli
	name = "cannoli"
	desc = "A sicilian treat that makes you into a wise guy."
	icon_state = "cannoli"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#ffffff"
	tastes = list("кондитерские изделия" = 1)
	foodtype = GRAIN | DAIRY | SUGAR
