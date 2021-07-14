// SPAS12

/obj/item/gun/ballistic/shotgun/spas12
	name = "Franchi SPAS-12"
	desc = "Древний, но эффективный дробовик, разработанный в Италии. Предназначался для использования силовыми структурами."
	icon_state = "spas12"
	icon = 'white/rebolution228/icons/weapons/spas12.dmi'
	lefthand_file = 'white/rebolution228/icons/weapons/guns_inhand_left.dmi'
	righthand_file = 'white/rebolution228/icons/weapons/guns_inhand_right.dmi'
	inhand_icon_state = "spess12"
	worn_icon = 'white/rebolution228/icons/weapons/guns_back.dmi'
	worn_icon_state = "spas12_back"
	fire_sound = 'white/rebolution228/sounds/weapons/spas_shoot.ogg'
	rack_sound = 'white/rebolution228/sounds/weapons/spas_pump.ogg'
	load_sound = 'white/rebolution228/sounds/weapons/spas_insert.ogg'
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal/eight
	weapon_weight = WEAPON_HEAVY
	pb_knockback = 1
	fire_delay = 5
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/gun/ballistic/shotgun/spas12/rubber
	mag_type = /obj/item/ammo_box/magazine/internal/shot/riot/eight

/obj/item/ammo_box/magazine/internal/shot/lethal/eight // lethal rounds
	max_ammo = 8
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/magazine/internal/shot/riot/eight // rubber rounds
	max_ammo = 8
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot


// M41A MKII

/obj/item/gun/ballistic/automatic/m41a2
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel
	name = "Импульсная Винтовка M41A"
	desc = "Основное оружие колониальных морпехов, оснащенная подствольным 40мм гранатомётом. Использует безгильзовые 10х24мм патроны. Неплохо работает против ксеноморфов."
	icon = 'white/rebolution228/icons/weapons/rguns.dmi'
	icon_state = "m41a2"
	inhand_icon_state = "m41a2"
	selector_switch_icon = TRUE
	lefthand_file = 'white/rebolution228/icons/weapons/guns_inhand_left.dmi'
	righthand_file = 'white/rebolution228/icons/weapons/guns_inhand_right.dmi'
	mag_type = /obj/item/ammo_box/magazine/m41a/caseless
	worn_icon = 'white/rebolution228/icons/weapons/guns_back.dmi'
	worn_icon_state = "m41a2_back"
	pin = /obj/item/firing_pin
	fire_delay = 1.5
	slot_flags = ITEM_SLOT_BACK
	can_suppress = FALSE
	burst_size = 4
	empty_indicator = TRUE
	spread = 5
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'white/rebolution228/sounds/weapons/fire_m41a1.ogg'
	var/list/fucking = list('white/rebolution228/sounds/weapons/fire_m41a1.ogg',
						'white/rebolution228/sounds/weapons/fire_m41a2.ogg',
						'white/rebolution228/sounds/weapons/fire_m41a3.ogg',
						'white/rebolution228/sounds/weapons/fire_m41a4.ogg')

/obj/item/gun/ballistic/automatic/m41a2/process_chamber()
	. = ..()
	fire_sound = pick(fucking)

/obj/item/gun/ballistic/automatic/m41a2/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/m41a
	update_icon()

/obj/item/gun/ballistic/automatic/m41a2/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/m41a2/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, "<span class='notice'>Выбираю режим стрельбы очередью.</span>")
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>Выбираю режим гранатомёта.</span>")
		if(2)
			select = 0
			burst_size = 1
			fire_delay = 0
			to_chat(user, "<span class='notice'>Выбираю полуавтоматический режим.</span>")
	playsound(user, 'white/rebolution228/sounds/weapons/dryfire1.ogg', 100, TRUE)
	update_icon()
	return

/obj/item/gun/ballistic/automatic/m41a2/update_overlays()
	. = ..()
	switch(select)
		if(0)
			. += "[initial(icon_state)]_semi"
		if(1)
			. += "[initial(icon_state)]_burst"
		if(2)
			. += "[initial(icon_state)]_gren"

