/datum/blackmarket_item/weapon
	markets = list(/datum/blackmarket_market/blackmarket)
	category = "Оружие"

/datum/blackmarket_item/weapon/pgun
	name = "Случайное баллистическое оружие"
	desc = "Пукает хорошо а стоимость ещё дороже"
	item = /obj/item/gun/ballistic/

	price_min = 1000
	price_max = 10000
	stock_min = 1
	stock_max = 10
	availability_prob = 100

/datum/blackmarket_item/weapon/pgun/spawn_item(loc)
	var/pgun = pick(list(/obj/item/gun/ballistic/automatic/ar/wzzzz,
			/obj/item/gun/ballistic/automatic/wzzzz/g43,
			/obj/item/gun/ballistic/automatic/m90/unrestricted/wzzzz/z8,
			/obj/item/gun/ballistic/automatic/surplus,
			/obj/item/gun/ballistic/shotgun/riot,
			/obj/item/gun/ballistic/automatic/pistol/makarov,
			/obj/item/gun/ballistic/rifle/boltaction,
			/obj/item/gun/ballistic/shotgun/doublebarrel,
			/obj/item/gun/ballistic/shotgun/sc_pump,
			/obj/item/gun/ballistic/revolver/mateba,
			/obj/item/gun/ballistic/automatic/pistol/traumatic,
			/obj/item/gun/ballistic/automatic/wzzzz/carbine,
			/obj/item/gun/ballistic/automatic/wzzzz/stg,
			/obj/item/gun/ballistic/automatic/M41A,
			/obj/item/gun/ballistic/automatic/pistol/deagle,
			/obj/item/gun/ballistic/automatic/pistol/deagle/gold,
			/obj/item/gun/ballistic/automatic/ar,
			/obj/item/gun/ballistic/automatic/wt550,
			/obj/item/gun/ballistic/automatic/wzzzz/assault_rifle,
			/obj/item/gun/ballistic/automatic/pistol/wzzzz/mauser,
			/obj/item/gun/ballistic/automatic/pistol/m1911,
			/obj/item/gun/ballistic/automatic/wzzzz/mp40,
			/obj/item/gun/ballistic/automatic/ar/wzzzz/fg42,
			/obj/item/gun/ballistic/automatic/pistol/wzzzz/luger))
	return new pgun(loc)


/datum/blackmarket_item/weapon/egun
	name = "Случайное энергетическое оружие"
	desc = "Пукает хорошо а стоимость ещё дороже"
	item = /obj/item/gun/energy/

	price_min = 1000
	price_max = 10000
	stock_min = 1
	stock_max = 10
	availability_prob = 100

/datum/blackmarket_item/weapon/egun/spawn_item(loc)
	var/egun = pick(list(/obj/item/gun/energy/e_gun,
			/obj/item/gun/energy/e_gun/mini,
			/obj/item/gun/energy/e_gun/stun,
			/obj/item/gun/energy/e_gun/old,
			/obj/item/gun/energy/e_gun/nuclear,
			/obj/item/gun/energy/laser,
			/obj/item/gun/energy/laser/retro,
			/obj/item/gun/energy/laser/retro/old,
			/obj/item/gun/energy/laser/scatter,
			/obj/item/gun/energy/laser/scatter/shotty,
			/obj/item/gun/energy/xray,
			/obj/item/gun/energy/tesla_revolver,
			/obj/item/gun/energy/kinetic_accelerator/crossbow,
			/obj/item/gun/energy/kinetic_accelerator/crossbow/large))
	return new egun(loc)

/datum/blackmarket_item/weapon/tgun
	name = "Случайное Тазер/Дизаблер"
	desc = "Тазер или Дизаблер? Сложный выбор..."
	item = /obj/item/gun/energy/taser

	price_min = 500
	price_max = 2000
	stock_min = 1
	stock_max = 10
	availability_prob = 100

/datum/blackmarket_item/weapon/tgun/spawn_item(loc)
	var/tgun = pick(list(/obj/item/gun/energy/taser,
			/obj/item/gun/energy/e_gun/advtaser,
			/obj/item/gun/energy/disabler))
	return new tgun(loc)


