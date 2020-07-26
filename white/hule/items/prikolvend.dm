/obj/machinery/vending/ancap
	name = "\improper AnCapVend Plus"
	desc = "A funny vending machine. There is a note on the side: \"Pls kys if you are a commie\""
	icon = 'white/hule/icons/obj/vending.dmi'
	icon_state = "ancap"
	icon_deny = "ancap-deny"
	product_ads = "Prikols here!"
	req_access = list()
	products = list(
						/obj/item/book/granter/crafting_recipe/cookbook = 1,
						/obj/item/seeds/random = 10
					)

	contraband = list(
						/obj/item/book/granter/crafting_recipe/cookbook = 3,
						/obj/item/reagent_containers/glass/bottle/nutrient/earthsblood = 3
					)

	premium = list(
						/obj/item/book/granter/martial/cqc = 1,
						/obj/item/disk/surgery/brainwashing = 1,
						/obj/item/gun/chem = 1,
						/obj/item/gun/blastcannon = 1
					)

	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	default_price = 1000
	extra_price = 50000
	payment_department = NO_FREEBIES

/obj/machinery/vending/ancap/Initialize(mapload)
	. = ..()
	wires.wires -= WIRE_THROW
	wires.wires += WIRE_ZAP

/obj/item/reagent_containers/glass/bottle/nutrient/earthsblood
	name = "bottle of earthsblood"
	desc = "Contains a fertilizer that makes trays self-sustaining."
	list_reagents = list(/datum/reagent/medicine/earthsblood = 20)
