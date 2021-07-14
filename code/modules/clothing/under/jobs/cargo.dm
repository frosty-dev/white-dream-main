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
	dying_key = DYE_REGISTRY_JUMPSKIRT
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
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/cargo/miner
	desc = "Униформа для работы в экстремальных условиях. Грязная."
	name = "комбинезон шахтёра"
	icon_state = "miner"
	inhand_icon_state = "miner"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 0, WOUND = 10)
	resistance_flags = NONE

/obj/item/clothing/under/rank/cargo/miner/lavaland
	desc = "Униформа для работы в экстремальных условиях."
	name = "комбинезон шахтёра"
	icon_state = "explorer"
	inhand_icon_state = "explorer"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/exploration
	name = "комбинезон рейнджера"
	desc = "В самый раз для похода в самую жопу космоса."
	icon = 'white/valtos/icons/clothing/uniforms.dmi'
	worn_icon = 'white/valtos/icons/clothing/mob/uniform.dmi'
	icon_state = "ranger"
	inhand_icon_state = "miner"
	can_adjust = FALSE
