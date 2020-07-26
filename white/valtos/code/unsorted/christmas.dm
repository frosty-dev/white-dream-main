/obj/item/stack/garland_pack
	name = "упаковка с гирляндами"
	singular_name = "упаковка с гирляндой"
	desc = "Похоже, пришло время вешать это на стены."
	icon = 'white/valtos/icons/ny.dmi'
	icon_state = "garland_pack"
	merge_type = /obj/item/stack/garland_pack
	max_amount = 50
	novariants = TRUE

/obj/item/stack/garland_pack/fifty
	amount = 50

/obj/item/stack/garland_pack/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(isclosedturf(target) && proximity)
		var/turf/closed/T = target
		if(locate(/obj/structure/garland) in T)
			to_chat(user, "<span class='warning'>Здесь уже есть гирлянда!</span>")
			return
		if(use(1))
			user.visible_message("<span class='notice'>[user] вешает [src] на [T].</span>", \
								"<span class='notice'>Вешаю гирлянду на [T].</span>")
			playsound(T, 'sound/items/deconstruct.ogg', 50, TRUE)
			var/obj/structure/garland/S = new(T)
			transfer_fingerprints_to(S)

/obj/structure/snowflakes
	name = "снежинки"
	desc = "Выглядят ужасно."
	icon = 'white/valtos/icons/ny.dmi'
	icon_state = "snowflakes_1"
	layer = SIGN_LAYER

/obj/structure/snowflakes/Initialize()
	. = ..()
	icon_state = "snowflakes_[rand(1, 4)]"

/obj/structure/garland
	name = "гирлянда"
	desc = "Зима близко!"
	anchored = TRUE
	opacity = FALSE
	icon = 'white/valtos/icons/ny.dmi'
	icon_state = "garland"
	layer = SIGN_LAYER
	max_integrity = 100
	var/on = FALSE
	var/brightness = 4

/obj/structure/garland/Initialize()
	. = ..()
	light_color = pick("#ff0000", "#6111ff", "#ffa500", "#44faff")
	update_garland()

/obj/structure/garland/proc/update_garland()
	if(!on)
		icon_state = "garland_on"
		set_light(brightness)
	else
		icon_state = "garland"
		set_light(0)

/obj/structure/garland/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	to_chat(user, "<span class='notice'>Начинаю снимать [src]...</span>")
	if(do_after(user, 50, target = src))
		var/obj/item/stack/garland_pack/M = new(loc)
		transfer_fingerprints_to(M)
		if(user.put_in_hands(M, TRUE))
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			qdel(src)
