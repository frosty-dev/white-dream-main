//telepadovo

/area/ruin/space/has_grav/telepadovo
	name = "Telepadovo"

/datum/map_template/ruin/space/telepadovo
	id = "telepadovo"
	suffix = "wruin1.dmm"
	name = "Telepadovo"
	allow_duplicates = FALSE
	description = "Синдикат в последнее время плохо финансируется, в следствии чего начал заведовать переправкой космобеженцев через телепады."

//austation

/obj/effect/mob_spawn/human/austation
	name = "пахнущая плохо капсула"
	desc = "Промёрзшая изнутри капсула. Если присмотреться, то внутри находится спящий человек."
	mob_name = "ассистуха"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "Я аутистовец"
	flavour_text = "Мне повезло проснуться непонятно где. Надо бы понять что тут стряслось и выжить."
	important_info = "Скоро закончится свет."
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
	allow_duplicates = FALSE
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

/obj/item/paper/crumpled/ruins/autism
	info = "<i>Ты пидор.</i>"

//telepadovo

/area/ruin/space/has_grav/powered/partywhite
	name = "Partywhite"

/*
/area/ruin/space/has_grav/powered/partywhite/Initialize(mapload)
	. = ..()
	if(mapload)
		for (var/obj/machinery/jukebox/disco/indestructible/D in src)
			D.activate_music()
*/

/datum/map_template/ruin/space/partywhite
	id = "partywhite"
	suffix = "wruin3.dmm"
	name = "Partywhite"
	allow_duplicates = FALSE
	description = "Синдикат решил устроить тусу посреди космоса и никто им не должен помешать. Никто."

//terrorship

/area/ruin/space/has_grav/terrorship
	name = "Terrorship"
	requires_power = FALSE
	noteleport = TRUE //ага ебать
	hidden = TRUE
	valid_territory = FALSE

/obj/structure/fluff/artillery
	name = "артиллерия"
	desc = "Долбит нормально."
	icon = 'white/valtos/icons/artillery.dmi'
	icon_state = "artillery"
	density = TRUE

/datum/map_template/ruin/space/terrorship
	id = "terrorship"
	suffix = "wruin4.dmm"
	name = "Terrorship"
	allow_duplicates = FALSE
	description = "При попытке пристыковать артиллерию к основной части корабля Mothership при помощи блюспейс технологий эта часть корабля попала в наш сектор. Блюпупа получил <b>за лупу</b>."
