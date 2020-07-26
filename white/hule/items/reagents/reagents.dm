/datum/reagent/toxin/hyperpsy
	name = "Hyperpsychotic drug"
	description = "A powerful psychotic toxin. Can cause a personality split."
	color = "#00FF00"
	toxpwr = 0
	taste_description = "кислотность"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/toxin/hyperpsy/on_mob_add(mob/M)
	..()
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.gain_trauma(/datum/brain_trauma/severe/split_personality)

/obj/item/reagent_containers/pill/hyperpsy
	name = "Hyperpsychotic drug pill"
	desc = "A powerful psychotic toxin. Can cause a personality split."
	icon_state = "pill17"
	list_reagents = list(/datum/reagent/toxin/hyperpsy = 1)
	//roundstart = 1

/datum/chemical_reaction/hyperpsy
	results = list("hyperpsy" = 1)
	required_reagents = list(/datum/reagent/consumable/ethanol/neurotoxin = 1, /datum/reagent/medicine/strange_reagent = 1, /datum/reagent/medicine/mannitol = 1)

/datum/supply_pack/medical/hyperpsy
	name = "Hyperpsychotic drug crate"
	cost = 5000
	contains = list(/obj/item/reagent_containers/pill/hyperpsy)
	crate_name = "hyperpsy crate"

/datum/reagent/toxin/nptox
	name = "Neuroparalitic toxin"
	description = "Powerful toxin that causes paralysis."
	color = "#0064C8"
	toxpwr = 0
	taste_description = "лайфвеб"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/toxin/nptox/on_mob_add(mob/M)
	..()
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.gain_trauma(/datum/brain_trauma/severe/paralysis, TRAUMA_RESILIENCE_SURGERY)

/datum/reagent/toxin/nptox/on_mob_life(mob/living/M)
	M.drowsyness += 3
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	M.Sleeping(10, 0)

/obj/item/grenade/chem_grenade/npgrenade
	name = "smoke grenade"
	desc = "The word 'утбябтрднвллк' is scribbled on it in crayon. You'd better don't try to disassemble this."
	icon = 'white/hule/icons/obj/weapons.dmi'
	icon_state = "npgrenade"
	stage = 3

/obj/item/grenade/chem_grenade/npgrenade/Initialize()
	. = ..()
	var/obj/item/reagent_containers/glass/beaker/B1 = new(src)
	var/obj/item/reagent_containers/glass/beaker/B2 = new(src)

	B1.reagents.add_reagent(/datum/reagent/toxin/nptox, 25)
	B1.reagents.add_reagent(/datum/reagent/potassium, 25)
	B2.reagents.add_reagent(/datum/reagent/phosphorus, 25)
	B2.reagents.add_reagent(/datum/reagent/consumable/sugar, 25)

	beakers += B1
	beakers += B2

/obj/item/grenade/chem_grenade/npgrenade/attackby(obj/item/I, mob/user, params)
	if(stage == 3 && istype(I, /obj/item/wirecutters) && !active)
		if(prob(90))
			prime()
			return
	..()
