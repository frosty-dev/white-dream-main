/obj/machinery/vending/chetverochka
	name = "Продуктовый вендомат (ОАО Четверочка-вендиг)"
	desc = "Всегда рядом."
	icon = 'white/baldenysh/icons/obj/vending.dmi'
	icon_state = "chetverochka"
	products = list(
					/obj/item/reagent_containers/food/snacks/kebab/rat/double = 3,
					/obj/item/storage/box/lcubes = 5,
					/obj/item/reagent_containers/food/snacks/canned/peaches/maint = 2,
					/obj/item/reagent_containers/food/snacks/soylentgreen = 5
					)
	contraband = list(
					/obj/item/reagent_containers/food/snacks/store/cheesewheel = 2
					)
	premium = list()
	//refill_canister = /obj/item/vending_refill/cola
	default_price = 100
	extra_price = 500
	payment_department = ACCOUNT_SRV
	light_mask = "chetverochka-light-mask"

/obj/machinery/vending/chetverochka/pharma
	name = "Аптечный вендомат (ОАО Четверочка-вендиг)"
	icon_state = "chet_pharma"
	products = list(
					/obj/item/stack/medical/gauze = 10,
					/obj/item/reagent_containers/hypospray/medipen = 3,
					/obj/item/storage/box/pillpack/potassiodide = 3,
					/obj/item/storage/box/pillpack/haloperidol = 3,
					/obj/item/storage/box/pillpack/antihol = 4,
					/obj/item/storage/box/pillpack/psicodine = 2,
					/obj/item/storage/box/pillpack/aspirin = 3

					)
	contraband = list(
						/obj/item/storage/box/pillpack/hohlomicin = 1

					)
	premium = list(
					/obj/item/storage/box/pillpack/stimulant = 1

					)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	//refill_canister = /obj/item/vending_refill/medical
	default_price = 200
	extra_price = 1000
	payment_department = ACCOUNT_MED
