/* Beds... get your mind out of the gutter, they're for sleeping!
 * Contains:
 * 		Beds
 *		Roller beds
 */

/*
 * Beds
 */
/obj/structure/bed
	name = "кровать"
	desc = "На ней можно лежать. Или стоять."
	icon_state = "bed"
	icon = 'icons/obj/objects.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2
	var/bolts = TRUE

/obj/structure/bed/examine(mob/user)
	. = ..()
	if(bolts)
		. += "<span class='notice'>Скручено несколькими <b>болтами</b>.</span>"

/obj/structure/bed/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/bed/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct(TRUE)
	else
		return ..()

/*
 * Roller beds
 */
/obj/structure/bed/roller
	name = "каталка"
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "down"
	anchored = FALSE
	resistance_flags = NONE
	var/foldabletype = /obj/item/roller

/obj/structure/bed/roller/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = W
		if(R.loaded)
			to_chat(user, "<span class='warning'>У меня уже есть пассажир!</span>")
			return

		if(has_buckled_mobs())
			if(buckled_mobs.len > 1)
				unbuckle_all_mobs()
				user.visible_message("<span class='notice'>[user] поднимает всех с [src].</span>")
			else
				user_unbuckle_mob(buckled_mobs[1],user)
		else
			R.loaded = src
			forceMove(R)
			user.visible_message("<span class='notice'>[user] собирает [src].</span>", "<span class='notice'>Собираю [src].</span>")
		return 1
	else
		return ..()

/obj/structure/bed/roller/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
			return 0
		if(has_buckled_mobs())
			return 0
		usr.visible_message("<span class='notice'>[usr] складывает [src.name].</span>", "<span class='notice'>Складываю [src.name].</span>")
		var/obj/structure/bed/roller/B = new foldabletype(get_turf(src))
		usr.put_in_hands(B)
		qdel(src)

/obj/structure/bed/roller/post_buckle_mob(mob/living/M)
	density = TRUE
	icon_state = "up"
	M.pixel_y = initial(M.pixel_y)

/obj/structure/bed/roller/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, TRUE)

/obj/structure/bed/roller/post_unbuckle_mob(mob/living/M)
	density = FALSE
	icon_state = "down"
	M.pixel_x = M.get_standard_pixel_x_offset(!(M.mobility_flags & MOBILITY_STAND))
	M.pixel_y = M.get_standard_pixel_y_offset(!(M.mobility_flags & MOBILITY_STAND))

/obj/item/roller
	name = "каталка"
	desc = "Сборная кровать для транспортировки людей."
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL // No more excuses, stop getting blood everywhere

/obj/item/roller/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = I
		if(R.loaded)
			to_chat(user, "<span class='warning'>[capitalize(R.name)] уже имеет в запасе каталку!</span>")
			return
		user.visible_message("<span class='notice'>[user] забирает [src].</span>", "<span class='notice'>Загружаю [src] в [R].</span>")
		R.loaded = new/obj/structure/bed/roller(R)
		qdel(src) //"Load"
		return
	else
		return ..()

/obj/item/roller/attack_self(mob/user)
	deploy_roller(user, user.loc)

/obj/item/roller/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(target))
		deploy_roller(user, target)

/obj/item/roller/proc/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/roller/R = new /obj/structure/bed/roller(location)
	R.add_fingerprint(user)
	qdel(src)

/obj/item/roller/robo //ROLLER ROBO DA!
	name = "каталкодок"
	desc = "Сборная кровать для транспортировки людей. Держите при её при себе всегда."
	var/obj/structure/bed/roller/loaded = null

/obj/item/roller/robo/Initialize()
	. = ..()
	loaded = new(src)

/obj/item/roller/robo/examine(mob/user)
	. = ..()
	. += "Док [loaded ? "загружен" : "пуст"]."

/obj/item/roller/robo/deploy_roller(mob/user, atom/location)
	if(loaded)
		loaded.forceMove(location)
		user.visible_message("<span class='notice'>[user] выдавливает [loaded].</span>", "<span class='notice'>Выдавливаю [loaded].</span>")
		loaded = null
	else
		to_chat(user, "<span class='warning'>Док пустой!</span>")

//Dog bed

/obj/structure/bed/dogbed
	name = "собачья кровать"
	icon_state = "dogbed"
	desc = "Удобная на вид кровать для собаки. Вы можете даже пристегнуть своего питомца на случай, если гравитация отключится."
	anchored = FALSE
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 10
	var/mob/living/owner = null

/obj/structure/bed/dogbed/ian
	desc = "Выглядит удобной!"
	name = "кроватка Яна"
	anchored = TRUE

/obj/structure/bed/dogbed/cayenne
	desc = "Кажется, немного... подозрительной."
	name = "кровать Кайенны"
	anchored = TRUE

/obj/structure/bed/dogbed/renault
	desc = "Выглядит удобно, Лисий человек нуждается в лисичке."
	name = "кровать Рено"
	anchored = TRUE

/obj/structure/bed/dogbed/runtime
	desc = "Удобная кошачья кровать. Вы можете даже пристегнуть своего питомца на случай, если гравитация отключится."
	name = "Кровать Рантайма"
	anchored = TRUE

/obj/structure/bed/dogbed/proc/update_owner(mob/living/M)
	owner = M
	name = "кровать [M]"
	desc = "Выглядит комфортно."

/obj/structure/bed/dogbed/buckle_mob(mob/living/M, force, check_loc)
	. = ..()
	update_owner(M)

/obj/structure/bed/alien
	name = "отдыхалка"
	desc = "Это похоже на штуки с Земли. Могут ли инопланетяне красть наши технологии?"
	icon_state = "abed"
