/datum/blackmarket_item/smisc
	markets = list(/datum/blackmarket_market/syndiemarket)
	category = "Полезное"

/datum/blackmarket_item/smisc/emag
	name = "Cryptographic Sequencer"
	desc = "The cryptographic sequencer, electromagnetic card, or emag, is a small card that unlocks hidden functions \
			in electronic devices, subverts intended functions, and easily breaks security mechanisms. Cannot be used to open airlocks."
	item = /obj/item/card/emag

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/doorjack
	name = "Airlock Authentication Override Card"
	desc = "A specialized cryptographic sequencer specifically designed to override station airlock access codes. \
			After hacking a certain number of airlocks, the device will require some time to recharge."
	item = /obj/item/card/emag/doorjack

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/sleepy_pen
	name = "Sleepy Pen"
	desc = "A syringe disguised as a functional pen, filled with a potent mix of drugs, including a \
			strong anesthetic and a chemical that prevents the target from speaking. \
			The pen holds one dose of the mixture, and can be refilled with any chemicals. Note that before the target \
			falls asleep, they will be able to move and act."
	item = /obj/item/pen/sleepy

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/edagger
	name = "Energy Dagger"
	desc = "A dagger made of energy that looks and functions as a pen when off."
	item = /obj/item/pen/edagger

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/suppressor
	name = "Suppressor"
	desc = "This suppressor will silence the shots of the weapon it is attached to for increased stealth and superior ambushing capability. It is compatible with many small ballistic guns including the Makarov, Stechkin APS and C-20r, but not revolvers or energy guns."
	item = /obj/item/suppressor

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/syndicate_detonator
	name = "Syndicate Detonator"
	desc = "The Syndicate detonator is a companion device to the Syndicate bomb. Simply press the included button \
			and an encrypted radio frequency will instruct all live Syndicate bombs to detonate. \
			Useful for when speed matters or you wish to synchronize multiple bomb blasts. Be sure to stand clear of \
			the blast radius before using the detonator."
	item = /obj/item/syndicatedetonator

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 100

/datum/blackmarket_item/smisc/agent_card
	name = "Agent Identification Card"
	desc = "Agent cards prevent artificial intelligences from tracking the wearer, and can copy access \
			from other identification cards. The access is cumulative, so scanning one card does not erase the \
			access gained from another. In addition, they can be forged to display a new assignment and name. \
			This can be done an unlimited amount of times. Some Syndicate areas and devices can only be accessed \
			with these cards."
	item = /obj/item/card/id/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 100

