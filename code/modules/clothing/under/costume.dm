/obj/item/clothing/under/costume
	icon = 'icons/obj/clothing/under/costume.dmi'
	mob_overlay_icon =  'icons/mob/clothing/under/costume.dmi'

/obj/item/clothing/under/costume/roman
	name = "\improper римские латы"
	desc = "Древнеримскиая броня. Сделана из металла и кожаных ремней."
	icon_state = "roman"
	item_state = "armor"
	can_adjust = FALSE
	strip_delay = 100
	resistance_flags = NONE

/obj/item/clothing/under/costume/jabroni
	name = "кожаный костюм БДСМ"
	desc = "И кто тут теперь Властелин?"
	icon_state = "darkholme"
	item_state = "darkholme"
	can_adjust = FALSE

/obj/item/clothing/under/costume/owl
	name = "униформа совы"
	desc = "Коричневый костюм из синтетических перьев."
	icon_state = "owl"
	can_adjust = FALSE

/obj/item/clothing/under/costume/griffin
	name = "униформа грифона"
	desc = "Коричневый костюм из белых синтетических перьев."
	icon_state = "griffin"
	can_adjust = FALSE

/obj/item/clothing/under/costume/schoolgirl
	name = "синий костюм школьницы"
	desc = "Ой, как в аниме. Ня!"
	icon_state = "schoolgirl"
	item_state = "schoolgirl"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/costume/schoolgirl/red
	name = "красный костюм школьницы"
	icon_state = "schoolgirlred"
	item_state = "schoolgirlred"

/obj/item/clothing/under/costume/schoolgirl/green
	name = "зелёный костюм школьницы"
	icon_state = "schoolgirlgreen"
	item_state = "schoolgirlgreen"

/obj/item/clothing/under/costume/schoolgirl/orange
	name = "оранжевый  костюм школьницы"
	icon_state = "schoolgirlorange"
	item_state = "schoolgirlorange"

/obj/item/clothing/under/costume/pirate
	name = "пиратская матроска"
	desc = "Ряяя!"
	icon_state = "pirate"
	item_state = "pirate"
	can_adjust = FALSE

/obj/item/clothing/under/costume/soviet
	name = "советская военная форма"
	desc = "За Родину!"
	icon_state = "soviet"
	item_state = "soviet"
	can_adjust = FALSE

/obj/item/clothing/under/costume/redcoat
	name = "красный плащ"
	desc = "Выглядит старо."
	icon_state = "redcoat"
	item_state = "redcoat"
	can_adjust = FALSE

/obj/item/clothing/under/costume/kilt
	name = "кильт"
	desc = "Включает плед и ботинки."
	icon_state = "kilt"
	item_state = "kilt"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/costume/kilt/highlander
	desc = "You're the only one worthy of this kilt."

/obj/item/clothing/under/costume/kilt/highlander/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER)

/obj/item/clothing/under/costume/gladiator
	name = "униформа гладиатора"
	desc = "Тебе скучно? Разве не поэтому ты здесь?"
	icon_state = "gladiator"
	item_state = "gladiator"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/gladiator/ash_walker
	desc = "Эта форма гладиатора, кажется, покрыта пеплом и довольно стара."
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/maid
	name = "униформа служанки"
	desc = "Надпись гласит: 'Maid in China'."
	icon_state = "maid"
	item_state = "maid"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/costume/maid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/maidapron/A = new (src)
	attach_accessory(A)

/obj/item/clothing/under/costume/geisha
	name = "костюм гейши"
	desc = "Милые космические ниндзя сэмпай не включены."
	icon_state = "geisha"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/costume/villain
	name = "костюм злодея"
	desc = "Смена гардероба необходима, если вы хотите поймать настоящего супергероя."
	icon_state = "villain"
	can_adjust = FALSE

/obj/item/clothing/under/costume/sailor
	name = "униформа моряка"
	desc = "Немного бухла, и погружение начинается."
	icon_state = "sailor"
	item_state = "b_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/singer
	desc = "Выглядит так, будто вы собрались петь или смешно пошутить."
	body_parts_covered = CHEST|GROIN|ARMS
	alternate_worn_layer = ABOVE_SHOES_LAYER
	can_adjust = FALSE

/obj/item/clothing/under/costume/singer/yellow
	name = "жёлтый наряд исполнителя"
	icon_state = "ysing"
	item_state = "ysing"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/costume/singer/blue
	name = "синий наряд исполнителя"
	icon_state = "bsing"
	item_state = "bsing"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/costume/mummy
	name = "упаковка мумии"
	desc = "С любовью из туалетной бумаги и скотча."
	icon_state = "mummy"
	item_state = "mummy"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/scarecrow
	name = "костюм пугала"
	desc = "Прекрасно для того, чтобы скрыться в ботанической."
	icon_state = "scarecrow"
	item_state = "scarecrow"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/draculass
	name = "плащ Дракулы"
	desc = "Одежка выглядит средневеково стиля \"Victorian\" ."
	icon_state = "draculass"
	item_state = "draculass"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/costume/drfreeze
	name = "костюм доктора Фриза"
	desc = "Выглядит холодно."
	icon_state = "drfreeze"
	item_state = "drfreeze"
	can_adjust = FALSE

/obj/item/clothing/under/costume/lobster
	name = "костюм омара из пены"
	desc = "Кто обезглавил талисман колледжа?"
	icon_state = "lobster"
	item_state = "lobster"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/gondola
	name = "костюм гондолы"
	desc = "Теперь готовишь ты."
	icon_state = "gondola"
	item_state = "lb_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/skeleton
	name = "костюм скелета"
	desc = "Черный костюм с нарисованым белым цветом скелетом. Ужасно!"
	icon_state = "skeleton"
	item_state = "skeleton"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/mech_suit
	name = "красный костюм пилота меха"
	desc = "Красный костюм, в котором ваша задница выглядит больше."
	icon_state = "red_mech_suit"
	item_state = "red_mech_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	fitted = NO_FEMALE_UNIFORM
	alternate_worn_layer = GLOVES_LAYER //covers hands but gloves can go over it. This is how these things work in my head.
	can_adjust = FALSE

/obj/item/clothing/under/costume/mech_suit/white
	name = "белый костюм пилота меха"
	desc = "Костюм пилота меха. Привлекательный."
	icon_state = "white_mech_suit"
	item_state = "white_mech_suit"

/obj/item/clothing/under/costume/mech_suit/blue
	name = "синий костюм пилота меха"
	desc = "Синий костюм для ленивых задниц."
	icon_state = "blue_mech_suit"
	item_state = "blue_mech_suit"

/obj/item/clothing/under/costume/russian_officer
	name = "\improper униформа русского офицера"
	desc = "Последнее в модных российских нарядах."
	icon = 'icons/obj/clothing/under/security.dmi'
	icon_state = "hostanclothes"
	item_state = "hostanclothes"
	mob_overlay_icon =  'icons/mob/clothing/under/security.dmi'
	alt_covers_chest = TRUE
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	strip_delay = 50
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
