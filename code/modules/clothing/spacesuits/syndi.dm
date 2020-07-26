//Regular syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate
	name = "красный космошлем"
	icon_state = "syndicate"
	inhand_icon_state = "syndicate"
	desc = "Has a tag on it: Totally not property of an enemy corporation, honest!"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30,"energy" = 40, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 80, "acid" = 85)

/obj/item/clothing/suit/space/syndicate
	name = "красный скафандр"
	icon_state = "syndicate"
	inhand_icon_state = "space_suit_syndicate"
	desc = "Has a tag on it: Totally not property of an enemy corporation, honest!"
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30,"energy" = 40, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 80, "acid" = 85)
	cell = /obj/item/stock_parts/cell/hyper

//Green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/green
	name = "зелёный космошлем"
	icon_state = "syndicate-helm-green"
	inhand_icon_state = "syndicate-helm-green"

/obj/item/clothing/suit/space/syndicate/green
	name = "зелёный скафандр"
	icon_state = "syndicate-green"
	inhand_icon_state = "syndicate-green"


//Dark green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/green/dark
	name = "dark green космошлем"
	icon_state = "syndicate-helm-green-dark"
	inhand_icon_state = "syndicate-helm-green-dark"

/obj/item/clothing/suit/space/syndicate/green/dark
	name = "dark green скафандр"
	icon_state = "syndicate-green-dark"
	inhand_icon_state = "syndicate-green-dark"


//Orange syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/orange
	name = "оранжевый космошлем"
	icon_state = "syndicate-helm-orange"
	inhand_icon_state = "syndicate-helm-orange"

/obj/item/clothing/suit/space/syndicate/orange
	name = "оранжевый скафандр"
	icon_state = "syndicate-orange"
	inhand_icon_state = "syndicate-orange"

//Blue syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/blue
	name = "синий космошлем"
	icon_state = "syndicate-helm-blue"
	inhand_icon_state = "syndicate-helm-blue"

/obj/item/clothing/suit/space/syndicate/blue
	name = "синий скафандр"
	icon_state = "syndicate-blue"
	inhand_icon_state = "syndicate-blue"


//Black syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black"
	inhand_icon_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black
	name = "чёрный скафандр"
	icon_state = "syndicate-black"
	inhand_icon_state = "syndicate-black"


//Black-green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/green
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black-green"
	inhand_icon_state = "syndicate-helm-black-green"

/obj/item/clothing/suit/space/syndicate/black/green
	name = "чёрный и зелёный скафандр"
	icon_state = "syndicate-black-green"
	inhand_icon_state = "syndicate-black-green"


//Black-blue syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/blue
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black-blue"
	inhand_icon_state = "syndicate-helm-black-blue"

/obj/item/clothing/suit/space/syndicate/black/blue
	name = "чёрный и синий скафандр"
	icon_state = "syndicate-black-blue"
	inhand_icon_state = "syndicate-black-blue"


//Black medical syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/med
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black-med"
	inhand_icon_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black/med
	name = "зелёный скафандр"
	icon_state = "syndicate-black-med"
	inhand_icon_state = "syndicate-black"


//Black-orange syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/orange
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black-orange"
	inhand_icon_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black/orange
	name = "чёрный и оранжевый скафандр"
	icon_state = "syndicate-black-orange"
	inhand_icon_state = "syndicate-black"


//Black-red syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/red
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black-red"
	inhand_icon_state = "syndicate-helm-black-red"

/obj/item/clothing/suit/space/syndicate/black/red
	name = "чёрный и красный скафандр"
	icon_state = "syndicate-black-red"
	inhand_icon_state = "syndicate-black-red"

//Black-red syndicate contract varient
/obj/item/clothing/head/helmet/space/syndicate/contract
	name = "шлем наёмника"
	desc = "Специализированный черно-золотой шлем, который более компактен, чем его стандартный аналог от Синдиката. Может быть ультра-сжатым даже в самые узкие пространства."
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "syndicate-contract-helm"
	inhand_icon_state = "syndicate-contract-helm"

/obj/item/clothing/suit/space/syndicate/contract
	name = "скафандр наёмника"
	desc = "Специализированный черно-золотой скафандр, который быстрее и компактнее, чем его стандартный аналог от Синдиката. Может быть ультра-сжатым даже в самые узкие пространства."
	slowdown = 1
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "syndicate-contract"
	inhand_icon_state = "syndicate-contract"

//Black with yellow/red engineering syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/engie
	name = "чёрный космошлем"
	icon_state = "syndicate-helm-black-engie"
	inhand_icon_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black/engie
	name = "чёрный инженерный скафандр"
	icon_state = "syndicate-black-engie"
	inhand_icon_state = "syndicate-black"
