/datum/blackmarket_item/food
	category = "Еда"

/datum/blackmarket_item/food/donk_pocket_box
	name = "Коробка Донк-Покетов"
	desc = "Хорошо упакованная коробка с самой любимой закуской любого космонавтика"
	item = /obj/item/storage/box/donkpockets

	stock_min = 1
	stock_max = 10
	price_min = 100
	price_max = 500
	availability_prob = 100

/datum/blackmarket_item/food/donk_pocket_box/spawn_item(loc)
	var/donkpockets = pick(list(/obj/item/storage/box/donkpockets,
			/obj/item/storage/box/donkpockets/donkpocketspicy,
			/obj/item/storage/box/donkpockets/donkpocketteriyaki,
			/obj/item/storage/box/donkpockets/donkpocketpizza,
			/obj/item/storage/box/donkpockets/donkpocketgondola, //Превращает в гондолу
			/obj/item/storage/box/donkpockets/donkpocketberry,
			/obj/item/storage/box/donkpockets/donkpockethonk))
	return new donkpockets(loc)

/datum/blackmarket_item/food/donut
	name = "Коробка с пончиками"
	desc = "Пахнет вкусно!"
	item = /obj/item/storage/fancy/donut_box

	stock_min = 1
	stock_max = 10
	price_min = 100
	price_max = 500
	availability_prob = 100

/datum/blackmarket_item/food/pizza
	name = "Пицца"
	desc =  "Что может быть вкуснее кусочка пиццы?"
	item = /obj/item/reagent_containers/food/snacks/pizza

	stock_min = 1
	stock_max = 20
	price_min = 500
	price_max = 3000
	availability_prob = 100

/datum/blackmarket_item/food/pizza/spawn_item(loc)
	var/pizza = pick(list(/obj/item/reagent_containers/food/snacks/pizza/margherita,
			/obj/item/reagent_containers/food/snacks/pizza/meat,
			/obj/item/reagent_containers/food/snacks/pizza/mushroom,
			/obj/item/reagent_containers/food/snacks/pizza/vegetable,
			/obj/item/reagent_containers/food/snacks/pizza/donkpocket,
			/obj/item/reagent_containers/food/snacks/pizza/dank,
			/obj/item/reagent_containers/food/snacks/pizza/sassysage,
			/obj/item/reagent_containers/food/snacks/pizza/pineapple,
			/obj/item/reagent_containers/food/snacks/pizza/arnold))
	return new pizza(loc)

/datum/blackmarket_item/food/snack
	name = "Закуска"
	desc = "Жрака"
	item = /obj/item/reagent_containers/food/snacks/candy

	stock_min = 10
	stock_max = 50
	price_min = 1
	price_max = 50
	availability_prob = 100

/datum/blackmarket_item/food/snack/spawn_item(loc)
	var/snack = pick(list(/obj/item/reagent_containers/food/snacks/candy/bronx,
			/obj/item/reagent_containers/food/snacks/sosjerky,
			/obj/item/reagent_containers/food/snacks/chips,
			/obj/item/reagent_containers/food/snacks/no_raisin,
			/obj/item/reagent_containers/food/snacks/no_raisin/healthy,
			/obj/item/reagent_containers/food/snacks/spacetwinkie,
			/obj/item/reagent_containers/food/snacks/syndicake,
			/obj/item/reagent_containers/food/snacks/energybar))
	return new snack(loc)