/datum/blackmarket_item/smisc/chameleon_proj
	name = "Chameleon Projector"
	desc = "Projects an image across a user, disguising them as an object scanned with it, as long as they don't \
			move the projector from their hand. Disguised users move slowly, and projectiles pass over them."
	item = /obj/item/chameleon

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/codespeak_manual
	name = "Codespeak Manual"
	desc = "Syndicate agents can be trained to use a series of codewords to convey complex information, which sounds like random concepts and drinks to anyone listening. \
			This manual teaches you this Codespeak. You can also hit someone else with the manual in order to teach them. This is the deluxe edition, which has unlimited uses."
	item = /obj/item/codespeak_manual/unlimited

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/emplight
	name = "EMP Flashlight"
	desc = "A small, self-recharging, short-ranged EMP device disguised as a working flashlight. \
			Useful for disrupting headsets, cameras, doors, lockers and borgs during stealth operations. \
			Attacking a target with this flashlight will direct an EM pulse at it and consumes a charge."
	item = /obj/item/flashlight/emp

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/mulligan
	name = "Mulligan"
	desc = "Screwed up and have security on your tail? This handy syringe will give you a completely new identity \
			and appearance."
	item = /obj/item/reagent_containers/syringe/mulligan

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/jammer
	name = "Radio Jammer"
	desc = "This device will disrupt any nearby outgoing radio communication when activated. Does not affect binary chat."
	item = /obj/item/jammer

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/binary
	name = "Binary Translator Key"
	desc = "A key that, when inserted into a radio headset, allows you to listen to and talk with silicon-based lifeforms, \
			such as AI units and cyborgs, over their private binary channel. Caution should \
			be taken while doing this, as unless they are allied with you, they are programmed to report such intrusions."
	item = /obj/item/encryptionkey/binary

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/camera_bug
	name = "Camera Bug"
	desc = "Enables you to view all cameras on the main network, set up motion alerts and track a target. \
			Bugging cameras allows you to disable them remotely."
	item = /obj/item/camera_bug

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/toolbox
	name = "Full Syndicate Toolbox"
	desc = "The Syndicate toolbox is a suspicious black and red. It comes loaded with a full tool set including a \
			multitool and combat gloves that are resistant to shocks and heat."
	item = /obj/item/storage/toolbox/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/encryptionkey
	name = "Syndicate Encryption Key"
	desc = "A key that, when inserted into a radio headset, allows you to listen to all station department channels \
			as well as talk on an encrypted Syndicate channel with other agents that have the same key."
	item = /obj/item/encryptionkey/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/syndietome
	name = "Syndicate Tome"
	desc = "Using rare artifacts acquired at great cost, the Syndicate has reverse engineered \
			the seemingly magical books of a certain cult. Though lacking the esoteric abilities \
			of the originals, these inferior copies are still quite useful, being able to provide \
			both weal and woe on the battlefield, even if they do occasionally bite off a finger."
	item = /obj/item/storage/book/bible/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/potion
	name = "Syndicate Sentience Potion"
	desc = "A potion recovered at great risk by undercover Syndicate operatives and then subsequently modified with Syndicate technology. \
			Using it will make any animal sentient, and bound to serve you, as well as implanting an internal radio for communication and an internal ID card for opening doors."
	item = /obj/item/slimepotion/slime/sentience/nuclear

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smiscd/gorillacubes
	name = "Box of Gorilla Cubes"
	desc = "A box with three Waffle Co. brand gorilla cubes. Eat big to get big. \
			Caution: Product may rehydrate when exposed to water."
	item = /obj/item/storage/box/gorillacubes

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/brainwash_disk
	name = "Brainwashing Surgery Program"
	desc = "A disk containing the procedure to perform a brainwashing surgery, allowing you to implant an objective onto a target. \
	Insert into an Operating Console to enable the procedure."
	item = /obj/item/disk/surgery/brainwashing

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/his_grace
	name = "His Grace"
	desc = "An incredibly dangerous weapon recovered from a station overcome by the grey tide. Once activated, He will thirst for blood and must be used to kill to sate that thirst. \
	His Grace grants gradual regeneration and complete stun immunity to His wielder, but be wary: if He gets too hungry, He will become impossible to drop and eventually kill you if not fed. \
	However, if left alone for long enough, He will fall back to slumber. \
	To activate His Grace, simply unlatch Him."
	item = /obj/item/his_grace

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/explosive_hot_potato
	name = "Exploding Hot Potato"
	desc = "A potato rigged with explosives. On activation, a special mechanism is activated that prevents it from being dropped. \
			The only way to get rid of it if you are holding it is to attack someone else with it, causing it to latch to that person instead."
	item = /obj/item/hot_potato/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/ez_clean_bundle
	name = "EZ Clean Grenade Bundle"
	desc = "A box with three cleaner grenades using the trademark Waffle Co. formula. Serves as a cleaner and causes acid damage to anyone standing nearby. \
			The acid only affects carbon-based creatures."
	item = /obj/item/storage/box/syndie_kit/ez_clean

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/pressure_mod
	name = "Kinetic Accelerator Pressure Mod"
	desc = "A modification kit which allows Kinetic Accelerators to do greatly increased damage while indoors. \
			Occupies 35% mod capacity."
	item = /obj/item/borg/upgrade/modkit/indoors

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smisc/syndie_jaws_of_life
	name = "Syndicate Jaws of Life"
	desc = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
	In it's crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or it's departments."
	item = /obj/item/crowbar/power/syndicate

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25
