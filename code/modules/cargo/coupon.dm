#define COUPON_OMEN "omen"

/obj/item/coupon
	name = "купон"
	desc = "Неважно, если вы не хотели этого раньше, важно то, что у вас есть купон на это!"
	icon_state = "data_1"
	icon = 'icons/obj/card.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	var/datum/supply_pack/discounted_pack
	var/discount_pct_off = 0.05
	var/obj/machinery/computer/cargo/inserted_console

/// Choose what our prize is :D
/obj/item/coupon/proc/generate(rig_omen=FALSE)
	discounted_pack = pick(subtypesof(/datum/supply_pack/goody))
	var/list/chances = list("0.10" = 4, "0.15" = 8, "0.20" = 10, "0.25" = 8, "0.50" = 4, COUPON_OMEN = 1)
	if(rig_omen)
		discount_pct_off = COUPON_OMEN
	else
		discount_pct_off = pickweight(chances)
	if(discount_pct_off == COUPON_OMEN)
		name = "купон - трахни себя"
		desc = "Небольшой текст гласит: «Вы будете убиты» ... Это звучит неправильно, не так ли?"
		if(ismob(loc))
			var/mob/M = loc
			to_chat(M, "<span class='warning'>Купон гласит '<b>трахни себя</b>' жирным шрифтом ... это цена или нет?</span>")
			M.AddComponent(/datum/component/omen, TRUE, src)
	else
		discount_pct_off = text2num(discount_pct_off)
		name = "купон - [round(discount_pct_off * 100)]% off [initial(discounted_pack.name)]"

/obj/item/coupon/attack_obj(obj/O, mob/living/user)
	if(!istype(O, /obj/machinery/computer/cargo))
		return ..()
	if(discount_pct_off == COUPON_OMEN)
		to_chat(user, "<span class='warning'>\The [O] подтверждает купон как подлинный, но отказывается принять его ...</span>")
		O.say("Выпуск купона уже в процессе ...")
		return

	inserted_console = O
	LAZYADD(inserted_console.loaded_coupons, src)
	inserted_console.say("Купон для [initial(discounted_pack.name)] принят!")
	forceMove(inserted_console)

/obj/item/coupon/Destroy()
	if(inserted_console)
		LAZYREMOVE(inserted_console.loaded_coupons, src)
		inserted_console = null
	. = ..()

#undef COUPON_OMEN
