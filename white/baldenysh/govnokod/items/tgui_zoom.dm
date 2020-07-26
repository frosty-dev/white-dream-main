/obj/item/clothing/glasses/monocle/map
	name = "amplification lens"
	var/ui_x = 350
	var/ui_y = 350

	var/map_name

	var/obj/screen/map_overlay/map_overlay
	var/obj/screen/map_view/cam_screen
	var/obj/screen/plane_master/lighting/cam_plane_master
	var/obj/screen/background/cam_background

	var/map_range = 12
	var/datum/movement_detector/tracker

/obj/item/clothing/glasses/monocle/map/equipped(mob/living/carbon/human/user, slot)
	..()
	if(slot == ITEM_SLOT_EYES)
		ui_interact(user)

/obj/item/clothing/glasses/monocle/map/interact(mob/user)
	return FALSE

/obj/item/clothing/glasses/monocle/map/Initialize()
	. = ..()
	tracker = new /datum/movement_detector(src, CALLBACK(src, .proc/update_view))

	map_name = "monocle_[REF(src)]_map"

	map_overlay = new
	map_overlay.name = "screen"
	map_overlay.assigned_map = map_name
	map_overlay.del_on_map_removal = FALSE
	map_overlay.screen_loc = "[map_name]:1,1"

	cam_screen = new
	cam_screen.name = "screen"
	cam_screen.assigned_map = map_name
	cam_screen.del_on_map_removal = FALSE
	cam_screen.screen_loc = "[map_name]:1,1"

	cam_plane_master = new
	cam_plane_master.name = "plane_master"
	cam_plane_master.assigned_map = map_name
	cam_plane_master.del_on_map_removal = FALSE
	cam_plane_master.screen_loc = "[map_name]:CENTER"

	cam_background = new
	cam_background.assigned_map = map_name
	cam_background.del_on_map_removal = FALSE

/obj/item/clothing/glasses/monocle/map/Destroy()
	qdel(map_overlay)
	qdel(cam_screen)
	qdel(cam_plane_master)
	qdel(cam_background)
	return ..()

/obj/screen/map_overlay
	name = "test overlay"
	icon = 'icons/mob/screen_full.dmi'
	icon_state = "curse1"
	layer = ABOVE_HUD_LAYER
	plane = ABOVE_HUD_PLANE

	var/default_width_tiles = 15
	var/default_height_tiles = 15

/obj/item/clothing/glasses/monocle/map/proc/update_view()
	if(!iscarbon(loc))
		return
	var/mob/living/carbon/user = loc

	var/list/visible_turfs = list()
	for(var/turf/T in view(map_range, user))
		visible_turfs += T

	var/list/bbox = get_bbox_of_atoms(visible_turfs)
	var/size_x = bbox[3] - bbox[1] + 1
	var/size_y = bbox[4] - bbox[2] + 1

	cam_screen.vis_contents = visible_turfs
	cam_background.icon_state = "clear"
	cam_background.fill_rect(1, 1, size_x, size_y)

	map_overlay.screen_loc = "[map_name]:[(size_x-map_overlay.default_width_tiles)/2]:16,[(size_y-map_overlay.default_height_tiles)/2]:16"
	var/matrix/M = initial(map_overlay.transform)
	M.Scale((size_x+1)/map_overlay.default_width_tiles, (size_y+1)/map_overlay.default_height_tiles)
	map_overlay.transform = M

/obj/item/clothing/glasses/monocle/map/ui_interact(\
		mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
		datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)

	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		user.client.register_map_obj(map_overlay)
		user.client.register_map_obj(cam_screen)
		user.client.register_map_obj(cam_plane_master)
		user.client.register_map_obj(cam_background)

		ui = new(user, src, ui_key, "MapWindow", name, ui_x, ui_y, master_ui, state)
		ui.open()

	update_view()

/obj/item/clothing/glasses/monocle/map/ui_static_data()
	var/list/data = list()
	data["mapRef"] = map_name
	return data

/obj/item/clothing/glasses/monocle/map/ui_close(mob/user)
	if(user && user.client)
		user.client.clear_map(map_name)

/obj/item/clothing/glasses/monocle/map/ui_status(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.glasses != src)
			. = UI_CLOSE
