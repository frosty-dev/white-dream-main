/obj/item/clothing/under/syndicate
	name = "тактическая водолазка"
	desc = "Неописуемая и слегка подозрительно выглядящая водолазка с цифровыми камуфляжными штанами."
	icon_state = "syndicate"
	item_state = "bl_suit"
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/skirt
	name = "тактическая юбка"
	desc = "Юбка для спецопераций."
	icon_state = "syndicate_skirt"
	item_state = "bl_suit"
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/tacticool
	name = "тактическая водолазка"
	desc = "Просто взглянув на это, хочется купить SKS, пойти в лес и -оперативничать-."
	icon_state = "tactifool"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	has_sensor = HAS_SENSORS

/obj/item/clothing/under/syndicate/tacticool/skirt
	name = "тактическая юбка"
	desc = "Просто взглянув на это, хочется купить SKS, пойти в лес и -оперативничать-."
	icon_state = "tactifool_skirt"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/sniper
	name = "тактический костюм"
	desc = "Тактическая водолазка с двойным швом, замаскированная под шелковый костюм гражданского уровня. Предназначен для самого деловитого оператора. Воротник действительно острый."
	icon = 'icons/obj/clothing/under/suits.dmi'
	icon_state = "really_black_suit"
	item_state = "bl_suit"
	mob_overlay_icon = 'icons/mob/clothing/under/suits.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/camo
	name = "камуфляжная одежда"
	desc = "Зеленая военная камуфляжная форма."
	icon_state = "camogreen"
	item_state = "g_suit"
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/soviet
	name = "Ratnik 5 спорткостюм"
	desc = "Плохо переведенные этикетки говорят вам, чтобы очистить это в водке. Отлично подходит для танцев вприсядку."
	icon_state = "trackpants"
	can_adjust = FALSE
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE

/obj/item/clothing/under/syndicate/combat
	name = "боевая одежда"
	desc = "С костюмом на подкладке так много карманов, вы готовы к работе."
	icon_state = "syndicate_combat"
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/rus_army
	name = "передовой военный спортивный костюм"
	desc = "Идеально для боевых действий."
	icon_state = "rus_under"
	can_adjust = FALSE
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE
