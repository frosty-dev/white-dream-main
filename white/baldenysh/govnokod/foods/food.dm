/obj/item/reagent_containers/food/snacks/lcube
	name = "Куб личинок в панировке"
	desc = "Мы - одна галактика. Миpatopг."
	icon = 'white/baldenysh/icons/obj/foods.dmi'
	icon_state = "lcube"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	cooked_type = /obj/item/reagent_containers/food/snacks/lcube/warm
	filling_color = "#FFF"
	tastes = list("мясо" = 1, "личинки" = 2)
	foodtype = MEAT | GROSS

/obj/item/reagent_containers/food/snacks/lcube/warm
	name = "горячий куб личинок"
	desc = "Теперь этим можно \"питаться\"."
	bonus_reagents = list(/datum/reagent/medicine/c2/probital = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/medicine/c2/probital = 2)
	cooked_type = null
	tastes = list("мясо" = 1)
	foodtype = MEAT | FRIED

/obj/item/storage/box/lcubes
	name = "Упаковка спрессованных личинок в панировке"
	desc = "Обязательно разогреть в микроволновке перед употреблением."
	icon = 'white/baldenysh/icons/obj/foods.dmi'
	icon_state = "plasticbox"
	illustration = null

/obj/item/storage/box/lcubes/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(/obj/item/reagent_containers/food/snacks/lcube))

/obj/item/storage/box/lcubes/PopulateContents()
    for(var/i in 1 to 6)
        new /obj/item/reagent_containers/food/snacks/lcube(src)


