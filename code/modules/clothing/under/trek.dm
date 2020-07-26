//Just some alt-uniforms themed around Star Trek - Pls don't sue, Mr Roddenberry ;_;


/obj/item/clothing/under/trek
	can_adjust = FALSE
	icon = 'icons/obj/clothing/under/trek.dmi'
	worn_icon = 'icons/mob/clothing/under/trek.dmi'


//TOS
/obj/item/clothing/under/trek/command
	name = "командирская форма"
	desc = "Это значит, что ты тут командир!"
	icon_state = "trek_command"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/trek/engsec
	name = "костюм engsec"
	desc = "Предназначена для спеца, шарящего в инженерии и охране."
	icon_state = "trek_engsec"
	inhand_icon_state = "r_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0) //more sec than eng, but w/e.
	strip_delay = 50

/obj/item/clothing/under/trek/medsci
	name = "костюм медскай"
	desc = "Предназначена для спеца, понимающего в медицине и науке."
	icon_state = "trek_medsci"
	inhand_icon_state = "b_suit"


//TNG
/obj/item/clothing/under/trek/command/next
	icon_state = "trek_next_command"
	inhand_icon_state = "r_suit"

/obj/item/clothing/under/trek/engsec/next
	icon_state = "trek_next_engsec"
	inhand_icon_state = "y_suit"

/obj/item/clothing/under/trek/medsci/next
	icon_state = "trek_next_medsci"


//ENT
/obj/item/clothing/under/trek/command/ent
	icon_state = "trek_ent_command"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/engsec/ent
	icon_state = "trek_ent_engsec"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/medsci/ent
	icon_state = "trek_ent_medsci"
	inhand_icon_state = "bl_suit"


//Q
/obj/item/clothing/under/trek/q
	name = "униформа французского маршалла"
	desc = "Мне в этом неловко..."
	icon_state = "trek_Q"
	inhand_icon_state = "r_suit"
