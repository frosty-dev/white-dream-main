/datum/chemical_reaction/solid_electricity
	required_reagents = list(/datum/reagent/consumable/liquidelectricity = 10)
	required_catalysts = list(/datum/reagent/silver = 5)
	mob_react = FALSE

/datum/chemical_reaction/solid_electricity/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/stack/solid_electricity(location)
	return
