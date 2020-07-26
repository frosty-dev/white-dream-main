/datum/reagent
	reagent_state = LIQUID//since reagent states are now interchangeable it makes sense for them to all start as liquids preventing unnescessary messages
	var/boiling_point = 500//the point at which a reagent changes from a liquid to a gaseous state
	var/melting_point = 273//the point at which a reagent changes from a liquid to a solid state
	var/processes = FALSE
	var/can_synth_seeds = TRUE

/datum/reagent/New()
	..()
	if(processes)
		START_PROCESSING(SSreagent_states, src)

/datum/reagent/Destroy() // This should only be called by the holder, so it's already handled clearing its references
	if(processes)
		STOP_PROCESSING(SSreagent_states, src)
	holder = null
	. = ..()

/datum/reagent/proc/FINISHONMOBLIFE(mob/living/M)
	current_cycle++
	M.reagents.remove_reagent(src.type, metabolization_rate * M.metabolism_efficiency) //By default it slowly disappears.
	return TRUE

/datum/reagent/proc/handle_state_change(turf/T, volume, atom)
	if(!QDELETED(src))	//otherwise it starts getting called on null holders
		var/touch_msg
		var/mob/living/touch_mob
		if(!istype(T))
			return
		if(is_type_in_typecache(T, GLOB.statechange_turf_blacklist))
			return
		if(!volume)
			return
		if(volume * 0.25 < 1)
			return
		if(atom)
			if(is_type_in_typecache(atom, GLOB.no_reagent_statechange_typecache))
				return
			if(istype(atom, /obj/item))
				var/obj/item/I = atom
				touch_mob = I.fingerprintslast
				if(istype(touch_mob))
					touch_msg = get_mob_by_key(touch_mob)
					touch_msg = "[ADMIN_LOOKUPFLW(touch_msg)]"

		if(is_type_in_typecache(src, GLOB.statechange_reagent_blacklist)) //Reagent states are interchangeable, so one blacklist to rule them all.
			return

		if(src.reagent_state == LIQUID) //LIQUID
			if(is_type_in_typecache(src, GLOB.vaporchange_reagent_blacklist)) //this is to prevent lube and clf3 from making chempiles
				return
			if(atom && istype(atom, /obj/effect/particle_effect))
				volume = volume * LIQUID_PARTICLE_EFFECT_EFFICIENCY//big nerf to smoke and foam duping
		if(src.reagent_state == SOLID) //SOLID
			if(is_type_in_typecache(src, GLOB.solidchange_reagent_blacklist))
				return
			if(atom && istype(atom, /obj/effect/particle_effect))
				volume = volume * SOLID_PARTICLE_EFFECT_EFFICIENCY//big nerf to smoke and foam duping

			for(var/obj/item/reagent_containers/food/snacks/solid_reagent/SR in T.contents)
				if(SR.reagents && SR.reagent_type == src.type && SR.reagents.total_volume < 200)
					if(touch_msg)
						SR.add_fingerprint(touch_mob)
					SR.reagents.add_reagent(src.type, volume)
					return TRUE

			var/obj/item/reagent_containers/food/snacks/solid_reagent/Sr = new (T)
			if(touch_msg)
				Sr.add_fingerprint(touch_mob)
			Sr.reagents.add_reagent(src.type, volume, src.data)
			Sr.reagent_type = src.type
			Sr.name = "затвердевший [src]"
			Sr.add_atom_colour(src.color, FIXED_COLOUR_PRIORITY)
			Sr.filling_color = src.color
