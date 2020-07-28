/obj/item/gun/energy/pulse
	name = "импульсная винтовка"
	desc = "Мощная многогранная энергетическая винтовка с тремя режимами. Такие используют на фронте."
	icon_state = "pulse"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	modifystate = TRUE
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	cell_type = "/obj/item/stock_parts/cell/pulse"

/obj/item/gun/energy/pulse/emp_act(severity)
	return

/obj/item/gun/energy/pulse/prize
	pin = /obj/item/firing_pin

/obj/item/gun/energy/pulse/prize/Initialize()
	. = ..()
	GLOB.poi_list += src
	var/turf/T = get_turf(src)

	message_admins("A pulse rifle prize has been created at [ADMIN_VERBOSEJMP(T)]")
	log_game("A pulse rifle prize has been created at [AREACOORD(T)]")

	notify_ghosts("Кто-то получил импульсную винтовку в качестве приза!", source = src, action = NOTIFY_ORBIT, header = "ПУЛЬСАЧИК")

/obj/item/gun/energy/pulse/prize/Destroy()
	GLOB.poi_list -= src
	. = ..()

/obj/item/gun/energy/pulse/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/carbine
	name = "импульсный карабин"
	desc = "Компактный вариант импульсной винтовки с меньшей огневой мощью, но более простым в хранении."
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	icon_state = "pulse_carbine"
	inhand_icon_state = null
	cell_type = "/obj/item/stock_parts/cell/pulse/carbine"
	can_flashlight = TRUE
	flight_x_offset = 18
	flight_y_offset = 12

/obj/item/gun/energy/pulse/carbine/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/pistol
	name = "импульсный пистолет"
	desc = "Импульсная винтовка в легко скрываемой упаковке пистолета с низкой емкостью."
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	icon_state = "pulse_pistol"
	inhand_icon_state = "gun"
	cell_type = "/obj/item/stock_parts/cell/pulse/pistol"

/obj/item/gun/energy/pulse/pistol/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/destroyer
	name = "импульсный разрушитель"
	desc = "Мощная энергетическая винтовка, созданная для чистого уничтожения."
	cell_type = "/obj/item/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)

/obj/item/gun/energy/pulse/destroyer/attack_self(mob/living/user)
	to_chat(user, "<span class='danger'>[src.name] имеет три настройки и все они в режиме УНИЧТОЖИТЬ.</span>")

/obj/item/gun/energy/pulse/pistol/m1911
	name = "\improper M1911-P"
	desc = "Компактный импульсный сердечник в классической рамке для пистолета для офицеров Nanotrasen. Это не размер пистолета, это размер отверстия, которое он пропускает через людей."
	icon_state = "m1911"
	inhand_icon_state = "gun"
	cell_type = "/obj/item/stock_parts/cell/infinite"
