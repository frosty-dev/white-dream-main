//Contains: Engineering department jumpsuits

/obj/item/clothing/under/rank/engineering
	icon = 'icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'icons/mob/clothing/under/engineering.dmi'

/obj/item/clothing/under/rank/engineering/chief_engineer
	desc = "Это костюм высокой видимости, предоставленный инженерам, достаточно сумасшедшим, чтобы достичь ранга \"Старшего Инженера\". Он имеет незначительную радиационную защиту."
	name = "комбинезон старшего инженера"
	icon_state = "chiefengineer"
	inhand_icon_state = "gy_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 80, "acid" = 40)
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/chief_engineer/skirt
	name = "юбкомбез старшего инженера"
	desc = "Это юбкомбез высокой видимости, который дается достаточно безумным инженерам, чтобы достичь ранга \"Старшего Инженера\". Он имеет незначительную радиационную защиту."
	icon_state = "chief_skirt"
	inhand_icon_state = "gy_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/engineering/atmospheric_technician
	desc = "Это комбинезон, который носят технические специалисты по атмосфере."
	name = "комбинезон атмостеха"
	icon_state = "atmos"
	inhand_icon_state = "atmos_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 60, "acid" = 20)
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skirt
	name = "юбкомбез атмостеха"
	desc = "Это юбкомбез, который носят технические специалисты по атмосфере."
	icon_state = "atmos_skirt"
	inhand_icon_state = "atmos_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/engineering/engineer
	desc = "Это оранжевый комбинезон с высокой видимостью, который носят инженеры. Он имеет незначительную радиационную защиту."
	name = "комбинезон инженера"
	icon_state = "engine"
	inhand_icon_state = "engi_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 60, "acid" = 20)
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/engineer/hazard
	name = "комбинезон инженера"
	desc = "Это оранжевый комбинезон с высокой видимостью, который носят инженеры. Он имеет незначительную радиационную защиту."
	icon_state = "hazard"
	inhand_icon_state = "suit-orange"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/engineer/skirt
	name = "юбкомбез инженера"
	desc = "Это оранжевый юбкомбез с высокой видимостью, который носят инженеры. Он имеет незначительную радиационную защиту."
	icon_state = "engine_skirt"
	inhand_icon_state = "engi_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