/obj/item/gun/ballistic/automatic/m41a2/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self(user)
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/gun/ballistic/automatic/m41a2/update_icon()
	..()
	if(magazine)
		icon_state = "m41a2"
		if(magazine.ammo_count() <= 0)
			icon_state = "m41a2_nm"
	else
		icon_state = "m41a2_e"

// m41a2 ammo

/obj/item/ammo_box/magazine/m41a/caseless
	name = "M41A2 Magazine"
	icon = 'white/rebolution228/icons/weapons/rammo.dmi'
	icon_state = "m41a2"
	ammo_type = /obj/item/ammo_casing/caseless/m41acaseless
	caliber = "10x24mm"
	max_ammo = 99

/obj/item/ammo_box/magazine/m41a/caseless/update_icon()
	..()
	if(ammo_count() <= 0)
		icon_state = "m41a2_e"
	else
		icon_state = "m41a2"

/obj/projectile/bullet/m41acaseless
	name = "10x24мм пуля"
	damage = 25
	armour_penetration = 25
	wound_bonus = -40

/obj/projectile/bullet/m41acaseless/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isalien(target))
		damage = 50

/obj/item/ammo_casing/caseless/m41acaseless
	name = "10x24мм патрон"
	projectile_type = /obj/projectile/bullet/m41acaseless

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/m41a
	fire_sound = 'white/rebolution228/sounds/weapons/fire_m41agrenadelauncher.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher/m41a

/obj/item/ammo_box/magazine/internal/grenadelauncher/m41a
	max_ammo = 2

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/m41a/afterattack()
	. = ..()
	magazine.get_round(FALSE)

// AS VAL

/obj/item/gun/ballistic/automatic/asval
	name = "АС 'Вал'"
	desc = "Бесшумный автомат, используемый войсками осназа Новой России. Использует 9х39 калибр."
	icon = 'white/rebolution228/icons/weapons/rguns.dmi'
	icon_state = "asval"
	inhand_icon_state = "asval"
	selector_switch_icon = TRUE
	lefthand_file = 'white/rebolution228/icons/weapons/guns_inhand_left.dmi'
	righthand_file = 'white/rebolution228/icons/weapons/guns_inhand_right.dmi'
	worn_icon = 'white/rebolution228/icons/weapons/guns_back.dmi'
	worn_icon_state = "asval_back"
	mag_type = /obj/item/ammo_box/magazine/asval
	pin = /obj/item/firing_pin
	fire_delay = 1
	slot_flags = ITEM_SLOT_BACK
	burst_size = 3
	empty_indicator = FALSE
	spread = 3
	weapon_weight = WEAPON_HEAVY
	fire_sound = 'white/rebolution228/sounds/weapons/fire_asval.ogg'
	rack_sound = 'white/rebolution228/sounds/weapons/asval_zatvor.ogg'
	can_suppress = FALSE

/obj/item/ammo_box/magazine/asval
	name = "9х39 магазин"
	icon = 'white/rebolution228/icons/weapons/rammo.dmi'
	icon_state = "asval"
	ammo_type = /obj/item/ammo_casing/c9x39
	caliber = "9x39"
	max_ammo = 20

/obj/item/ammo_box/magazine/asval/update_icon()
	..()
	if(ammo_count() <= 0)
		icon_state = "asval_e"
	else
		icon_state = "asval"

/obj/item/ammo_casing/c9x39
	name = "9x39 гильза"
	projectile_type = /obj/projectile/bullet/c9x39eb

/obj/projectile/bullet/c9x39eb
	name = "9x39 пуля"
	damage = 40
	armour_penetration = 70
	wound_bonus = 10

// AK74M

