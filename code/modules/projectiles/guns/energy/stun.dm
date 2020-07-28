/obj/item/gun/energy/taser
	name = "тазер"
	desc = "Энергетический электрошокер малой мощности, используемый группами безопасности для подавления целей на расстоянии."
	icon_state = "taser"
	inhand_icon_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/electrode)
	ammo_x_offset = 3

/obj/item/gun/energy/tesla_revolver
	name = "тесла пушка"
	desc = "Экспериментальная пушка, основанная на экспериментальном двигателе, с такой же вероятностью убьет своего оператора, как и цель."
	icon_state = "tesla"
	inhand_icon_state = "tesla"
	ammo_type = list(/obj/item/ammo_casing/energy/tesla_revolver)
	can_flashlight = FALSE
	pin = null
	shaded_charge = 1

/obj/item/gun/energy/e_gun/advtaser
	name = "гибридный тазер"
	desc = "Двухрежимный тазер, предназначенный для стрельбы как мощными электродами ближнего радиуса действия, так и лучами дальнего действия дальнего действия."
	icon_state = "advtaser"
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/advtaser/cyborg
	name = "тазер киборга"
	desc = "Интегрированный гибридный электрошокер, который берет прямо из силовой ячейки киборга. Оружие содержит ограничитель для предотвращения перегрева силовой ячейки киборга."
	can_flashlight = FALSE
	can_charge = FALSE
	use_cyborg_cell = TRUE

/obj/item/gun/energy/disabler
	name = "усмиритель"
	desc = "Оружие самообороны, которое истощает органические цели, ослабляя их, пока они не упадут."
	icon_state = "disabler"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 10
	fire_delay = 2

/obj/item/gun/energy/disabler/cyborg
	name = "усмиритель киборга"
	desc = "Встроенный блокировщик, который питается от силовой ячейки киборга. Это оружие содержит ограничитель для предотвращения перегрева силовой ячейки киборга."
	can_charge = FALSE
	use_cyborg_cell = TRUE
