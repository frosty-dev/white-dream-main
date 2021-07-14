/mob/proc/sasamba_testing(template_type)
	var/datum/map_template/MT = new template_type()
	MT.load(get_turf(src))

/datum/map_template/lavaportal
	name = "Lavaland portal room"
	mappath = "white/baldenysh/map_templates/lavaportal.dmm"

/area/ruin/space/has_grav/lavaportal
	name = "Lavaland portal room"
	icon_state = "yellow"
	area_flags = UNIQUE_AREA | HIDDEN_AREA
