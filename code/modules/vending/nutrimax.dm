/obj/machinery/vending/hydronutrients
	name = "\improper NutriMax"
	desc = "A plant nutrients vendor."
	product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	light_mask = "nutri-light-mask"
	products = list(/obj/item/reagent_containers/glass/bottle/nutrient/ez = 30,
					/obj/item/reagent_containers/glass/bottle/nutrient/l4z = 20,
					/obj/item/reagent_containers/glass/bottle/nutrient/rh = 10,
					/obj/item/reagent_containers/spray/pestspray = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/storage/bag/plants = 5,
					/obj/item/cultivator = 3,
					/obj/item/shovel/spade = 3,
					/obj/item/secateurs = 3,
					/obj/item/plant_analyzer = 4,
					/obj/machinery/plantgenes = 1,
					/obj/item/disk/plantgene = 20,
					)
	contraband = list(/obj/item/reagent_containers/glass/bottle/ammonia = 10,
					  /obj/item/reagent_containers/glass/bottle/diethylamine = 5,
					  /obj/machinery/chem_dispenser = 1,
					  /obj/item/storage/box/plumbing = 1,
					  /obj/item/construction/plumbing = 1,
					  /obj/item/reagent_containers/glass/beaker/large = 2
					  )
	refill_canister = /obj/item/vending_refill/hydronutrients
	default_price = 100
	extra_price = 250
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/hydronutrients
	machine_name = "NutriMax"
	icon_state = "refill_plant"
