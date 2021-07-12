/**
 * ## catwalk flooring
 *
 * They show what's underneath their catwalk flooring (pipes and the like)
 * you can crowbar it to interact with the underneath stuff without destroying the tile...
 * unless you want to!
 */
/turf/open/floor/plating/catwalk_floor
	icon = 'icons/turf/floors/catwalk_plating.dmi'
	icon_state = "catwalk_below"
	name = "помост"
	desc = "Пол, который показывает своё содержимое. Инженерам это определённо понравится!"
	baseturfs = /turf/open/floor/plating
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_CATWALK
	clawfootstep = FOOTSTEP_CATWALK
	heavyfootstep = FOOTSTEP_CATWALK
	var/covered = TRUE

/turf/open/floor/plating/catwalk_floor/Initialize()
	. = ..()
	update_turf_overlay()

/turf/open/floor/plating/catwalk_floor/proc/update_turf_overlay()
	var/image/I = image(icon, src, "catwalk_above", CATWALK_LAYER)
	I.plane = FLOOR_PLANE
	if(covered)
		overlays += I
	else
		overlays -= I
		qdel(I)

/turf/open/floor/plating/catwalk_floor/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	covered = !covered
	user.balloon_alert(user, "[!covered ? "покрытие снято" : "покрытие добавлено"]")
	update_turf_overlay()

/turf/open/floor/plating/catwalk_floor/pry_tile(obj/item/crowbar, mob/user, silent)
	if(covered)
		user.balloon_alert(user, "надо снять покрытие")
		return FALSE
	. = ..()
