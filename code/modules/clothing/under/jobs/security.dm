/*
 * Contains:
 *		Security
 *		Detective
 *		Navy uniforms
 */

/*
 * Security
 */

/obj/item/clothing/under/rank/security
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/officer
	name = "комбинезон офицера"
	desc = "Тактический защитный комбинезон для офицеров в комплекте с ремнем безопасности Нанотрейзен."
	icon_state = "rsecurity"
	inhand_icon_state = "r_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30, "wound" = 10)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/officer/grey
	name = "серый комбинезон офицера"
	desc = "Тактическая реликвия прошлых лет до того, как Нанотрейзен решил, что покрасить костюмы в красный цвет дешевле, чем смывать кровь."
	icon_state = "security"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/officer/skirt
	name = "юбкомбез офицера"
	desc = "Защитный \"тактический\" комбинезон с юбкой вместо штанов."
	icon_state = "secskirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE //you know now that i think of it if you adjust the skirt and the sprite disappears isn't that just like flashing everyone
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/officer/blueshirt
	name = "голубая рубашка и галстук"
	desc = "I'm a little busy right now, Calhoun."
	icon_state = "blueshift"
	inhand_icon_state = "blueshift"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/formal
	name = "костюм офицера"
	desc = "Новейшие модные костюмы для охраны."
	icon_state = "officerblueclothes"
	inhand_icon_state = "officerblueclothes"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/constable
	name = "constable outfit"
	desc = "A british looking outfit."
	icon_state = "constable"
	inhand_icon_state = "constable"
	can_adjust = FALSE
	custom_price = 200

/obj/item/clothing/under/rank/security/warden
	name = "костюм офицера"
	desc = "Формальный защитный костюм для офицеров в комплекте с пряжкой на поясе Нанотрейзен."
	icon_state = "rwarden"
	inhand_icon_state = "r_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30, "wound" = 10)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = 3
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/warden/grey
	name = "серый костюм офицера"
	desc = "Классическая реликвия прошлых лет до того, как Нанотрейзен решил, что покрасить костюмы в красный цвет дешевле, чем смывать кровь."
	icon_state = "warden"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/warden/skirt
	name = "костюм надзирателя с юбкой"
	desc = "Формальный защитный костюм для офицеров в комплекте с пряжкой на поясе Нанотрейзен."
	icon_state = "rwarden_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/warden/formal
	desc = "Знаки отличия на этой форме говорят о том, что эта форма принадлежит Надзирателю."
	name = "костюм надзирателя"
	icon_state = "wardenblueclothes"
	inhand_icon_state = "wardenblueclothes"
	alt_covers_chest = TRUE

/*
 * Detective
 */
/obj/item/clothing/under/rank/security/detective
	name = "жёсткий костюм"
	desc = "Кто-то, кто носит это, точно в деле."
	icon_state = "detective"
	inhand_icon_state = "det"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30, "wound" = 10)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = 3
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/detective/skirt
	name = "жёсткий костюм с юбочкой"
	desc = "Кто-то, кто носит это, точно в деле."
	icon_state = "detective_skirt"
	inhand_icon_state = "det"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/detective/grey
	name = "нуарный костюм"
	desc = "Серый костюм частного детектива в закалённом виде, в комплекте с зажимом для галстука."
	icon_state = "greydet"
	inhand_icon_state = "greydet"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/detective/grey/skirt
	name = "нуарный костюм с юбкой"
	desc = "Серый костюм с юбкой частного детектива в закалённом виде, в комплекте с зажимом для галстука."
	icon_state = "greydet_skirt"
	inhand_icon_state = "greydet"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/security/head_of_security
	name = "комбинезон начальника охраны"
	desc = "Защитный комбинезон, украшенный для тех немногих самоотверженным стремлением занять пост начальника охраны."
	icon_state = "rhos"
	inhand_icon_state = "r_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	strip_delay = 60
	alt_covers_chest = TRUE
	sensor_mode = 3
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/head_of_security/skirt
	name = "юбкомбез начальника охраны"
	desc = "Защитный комбинезон, украшенный для тех немногих самоотверженным стремлением занять пост начальника охраны."
	icon_state = "rhos_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/head_of_security/grey
	name = "серый костюм начальника охраны"
	desc = "Есть старики, есть смельчаки, есть смельчаки, но очень мало стариков, есть смельчаки."
	icon_state = "hos"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/head_of_security/alt
	name = "водолазка начальника охраны"
	desc = "Стильная альтернатива обычному костюму начальника охраны, в комплекте с тактическими штанами."
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	name = "водолазка начальника охраны с юбкой"
	desc = "Стильная альтернатива обычному головному костюму безопасности, в комплекте с тактической юбкой."
	icon_state = "hosalt_skirt"
	inhand_icon_state = "bl_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/head_of_security/parade
	name = "парадный костюм начальника охраны"
	desc = "Мужская роскошная одежда начальника охраны, для особых случаев."
	icon_state = "hos_parade_male"
	inhand_icon_state = "r_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	name = "парадный костюм начальника охраны"
	desc = "Женская роскошная одежда начальника охраны, для особых случаев."
	icon_state = "hos_parade_fem"
	inhand_icon_state = "r_suit"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/formal
	desc = "Знаки отличия на этой форме говорят о том, что эта форма принадлежит начальнику службы безопасности."
	name = "костюм главы службы безопасности"
	icon_state = "hosblueclothes"
	inhand_icon_state = "hosblueclothes"
	alt_covers_chest = TRUE

/*
 *Spacepol
 */

/obj/item/clothing/under/rank/security/officer/spacepol
	name = "полицейская униформа"
	desc = "Космос, не контролируемый мегакорпорациями, планетами или пиратами, находится под юрисдикцией Космопола."
	icon_state = "spacepol"
	inhand_icon_state = "spacepol"
	can_adjust = FALSE

/obj/item/clothing/under/rank/prisoner
	name = "тюремный комбинезон"
	desc = "Это унифицированная тюремная одежда Нанотрейзен. Его датчики костюма застряли в положении \"Полностью Вкл\"."
	icon = 'icons/obj/clothing/under/security.dmi'
	icon_state = "prisoner"
	inhand_icon_state = "o_suit"
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/skirt
	name = "тюремный юбкомбез"
	desc = "Это унифицированная тюремная одежда Нанотрейзен. Его датчики костюма застряли в положении \"Полностью Вкл\"."
	icon_state = "prisoner_skirt"
	inhand_icon_state = "o_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/officer/beatcop
	name = "space police uniform"
	desc = "A police uniform often found in the lines at donut shops."
	icon_state = "spacepolice_families"
	inhand_icon_state = "spacepolice_families"
	can_adjust = FALSE
