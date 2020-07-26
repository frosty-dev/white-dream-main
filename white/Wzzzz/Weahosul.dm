/obj/item/ammo_box/magazine/internal/boltaction98
	name = "bolt action rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/a792x57
	caliber = "a792x57"
	max_ammo = 5
	multiload = 1

/obj/item/ammo_box/n792x57
	name = "ammo box (7.92x57)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/a792x57
	max_ammo = 14

/obj/item/ammo_box/magazine/wzzzz/a792x57
	name = "Clip (7.92x57mm)"
	icon = 'white/Wzzzz/icons/ammo.dmi'
	icon_state = "kclip"
	caliber = "a792x57"
	ammo_type = /obj/item/ammo_casing/a792x57
	max_ammo = 5
	multiple_sprites = TRUE

/obj/item/ammo_casing/a792x57
	name = "7.92x57mm bullet casing"
	desc = "A 7.92x57mm bullet casing."
	caliber = "a792x57"
	projectile_type = /obj/projectile/bullet/a792x57
	icon = 'white/Wzzzz/icons/ammo.dmi'
	icon_state = "rifle_casing"
	inhand_icon_state = "rifle_casing"

/obj/projectile/bullet/a792x57
	damage = 45
	stamina = 25
	speed = 0.4
	armour_penetration = 45

/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k
	name = "kar98k"
	desc = "Some kind of bolt action rifle. You get the feeling you shouldn't have this."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "kar98k"
	inhand_icon_state = "kar98k"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction98
	bolt_wording = "bolt"
	w_class = WEIGHT_CLASS_BULKY
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'white/Wzzzz/kar_shot.ogg'
	fire_sound_volume = 80
	vary_fire_sound = FALSE
	tac_reloads = FALSE
	can_be_sawn_off = FALSE
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/back.dmi'
	slot_flags = ITEM_SLOT_BACK
	can_bayonet = TRUE
	knife_x_offset = 27
	slot_flags = 0
	knife_y_offset = 13

obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_locked ? "open" : "closed"]."

/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/update_icon(var/add_scope = FALSE)
	if (bolt_locked == FALSE)
		icon_state = "kar98k_open"
		inhand_icon_state = "kar98k_open"
	else
		icon_state = "kar98k"
		inhand_icon_state = "kar98k"
	if (bolt_locked == FALSE)
		if(!findtext(icon_state, "_open"))
			icon_state = "kar98k_open"
			inhand_icon_state = "kar98k_open"
	else if(icon_state == "kar98k_open") //closed
		icon_state = "kar98k"
	return

obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/rack(mob/user = null)
	if (bolt_locked == FALSE)
		to_chat(user, "<span class='notice'>You open the bolt of \the [src]</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE)
		bolt_locked = TRUE
		update_icon()
		return
	drop_bolt(user)


/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope
	name = "kar98k scope"
	desc = "Some kind of bolt action rifle. You get the feeling you shouldn't have this."
	icon_state = "kar98k_scope"
	inhand_icon_state = "kar98k_scope"
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	actions_types = list()

obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_locked ? "open" : "closed"]."

/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope/update_icon(var/add_scope = FALSE)
	if (bolt_locked == FALSE)
		icon_state = "kar98k_scope_open"
		inhand_icon_state = "kar98k_scope_open"
		icon = 'white/Wzzzz/icons/Weea.dmi'
		slot_flags = ITEM_SLOT_BACK
		lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
		righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
		worn_icon = 'white/Wzzzz/icons/clothing/mob1/back.dmi'
		fire_sound = 'white/Wzzzz/kar_shot.ogg'
	else
		icon_state = "kar98k_scope"
		inhand_icon_state = "kar98k_scope"
		icon = 'white/Wzzzz/icons/Weea.dmi'
		lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
		righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
		worn_icon = 'white/Wzzzz/icons/clothing/mob1/back.dmi'
		fire_sound = 'white/Wzzzz/kar_shot.ogg'
		return

obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope/rack(mob/user = null)
	if (bolt_locked == FALSE)
		to_chat(user, "<span class='notice'>You open the bolt of \the [src]</span>")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE)
		bolt_locked = TRUE
		update_icon()
		return
	drop_bolt(user)

/obj/item/gun/energy/taser/wzzzz/carbine
	name = "taser carbine"
	desc = "The NT Mk44 NL is a high capacity gun used for non-lethal takedowns. It can switch between high and low intensity stun shots."
	icon_state = "tasercarbine"
	inhand_icon_state = "tasercarbine"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_BACK
	icon = 'white/Wzzzz/icons/Weea.dmi'
	force = 8
	selfcharge = 1
	ammo_x_offset = 2
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/back.dmi'

/obj/item/ammo_casing/energy/electrode/carb
	e_cost = 150
	projectile_type = /obj/projectile/energy/electrode/carb

/obj/projectile/energy/electrode/carb
	damage = 60
	stutter = 7
	jitter = 27
	range = 10

/obj/item/ammo_box/magazine/wt550m9/wzzzz/mc9mmt
	name = "top mounted magazine (9mm)"
	ammo_type = /obj/item/ammo_casing/wzzzz/c9mm
	caliber = "9mm"

/obj/item/ammo_casing/wzzzz/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/projectile/bullet/c9mmt

/obj/projectile/bullet/c9mmt
	damage = 25
	armour_penetration = 13.5

/obj/item/gun/ballistic/automatic/wt550/wzzzz/german
	name = "9mm machine pistol"
	desc = "The W-T 550 Saber is a cheap self-defense weapon, mass-produced by Ward-Takahashi for paramilitary and private use. Uses 9mm rounds."
	icon_state = "wt550"
	burst_size = 3
	inhand_icon_state = "wt550"
	lefthand_file = 'white/Wzzzz/icons/clothing/mob/lefthand_guns.dmi'
	righthand_file = 'white/Wzzzz/icons/clothing/mob/righthand_guns.dmi'
	mag_type = /obj/item/ammo_box/magazine/wt550m9/wzzzz/mc9mmt
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/chainsaw/wzzzz
	name = "circular saw"
	desc = "Good against wood or flesh, bad against steel."
	icon_state = "saw"
	icon = 'white/Wzzzz/icons/Weea.dmi'
	inhand_icon_state = "saw"
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	throwforce = 12
	force = 13
	force_on = 27
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	armour_penetration = 0
	sharpness = 5

/obj/item/shovel/serrated/wzzzz
	name = "bone shovel"
	desc = "Weapon and tool together."
	icon = 'white/Wzzzz/icons/Weea.dmi'
	throwforce = 10
	force = 12

/obj/item/shovel/spade/wzzz
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "german_shovel2"
	inhand_icon_state = "german_shovel2"
	righthand_file = 'white/Wzzzz/icons/Weear.dmi'
	lefthand_file = 'white/Wzzzz/icons/Weeal.dmi'
	throwforce = 11
	force = 12

/obj/item/pickaxe/silver/wzzzz
	name = "bone pickaxe"
	desc = "Improvise your life with bones and wood."
	toolspeed = 0.2
	force = 12
	throwforce = 8
	icon = 'white/Wzzzz/icons/Weea.dmi'
	icon_state = "pickaxe_bone"
	inhand_icon_state = "pickaxe_bone"

/obj/item/clothing/mask/cigarette/pipe/cobpipe/wzzzz
	icon = 'white/Wzzzz/icons/Weea.dmi'
	name = "pipe"
