/datum/abVector
	var/x
	var/y

/datum/abVector/New(/datum/abVector/V, new_x, new_y)
	if(V)
		x = V.x
		y = V.y
	else if(new_x && new_y)
		x = new_x
		y = new_y
	else
		x = 0
		y = 0

///////////////// vsem priv mne len' ebatsya s overloadingom

/datum/abVector/proc/addVec(/datum/abVector/V)
	x += V.x
	y += V.y

/datum/abVector/proc/subVec(/datum/abVector/V)
	x -= V.x
	y -= V.y

/datum/abVector/proc/mulVec(/datum/abVector/V)
	x *= V.x
	y *= V.y

/datum/abVector/proc/divVec(/datum/abVector/V)
	if(V.x != 0)
		x /= V.x
	if(V.y != 0)
		y /= V.y

/datum/abVector/proc/owVec(/datum/abVector/V)
	x = V.x
	y = V.y

///////////////////

/datum/abVector/proc/addScal(xS, yS)
	if(yS)
		x += xS
		y += yS
	else
		x += xS
		y += xS

/datum/abVector/proc/subScal(xS, yS)
	if(yS)
		x -= xS
		y -= yS
	else
		x -= xS
		y -= xS

/datum/abVector/proc/mulScal(xS, yS)
	if(yS)
		x *= xS
		y *= yS
	else
		x *= xS
		y *= xS

/datum/abVector/proc/divScal(xS, yS)
	if(yS)
		if(xS != 0)
			x /= xS
		if(yS != 0)
			y /= yS
	else
		if(xS != 0)
			x /= xS
			y /= xS

/datum/abVector/proc/owScal(new_x, new_y)
	if(yS)
		x = new_x
		y = new_y
	else
		x = new_x
		y = new_x

//////////////////

/datum/abVector/proc/clone()
	return new /datum/abVector(x, y)

/datum/abVector/proc/magnitude()
	return sqrt(x * x + y * y)





