/datum/blackmarket_item/smedicine
	markets = list(/datum/blackmarket_market/syndiemarket)
	category = "Медицина"

/datum/blackmarket_item/smedicine/traitor_chem_bottle
	name = "Poison Kit"
	desc = "An assortment of deadly chemicals packed into a compact box. Comes with a syringe for more precise application."
	item = /obj/item/storage/box/syndie_kit/chemical

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/romerol_kit
	name = "Romerol"
	desc = "A highly experimental bioterror agent which creates dormant nodules to be etched into the grey matter of the brain. \
			On death, these nodules take control of the dead body, causing limited revivification, \
			along with slurred speech, aggression, and the ability to infect others with this agent."
	item = /obj/item/storage/box/syndie_kit/romerol

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/magillitis_serum
	name = "Magillitis Serum Autoinjector"
	desc = "A single-use autoinjector which contains an experimental serum that causes rapid muscular growth in Hominidae. \
			Side-affects may include hypertrichosis, violent outbursts, and an unending affinity for bananas."
	item = /obj/item/reagent_containers/hypospray/medipen/magillitis

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/modified_syringe_gun
	name = "Modified Syringe Gun"
	desc = "A syringe gun that fires DNA injectors instead of normal syringes."
	item = /obj/item/gun/syringe/dna

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/chemical_gun
	name = "Reagent Dartgun"
	desc = "A heavily modified syringe gun which is capable of synthesizing its own chemical darts using input reagents. Can hold 100u of reagents."
	item = /obj/item/gun/chem

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/medgun
	name = "Medbeam Gun"
	desc = "A wonder of Syndicate engineering, the Medbeam gun, or Medi-Gun enables a medic to keep his fellow \
			operatives in the fight, even while under fire. Don't cross the streams!"
	item = /obj/item/gun/medbeam

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/rad_laser
	name = "Radioactive Microlaser"
	desc = "A radioactive microlaser disguised as a standard Nanotrasen health analyzer. When used, it emits a \
			powerful burst of radiation, which, after a short delay, can incapacitate all but the most protected \
			of humanoids. It has two settings: intensity, which controls the power of the radiation, \
			and wavelength, which controls the delay before the effect kicks in."
	item = /obj/item/healthanalyzer/rad_laser

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/medkit
	name = "Syndicate Combat Medic Kit"
	desc = "This first aid kit is a suspicious brown and red. Included is a combat stimulant injector \
			for rapid healing, a medical night vision HUD for quick identification of injured personnel, \
			and other supplies helpful for a field medic."
	item = /obj/item/storage/firstaid/tactical

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/stimpack
	name = "Stimpack"
	desc = "Stimpacks, the tool of many great heroes, make you nearly immune to stuns and knockdowns for about \
			5 minutes after injection."
	item = /obj/item/reagent_containers/hypospray/medipen/stimulants

	price_min = 5000
	price_max = 50000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smedicine/surgerybag
	name = "Syndicate Surgery Duffel Bag"
	desc = "The Syndicate surgery duffel bag is a toolkit containing all surgery tools, surgical drapes, \
			a Syndicate brand MMI, a straitjacket, and a muzzle."
	item = /obj/item/storage/backpack/duffelbag/syndie/surgery

	price_min = 1000
	price_max = 5000
	stock_max = 1
	availability_prob = 25
