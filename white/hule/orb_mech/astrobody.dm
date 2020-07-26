/datum/astrobody
	var/name
	var/mass
	var/radius
	var/heading = 0

	var/datum/abVector/pos
	var/datum/abVector/vel

	var/datum/abVector/accel
	var/datum/abVector/force

/datum/astrobody/t_attr
	name = "test attractor"
	mass = 3000
	radius = 20

/datum/astrobody/t_mvr
	name = "test mover"
	mass = 1
	radius = 5



