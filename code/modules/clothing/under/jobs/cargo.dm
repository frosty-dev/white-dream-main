/obj/item/clothing/under/rank/cargo
	icon = 'icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/rank/cargo/qm
	name = "комбинезон завхоза"
	desc = "Создан для защиты от травм при работе с бумагой."
	icon_state = "qm"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargo/qm/skirt
	name = "юбкомбез завхоза"
	desc = "Создан для защиты от травм при работе с бумагой."
	icon_state = "qm_skirt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/cargo/tech
	name = "комбинезон грузчика"
	desc = "Шооооорты! Они комфортные и легко сидят!"
	icon_state = "cargotech"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	mutantrace_variation = MUTANTRACE_VARIATION
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/cargo/tech/skirt
	name = "юбкомбез грузчика"
	desc = "Юбооооочки! Они комфортные и легко сидят!"
	icon_state = "cargo_skirt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	mutantrace_variation = NO_MUTANTRACE_VARIATION
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/cargo/miner
	desc = "Униформа для работы в экстремальных условиях. Грязная."
	name = "комбинезон шахтёра"
	icon_state = "miner"
	inhand_icon_state = "miner"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 0, "wound" = 10)
	resistance_flags = NONE

/obj/item/clothing/under/rank/cargo/miner/lavaland
	desc = "Униформа для работы в экстремальных условиях."
	name = "комбинезон шахтёра"
	icon_state = "explorer"
	inhand_icon_state = "explorer"
	can_adjust = FALSE
