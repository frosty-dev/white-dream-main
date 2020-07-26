SUBSYSTEM_DEF(orb_mech)
	name = "Orbital Mechanics"
	priority = FIRE_PRIORITY_SPACEDRIFT
	wait = 600
//	flags = SS_NO_TICK_CHECK|SS_NO_INIT
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/gravConst = 0.05

	var/list/processing = list()

/datum/controller/subsystem/orb_mech/PreInit()


/datum/controller/subsystem/orb_mech/fire()

/datum/controller/subsystem/orb_mech/proc/gravAttract(list/bodies)
	var/datum/abVector/disp = new

	for(var/datum/astrobody/this in bodies)
		for(var/datum/astrobody/other in bodies)
			if(this == other)
				continue

			disp.owVec(other.pos.subVec(this.pos))

			var/dist = disp.magnitude()

			if(dist > 0)
				var/dir = disp.divScal(dist)

				var/gravMag = this.mass * other.mass * gravConst / (dist * dist)

				this.force.owVec(dir.mulScal(0 - gravMag))

