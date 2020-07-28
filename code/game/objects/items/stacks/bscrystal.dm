//Bluespace crystals, used in telescience and when crushed it will blink you to a random turf.
/obj/item/stack/ore/bluespace_crystal
	name = "блюспейс кристаллы"
	desc = "Светящийся блюспейс кристалл, мало что известно о том, как они работают. Этот выглядит очень деликатно."
	icon = 'icons/obj/telescience.dmi'
	icon_state = "bluespace_crystal"
	singular_name = "блюспейс кристалл"
	dye_color = DYE_COSMIC
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/bluespace=MINERAL_MATERIAL_AMOUNT)
	points = 50
	var/blink_range = 8 // The teleport range when crushed/thrown at someone.
	refined_type = /obj/item/stack/sheet/bluespace_crystal
	grind_results = list(/datum/reagent/bluespace = 20)
	scan_state = "rock_BScrystal"

/obj/item/stack/ore/bluespace_crystal/refined
	name = "изысканный блюспейс кристалл"
	points = 0
	refined_type = null

/obj/item/stack/ore/bluespace_crystal/Initialize()
	. = ..()
	if(loc)
		forceMove(loc, rand(-5, 5), rand(-5, 5))

/obj/item/stack/ore/bluespace_crystal/get_part_rating()
	return 1

/obj/item/stack/ore/bluespace_crystal/attack_self(mob/user)
	user.visible_message("<span class='warning'><b>[user]</b> раздавливает <b>[src]</b>!</span>", "<span class='danger'>Раздавливаю <b>[src]</b>!</span>")
	new /obj/effect/particle_effect/sparks(loc)
	playsound(loc, "sparks", 50, TRUE)
	blink_mob(user)
	use(1)

/obj/item/stack/ore/bluespace_crystal/proc/blink_mob(mob/living/L)
	do_teleport(L, get_turf(L), blink_range, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/item/stack/ore/bluespace_crystal/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) // not caught in mid-air
		visible_message("<span class='notice'><b>[capitalize(src)]</b> шипит и исчезает при ударе!</span>")
		var/turf/T = get_turf(hit_atom)
		new /obj/effect/particle_effect/sparks(T)
		playsound(loc, "sparks", 50, TRUE)
		if(isliving(hit_atom))
			blink_mob(hit_atom)
		use(1)

//Artificial bluespace crystal, doesn't give you much research.
/obj/item/stack/ore/bluespace_crystal/artificial
	name = "искусственный блюспейс кристалл"
	desc = "Искусственно сделанный блюспейс кристалл, выглядит изысканно."
	custom_materials = list(/datum/material/bluespace=MINERAL_MATERIAL_AMOUNT*0.5)
	blink_range = 4 // Not as good as the organic stuff!
	points = 0 //nice try
	refined_type = null
	grind_results = list(/datum/reagent/bluespace = 10, /datum/reagent/silicon = 20)

//Polycrystals, aka stacks
/obj/item/stack/sheet/bluespace_crystal
	name = "блюспейс поликристаллы"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "polycrystal"
	inhand_icon_state = "sheet-polycrystal"
	singular_name = "блюспейс поликристалл"
	desc = "Стабильный поликристалл, изготовленный из сплавленных блюспейс кристаллов. Вы могли бы вероятно сломать один."
	custom_materials = list(/datum/material/bluespace=MINERAL_MATERIAL_AMOUNT)
	attack_verb =list("блюспейс полибьёт", "блюспейс полиударяет", "блюспейс полилупит", "блюспейс поливмазывает", "блюспейс полиразносит")
	novariants = TRUE
	grind_results = list(/datum/reagent/bluespace = 20)
	point_value = 30
	var/crystal_type = /obj/item/stack/ore/bluespace_crystal/refined

/obj/item/stack/sheet/bluespace_crystal/attack_self(mob/user)// to prevent the construction menu from ever happening
	to_chat(user, "<span class='warning'>Не могу сломать целый поликристалл в руке. Надо бы их разделить.</span>")

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/stack/sheet/bluespace_crystal/attack_hand(mob/user)
	if(user.get_inactive_held_item() == src)
		if(zero_amount())
			return
		var/BC = new crystal_type(src)
		user.put_in_hands(BC)
		use(1)
		if(!amount)
			to_chat(user, "<span class='notice'>Разбиваю последний кристалл.</span>")
		else
			to_chat(user, "<span class='notice'>Разбиваю кристалл.</span>")
	else
		..()
