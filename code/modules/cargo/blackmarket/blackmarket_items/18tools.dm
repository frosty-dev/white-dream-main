/datum/blackmarket_item/tool
	markets = list(/datum/blackmarket_market/blackmarket)
	category = "Инструменты"

/datum/blackmarket_item/tool/caravan_wrench
	name = "Экспериментальный гаечный ключ"
	desc = "Очень быстрый и удобный гаечный ключ"
	item = /obj/item/wrench/caravan
	stock = 1

	price_min = 400
	price_max = 800
	availability_prob = 100

/datum/blackmarket_item/tool/caravan_wirecutters
	name = "Экспериментальные кусачки"
	desc = "Очень быстрые и удобные кусачки"
	item = /obj/item/wirecutters/caravan
	stock = 1

	price_min = 400
	price_max = 800
	availability_prob = 100

/datum/blackmarket_item/tool/caravan_screwdriver
	name = "Экспериментальная отвёртка"
	desc = "Очень быстрая и удобная отвёртка"
	item = /obj/item/screwdriver/caravan
	stock = 1

	price_min = 400
	price_max = 800
	availability_prob = 100

/datum/blackmarket_item/tool/caravan_crowbar
	name = "Экспериментальный ломик"
	desc = "Очень быстрый и удобный ломик"
	item = /obj/item/crowbar/red/caravan
	stock = 1

	price_min = 400
	price_max = 800
	availability_prob = 100

/datum/blackmarket_item/tool/brped
	name = "РПЕД с деталями"
	desc = "РПЕД содержащий передовые запчасти для машин"
	item = /obj/item/storage/part_replacer/bluespace/tier3

	price_min = 5000
	price_max = 15000
	stock_min = 1
	stock_max = 10
	availability_prob = 100

/datum/blackmarket_item/tool/brped/spawn_item(loc)
	var/rped = pick(list(/obj/item/storage/part_replacer/bluespace/tier3,
			/obj/item/storage/part_replacer/bluespace/tier4))
	return new rped(loc)

/datum/blackmarket_item/tool/toolbox
	name = "Случайный Тулбокс"
	desc = "Может содержать синдикатовский тулбокс"
	item = /obj/item/storage/toolbox

	price_min = 100
	price_max = 1000
	stock_min = 1
	stock_max = 25
	availability_prob = 100

/datum/blackmarket_item/tool/toolbox/spawn_item(loc)
	var/toolbox = pick(list(/obj/item/storage/toolbox/emergency,
			/obj/item/storage/toolbox/emergency/old,
			/obj/item/storage/toolbox/mechanical,
			/obj/item/storage/toolbox/mechanical/old,
			/obj/item/storage/toolbox/mechanical/old/clean,
			/obj/item/storage/toolbox/electrical,
			/obj/item/storage/toolbox/syndicate))
	return new toolbox(loc)


/datum/blackmarket_item/tool/thermite_bottle
	name = "Бутылочка с термитом"
	desc = "Дыроёб"
	item = /obj/item/reagent_containers/glass/bottle/thermite

	price_min = 500
	price_max = 1500
	stock_max = 3
	availability_prob = 30
