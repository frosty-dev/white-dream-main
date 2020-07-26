/datum/component/glooed
	var/gloo_applied = 0

	var/obj_fullgloo = 3
	var/carbon_fullgloo = 15

	var/head_glooed = FALSE
	var/chest_glooed = FALSE
	var/larm_glooed = FALSE
	var/rarm_glooed = FALSE
	var/lleg_glooed = FALSE
	var/rleg_glooed = FALSE

/datum/component/glooed/Initialize()
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/glooed/RegisterWithParent()
	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, .proc/ungloo)

/datum/component/glooed/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT)

/datum/component/glooed/proc/ungloo()
	qdel(src)

/datum/component/glooed/proc/fullgloo()
	var/atom/movable/A = parent
	var/obj/structure/spider/cocoon/gloo/G = new(get_turf(A))
	A.forceMove(G)
	qdel(src)

/datum/component/glooed/proc/get_glooed(amount)
	if(isitem(parent))
		fullgloo()
		return

	gloo_applied += amount

	if(isobj(parent) && gloo_applied >= obj_fullgloo)
		fullgloo()
		return

	if(iscarbon(parent) && gloo_applied >= carbon_fullgloo)
		fullgloo()
		return

/datum/component/glooed/proc/get_glooed_carbon(def_zone)
	if(def_zone == BODY_ZONE_HEAD)
		head_glooed = TRUE
	if(def_zone == BODY_ZONE_CHEST)
		chest_glooed = TRUE
	if(def_zone == BODY_ZONE_L_ARM)
		larm_glooed = TRUE
	if(def_zone == BODY_ZONE_R_ARM)
		rarm_glooed = TRUE
	if(def_zone == BODY_ZONE_L_LEG)
		lleg_glooed = TRUE
	if(def_zone == BODY_ZONE_R_LEG)
		rleg_glooed = TRUE

	if(head_glooed&&chest_glooed&&larm_glooed&&rarm_glooed&&lleg_glooed&&rleg_glooed)
		fullgloo()

/obj/structure/spider/cocoon/gloo
	name = "нитропеновый кокон"
	desc = "Something wrapped in nitrofoam."
