/obj/item/stack/license_plates
	name = "неверная табличка"
	desc = "алоха я в бар"
	icon = 'icons/obj/machines/prison.dmi'
	icon_state = "empty_plate"
	novariants = FALSE
	max_amount = 50

/obj/item/stack/license_plates/empty
	name = "пустой номерной знак"
	desc = "Вместо номера автомобильного номера это может содержать цитату типа «Жить, смеяться, любить»."

/obj/item/stack/license_plates/empty/fifty
	amount = 50

/obj/item/stack/license_plates/filled
	name = "номерной знак"
	desc = "Тюремный труд окупается."
	icon_state = "filled_plate_1_1"

///Override to allow for variations
/obj/item/stack/license_plates/filled/update_icon_state()
	if(novariants)
		return
	if(amount <= (max_amount * (1/3)))
		icon_state = "filled_plate_[rand(1,6)]_1"
	else if (amount <= (max_amount * (2/3)))
		icon_state = "filled_plate_[rand(1,6)]_2"
	else
		icon_state = "filled_plate_[rand(1,6)]_3"