/obj/item/gun/ballistic/automatic/ak74m
	name = "AK-74M"
	desc = "Младший брат автомата АК. Использует 5.45 калибр."
	icon = 'white/rebolution228/icons/weapons/rguns.dmi'
	icon_state = "ak74m"
	inhand_icon_state = "ak74m"
	selector_switch_icon = TRUE
	lefthand_file = 'white/rebolution228/icons/weapons/guns_inhand_left.dmi'
	righthand_file = 'white/rebolution228/icons/weapons/guns_inhand_right.dmi'
	worn_icon = 'white/rebolution228/icons/weapons/guns_back.dmi'
	worn_icon_state = "ak74m_back"
	mag_type = /obj/item/ammo_box/magazine/ak74m
	pin = /obj/item/firing_pin
	fire_delay = 2
	slot_flags = ITEM_SLOT_BACK
	burst_size = 3
	empty_indicator = FALSE
	spread = 5
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	rack_sound = 'white/rebolution228/sounds/weapons/74_zatvor.ogg'
	eject_sound = 'white/rebolution228/sounds/weapons/74_magout.ogg'
	eject_empty_sound = 'white/rebolution228/sounds/weapons/74_magout.ogg'
	load_sound = 'white/rebolution228/sounds/weapons/74_magout.ogg'
	load_empty_sound = 'white/rebolution228/sounds/weapons/74_magin.ogg'
	fire_sound = 'white/rebolution228/sounds/weapons/74_ebashit1.ogg'
	var/list/huipizdaaa = list('white/rebolution228/sounds/weapons/74_ebashit1.ogg',
							'white/rebolution228/sounds/weapons/74_ebashit2.ogg',
							'white/rebolution228/sounds/weapons/74_ebashit3.ogg')
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/ak74m/process_chamber()
	. = ..()
	fire_sound = pick(huipizdaaa)

/obj/item/ammo_box/magazine/ak74m
	name = "AK-74 Magazine (5.45)"
	icon = 'white/rebolution228/icons/weapons/rammo.dmi'
	icon_state = "ak74m"
	ammo_type = /obj/item/ammo_casing/a545
	caliber = "a545"
	max_ammo = 30

/obj/item/ammo_box/magazine/ak74m/update_icon()
	..()
	if(ammo_count() <= 0)
		icon_state = "ak74m_e"
	else
		icon_state = "ak74m"

/obj/item/ammo_casing/a545
	name = "5.45x39 гильза"
	icon_state = ".50"
	projectile_type = /obj/projectile/bullet/a545

/obj/projectile/bullet/a545
	name = "5.45 пуля"
	damage = 30
	armour_penetration = 20
	wound_bonus = -20

// AK74M GP25

/obj/item/gun/ballistic/automatic/ak74m/gp25
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel
	desc = "Младший брат автомата АК. Использует 5.45 калибр. Имеет при себе подствольник ГП-25."
	icon_state = "ak74mgl"
	inhand_icon_state = "ak74mgl"
	worn_icon_state = "ak74mgl_back"

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/gp25
	fire_sound = 'white/rebolution228/sounds/weapons/fire_m41agrenadelauncher.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher/gp25

/obj/item/ammo_box/magazine/internal/grenadelauncher/gp25
	name = "ebalo"
	ammo_type = /obj/item/ammo_casing/a40mm/vog25
	caliber = "40mmvog"
	max_ammo = 1

/obj/item/gun/ballistic/automatic/ak74m/gp25/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self(user)
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/ammo_casing/a40mm/vog25
	name = "Выстрел ВОГ-25"
	desc = "Бум."
	caliber = "40mmvog"
	icon = 'white/rebolution228/icons/weapons/rammo.dmi'
	icon_state = "vog25"
	projectile_type = /obj/projectile/bullet/vog25

/obj/projectile/bullet/vog25
	name = "40mm grenade"
	icon = 'white/rebolution228/icons/weapons/projectile.dmi'
	icon_state = "vog25"
	damage = 150

/obj/projectile/bullet/vog25/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 2, 3, 4, flame_range = 4)
	return BULLET_ACT_HIT

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/gp25/afterattack()
	. = ..()
	magazine.get_round(FALSE)

/obj/item/gun/ballistic/automatic/ak74m/gp25/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/gp25
	update_icon()

/obj/item/gun/ballistic/automatic/ak74m/gp25/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/ak74m/gp25/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, "<span class='notice'>Выбираю режим стрельбы очередью.</span>")
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>Выбираю режим стрельбы из подствольника.</span>")
		if(2)
			select = 0
			burst_size = 1
			fire_delay = 0
			to_chat(user, "<span class='notice'>Выбираю полуавтоматический режим.</span>")
	playsound(user, 'white/rebolution228/sounds/weapons/dryfire1.ogg', 100, TRUE)
	update_icon()
	return
