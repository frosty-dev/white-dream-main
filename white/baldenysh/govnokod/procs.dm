/area/proc/get_bounds()
	var/minX
	var/minY
	var/maxX
	var/maxY
	for(var/atom/A in contents)
		if(!minX)
			minX = A.x
			minY = A.y
			maxX = A.x
			maxY = A.y

		if(A.x < minX)
			minX = A.x
		else if (A.x > maxX)
			maxX = A.x

		if(A.y < minY)
			minY = A.y
		else if (A.y > maxY)
			maxY = A.y

	return list("minX" = minX, "minY" = minY, "maxX" = maxX, "maxY" = maxY)
/*
/proc/area2text(area/saving)
	var/list/bounds = saving.get_bounds()
*/
