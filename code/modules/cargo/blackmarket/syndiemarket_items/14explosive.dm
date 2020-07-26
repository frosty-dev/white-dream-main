/datum/blackmarket_item/sexplosive //sex
	markets = list(/datum/blackmarket_market/syndiemarket)
	category = "Ближний бой"

/datum/blackmarket_item/sexplosive/c4
	name = "Composition C-4"
	desc = "C-4 is plastic explosive of the common variety Composition C. You can use it to breach walls, sabotage equipment, or connect \
			an assembly to it in order to alter the way it detonates. It can be attached to almost all objects and has a modifiable timer with a \
			minimum setting of 10 seconds."
	item = /obj/item/grenade/c4

	price_min = 5000
	price_max = 10000
	stock_min = 1
	stock_max = 10
	availability_prob = 25

/datum/blackmarket_item/sexplosive/c4bag
	name = "Bag of C-4 explosives"
	desc = "Because sometimes quantity is quality. Contains 10 C-4 plastic explosives."
	item = /obj/item/storage/backpack/duffelbag/syndie/c4

	price_min = 50000
	price_max = 100000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/x4bag
	name = "Bag of X-4 explosives"
	desc = "Contains 3 X-4 shaped plastic explosives. Similar to C4, but with a stronger blast that is directional instead of circular. \
			X-4 can be placed on a solid surface, such as a wall or window, and it will blast through the wall, injuring anything on the opposite side, while being safer to the user. \
			For when you want a controlled explosion that leaves a wider, deeper, hole."
	item = /obj/item/storage/backpack/duffelbag/syndie/x4

	price_min = 100000
	price_max = 1000000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/clown_bomb_clownops
	name = "Clown Bomb"
	desc = "The Clown bomb is a hilarious device capable of massive pranks. It has an adjustable timer, \
			with a minimum of 60 seconds, and can be bolted to the floor with a wrench to prevent \
			movement. The bomb is bulky and cannot be moved; upon ordering this item, a smaller beacon will be \
			transported to you that will teleport the actual bomb to it upon activation. Note that this bomb can \
			be defused, and some crew may attempt to do so."
	item = /obj/item/sbeacondrop/clownbomb

	price_min = 100000
	price_max = 1000000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/emp
	name = "EMP Grenades and Implanter Kit"
	desc = "A box that contains five EMP grenades and an EMP implant with three uses. Useful to disrupt communications, \
			security's energy weapons and silicon lifeforms when you're in a tight spot."
	item = /obj/item/storage/box/syndie_kit/emp

	price_min = 10000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/virus_grenade
	name = "Fungal Tuberculosis Grenade"
	desc = "A primed bio-grenade packed into a compact box. Comes with five Bio Virus Antidote Kit (BVAK) \
			autoinjectors for rapid application on up to two targets each, a syringe, and a bottle containing \
			the BVAK solution."
	item = /obj/item/storage/box/syndie_kit/tuberculosisgrenade

	price_min = 100000
	price_max = 1000000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/pizza_bomb
	name = "Pizza Bomb"
	desc = "A pizza box with a bomb cunningly attached to the lid. The timer needs to be set by opening the box; afterwards, \
			opening the box again will trigger the detonation after the timer has elapsed. Comes with free pizza, for you or your target!"
	item = /obj/item/pizzabox/bomb

	price_min = 50000
	price_max = 100000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/soap_clusterbang
	name = "Slipocalypse Clusterbang"
	desc = "A traditional clusterbang grenade with a payload consisting entirely of Syndicate soap. Useful in any scenario!"
	item = /obj/item/grenade/clusterbuster/soap

	price_min = 5000
	price_max = 10000
	stock_min = 1
	stock_max = 10
	availability_prob = 25

/datum/blackmarket_item/sexplosive/syndicate_bomb
	name = "Syndicate Bomb"
	desc = "The Syndicate bomb is a fearsome device capable of massive destruction. It has an adjustable timer, \
			with a minimum of 60 seconds, and can be bolted to the floor with a wrench to prevent \
			movement. The bomb is bulky and cannot be moved; upon ordering this item, a smaller beacon will be \
			transported to you that will teleport the actual bomb to it upon activation. Note that this bomb can \
			be defused, and some crew may attempt to do so. \
			The bomb core can be pried out and manually detonated with other explosives."
	item = /obj/item/sbeacondrop/bomb

	price_min = 50000
	price_max = 100000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sexplosive/syndicate_minibomb
	name = "Syndicate Minibomb"
	desc = "The minibomb is a grenade with a five-second fuse. Upon detonation, it will create a small hull breach \
			in addition to dealing high amounts of damage to nearby personnel."
	item = /obj/item/grenade/syndieminibomb

	price_min = 5000
	price_max = 10000
	stock_min = 1
	stock_max = 10
	availability_prob = 25

/datum/blackmarket_item/sexplosive/tearstache
	name = "Teachstache Grenade"
	desc = "A teargas grenade that launches sticky moustaches onto the face of anyone not wearing a clown or mime mask. The moustaches will \
		remain attached to the face of all targets for one minute, preventing the use of breath masks and other such devices."
	item = /obj/item/grenade/chem_grenade/teargas/moustache

	price_min = 100000
	price_max = 1000000
	stock_max = 1
	availability_prob = 5

/datum/blackmarket_item/sexplosive/viscerators
	name = "Viscerator Delivery Grenade"
	desc = "A unique grenade that deploys a swarm of viscerators upon activation, which will chase down and shred \
			any non-operatives in the area."
	item = /obj/item/grenade/spawnergrenade/manhacks

	price_min = 100000
	price_max = 1000000
	stock_max = 1
	availability_prob = 5
