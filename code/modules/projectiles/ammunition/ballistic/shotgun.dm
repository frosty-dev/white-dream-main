// Shotgun

/obj/item/ammo_casing/shotgun
	name = "12g патрон"
	desc = "Свинцовый стержень 12 калибра."
	icon_state = "blshell"
	caliber = "shotgun"
	custom_materials = list(/datum/material/iron=4000)
	projectile_type = /obj/projectile/bullet/shotgun_slug

/obj/item/ammo_casing/shotgun/executioner
	name = "executioner slug"
	desc = "A 12 gauge lead slug purpose built to annihilate flesh on impact."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/executioner

/obj/item/ammo_casing/shotgun/pulverizer
	name = "pulverizer slug"
	desc = "A 12 gauge lead slug purpose built to annihilate bones on impact."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/pulverizer

/obj/item/ammo_casing/shotgun/beanbag
	name = "12g резиновый патрон"
	desc = "Мелкие резинки для контроля над беспорядками."
	icon_state = "bshell"
	custom_materials = list(/datum/material/iron=250)
	projectile_type = /obj/projectile/bullet/shotgun_beanbag

/obj/item/ammo_casing/shotgun/incendiary
	name = "12g поджигающий патрон"
	desc = "Пуля с зажигательным покрытием."
	icon_state = "ishell"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun

/obj/item/ammo_casing/shotgun/dragonsbreath
	name = "12g патрон драконьего дыхания"
	desc = "Пуля, которая выдаёт кучу горящих шариков."
	icon_state = "ishell2"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	pellets = 4
	variance = 35

/obj/item/ammo_casing/shotgun/stunslug
	name = "12g электропатрон"
	desc = "Останавливающая пуля с живительным зарядом энергии внутри."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_stunslug
	custom_materials = list(/datum/material/iron=250)

/obj/item/ammo_casing/shotgun/meteorslug
	name = "12g метеоропатрон"
	desc = "Пуля оснащенная технологией CMC, которая при выстреле запускает массивный снаряд."
	icon_state = "mshell"
	projectile_type = /obj/projectile/bullet/shotgun_meteorslug

/obj/item/ammo_casing/shotgun/pulseslug
	name = "12g импульсный патрон"
	desc = "Деликатное устройство, которое можно загрузить в ружье. Праймер действует как кнопка, \
	которая запускает среду усиления и запускает мощный энергетический взрыв. Хотя отвод тепла и \
	энергии ограничивает одно использование, он все же может позволить оператору поражать цели, \
	с которыми у баллистических боеприпасов возникнут трудности."
	icon_state = "pshell"
	projectile_type = /obj/projectile/beam/pulse/shotgun

/obj/item/ammo_casing/shotgun/frag12
	name = "12g FRAG-12 патрон"
	desc = "Выстрел из взрывчатого вещества с большой взрывчаткой для дробовика 12 калибра."
	icon_state = "heshell"
	projectile_type = /obj/projectile/bullet/shotgun_frag12

/obj/item/ammo_casing/shotgun/buckshot
	name = "12g патрон с картечью"
	desc = "Шарики 12 калибра."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot
	pellets = 6
	variance = 25

/obj/item/ammo_casing/shotgun/rubbershot
	name = "12g патрон с резиной"
	desc = "Пуля, заполненная плотно упакованными резиновыми шариками, используется для выведения людей из строя на расстоянии."
	icon_state = "bshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_rubbershot
	pellets = 6
	variance = 25
	custom_materials = list(/datum/material/iron=4000)

/obj/item/ammo_casing/shotgun/incapacitate
	name = "12g самодельный патрон"
	desc = "Патрон заполненный чем-то... Используется для обезвреживания людей."
	icon_state = "bountyshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_incapacitate
	pellets = 12//double the pellets, but half the stun power of each, which makes this best for just dumping right in someone's face.
	variance = 25
	custom_materials = list(/datum/material/iron=4000)

/obj/item/ammo_casing/shotgun/improvised
	name = "12g импровизированный патрон"
	desc = "Чрезвычайно слабая пуля с несколькими маленькими шариками из металлических осколков."
	icon_state = "improvshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_improvised
	custom_materials = list(/datum/material/iron=250)
	pellets = 10
	variance = 25

/obj/item/ammo_casing/shotgun/ion
	name = "12g ионная пуля"
	desc = "Усовершенствованная пуля, в которой используется подпространственный кристалл для создания эффекта, аналогичного стандартной ионной винтовке. \
	Уникальные свойства кристалла разбивают импульс на множество индивидуально более слабых болтов."
	icon_state = "ionshell"
	projectile_type = /obj/projectile/ion/weak
	pellets = 4
	variance = 35

/obj/item/ammo_casing/shotgun/laserslug
	name = "12g рассеивающий лазер патрон"
	desc = "Усовершенствованная пуля, которая использует микро-лазер для воспроизведения эффектов лазерного оружия рассеяния в баллистической упаковке."
	icon_state = "lshell"
	projectile_type = /obj/projectile/beam/weak
	pellets = 6
	variance = 35

/obj/item/ammo_casing/shotgun/techshell
	name = "12g пустой высокотехнологичный патрон"
	desc = "Высокотехнологичная пуля, в которую можно загружать материалы для создания уникальных эффектов."
	icon_state = "cshell"
	projectile_type = null

/obj/item/ammo_casing/shotgun/dart
	name = "12g дротик"
	desc = "Дротик для использования в ружьях. Может вводиться до 30 единиц любого химического вещества."
	icon_state = "cshell"
	projectile_type = /obj/projectile/bullet/dart
	var/reagent_amount = 30

/obj/item/ammo_casing/shotgun/dart/Initialize()
	. = ..()
	create_reagents(reagent_amount, OPENCONTAINER)

/obj/item/ammo_casing/shotgun/dart/attackby()
	return

/obj/item/ammo_casing/shotgun/dart/bioterror
	desc = "Патрон наполненный смертельными токсинами."

/obj/item/ammo_casing/shotgun/dart/bioterror/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 6)
	reagents.add_reagent(/datum/reagent/toxin/spore, 6)
	reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 6) //;HELP OPS IN MAINT
	reagents.add_reagent(/datum/reagent/toxin/coniine, 6)
	reagents.add_reagent(/datum/reagent/toxin/sodium_thiopental, 6)
