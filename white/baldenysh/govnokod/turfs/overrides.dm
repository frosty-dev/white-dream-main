/turf
	var/turf/above_override = null
	var/turf/below_override = null

/turf/proc/check_overrides()
	if(above_override || below_override)
		return TRUE
	return FALSE

/turf/proc/is_overridden_below(turf/below)
	if(below_override == below && below.above_override == src)
		return TRUE
	return FALSE

/proc/get_dir_multiz_override(turf/us, turf/them)
	us = get_turf(us)
	them = get_turf(them)

	if(!us || !them)
		return NONE
	if(us.z == them.z)
		if(!us.check_overrides() && !them.check_overrides())
			return get_dir(us, them)
		if(us.below_override)
			if(us.is_overridden_below(them))
				return UP
			if(them in get_adjacent_open_turfs(us.below_override))
				return (UP | get_dir(us.below_override, them))
		if(them.below_override)
			if(them.is_overridden_below(us))
				return DOWN
			if(us in get_adjacent_open_turfs(them.below_override))
				return (DOWN | get_dir(them.below_override, us))
	else
		var/turf/T = us.above()
		var/dir = NONE
		if((T && (T.z == them.z)))
			dir = UP
		else
			T = us.below()
			if(T && (T.z == them.z))
				dir = DOWN
			else
				return get_dir(us, them)

		return (dir | get_dir(us, them))
