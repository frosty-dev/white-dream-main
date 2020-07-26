/obj/item/melee_attack_chain(mob/user, atom/target, params)
	. = ..()
	SSdemo.mark_dirty(src)
	if(isturf(target))
		SSdemo.mark_turf(target)
	else
		SSdemo.mark_dirty(target)

/obj/item/attack_self(mob/user)
	. = ..()
	SSdemo.mark_dirty(src)

/atom/movable/Moved(atom/OldLoc, Dir)
	. = ..()
	SSdemo.mark_dirty(src)

/atom
	var/image/demo_last_appearance

/atom/movable
	var/atom/demo_last_loc

/mob/Login()
	. = ..()
	SSdemo.write_event_line("setmob [client.ckey] \ref[src]")

/client/New()
	SSdemo.write_event_line("login [ckey]")
	. = ..()

/client/Del()
	. = ..()
	SSdemo.write_event_line("logout [ckey]")

/turf/setDir()
	. = ..()
	SSdemo.mark_turf(src)

/atom/movable/setDir()
	. = ..()
	SSdemo.mark_dirty(src)

/obj/machinery/door/airlock/update_icon(state, override)
	. = ..()
	if(operating && !override)
		return
	SSdemo.mark_dirty(src)

/obj/machinery/door/firedoor/update_icon()
	. = ..()
	SSdemo.mark_dirty(src)

/obj/machinery/door/poddoor/update_icon()
	. = ..()
	SSdemo.mark_dirty(src)

/obj/machinery/door/window/update_icon()
	. = ..()
	SSdemo.mark_dirty(src)

/turf/ChangeTurf(path, list/new_baseturfs, flags)
	. = ..()
	SSdemo.mark_turf(src)

/atom/movable/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock)
	. = ..()
	if(.)
		SSdemo.mark_dirty(src)
