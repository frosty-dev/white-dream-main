/obj/item/clothing/shoes/sneakers
	dying_key = DYE_REGISTRY_SNEAKERS

/obj/item/clothing/shoes/sneakers/black
	name = "чёрные туфли"
	icon_state = "black"
	desc = "Парочка чёрных туфель."
	custom_price = 50

	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT

/obj/item/clothing/shoes/sneakers/brown
	name = "коричневые туфли"
	desc = "Парочка коричневых туфель."
	icon_state = "brown"

/obj/item/clothing/shoes/sneakers/blue
	name = "синие туфли"
	icon_state = "blue"

/obj/item/clothing/shoes/sneakers/green
	name = "зелёные туфли"
	icon_state = "green"

/obj/item/clothing/shoes/sneakers/yellow
	name = "жёлтые туфли"
	icon_state = "yellow"

/obj/item/clothing/shoes/sneakers/purple
	name = "фиолетовые туфли"
	icon_state = "purple"

/obj/item/clothing/shoes/sneakers/red
	name = "красные туфли"
	desc = "Stylish red shoes."
	icon_state = "red"

/obj/item/clothing/shoes/sneakers/white
	name = "белые туфли"
	icon_state = "white"
	permeability_coefficient = 0.01

/obj/item/clothing/shoes/sneakers/rainbow
	name = "радужные туфли"
	desc = "Very gay shoes."
	icon_state = "rain_bow"

/obj/item/clothing/shoes/sneakers/orange
	name = "оранжевые туфли"
	icon_state = "orange"

/obj/item/clothing/shoes/sneakers/orange/attack_self(mob/user)
	if (src.chained)
		src.chained = null
		src.slowdown = SHOES_SLOWDOWN
		new /obj/item/restraints/handcuffs( user.loc )
		src.icon_state = "orange"
	return

/obj/item/clothing/shoes/sneakers/orange/attackby(obj/H, loc, params)
	..()
	// Note: not using istype here because we want to ignore all subtypes
	if (H.type == /obj/item/restraints/handcuffs && !chained)
		qdel(H)
		src.chained = 1
		src.slowdown = 15
		src.icon_state = "orange1"
	return

/obj/item/clothing/shoes/sneakers/orange/allow_attack_hand_drop(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/C = user
		if(C.shoes == src && chained == 1)
			to_chat(user, "<span class='warning'>Мне бы не помешала помощь чтобы снять их!</span>")
			return FALSE
	return ..()

/obj/item/clothing/shoes/sneakers/orange/MouseDrop(atom/over)
	var/mob/m = usr
	if(ishuman(m))
		var/mob/living/carbon/human/c = m
		if(c.shoes == src && chained == 1)
			to_chat(c, "<span class='warning'>Мне бы не помешала помощь чтобы снять их!</span>")
			return
	return ..()

