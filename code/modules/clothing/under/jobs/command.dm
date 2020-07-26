/obj/item/clothing/under/rank/captain
	desc = "Это синий комбинезон с золотыми знаками, обозначающими звание \"Капитан\"."
	name = "комбинезон капитана"
	icon_state = "captain"
	inhand_icon_state = "b_suit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	icon = 'icons/obj/clothing/under/captain.dmi'
	worn_icon = 'icons/mob/clothing/under/captain.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 15)

/obj/item/clothing/under/rank/captain/skirt
	name = "юбкомбез капитана"
	desc = "Это синий юбкомбез с золотыми знаками, обозначающими звание \"Капитан\"."
	icon_state = "captain_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/captain/suit
	name = "костюм капитана"
	desc = "Зеленый костюм и желтый галстук. Пример авторитета."
	icon_state = "green_suit"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/suit/skirt
	name = "зелёный костюм капитана с юбкой"
	desc = "Зеленая костюмная юбка и желтый галстук. Пример авторитета."
	icon_state = "green_suit_skirt"
	inhand_icon_state = "dg_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/captain/parade
	name = "парадный костюм капитана"
	desc = "Капитанская роскошная одежда, для особых случаев."
	icon_state = "captain_parade"
	inhand_icon_state = "by_suit"
	can_adjust = FALSE
