/datum/component/aoe_melee
	var/obj/item/master = null

/datum/component/aoe_melee/Initialize()
	if(istype(parent, /obj/item))
		master = parent
	else
		qdel(src)

/datum/component/aoe_melee/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, .proc/start_attack)

/datum/component/aoe_melee/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_AFTERATTACK)

/datum/component/aoe_melee/proc/start_attack(atom/target, mob/user)
	if(get_dist(user, target) <= master.reach)
		return

/datum/component/aoe_melee/swing
	var/cur_angle = 0

	var/attack_cone = 180
	var/deg_between_hits = 45

	var/clockwise = TRUE
	var/segments_per_action = 6
	var/time_per_action = 0.15

	var/image/anim_img = null
	var/anim_size_mod = 0.75
	var/init_img_turn = 0
	var/radius = 26

	var/anim_flags = ANIMATION_PARALLEL

	var/hitproc_debug = TRUE
	var/hitproc_obj = /obj/item/wrench

/datum/component/aoe_melee/swing/proc/prepare_img(atom/target, mob/user)
	anim_img = image(icon = master, loc = master.loc, layer = user.layer + 0.1)
	anim_img.plane = GAME_PLANE
	anim_img.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

	var/direction = get_dir(user, target)
	cur_angle = dir2angle(direction)

	anim_img.transform = anim_img.transform.Turn(init_img_turn + cur_angle)

	anim_img.transform *= anim_size_mod

	var/matrix/shift = matrix(anim_img.transform)

	if(direction & NORTH)
		shift.Translate(0, radius)
	else if(direction & SOUTH)
		shift.Translate(0, -radius)
	if(direction & EAST)
		shift.Translate(radius, 0)
	else if(direction & WEST)
		shift.Translate(-radius, 0)

	anim_img.transform = shift

/datum/component/aoe_melee/swing/start_attack(atom/target, mob/user)
	..()

	prepare_img(target, user)

	var/rotations = attack_cone/deg_between_hits

	flick_overlay_view(anim_img, user, time_per_action*rotations*segments_per_action)

	var/half_cone = attack_cone/2

	if(clockwise)
		half_cone = -half_cone

	anim_img.transform = anim_img.transform.Turn(half_cone)
	cur_angle += half_cone

	animate(anim_img, transform = matrix(anim_img.transform), time = time_per_action, 1, flags = anim_flags)
	hitproc(get_step(master, angle2dir(cur_angle)))

	for(var/i in 1 to rotations)
		rotate(deg_between_hits)
		var/local_angle = cur_angle
		spawn(time_per_action*segments_per_action*i)
			hitproc(get_step(master, angle2dir(local_angle)))

/datum/component/aoe_melee/swing/proc/hitproc(turf/loc)
	if(hitproc_debug)
		new hitproc_obj(loc)
		return
	return

/datum/component/aoe_melee/swing/proc/rotate(angle)
	if(clockwise)
		angle = -angle

	cur_angle += angle

	var/list/matrices = generate_turn_matrices(anim_img, angle)
	for(var/matrix/mtrx in matrices)
		animate(transform = mtrx, time = time_per_action)

/datum/component/aoe_melee/swing/proc/generate_turn_matrices(image/img, angle)
	var/list/matrices = list()
	var/segment = angle/segments_per_action

	for(var/i in 1 to segments_per_action)
		var/matrix/M = img.transform
		M.Turn(segment*i)
		matrices += M

	return matrices





/obj/item/claymore/aoetest
	name = "anime sord"

/obj/item/claymore/aoetest/Initialize()
	. = ..()
	var/datum/component/aoe_melee/swing/SW = AddComponent(/datum/component/aoe_melee/swing)
	SW.init_img_turn = -45

/obj/item/fireaxe/ayetest
	name = "anime tonop"
	var/datum/component/aoe_melee/swing/SW = null

/obj/item/fireaxe/ayetest/Initialize()
	. = ..()
	var/datum/component/aoe_melee/swing/SW = AddComponent(/datum/component/aoe_melee/swing)
	SW.init_img_turn = 90
