SUBSYSTEM_DEF(aspects)
	name = "Aspects"

	flags = SS_NO_FIRE //я блять это только сейчас заметил. Ну да ладно.
	init_order = -70

	runlevels = RUNLEVEL_GAME

	var/ca_name = "LOBBY"
	var/ca_desc = "Секрет."

	var/list/aspects = list()

	var/datum/round_aspect/current_aspect

/datum/controller/subsystem/aspects/Initialize()
	for(var/item in typesof(/datum/round_aspect))
		var/datum/round_aspect/A = new item()
		aspects[A] = A.weight

	toplayers = "Создаём случайные последовательности"

	return ..()

/datum/controller/subsystem/aspects/stat_entry(msg)
	..("CA:[ca_name]")

/datum/controller/subsystem/aspects/proc/run_aspect()
	current_aspect = pickweight(aspects)
	current_aspect.run_aspect()
	ca_name = current_aspect.name
	ca_desc = current_aspect.desc

	to_chat(world, "<span class='notice'><B>Важно:</B> [current_aspect.desc]</span>")
