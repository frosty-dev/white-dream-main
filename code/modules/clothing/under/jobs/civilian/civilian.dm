//Alphabetical order of civilian jobs.

/obj/item/clothing/under/rank/civilian
	icon = 'icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'icons/mob/clothing/under/civilian.dmi'

/obj/item/clothing/under/rank/civilian/bartender
	desc = "Похоже, ему не помешало бы немного больше таланта."
	name = "униформа бармена"
	icon_state = "barman"
	inhand_icon_state = "bar_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/bartender/purple
	desc = "Похоже, у него много таланта!"
	name = "фиолетовая униформа бармена"
	icon_state = "purplebartender"
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/bartender/skirt
	name = "униформа бармена с юбкой"
	desc = "Похоже, ему не помешало бы немного больше таланта."
	icon_state = "barman_skirt"
	inhand_icon_state = "bar_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/chaplain
	desc = "Это черный комбинезон, который часто носят религиозные люди."
	name = "комбинезон священника"
	icon_state = "chaplain"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/chaplain/skirt
	name = "юбкомбез священника"
	desc = "Это черная прыжковая рубашка. Если вы носите это, вероятно, вам нужна религиозная помощь больше, чем вы будете ее предоставлять."
	icon_state = "chapblack_skirt"
	inhand_icon_state = "bl_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/chef
	name = "кулинарный комбинезон"
	desc = "Костюм, который дается только самому <b>хардкорному</b> повару в пространстве."
	icon_state = "chef"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/chef/skirt
	name = "юбка повара"
	desc = "Юбка, которая дается только самым <b>хардкорным</b> поварам в пространстве."
	icon_state = "chef_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/head_of_personnel
	desc = "Это комбинезон, который носит тот, кто работает в должности \"Главы Персонала\"."
	name = "комбинезон главы персонала"
	icon_state = "hop"
	inhand_icon_state = "b_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skirt
	name = "юбка главы персонала"
	desc = "Это юбкомбез, который носит тот, кто работает в должности \"Главы Персонала\"."
	icon_state = "hop_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit
	name = "костюм главы персонала"
	desc = "Сине-зелёный костюм и желтый галстук. Авторитетный и в то же время отвратительный ансамбль."
	icon_state = "teal_suit"
	inhand_icon_state = "g_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	name = "сине-зелёная юбка"
	desc = "Сине-зелёная юбка и желтый галстук. Авторитетный и в то же время отвратительный ансамбль."
	icon_state = "teal_suit_skirt"
	inhand_icon_state = "g_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/hydroponics
	desc = "Это комбинезон, разработанный для защиты от незначительных рисков, связанных с растениями."
	name = "комбинезон ботаника"
	icon_state = "hydroponics"
	inhand_icon_state = "g_suit"
	permeability_coefficient = 0.5

/obj/item/clothing/under/rank/civilian/hydroponics/skirt
	name = "юбкомбез ботаника"
	desc = "Это юбкомбез, разработанный для защиты от мелких травм, связанных с растениями."
	icon_state = "hydroponics_skirt"
	inhand_icon_state = "g_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/janitor
	desc = "Это официальная униформа уборщика станции. Он имеет незначительную защиту от биологических опасностей."
	name = "комбинезон уборщика"
	icon_state = "janitor"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/civilian/janitor/skirt
	name = "юбкомбез уборщика"
	desc = "Это официальная униформа уборщика станции. Он имеет незначительную защиту от биологических опасностей."
	icon_state = "janitor_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/janitor/maid
	name = "униформа служанки"
	desc = "Простая униформа служанки для домашнего хозяйства."
	icon_state = "janimaid"
	inhand_icon_state = "janimaid"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/lawyer
	desc = "Прямолинейно."
	name = "костюм адвоката"
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/lawyer/dye_item(dye_color, dye_key_override)
	if(dye_color == DYE_COSMIC || dye_color == DYE_SYNDICATE)
		..(dye_color, DYE_LAWYER_SPECIAL)
	else
		..()

/obj/item/clothing/under/rank/civilian/lawyer/black
	name = "чёрный костюм адвоката"
	icon_state = "lawyer_black"
	inhand_icon_state = "lawyer_black"

/obj/item/clothing/under/rank/civilian/lawyer/black/skirt
	name = "чёрный костюм адвоката с юбкой"
	icon_state = "lawyer_black_skirt"
	inhand_icon_state = "lawyer_black"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/lawyer/female
	name = "женский чёрный костюм адвоката"
	icon_state = "black_suit_fem"
	inhand_icon_state = "black_suit_fem"
	worn_icon = 'icons/mob/clothing/under/suits.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/female/skirt
	name = "женский чёрный костюм адвоката с юбкой"
	icon_state = "black_suit_fem_skirt"
	inhand_icon_state = "black_suit_fem_skirt"
	worn_icon = 'icons/mob/clothing/under/suits.dmi'
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/lawyer/red
	name = "красный костюм адвоката"
	icon_state = "lawyer_red"
	inhand_icon_state = "lawyer_red"

/obj/item/clothing/under/rank/civilian/lawyer/red/skirt
	name = "красный костюм адвоката с юбкой"
	icon_state = "lawyer_red_skirt"
	inhand_icon_state = "lawyer_red"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/lawyer/blue
	name = "синий костюм адвоката"
	icon_state = "lawyer_blue"
	inhand_icon_state = "lawyer_blue"

/obj/item/clothing/under/rank/civilian/lawyer/blue/skirt
	name = "синий костюм адвоката с юбкой"
	icon_state = "lawyer_blue_skirt"
	inhand_icon_state = "lawyer_blue"
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	name = "синий костюм"
	desc = "Классный костюм и галстук."
	icon_state = "bluesuit"
	inhand_icon_state = "b_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt
	name = "синий костюм с юбкой"
	desc = "Классный костюм и галстук."
	icon_state = "bluesuit_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/lawyer/purpsuit
	name = "фиолетовый костюм адвоката"
	icon_state = "lawyer_purp"
	inhand_icon_state = "p_suit"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt
	name = "фиолетовый костюм адвоката с юбкой"
	icon_state = "lawyer_purp_skirt"
	inhand_icon_state = "p_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/civilian/lawyer/galaxy
	worn_icon = 'icons/mob/clothing/under/lawyer_galaxy.dmi'
	can_adjust = FALSE
	name = "синий галактический костюм"
	icon_state = "lawyer_galaxy_blue"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/rank/civilian/lawyer/galaxy/red
	name = "красный галактический костюм"
	icon_state = "lawyer_galaxy_red"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/rank/civilian/cookjorts
	name = "шорты для гриля"
	desc = "Ибо когда все, чего ты хочешь в жизни, это жарить на гриле ради Бога!"
	icon_state = "cookjorts"
