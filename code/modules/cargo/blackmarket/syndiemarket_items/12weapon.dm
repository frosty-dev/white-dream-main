/datum/blackmarket_item/sweapon
	markets = list(/datum/blackmarket_market/syndiemarket)
	category = "Оружие"

/datum/blackmarket_item/sweapon/pistol
	name = "Makarov Pistol"
	desc = "A small, easily concealable handgun that uses 9mm auto rounds in 8-round magazines and is compatible \
			with suppressors."
	item = /obj/item/gun/ballistic/automatic/pistol

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/aps
	name = "Stechkin APS Machine Pistol"
	desc = "An ancient Soviet machine pistol, refurbished for the modern age. Uses 9mm auto rounds in 15-round magazines and is compatible \
			with suppressors. The gun fires in three round bursts."
	item = /obj/item/gun/ballistic/automatic/pistol/aps

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/revolver
	name = "Syndicate Revolver"
	desc = "A brutally simple Syndicate revolver that fires .357 Magnum rounds and has 7 chambers."
	item = /obj/item/gun/ballistic/revolver

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/pie_cannon
	name = "Banana Cream Pie Cannon"
	desc = "A special pie cannon for a special clown, this gadget can hold up to 20 pies and automatically fabricates one every two seconds!"
	item = /obj/item/pneumatic_cannon/pie/selfcharge

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/blastcannon
	name = "Blast Cannon"
	desc = "A highly specialized weapon, the Blast Cannon is actually relatively simple. It contains an attachment for a tank transfer valve mounted to an angled pipe specially constructed \
			withstand extreme pressure and temperatures, and has a mechanical trigger for triggering the transfer valve. Essentially, it turns the explosive force of a bomb into a narrow-angle \
			blast wave \"projectile\". Aspiring scientists may find this highly useful, as forcing the pressure shockwave into a narrow angle seems to be able to bypass whatever quirk of physics \
			disallows explosive ranges above a certain distance, allowing for the device to use the theoretical yield of a transfer valve bomb, instead of the factual yield."
	item = /obj/item/gun/blastcannon

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25
/datum/blackmarket_item/sweapon/shotgun
	name = "Bulldog Shotgun"
	desc = "A fully-loaded semi-automatic drum-fed shotgun. Compatible with all 12g rounds. Designed for close \
			quarter anti-personnel engagements."
	item = /obj/item/gun/ballistic/shotgun/bulldog

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/smg
	name = "C-20r Submachine Gun"
	desc = "A fully-loaded Scarborough Arms bullpup submachine gun. The C-20r fires .45 rounds with a \
			24-round magazine and is compatible with suppressors."
	item = /obj/item/gun/ballistic/automatic/c20r

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/machinegun
	name = "L6 Squad Automatic Weapon"
	desc = "A fully-loaded Aussec Armoury belt-fed machine gun. \
			This deadly weapon has a massive 50-round magazine of devastating 7.12x82mm ammunition."
	item = /obj/item/gun/ballistic/automatic/l6_saw

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/carbine
	name = "M-90gl Carbine"
	desc = "A fully-loaded, specialized three-round burst carbine that fires 5.56mm ammunition from a 30 round magazine \
			with a toggleable 40mm underbarrel grenade launcher."
	item = /obj/item/gun/ballistic/automatic/m90

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/sniper
	name = "Sniper Rifle"
	desc = "Ranged fury, Syndicate style. Guaranteed to cause shock and awe or your TC back!"
	item = /obj/item/gun/ballistic/automatic/sniper_rifle/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 5

/datum/blackmarket_item/sweapons/crossbow
	name = "Miniature Energy Crossbow"
	desc = "A short bow mounted across a tiller in miniature. \
	Small enough to fit into a pocket or slip into a bag unnoticed. \
	It will synthesize and fire bolts tipped with a debilitating \
	toxin that will damage and disorient targets, causing them to \
	slur as if inebriated. It can produce an infinite number \
	of bolts, but takes time to automatically recharge after each shot."
	item = /obj/item/gun/energy/kinetic_accelerator/crossbow

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/foammachinegun
	name = "Toy Machine Gun"
	desc = "A fully-loaded Donksoft belt-fed machine gun. This weapon has a massive 50-round magazine of devastating \
			riot grade darts, that can briefly incapacitate someone in just one volley."
	item = /obj/item/gun/ballistic/automatic/l6_saw/toy

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/foampistol
	name = "Toy Pistol with Riot Darts"
	desc = "An innocent-looking toy pistol designed to fire foam darts. Comes loaded with riot-grade \
			darts effective at incapacitating a target."
	item = /obj/item/gun/ballistic/automatic/toy/pistol/riot

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/dart_pistol
	name = "Dart Pistol"
	desc = "A miniaturized version of a normal syringe gun. It is very quiet when fired and can fit into any \
			space a small item can."
	item = /obj/item/gun/syringe/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/clownsuperpin
	name = "Super Ultra Hilarious Firing Pin"
	desc = "Like the ultra hilarious firing pin, except the gun you insert this pin into explodes when someone who isn't clumsy or a clown tries to fire it."
	item = /obj/item/firing_pin/clown/ultra/selfdestruct

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/sweapon/clownpin
	name = "Ultra Hilarious Firing Pin"
	desc = "A firing pin that, when inserted into a gun, makes that gun only usable by clowns and clumsy people and makes that gun honk whenever anyone tries to fire it."
	item = /obj/item/firing_pin/clown/ultra

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25
