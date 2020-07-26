/obj/item/card/data/calling
	name = "телефонная карта"
	icon_state = "data_1"
	var/calling_num

/obj/item/card/data/calling/Initialize()
	. = ..()
	var/station_code = "13"
	var/iin = rand(0, 999)
	var/cardnum = rand(0, 999999)

	calling_num = "[station_code][iin][cardnum]"
	calling_num = get_luhn(calling_num)

/obj/item/card/data/calling/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Номер карты: [calling_num]</span>"
	. += "Путем пипец хитрых вычислений в своей коре головново мозга вычесляю што номер данной карты [check_luhn(calling_num) ? "правильный" : "неправильный"]."
