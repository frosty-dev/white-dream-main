/obj/machinery/power/atmos_synthesizer
	name = "собиратель приколов"
	desc = "Собирает приколы из прикольных газов. Работает на каких-то там блюспейс залупах, чисто поебать на КПД больше 100%."
	anchored = FALSE
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN
	icon = 'icons/obj/atmos.dmi'
	icon_state = "electrolyzer-off"
	max_integrity = 250
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 80, "acid" = 10)
	//circuit = /obj/item/circuitboard/machine/electrolyzer
	use_power = NO_POWER_USE
	idle_power_usage = 100
	active_power_usage = 200

	var/synth_type = /obj/item/stack/sheet/cotton
	var/list/gas_moles_per_synth = list(
										/datum/gas/oxygen = 0.1
										)
	var/moles_removed = 5

	var/datum/gas_mixture/internal

	var/wrong_mix = FALSE

/obj/machinery/power/atmos_synthesizer/examine(mob/user)
	. = ..()
	if(wrong_mix)
		. += "<span class=notice>ОШИБКА: Отсутствуют необходимые газы или пропорции не соотвествуют нормам.</span>"

/obj/machinery/power/atmos_synthesizer/Initialize()
	. = ..()
	if(anchored)
		connect_to_network()

/obj/machinery/power/atmos_synthesizer/Destroy()
	release_gases()
	disconnect_from_network()
	return ..()

/obj/machinery/power/atmos_synthesizer/should_have_node()
	return anchored

/obj/machinery/power/atmos_synthesizer/wrench_act(mob/living/user, obj/item/I)
	..()
	if(default_unfasten_wrench(user, I))
		if(anchored)
			connect_to_network()
		else
			disconnect_from_network()
	return TRUE

/obj/machinery/power/atmos_synthesizer/process()
	if(avail(idle_power_usage)&&anchored)
		remove_gases()
		var/mod = get_mod()

		if(!mod)
			wrong_mix = TRUE
			add_load(idle_power_usage)
		else
			wrong_mix = FALSE
			if(avail(active_power_usage*mod))
				add_load(active_power_usage*mod)
				do_synth(mod)
			else
				add_load(idle_power_usage)

		release_gases()

/obj/machinery/power/atmos_synthesizer/proc/remove_gases()
	var/turf/T = get_turf(src)
	var/datum/gas_mixture/env = T.return_air()
	internal = env.remove(moles_removed)

/obj/machinery/power/atmos_synthesizer/proc/release_gases()
	if(!internal)
		return
	var/turf/T = get_turf(src)
	var/datum/gas_mixture/env = T.return_air()
	env.merge(internal)
	air_update_turf()
	internal = null

/obj/machinery/power/atmos_synthesizer/proc/get_mod()
	if(!internal)
		return 0
	var/mod = 0
	var/list/avail = list()

	for(var/gas_type in gas_moles_per_synth)
		avail.Add(internal.get_moles(gas_type) / gas_moles_per_synth[gas_type])

	mod = round(min(avail))
	return mod

/obj/machinery/power/atmos_synthesizer/proc/do_synth(mod)
	if(!mod)
		return

	for(var/gas_type in gas_moles_per_synth)
		internal.adjust_moles(gas_type, -gas_moles_per_synth[gas_type]*mod)

	for(var/i in 1 to mod)
		new synth_type(get_turf(src))

/obj/machinery/power/atmos_synthesizer/coalgen
	name = "ГЕН-УГ-314А"
	desc = "Собирает уголь, во хохма-то."
	synth_type = /obj/item/stack/sheet/mineral/coal
	gas_moles_per_synth = list(
								/datum/gas/carbon_dioxide = 0.05,
								/datum/gas/hydrogen = 0.2,
								/datum/gas/miasma = 0.1
								)


