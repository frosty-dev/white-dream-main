/datum/map_template/ruin/space/bseruin
	id = "bseruin"
	suffix = "bseruin.dmm"
	name = "BSE Ruin"
	always_place = TRUE
	allow_duplicates = FALSE
	description = "Аааааааааааааааа. А."


/area/ruin/space/has_grav/bseruin
	name = "BSE Ruin"
	icon_state = "yellow"

/area/ruin/space/has_grav/bseruin/asteroid
	name = "Asteroid"
	icon_state = "yellow"

/area/ruin/space/has_grav/bseruin/foam
	name = "Foam"
	icon_state = "bluenew"

/area/ruin/space/has_grav/bseruin/ntnet
	name = "Building 1"
	icon_state = "tcomsatcham"

/area/ruin/space/has_grav/bseruin/shop
	name = "Building 2"
	icon_state = "storage"

/area/ruin/space/has_grav/bseruin/backyard
	name = "Building 2 backyard"
	icon_state = "red"


/obj/effect/mapping_helpers/dead_body_placer_custom
	name = "Dead Body placer"
	late = TRUE
	icon_state = "deadbodyplacer"
	var/bodycount = 2 //number of bodies to spawn
	var/species = /datum/species/human

/obj/effect/mapping_helpers/dead_body_placer_custom/LateInitialize()
	var/area/a = get_area(src)
	var/list/trays = list()
	for (var/i in a.contents)
		if (istype(i, /obj/structure/bodycontainer/morgue))
			trays += i
	if(!trays.len)
		log_mapping("[src] at [x],[y] could not find any morgues.")
		return
	for (var/i = 1 to bodycount)
		var/obj/structure/bodycontainer/morgue/j = pick(trays)
		var/mob/living/carbon/human/h = new /mob/living/carbon/human(j, 1)
		h.set_species(species)
		h.death()
		for (var/part in h.internal_organs) //randomly remove organs from each body, set those we keep to be in stasis
			if (prob(40))
				qdel(part)
			else
				var/obj/item/organ/O = part
				O.organ_flags |= ORGAN_FROZEN
		j.update_icon()
	qdel(src)


/obj/effect/mob_spawn/human/smuggler
	name = "stasis unit"
	desc = "A humming sleeper with a silhouetted occupant inside."
	mob_name = "контрабандист"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/smuggler
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "Прив вы контрабандист. Че как делать думай сам."
	assignedrole = "Контрабандист"

/obj/effect/mob_spawn/human/smuggler/Destroy()
	new /obj/machinery/stasis/survival_pod(get_turf(src))
	return ..()

/datum/outfit/smuggler
	name = "Smuggler"
	uniform = /obj/item/clothing/under/suit/charcoal
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/storage/secure/briefcase/smuggler

/obj/item/storage/secure/briefcase/smuggler/PopulateContents()
	new /obj/item/modular_computer/laptop/preset/civilian
