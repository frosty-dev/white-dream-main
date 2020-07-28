/obj/item/clothing/suit/toggle/labcoat
	name = "лабораторный халат"
	desc = "Костюм, который защищает от небольших разливов химикатов."
	icon_state = "labcoat"
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	togglename = "buttons"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/toggle/labcoat/cmo
	name = "халат главврача"
	desc = "Синее, чем стандартная модель."
	icon_state = "labcoat_cmo"
	inhand_icon_state = "labcoat_cmo"

/obj/item/clothing/suit/toggle/labcoat/paramedic
	name = "куртка парамедика"
	desc = "Темно-синий жакет со светоотражающими полосками для техников скорой медицинской помощи."
	icon_state = "labcoat_paramedic"
	inhand_icon_state = "labcoat_paramedic"

/obj/item/clothing/suit/toggle/labcoat/mad
	name = "лабораторный костюм сумасшедшего"
	desc = "Это заставляет вас выглядеть способным обмануть кого-то на ногине и выстрелить им в космос."
	icon_state = "labgreen"
	inhand_icon_state = "labgreen"

/obj/item/clothing/suit/toggle/labcoat/genetics
	name = "лабораторный халат генетика"
	desc = "Костюм, который защищает от небольших разливов химикатов. Имеет синюю полосу на плече."
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/toggle/labcoat/chemist
	name = "лабораторный халат химика"
	desc = "Костюм, который защищает от небольших разливов химикатов. Имеет оранжевую полосу на плече."
	icon_state = "labcoat_chem"

/obj/item/clothing/suit/toggle/labcoat/virologist
	name = "лабораторный халат вирусолога"
	desc = "Костюм, который защищает от небольших разливов химикатов. Предлагает немного больше защиты от биологической опасности, чем стандартная модель. Имеет зеленую полосу на плече."
	icon_state = "labcoat_vir"

/obj/item/clothing/suit/toggle/labcoat/science
	name = "лабораторный халат учёного"
	desc = "Костюм, который защищает от небольших разливов химикатов. Имеет фиолетовую полоску на плече."
	icon_state = "labcoat_tox"
