/obj/item/food/lcube
	name = "Куб личинок в панировке"
	desc = "Мы - одна галактика. Meeratorg Holding Ltd."
	icon = 'white/baldenysh/icons/obj/foods.dmi'
	icon_state = "lcube"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	microwaved_type = /obj/item/food/lcube/warm
	tastes = list("мясо" = 1, "личинки" = 2)
	foodtypes = MEAT | GROSS

/obj/item/food/lcube/warm
	name = "горячий куб личинок"
	desc = "Теперь этим можно \"питаться\"."
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/c2/probital = 2)
	microwaved_type = null
	tastes = list("мясо" = 1)
	foodtypes = MEAT | FRIED

/obj/item/storage/box/lcubes
	name = "Упаковка спрессованных личинок в панировке"
	desc = "Обязательно разогреть в микроволновке перед употреблением."
	icon = 'white/baldenysh/icons/obj/foods.dmi'
	icon_state = "plasticbox"
	illustration = null

/obj/item/storage/box/lcubes/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(/obj/item/food/lcube))

/obj/item/storage/box/lcubes/PopulateContents()
    for(var/i in 1 to 6)
        new /obj/item/food/lcube(src)

/obj/item/food/porridgebar
	name = "Протеиновый смузи батончик \"Порридж\""
	desc = "Я обязательно вкачусь."
	//icon = 'white/baldenysh/icons/obj/foods.dmi'
	//icon_state = "lcube"
	tastes = list("ничего"= 9, "соя" = 1)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 20, /datum/reagent/consumable/ethanol/creme_de_coconut = 1)

/obj/item/food/snus_cap
	name = "Snussus Vulgaris"
	desc = "Снюсогриб обыкновенный. Его подозрительный вид так и чарует вас своим обоянием."
	//icon = 'white/baldenysh/icons/obj/foods.dmi'
	//icon_state = "lcube"
	tastes = list("табак"= 1)
	food_reagents = list( /datum/reagent/drug/nicotine = 10, /datum/reagent/consumable/nutriment/protein = 5)
