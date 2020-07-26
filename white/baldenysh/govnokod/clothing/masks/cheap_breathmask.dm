/obj/item/clothing/mask/breath/cheap
	name = "дыхательная маска"
	desc = "Дыхательная маска, сделанная из пластика."
	max_integrity = 50
	icon_state = "breath"
	inhand_icon_state = "m_mask"

/obj/item/clothing/mask/breath/cheap/equipped(mob/M, slot)
	. = ..()
	RegisterSignal(M, COMSIG_MOB_APPLY_DAMGE, .proc/damage_mask, override = TRUE)

/obj/item/clothing/mask/breath/cheap/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_APPLY_DAMGE)

/obj/item/clothing/mask/gas/cheap
	name = "противогаз"
	desc = "Бюджетный противогаз."
	max_integrity = 80

/obj/item/clothing/mask/gas/cheap/equipped(mob/M, slot)
	. = ..()
	RegisterSignal(M, COMSIG_MOB_APPLY_DAMGE, .proc/damage_mask, override = TRUE)

/obj/item/clothing/mask/gas/cheap/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_APPLY_DAMGE)

/obj/item/clothing/mask/attackby(obj/item/W, mob/user, params)
	if(damaged_clothes && istype(W, /obj/item/stack/sticky_tape))
		var/obj/item/stack/sticky_tape/T = W
		T.use(5)
		update_clothes_damaged_state(FALSE)
		obj_integrity = max_integrity
		playsound(user, 'white/valtos/sounds/ducttape1.ogg', 50, 1)
		to_chat(user, "<span class='notice'>Чиню повреждения [src] используя [T].</span>")
		clothing_flags = initial(clothing_flags)
		visor_flags = initial(visor_flags)
		desc = initial(desc)
		return 1
	return ..()

/obj/item/clothing/mask/proc/damage_mask(datum/source, damage, damagetype, def_zone)
	if(def_zone != BODY_ZONE_HEAD)
		return
	if(damagetype != BRUTE)
		return
	if(!(clothing_flags & MASKINTERNALS))
		return
	if(damage < 5)
		return

	take_damage(damage, sound_effect=FALSE)

	if(obj_integrity/max_integrity < 0.5)
		clothing_flags = 0
		visor_flags = 0
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			C.visible_message("<span class='warning'>[src] [C] трескается!</span>", "<span class='danger'>[src] трескается!</span>")
			desc += " Поверхность покрыта множеством трещин."




