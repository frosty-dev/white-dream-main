/datum/blackmarket_item/melee
	markets = list(/datum/blackmarket_market/blackmarket)
	category = "Ближний бой"

/*
/datum/blackmarket_item/melee/energy/esword
	name = "Случайное энергетическое оружие ближнего боя"
	desc = "При заказе вам будет выдано случайное энергетическое оружие ближнего боя"
	item = /obj/item/melee/transforming/energy/sword

	price_min = 5000
	price_max = 20000
	stock_min = 1
	stock_max = 5
	availability_prob = 100

/datum/blackmarket_item/melee/energy/esword/spawn_item(loc)
	var/esword = pick(list(/obj/item/melee/transforming/energy/sword,
			/obj/item/melee/transforming/energy/sword/saber/red,
			/obj/item/melee/transforming/energy/sword/saber/blue,
			/obj/item/melee/transforming/energy/sword/saber/green,
			/obj/item/melee/transforming/energy/sword/saber/purple,
			/obj/item/melee/transforming/energy/sword/bananium,
			/obj/item/melee/transforming/energy/sword/pirate,
			/obj/item/melee/transforming/energy/blade,
			/obj/item/melee/transforming/energy/blade/hardlight,
			/obj/item/dualsaber))
	return new esword(loc)
*/

/datum/blackmarket_item/melee/psword
	name = "Случайное физическое оружие ближнего боя"
	desc = "При заказе вам будет выдано случайное физичекое оружие ближнего боя. Внимание! Оружие в данном товаре может не оправдать ваши желания"
	item = /obj/item/melee/classic_baton/dildon

	price_min = 1000
	price_max = 15000
	stock_min = 1
	stock_max = 5
	availability_prob = 100

/datum/blackmarket_item/melee/psword/spawn_item(loc)
	var/psword = pick(list(/obj/item/melee/sabre,
			/obj/item/melee/classic_baton,
			/obj/item/melee/classic_baton/telescopic,
			/obj/item/melee/cleric_mace,
			/obj/item/spear/grey_tide,
			/obj/item/spear,
			/obj/item/spear/bonespear,
			/obj/item/melee/baton/boomerang,
			/obj/item/melee/baton/cattleprod,
			/obj/item/melee/baton,
			/obj/item/melee/powerfist,
			/obj/item/sord,
			/obj/item/paxe,
			/obj/item/claymore,
			/obj/item/claymore/highlander,
			/obj/item/katana,
			/obj/item/switchblade,
			/obj/item/mounted_chainsaw,
			/obj/item/tailclub,
			/obj/item/melee/baseball_bat/ablative,
			/obj/item/melee/flyswatter,									//Да
			/obj/item/extendohand,
			/obj/item/gohei,
			/obj/item/vibro_weapon,
			/obj/item/chainsaw))
	return new psword(loc)

/datum/blackmarket_item/melee/hsword
	name = "Случайное священное оружие ближнего боя"
	desc = "При заказе вам будет выдано случайное священное оружие ближнего боя. Да прибудет с вами бог!"
	item = /obj/item/nullrod

	price_min = 5000
	price_max = 10000
	stock_min = 1
	stock_max = 5
	availability_prob = 100

/datum/blackmarket_item/melee/hsword/spawn_item(loc)
	var/hsword = pick(list(/obj/item/nullrod/godhand,
			/obj/item/nullrod/staff,
			/obj/item/nullrod/claymore,
			/obj/item/nullrod/claymore/darkblade,
			/obj/item/nullrod/claymore/chainsaw_sword,
			/obj/item/nullrod/claymore/glowing,
			/obj/item/nullrod/claymore/katana,
			/obj/item/nullrod/claymore/multiverse,
			/obj/item/nullrod/claymore/saber,
			/obj/item/nullrod/claymore/saber/red,
			/obj/item/nullrod/claymore/saber/pirate,
			/obj/item/nullrod/sord,
			/obj/item/nullrod/scythe,
			/obj/item/nullrod/scythe/vibro,
			/obj/item/nullrod/scythe/spellblade,
			/obj/item/nullrod/scythe/talking,
			/obj/item/nullrod/scythe/talking/chainsword,
			/obj/item/nullrod/hammmer,
			/obj/item/nullrod/chainsaw,
			/obj/item/nullrod/clown,
			/obj/item/nullrod/pride_hammer,
			/obj/item/nullrod/whip,
			/obj/item/nullrod/fedora,
			/obj/item/nullrod/armblade,
			/obj/item/nullrod/armblade/tentacle,
			/obj/item/nullrod/carp,
			/obj/item/nullrod/claymore/bostaff,
			/obj/item/nullrod/tribal_knife,
			/obj/item/nullrod/pitchfork,
			/obj/item/nullrod/egyptian,
			/obj/item/nullrod/hypertool,
			/obj/item/nullrod/spear))
	return new hsword(loc)

/datum/blackmarket_item/melee/crusaderpack
	name = "Набор крестоносца"
	desc = "Набор священного воина"
	item = /obj/item/storage/box

	price_min = 1000
	price_max = 5000
	stock_max = 3
	availability_prob = 70

/datum/blackmarket_item/melee/crusaderpack/spawn_item(loc)
	var/obj/item/storage/box/B = ..()
	B.name = "Набор Крестонсца"
	B.desc = "DEUS VULT!"
	new /obj/item/clothing/head/helmet/plate/crusader(B)
	new /obj/item/clothing/suit/armor/plate/crusader(B)
	new /obj/item/paxee(B)
	return B
