/datum/blackmarket_item/smelee
	markets = list(/datum/blackmarket_market/syndiemarket)
	category = "Ближний бой"

/datum/blackmarket_item/smelee/cqc
	name = "CQC Manual"
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."
	item = /obj/item/book/granter/martial/cqc

	price_min = 50000
	price_max = 100000
	stock_max = 1
	availability_prob = 10
/datum/blackmarket_item/smelee/martialarts
	name = "Martial Arts Scroll"
	desc = "This scroll contains the secrets of an ancient martial arts technique. You will master unarmed combat \
			and gain the ability to swat bullets from the air, but you will also refuse to use dishonorable ranged weaponry."
	item = /obj/item/book/granter/martial/carp

	price_min = 50000
	price_max = 100000
	stock_max = 1
	availability_prob = 10

/datum/blackmarket_item/smelee/powerfist
	name = "Power Fist"
	desc = "The power-fist is a metal gauntlet with a built-in piston-ram powered by an external gas supply.\
			Upon hitting a target, the piston-ram will extend forward to make contact for some serious damage. \
			Using a wrench on the piston valve will allow you to tweak the amount of gas used per punch to \
			deal extra damage and hit targets further. Use a screwdriver to take out any attached tanks."
	item = /obj/item/melee/powerfist

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smelee/rapid
	name = "Gloves of the North Star"
	desc = "These gloves let the user punch people very fast. Does not improve weapon attack speed or the meaty fists of a hulk."
	item = /obj/item/clothing/gloves/rapid

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smelee/sword
	name = "Energy Sword"
	desc = "The energy sword is an edged weapon with a blade of pure energy. The sword is small enough to be \
			pocketed when inactive. Activating it produces a loud, distinctive noise."
	item = /obj/item/melee/transforming/energy/sword/saber

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smelee/doublesword
	name = "Double-Bladed Energy Sword"
	desc = "The double-bladed energy sword does slightly more damage than a standard energy sword and will deflect \
			all energy projectiles, but requires two hands to wield."
	item = /obj/item/dualsaber

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smelee/clownsword
	name = "Bananium Energy Sword"
	desc = "An energy sword that deals no damage, but will slip anyone it contacts, be it by melee attack, thrown \
	impact, or just stepping on it. Beware friendly fire, as even anti-slip shoes will not protect against it."
	item = /obj/item/melee/transforming/energy/sword/bananium

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smelee/bananashield
	name = "Bananium Energy Shield"
	desc = "A clown's most powerful defensive weapon, this personal shield provides near immunity to ranged energy attacks \
		by bouncing them back at the ones who fired them. It can also be thrown to bounce off of people, slipping them, \
		and returning to you even if you miss. WARNING: DO NOT ATTEMPT TO STAND ON SHIELD WHILE DEPLOYED, EVEN IF WEARING ANTI-SLIP SHOES."
	item = /obj/item/shield/energy/bananium

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25

/datum/blackmarket_item/smelee/shield
	name = "Energy Shield"
	desc = "An incredibly useful personal shield projector, capable of reflecting energy projectiles and defending \
			against other attacks. Pair with an Energy Sword for a killer combination."
	item = /obj/item/shield/energy

	price_min = 5000
	price_max = 10000
	stock_max = 1
	availability_prob = 25
