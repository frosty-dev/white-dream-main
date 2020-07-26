/obj/item/ammo_box/a357
	name = "скоростной зарядник (.357)"
	desc = "Предназначен для быстрой перезарядки револьверов."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION

/obj/item/ammo_box/a357/match
	name = "скоростной зарядник (.357 Самонаводящиеся)"
	desc = "Предназначен для быстрой перезарядки револьверов. Эти патроны изготавливаются с очень жесткими конвенциями, что позволяет легко их демонстрировать."
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/c38
	name = "скоростной зарядник (.38)"
	desc = "Предназначен для быстрой перезарядки револьверов."
	icon_state = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	custom_materials = list(/datum/material/iron = 20000)

/obj/item/ammo_box/c38/trac
	name = "скоростной зарядник (.38 TRAC)"
	desc = "Предназначен для быстрой перезарядки револьверов. Пули TRAC внедряют следящий имплант в тело цели."
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/c38/match
	name = "скоростной зарядник (.38 Самонаводящиеся)"
	desc = "Предназначен для быстрой перезарядки револьверов. Эти патроны изготавливаются с очень жесткими конвенциями, что позволяет легко их демонстрировать."
	ammo_type = /obj/item/ammo_casing/c38/match

/obj/item/ammo_box/c38/match/bouncy
	name = "скоростной зарядник (.38 Резиновые)"
	desc = "Предназначен для быстрой перезарядки револьверов. Эти патроны являются невероятно бодрящими и не летальными, что делает их отличными для демонстрации трикшотов."
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy

/obj/item/ammo_box/c38/dumdum
	name = "скоростной зарядник (.38 DumDum)"
	desc = "Предназначен для быстрой перезарядки револьверов. DumDum пули разбиваются при ударе и измельчают внутренности цели, вероятно попав внутрь."
	ammo_type = /obj/item/ammo_casing/c38/dumdum

/obj/item/ammo_box/c38/hotshot
	name = "скоростной зарядник (.38 Hot Shot)"
	desc = "Предназначен для быстрой перезарядки револьверов. Hot Shot пули содержат зажигательную смесь."
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/c38/iceblox
	name = "скоростной зарядник (.38 Iceblox)"
	desc = "Предназначен для быстрой перезарядки револьверов. Iceblox пули содержат замораживающую смесь."
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/ammo_box/c9mm
	name = "ящик с патронами (9mm)"
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 30

/obj/item/ammo_box/c10mm
	name = "ящик с патронами (10mm)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 20

/obj/item/ammo_box/c45
	name = "ящик с патронами (.45)"
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 20

/obj/item/ammo_box/a40mm
	name = "ящик с патронами (40mm гранаты)"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/a762
	name = "заряжающая штука (7.62mm)"
	desc = "Заряжает, да."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/n762
	name = "ящик с патронами (7.62x38mmR)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 14

/obj/item/ammo_box/foambox
	name = "ящик с патронами (Пенчики)"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foambox"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 40
	custom_materials = list(/datum/material/iron = 500)

/obj/item/ammo_box/foambox/riot
	icon_state = "foambox_riot"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	custom_materials = list(/datum/material/iron = 50000)
