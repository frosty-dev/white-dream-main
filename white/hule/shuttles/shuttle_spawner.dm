/obj/item/shuttlespawner
	name = "bluespace shuttle capsule"
	desc = "An emergency shelter stored within a pocket of bluespace."
	icon_state = "capsule"
	icon = 'icons/obj/mining.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/datum/map_template/shuttle/capsule/template
	var/used = FALSE

/obj/item/shuttlespawner/Destroy()
	template = null // without this, capsules would be one use. per round.
	. = ..()

/obj/item/shuttlespawner/examine(mob/user)
	. = ..()
	. += "This capsule has the [template.name] stored."
	. += template.description

/obj/item/shuttlespawner/attack_self()
	//Can't grab when capsule is New() because templates aren't loaded then
	if(!used)
		loc.visible_message("<span class='warning'>\The [src] begins to shake. Stand back!</span>")
		used = TRUE
		sleep(50)
		var/turf/deploy_location = get_turf(src)
		var/status = template.check_deploy(deploy_location)
		switch(status)
			if("bad area")
				src.loc.visible_message("<span class='warning'>\The [src] will not function in this area.</span>")
			if("bad turfs", "anchored objects")
				var/width = template.width
				var/height = template.height
				src.loc.visible_message("<span class='warning'>\The [src] doesn't have room to deploy! You need to clear a [width]x[height] area!</span>")

		if(status != "allowed")
			used = FALSE
			return

		playsound(src, 'sound/effects/phasein.ogg', 100, 1)

		var/turf/T = deploy_location
		message_admins("[ADMIN_LOOKUPFLW(usr)] activated a shuttle capsule! [ADMIN_VERBOSEJMP(T)]")
		template.load(deploy_location, centered = TRUE, register = FALSE)
		new /obj/effect/particle_effect/smoke(get_turf(src))
		qdel(src)

/datum/map_template/shuttle/capsule
	name = "Capsule Shuttle"
	prefix = "white/hule/shuttles/"
	suffix = ""
	port_id = ""
	var/blacklisted_turfs
	var/whitelisted_turfs
	var/banned_areas
	var/banned_objects

/datum/map_template/shuttle/capsule/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/closed)
	whitelisted_turfs = typecacheof(/turf/open/space/basic)
	banned_areas = typecacheof(/area/shuttle)

/datum/map_template/shuttle/capsule/proc/check_deploy(turf/deploy_location)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/T in affected)
		var/area/A = get_area(T)
		if(is_type_in_typecache(A, banned_areas))
			return "bad area"

		var/banned = is_type_in_typecache(T, blacklisted_turfs)
		var/permitted = is_type_in_typecache(T, whitelisted_turfs)
		if(banned && !permitted)
			return "bad turfs"

		for(var/obj/O in T)
			if((O.density && O.anchored) || is_type_in_typecache(O, banned_objects))
				return "anchored objects"
	return "allowed"
