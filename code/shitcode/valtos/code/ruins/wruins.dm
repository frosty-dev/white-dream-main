//telepadovo

/area/ruin/space/has_grav/telepadovo
	name = "Telepadovo"

/datum/map_template/ruin/space/telepadovo
	id = "telepadovo"
	suffix = "wruin1.dmm"
	name = "Telepadovo"
	description = "Синдикат в последнее время плохо финансируется, в следствии чего начал заведовать переправкой космобеженцев через телепады."

//austation

/obj/effect/mob_spawn/human/austation
	name = "пахнущая ссаниной капсула"
	desc = "Промёрзшая изнутри капсула. Если присмотреться, то внутри находится спящий человек."
	mob_name = "ассистуха"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>Мне повезло проснуться хрен пойми где. Надо бы понять что тут стряслось и выжить.</b>"
	uniform = /datum/outfit/job/assistant
	shoes = null
	assignedrole = "Autism Crew"

/obj/effect/mob_spawn/human/austation/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/area/ruin/space/has_grav/austation
	name = "Autism Station"

/datum/map_template/ruin/space/austation
	id = "austation"
	suffix = "wruin2.dmm"
	name = "Autism Station"
	description = "Практически автономная министация посреди космоса. Уцелела благодаря идиотам среди экипажа и полным отсутствием тактической ценности для синдиката."

/area/shuttle/explorer_mini
	requires_power = TRUE
	name = "Auto-Explorer Mini"

/datum/map_template/shuttle/ruin/explorer_mini
	suffix = "explorer_mini"
	name = "Auto-Explorer Mini"

/obj/item/circuitboard/computer/explorer_mini
	build_path = /obj/machinery/computer/shuttle/explorer_mini

/obj/machinery/computer/shuttle/explorer_mini
	name = "Auto-Explorer Mini Shuttle Console"
	desc = "Used to control the Auto-Explorer Mini."
	circuit = /obj/item/circuitboard/computer/explorer_mini
	shuttleId = "explorer_mini"
	possible_destinations = "explorer_mini_custom;explorer_mini_station"

/obj/machinery/computer/camera_advanced/shuttle_docker/explorer_mini
	name = "Auto-Explorer Mini Navigation Computer"
	desc = "Used to designate a precise transit location for the Auto-Explorer Mini."
	shuttleId = "explorer_mini"
	shuttlePortId = "explorer_mini_custom"
	jumpto_ports = list("explorer_mini_station" = 1)
	view_range = 9

//telepadovo

/area/ruin/space/has_grav/powered/partywhite
	name = "Partywhite"
	var/music_triggered = FALSE

/area/ruin/space/has_grav/powered/partywhite/Entered(mob/user)
	. = ..()

	if(!user.ckey)
		return

	if (!music_triggered)
		for (var/obj/machinery/jukebox/disco/indestructible/D in /area/ruin/space/has_grav/powered/partywhite)
			D.activate_music()
		music_triggered = TRUE

/datum/map_template/ruin/space/partywhite
	id = "partywhite"
	suffix = "wruin3.dmm"
	name = "Partywhite"
	description = "Синдикат решил устроить тусу посреди космоса и никто им не должен помешать. Никто."
