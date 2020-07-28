/obj/item/clothing/under/color
	desc = "Стандартный цветной комбинезон. Разнообразие - это часть жизни!"
	dying_key = DYE_REGISTRY_UNDER
	icon = 'icons/obj/clothing/under/color.dmi'
	worn_icon = 'icons/mob/clothing/under/color.dmi'

/obj/item/clothing/under/color/jumpskirt
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/color/random
	icon_state = "random_jumpsuit"

/obj/item/clothing/under/color/random/Initialize()
	..()
	var/obj/item/clothing/under/color/C = pick(subtypesof(/obj/item/clothing/under/color) - typesof(/obj/item/clothing/under/color/jumpskirt) - /obj/item/clothing/under/color/random - /obj/item/clothing/under/color/grey/ancient - /obj/item/clothing/under/color/black/ghost)
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.equip_to_slot_or_del(new C(H), ITEM_SLOT_ICLOTHING) //or else you end up with naked assistants running around everywhere...
	else
		new C(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/clothing/under/color/jumpskirt/random
	icon_state = "random_jumpsuit"		//Skirt variant needed

/obj/item/clothing/under/color/jumpskirt/random/Initialize()
	..()
	var/obj/item/clothing/under/color/jumpskirt/C = pick(subtypesof(/obj/item/clothing/under/color/jumpskirt) - /obj/item/clothing/under/color/jumpskirt/random)
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.equip_to_slot_or_del(new C(H), ITEM_SLOT_ICLOTHING)
	else
		new C(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/clothing/under/color/black
	name = "чёрный комбинезон"
	icon_state = "black"
	inhand_icon_state = "bl_suit"
	resistance_flags = NONE

/obj/item/clothing/under/color/jumpskirt/black
	name = "чёрный юбкомбезон"
	icon_state = "black_skirt"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/color/black/ghost
	item_flags = DROPDEL

/obj/item/clothing/under/color/black/ghost/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/clothing/under/color/grey
	name = "серый комбинезон"
	desc = "Вкусный серый комбинезон, напоминающий о старых добрых временах."
	icon_state = "grey"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/color/jumpskirt/grey
	name = "серый юбкомбезон"
	desc = "Вкусная серая юбкомбезка, напоминающая старые добрые времена."
	icon_state = "grey_skirt"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/color/grey/ancient
	name = "древний комбинезон"
	desc = "Ужасно оборванный и потрепанный серый комбинезон. Похоже, его не стирали уже больше десяти лет."

/obj/item/clothing/under/color/blue
	name = "синий комбинезон"
	icon_state = "blue"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/color/jumpskirt/blue
	name = "синий юбкомбезон"
	icon_state = "blue_skirt"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/color/green
	name = "зелёный комбинезон"
	icon_state = "green"
	inhand_icon_state = "g_suit"

/obj/item/clothing/under/color/jumpskirt/green
	name = "зелёный юбкомбезон"
	icon_state = "green_skirt"
	inhand_icon_state = "g_suit"

/obj/item/clothing/under/color/orange
	name = "оранжевый комбинезон"
	desc = "Не носите это рядом с параноидальными офицерами."
	icon_state = "orange"
	inhand_icon_state = "o_suit"

/obj/item/clothing/under/color/jumpskirt/orange
	name = "оранжевый юбкомбезон"
	icon_state = "orange_skirt"
	inhand_icon_state = "o_suit"

/obj/item/clothing/under/color/pink
	name = "розовый комбинезон"
	icon_state = "pink"
	desc = "Достаточно посмотреть на этот костюм и почувствовать себя <i>неповторимым</i> парнем на деревне."
	inhand_icon_state = "p_suit"

/obj/item/clothing/under/color/jumpskirt/pink
	name = "розовый юбкомбезон"
	icon_state = "pink_skirt"
	inhand_icon_state = "p_suit"

/obj/item/clothing/under/color/red
	name = "красный комбинезон"
	icon_state = "red"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/color/jumpskirt/red
	name = "красный юбкомбезон"
	icon_state = "red_skirt"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/color/white
	name = "белый комбинезон"
	icon_state = "white"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/color/jumpskirt/white
	name = "белый юбкомбезон"
	icon_state = "white_skirt"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/color/yellow
	name = "желтый комбинезон"
	icon_state = "yellow"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/color/jumpskirt/yellow
	name = "желтый юбкомбезон"
	icon_state = "yellow_skirt"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/color/darkblue
	name = "тёмно-синий комбинезон"
	icon_state = "darkblue"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/color/jumpskirt/darkblue
	name = "тёмно-синий юбкомбезон"
	icon_state = "darkblue_skirt"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/color/teal
	name = "сине-зеленый комбинезон"
	icon_state = "teal"
	inhand_icon_state = "b_suit"

/obj/item/clothing/under/color/jumpskirt/teal
	name = "сине-зеленый юбкомбезон"
	icon_state = "teal_skirt"
	inhand_icon_state = "b_suit"


/obj/item/clothing/under/color/lightpurple
	name = "фиолетовый комбинезон"
	icon_state = "lightpurple"
	inhand_icon_state = "p_suit"

/obj/item/clothing/under/color/jumpskirt/lightpurple
	name = "светло-фиолетовый юбкомбезон"
	icon_state = "lightpurple_skirt"
	inhand_icon_state = "p_suit"

/obj/item/clothing/under/color/darkgreen
	name = "тёмно-зелёный комбинезон"
	icon_state = "darkgreen"
	inhand_icon_state = "g_suit"

/obj/item/clothing/under/color/jumpskirt/darkgreen
	name = "тёмно-зелёный юбкомбезон"
	icon_state = "darkgreen_skirt"
	inhand_icon_state = "g_suit"

/obj/item/clothing/under/color/lightbrown
	name = "светло-коричневый комбинезон"
	icon_state = "lightbrown"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/color/jumpskirt/lightbrown
	name = "светло-коричневый юбкомбезон"
	icon_state = "lightbrown_skirt"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/color/brown
	name = "коричневый комбинезон"
	icon_state = "brown"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/color/jumpskirt/brown
	name = "коричневый юбкомбезон"
	icon_state = "brown_skirt"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/color/maroon
	name = "бордовый комбинезон"
	icon_state = "maroon"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/color/jumpskirt/maroon
	name = "бордовый юбкомбезон"
	icon_state = "maroon_skirt"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/color/rainbow
	name = "радужный комбинезон"
	desc = "Многоцветный комбинезон!"
	icon_state = "rainbow"
	inhand_icon_state = "rainbow"
	can_adjust = FALSE

/obj/item/clothing/under/color/jumpskirt/rainbow
	name = "радужный юбкомбезон"
	desc = "Многоцветный комбинезон!"
	icon_state = "rainbow_skirt"
	inhand_icon_state = "rainbow"
	can_adjust = FALSE
