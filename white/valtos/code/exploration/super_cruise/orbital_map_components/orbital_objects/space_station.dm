/datum/orbital_object/z_linked/station
	name = "Космическая Станция 13"
	mass = 0
	radius = 30
	//Sure, why not?
	can_dock_anywhere = TRUE
	static_object = TRUE

/datum/orbital_object/z_linked/station/Destroy()
	. = ..()
	SSticker.force_ending = TRUE

/datum/orbital_object/z_linked/station/post_map_setup()
	//Orbit around the system center
	name = "[station_name()] #[linked_z_level.z_value - 1]"
	var/datum/orbital_object/z_linked/station/station = locate() in SSorbits.orbital_map.bodies
	if(station && station != src)
		orbitting = TRUE
		position.x = station.position.x
		position.y = station.position.y + 32
	else
		set_orbitting_around_body(SSorbits.orbital_map.center, 1500)
