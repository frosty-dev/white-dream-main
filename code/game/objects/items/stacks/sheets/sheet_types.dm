/* Diffrent misc types of sheets
 * Contains:
 * Metal
 * Plasteel
 * Wood
 * Cloth
 * Plastic
 * Cardboard
 * Paper Frames
 * Runed Metal (cult)
 * Bronze (bake brass)
 */

/*
 * Metal
 */
GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("Табурет", /obj/structure/chair/stool, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("барный стул", /obj/structure/chair/stool/bar, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("кровать", /obj/structure/bed, 2, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe_list("офисные кресла", list( \
		new/datum/stack_recipe("темное офисное кресло", /obj/structure/chair/office, 5, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("светлое офисное кресло", /obj/structure/chair/office/light, 5, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("удобные стулья", list( \
		new/datum/stack_recipe("бежевый удобный стул", /obj/structure/chair/comfy/beige, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("чёрный удобный стул", /obj/structure/chair/comfy/black, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("коричневый удобный стул", /obj/structure/chair/comfy/brown, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("лаймовый удобный стул", /obj/structure/chair/comfy/lime, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("бирюзовый удобный стул", /obj/structure/chair/comfy/teal, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("диваны", list(
		new /datum/stack_recipe("диван (центральный)", /obj/structure/chair/sofa, 1, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("диван (левый)", /obj/structure/chair/sofa/left, 1, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("диван (правый)", /obj/structure/chair/sofa/right, 1, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("диван (угловой)", /obj/structure/chair/sofa/corner, 1, one_per_turf = TRUE, on_floor = TRUE)
		)), \
	new/datum/stack_recipe_list("корпоративные диваны", list( \
		new /datum/stack_recipe("диван (центральный)", /obj/structure/chair/sofa/corp, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("диван (левый)", /obj/structure/chair/sofa/corp/left, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("диван (правый)", /obj/structure/chair/sofa/corp/right, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("диван (угловой)", /obj/structure/chair/sofa/corp/corner, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new /datum/stack_recipe_list("шахматные фигуры", list( \
		new /datum/stack_recipe("Белый Pawn", /obj/structure/chess/whitepawn, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Rook", /obj/structure/chess/whiterook, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Knight", /obj/structure/chess/whiteknight, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Bishop", /obj/structure/chess/whitebishop, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Queen", /obj/structure/chess/whitequeen, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый King", /obj/structure/chess/whiteking, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Pawn", /obj/structure/chess/blackpawn, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Rook", /obj/structure/chess/blackrook, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Knight", /obj/structure/chess/blackknight, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Bishop", /obj/structure/chess/blackbishop, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Queen", /obj/structure/chess/blackqueen, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный King", /obj/structure/chess/blackking, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	)),
	null, \
	new/datum/stack_recipe("части стойки", /obj/item/rack_parts), \
	new/datum/stack_recipe("шкаф", /obj/structure/closet, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("каркас канистры", /obj/structure/canister_frame/machine/frame_tier_0, 5, time = 8, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("плитка для пола", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	new/datum/stack_recipe("металлический стержень", /obj/item/stack/rods, 1, 2, 60), \
	null, \
	new/datum/stack_recipe("каркас стены", /obj/structure/girder, 2, time = 40, one_per_turf = TRUE, on_floor = TRUE, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75), \
	null, \
	new/datum/stack_recipe("компьютерный каркас", /obj/structure/frame/computer, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("модульная консоль", /obj/machinery/modular_computer/console/buildable/, 10, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("каркас машины", /obj/structure/frame/machine, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new /datum/stack_recipe_list("каркас шлюза", list( \
		new /datum/stack_recipe("каркас стандартного шлюза", /obj/structure/door_assembly, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас публичного шлюза", /obj/structure/door_assembly/door_assembly_public, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас командного шлюза", /obj/structure/door_assembly/door_assembly_com, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас шлюза службы безопасности", /obj/structure/door_assembly/door_assembly_sec, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас инженерного шлюза", /obj/structure/door_assembly/door_assembly_eng, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас шахтерского шлюза", /obj/structure/door_assembly/door_assembly_min, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас атмосферного шлюза", /obj/structure/door_assembly/door_assembly_atmo, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас шлюза отдела исследований", /obj/structure/door_assembly/door_assembly_research, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас морозильного шлюза ", /obj/structure/door_assembly/door_assembly_fre, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас шлюза научного отдела", /obj/structure/door_assembly/door_assembly_science, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас медицинского шлюза", /obj/structure/door_assembly/door_assembly_med, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас шлюза вирусологии", /obj/structure/door_assembly/door_assembly_viro, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас технического шлюза", /obj/structure/door_assembly/door_assembly_mai, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас внешнего шлюза", /obj/structure/door_assembly/door_assembly_ext, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас внешнего технического шлюза", /obj/structure/door_assembly/door_assembly_extmai, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас герметичного люка", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("каркас технического люка", /obj/structure/door_assembly/door_assembly_mhatch, 4, time = 50, one_per_turf = 1, on_floor = 1), \
	)), \
	null, \
	new/datum/stack_recipe("каркас пожарного шлюза", /obj/structure/firelock_frame, 3, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("каркас турели", /obj/machinery/porta_turret_construct, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("крюк для разделывания", /obj/structure/kitchenspike_frame, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("каркас отражателя", /obj/structure/reflector, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("корпус гранаты", /obj/item/grenade/chem_grenade), \
	new/datum/stack_recipe("каркас светильника", /obj/item/wallframe/light_fixture, 2), \
	new/datum/stack_recipe("каркас небольшого светильника", /obj/item/wallframe/light_fixture/small, 1), \
	null, \
	new/datum/stack_recipe("рамка APC", /obj/item/wallframe/apc, 2), \
	new/datum/stack_recipe("каркас контроллера воздуха", /obj/item/wallframe/airalarm, 2), \
	new/datum/stack_recipe("каркас пожарной тревоги", /obj/item/wallframe/firealarm, 2), \
	new/datum/stack_recipe("шкаф для огнетушителя", /obj/item/wallframe/extinguisher_cabinet, 2), \
	new/datum/stack_recipe("рамка для кнопки", /obj/item/wallframe/button, 1), \
	null, \
	new/datum/stack_recipe("железная дверь", /obj/structure/mineral_door/iron, 20, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("каркас прожектора", /obj/structure/floodlight_frame, 5, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("ящик для голосования", /obj/structure/votebox, 15, time = 50), \
	new/datum/stack_recipe("пестик", /obj/item/pestle, 1, time = 50), \
	new/datum/stack_recipe("каркас гигиенобота", /obj/item/bot_assembly/hygienebot, 2, time = 5 SECONDS), \
	new/datum/stack_recipe("каркас душа", /obj/structure/showerframe, 2, time= 2 SECONDS)
))

/obj/item/stack/sheet/metal
	name = "металл"
	desc = "Листы из металла."
	singular_name = "лист металла"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "sheet-metal"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	throwforce = 10
	flags_1 = CONDUCT_1
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/metal
	grind_results = list(/datum/reagent/iron = 20)
	point_value = 2
	tableVariant = /obj/structure/table
	material_type = /datum/material/iron
	matter_amount = 4
	cost = 500
	source = /datum/robot_energy_storage/metal

/obj/item/stack/sheet/metal/narsie_act()
	new /obj/item/stack/sheet/runed_metal(loc, amount)
	qdel(src)

/obj/item/stack/sheet/metal/fifty
	amount = 50

/obj/item/stack/sheet/metal/twenty
	amount = 20

/obj/item/stack/sheet/metal/ten
	amount = 10

/obj/item/stack/sheet/metal/five
	amount = 5

/obj/item/stack/sheet/metal/get_main_recipes()
	. = ..()
	. += GLOB.metal_recipes

/obj/item/stack/sheet/metal/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] начинает лупить [user.ru_na()]себя по голове <b>[src.name]</b>! Похоже на то, что [user.p_theyre()] пытается покончить с собой!</span>")
	return BRUTELOSS

/*
 * Plasteel
 */
GLOBAL_LIST_INIT(plasteel_recipes, list ( \
	new/datum/stack_recipe("Ядро ИИ", /obj/structure/ai_core, 4, time = 50, one_per_turf = TRUE), \
	new/datum/stack_recipe("Сборка бомб", /obj/machinery/syndicatebomb/empty, 10, time = 50), \
	null, \
	new /datum/stack_recipe_list("airlock assemblies", list( \
		new/datum/stack_recipe("high security airlock assembly", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("vault door assembly", /obj/structure/door_assembly/door_assembly_vault, 6, time = 50, one_per_turf = 1, on_floor = 1), \
	)), \
))

/obj/item/stack/sheet/plasteel
	name = "пласталь"
	singular_name = "лист пластали"
	desc = "Это лист из сплава железа и плазмы"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "sheet-plasteel"
	inhand_icon_state = "sheet-plasteel"
	mats_per_unit = list(/datum/material/alloy/plasteel=MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/alloy/plasteel
	throwforce = 10
	flags_1 = CONDUCT_1
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 80)
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/plasteel
	grind_results = list(/datum/reagent/iron = 20, /datum/reagent/toxin/plasma = 20)
	point_value = 23
	tableVariant = /obj/structure/table/reinforced
	material_flags = MATERIAL_NO_EFFECTS
	matter_amount = 12

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.plasteel_recipes

/obj/item/stack/sheet/plasteel/twenty
	amount = 20

/obj/item/stack/sheet/plasteel/fifty
	amount = 50

/*
 * Wood
 */
GLOBAL_LIST_INIT(wood_recipes, list ( \
	new/datum/stack_recipe("деревянные сандалии", /obj/item/clothing/shoes/sandal, 1), \
	new/datum/stack_recipe("деревянный пол", /obj/item/stack/tile/wood, 1, 4, 20), \
	new/datum/stack_recipe("деревянный корпус стола", /obj/structure/table_frame/wood, 2, time = 10), \
	new/datum/stack_recipe("приклад винтовки", /obj/item/weaponcrafting/stock, 10, time = 40), \
	new/datum/stack_recipe("скалка", /obj/item/kitchen/rollingpin, 2, time = 30), \
	new/datum/stack_recipe("деревянный стул", /obj/structure/chair/wood/, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("winged wooden chair", /obj/structure/chair/wood/wings, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("wooden barricade", /obj/structure/barricade/wooden, 5, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("кузнеческое полено", /obj/item/blacksmith/srub, 10, time = 10), \
	new/datum/stack_recipe("частокол", /obj/structure/barricade/wooden/stockade, 2, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("деревянная дверь", /obj/structure/mineral_door/wood, 10, time = 20, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("гроб", /obj/structure/closet/crate/coffin, 5, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("книжный шкаф", /obj/structure/bookcase, 4, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("сушилка", /obj/machinery/smartfridge/drying_rack, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("деревянная бочка", /obj/structure/fermenting_barrel, 8, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("собачья кровать", /obj/structure/bed/dogbed, 10, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("комод", /obj/structure/dresser, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("рамка для фотографии", /obj/item/wallframe/picture, 1, time = 10),\
	new/datum/stack_recipe("рамка для рисунка", /obj/item/wallframe/painting, 1, time = 10),\
	new/datum/stack_recipe("стенд шасси", /obj/structure/displaycase_chassis, 5, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("деревянный щит", /obj/item/shield/riot/buckler, 20, time = 40), \
	new/datum/stack_recipe("пчельник", /obj/structure/beebox, 40, time = 50),\
	new/datum/stack_recipe("маска Тики", /obj/item/clothing/mask/gas/tiki_mask, 2), \
	new/datum/stack_recipe("рамка для меда", /obj/item/honey_frame, 5, time = 10),\
	new/datum/stack_recipe("деревянное ведро", /obj/item/reagent_containers/glass/bucket/wooden, 3, time = 10),\
	new/datum/stack_recipe("грабли", /obj/item/cultivator/rake, 5, time = 10),\
	new/datum/stack_recipe("ящик для руды", /obj/structure/ore_box, 4, time = 50, one_per_turf = TRUE, on_floor = TRUE),\
	new/datum/stack_recipe("деревянный ящик", /obj/structure/closet/crate/wooden, 6, time = 50, one_per_turf = TRUE, on_floor = TRUE),\
	new/datum/stack_recipe("бейсбольная бита", /obj/item/melee/baseball_bat, 5, time = 15),\
	new/datum/stack_recipe("ткацкий станок", /obj/structure/loom, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("mortar", /obj/item/reagent_containers/glass/mortar, 3), \
	new/datum/stack_recipe("головешка", /obj/item/match/firebrand, 2, time = 100), \
	new/datum/stack_recipe("зубок", /obj/item/stack/teeth/human/wood, 1, time = 5),\
	new/datum/stack_recipe("рукоять скипетра", /obj/item/scepter_shaft, 3, time=5),\
	null, \
	new/datum/stack_recipe_list("церковные скамьи", list(
		new /datum/stack_recipe("скамья (центральная)", /obj/structure/chair/pew, 3, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("скамья (левая)", /obj/structure/chair/pew/left, 3, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("скамья (правая)", /obj/structure/chair/pew/right, 3, one_per_turf = TRUE, on_floor = TRUE)
		)),
	null, \
	))

/obj/item/stack/sheet/mineral/wood
	name = "деревянные доски"
	desc = "Можно лишь предположить что это куча дерева."
	singular_name = "деревянная доска"
	icon_state = "sheet-wood"
	inhand_icon_state = "sheet-wood"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/wood=MINERAL_MATERIAL_AMOUNT)
	sheettype = "wood"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 0)
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	full_w_class = WEIGHT_CLASS_NORMAL
	merge_type = /obj/item/stack/sheet/mineral/wood
	novariants = TRUE
	material_type = /datum/material/wood
	grind_results = list(/datum/reagent/cellulose = 20) //no lignocellulose or lignin reagents yet,
	walltype = /turf/closed/wall/mineral/wood

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.wood_recipes

/obj/item/stack/sheet/mineral/wood/fifty
	amount = 50

/*
 * Bamboo
 */

GLOBAL_LIST_INIT(bamboo_recipes, list ( \
	new/datum/stack_recipe("ловушка волчья яма ", /obj/structure/punji_sticks, 5, time = 30, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("распылитель", /obj/item/gun/syringe/blowgun, 10, time = 70), \
	))

/obj/item/stack/sheet/mineral/bamboo
	name = "черенки бамбука"
	desc = "Мелко нарезанные бамбуковые палочки."
	singular_name = "обрезанная бамбуковая палочка"
	icon_state = "sheet-bamboo"
	inhand_icon_state = "sheet-bamboo"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/bamboo = MINERAL_MATERIAL_AMOUNT)
	throwforce = 15
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 0)
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/bamboo
	grind_results = list(/datum/reagent/cellulose = 10)
	material_type = /datum/material/bamboo

/obj/item/stack/sheet/mineral/bamboo/get_main_recipes()
	. = ..()
	. += GLOB.bamboo_recipes

/*
 * Cloth
 */
GLOBAL_LIST_INIT(cloth_recipes, list ( \
	new/datum/stack_recipe("белый джемпер", /obj/item/clothing/under/color/jumpskirt/white, 3), /*Ladies first*/ \
	new/datum/stack_recipe("белый комбинезон", /obj/item/clothing/under/color/white, 3), \
	new/datum/stack_recipe("белые ботинки", /obj/item/clothing/shoes/sneakers/white, 2), \
	new/datum/stack_recipe("белый шарф", /obj/item/clothing/neck/scarf, 1), \
	null, \
	new/datum/stack_recipe("рюкзак", /obj/item/storage/backpack, 4), \
	new/datum/stack_recipe("вещмешок", /obj/item/storage/backpack/duffelbag, 6), \
	null, \
	new/datum/stack_recipe("сумка для растений", /obj/item/storage/bag/plants, 4), \
	new/datum/stack_recipe("сумка для книг", /obj/item/storage/bag/books, 4), \
	new/datum/stack_recipe("ранец шахтера", /obj/item/storage/bag/ore, 4), \
	new/datum/stack_recipe("сумка для химикатов", /obj/item/storage/bag/chemistry, 4), \
	new/datum/stack_recipe("сумка для биологических образцов", /obj/item/storage/bag/bio, 4), \
	new/datum/stack_recipe("строительная сумка", /obj/item/storage/bag/construction, 4), \
	null, \
	new/datum/stack_recipe("импровизированная марля", /obj/item/stack/medical/gauze/improvised, 1, 2, 6), \
	new/datum/stack_recipe("тряпка", /obj/item/reagent_containers/glass/rag, 1), \
	new/datum/stack_recipe("простыня", /obj/item/bedsheet, 3), \
	new/datum/stack_recipe("пустой мешок для песка", /obj/item/emptysandbag, 4), \
	null, \
	new/datum/stack_recipe("перчатки без пальцев", /obj/item/clothing/gloves/fingerless, 1), \
	new/datum/stack_recipe("белые перчатки", /obj/item/clothing/gloves/color/white, 3), \
	new/datum/stack_recipe("белая мягкая кепка", /obj/item/clothing/head/soft/mime, 2), \
	new/datum/stack_recipe("белая шапочка", /obj/item/clothing/head/beanie, 2), \
	null, \
	new/datum/stack_recipe("повязка на глаза", /obj/item/clothing/glasses/blindfold, 2), \
	null, \
	new/datum/stack_recipe("Холст 19x19", /obj/item/canvas/nineteen_nineteen, 3), \
	new/datum/stack_recipe("Холст 23x19", /obj/item/canvas/twentythree_nineteen, 4), \
	new/datum/stack_recipe("Холст 23x23", /obj/item/canvas/twentythree_twentythree, 5), \
	))

/obj/item/stack/sheet/cloth
	name = "ткань"
	desc = "Это хлопок? Лен? Джинса? Мешковина? Канва? Не могу сказать."
	singular_name = "рулон ткани"
	icon_state = "sheet-cloth"
	inhand_icon_state = "sheet-cloth"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cloth
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.cloth_recipes

/obj/item/stack/sheet/cloth/ten
	amount = 10

/obj/item/stack/sheet/cloth/five
	amount = 5

GLOBAL_LIST_INIT(durathread_recipes, list ( \
	new/datum/stack_recipe("дюратканевый комбинезон", /obj/item/clothing/under/misc/durathread, 4, time = 40),
	new/datum/stack_recipe("дюратканевый берет", /obj/item/clothing/head/beret/durathread, 2, time = 40), \
	new/datum/stack_recipe("дюратканевая шапочка", /obj/item/clothing/head/beanie/durathread, 2, time = 40), \
	new/datum/stack_recipe("дюратканевая бандана", /obj/item/clothing/mask/bandana/durathread, 1, time = 25), \
	))

/obj/item/stack/sheet/durathread
	name = "дюраткань"
	desc = "Ткань сшитая из невероятно прочных нитей, часто полезна при производстве брони."
	singular_name = "дюратканевый рулон"
	icon_state = "sheet-durathread"
	inhand_icon_state = "sheet-cloth"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/durathread
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'

/obj/item/stack/sheet/durathread/get_main_recipes()
	. = ..()
	. += GLOB.durathread_recipes

/obj/item/stack/sheet/cotton
	name = "пучок необработанного хлопка"
	desc = "Куча необработанного хлопка готовая к пряже на ткакцом станке."
	singular_name = "шарик хлопка-сырца"
	icon_state = "sheet-cotton"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cotton
	var/pull_effort = 10
	var/loom_result = /obj/item/stack/sheet/cloth
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cotton/durathread
	name = "пучок необработанной дюраткани"
	desc = "Куча необработанной дюраткани готовая к пряже на ткацком станке."
	singular_name = "шарик необработанной дюраткани"
	icon_state = "sheet-durathreadraw"
	merge_type = /obj/item/stack/sheet/cotton/durathread
	loom_result = /obj/item/stack/sheet/durathread
	grind_results = list()

/*
 * Cardboard
 */
GLOBAL_LIST_INIT(cardboard_recipes, list (																				 \
	new/datum/stack_recipe("коробка", /obj/item/storage/box),															 \
	new/datum/stack_recipe("костюм картонного киборга", /obj/item/clothing/suit/cardborg, 3),					  		 \
	new/datum/stack_recipe("шлем картонного киборга", /obj/item/clothing/head/cardborg),								 \
	new/datum/stack_recipe("большая коробка", /obj/structure/closet/cardboard, 4, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("картонная фигурка", /obj/item/cardboard_cutout, 5),											 \
	null,																												 \

	new/datum/stack_recipe("коробка из под пиццы", /obj/item/pizzabox),							\
	new/datum/stack_recipe("папка", /obj/item/folder),											\
	null,																						\
	//TO-DO: Find a proper way to just change the illustration on the box. Code isn't the issue, input is.
	new/datum/stack_recipe_list("необычные коробки", list(
		new /datum/stack_recipe("коробка для пончиков", /obj/item/storage/fancy/donut_box),								\
		new /datum/stack_recipe("коробка для яиц", /obj/item/storage/fancy/egg_box),									\
		new /datum/stack_recipe("donk-pockets box", /obj/item/storage/box/donkpockets),									\
		new /datum/stack_recipe("donk-pockets spicy box", /obj/item/storage/box/donkpockets/donkpocketspicy),			\
		new /datum/stack_recipe("donk-pockets teriyaki box", /obj/item/storage/box/donkpockets/donkpocketteriyaki),		\
		new /datum/stack_recipe("donk-pockets pizza box", /obj/item/storage/box/donkpockets/donkpocketpizza),			\
		new /datum/stack_recipe("donk-pockets berry box", /obj/item/storage/box/donkpockets/donkpocketberry),			\
		new /datum/stack_recipe("donk-pockets honk box", /obj/item/storage/box/donkpockets/donkpockethonk),				\
		new /datum/stack_recipe("monkey cube box", /obj/item/storage/box/monkeycubes),
		new /datum/stack_recipe("коробка для наггетсов", /obj/item/storage/fancy/nugget_box),							\
		null,																											\

		new /datum/stack_recipe("коробка для летальных дробей", /obj/item/storage/box/lethalshot),\
		new /datum/stack_recipe("коробка для резиновых дробей", /obj/item/storage/box/rubbershot),\
		new /datum/stack_recipe("коробка для резиновых дробей", /obj/item/storage/box/beanbag),		\
		new /datum/stack_recipe("коробка для светошумовых гранат", /obj/item/storage/box/flashbangs),\
		new /datum/stack_recipe("flashes box", /obj/item/storage/box/flashes),						\
		new /datum/stack_recipe("коробка для наручников", /obj/item/storage/box/handcuffs),			\
		new /datum/stack_recipe("коробка для ID карт", /obj/item/storage/box/ids),					\
		new /datum/stack_recipe("коробка для PDA", /obj/item/storage/box/pdas),						\
		null,																						\

		new /datum/stack_recipe("коробка для таблеток", /obj/item/storage/box/pillbottles),			\
		new /datum/stack_recipe("коробка для стаканов", /obj/item/storage/box/beakers),				\
		new /datum/stack_recipe("коробка для шприцов", /obj/item/storage/box/syringes),				\
		new /datum/stack_recipe("коробка для латексных перчаток", /obj/item/storage/box/gloves),	\
		new /datum/stack_recipe("коробка для стерильных масок", /obj/item/storage/box/masks),		\
		new /datum/stack_recipe("коробка для мешков для тел", /obj/item/storage/box/bodybags),		\
		new /datum/stack_recipe("коробка для рецептурных очков", /obj/item/storage/box/rxglasses),	\
		new /datum/stack_recipe("коробка для инъекторов", /obj/item/storage/box/medipens),			\
		null,																						\

		new /datum/stack_recipe("коробка для дисков", /obj/item/storage/box/disks),						\
		new /datum/stack_recipe("коробка световых трубок", /obj/item/storage/box/lights/tubes),			\
		new /datum/stack_recipe("коробка для лампочек", /obj/item/storage/box/lights/bulbs),			\
		new /datum/stack_recipe("коробка для разных лампочек", /obj/item/storage/box/lights/mixed),		\
		new /datum/stack_recipe("коробка для мышеловок", /obj/item/storage/box/mousetraps),				\
		new /datum/stack_recipe("коробка для свечей", /obj/item/storage/fancy/candle_box)
		)),

	null,																								\
))

/obj/item/stack/sheet/cardboard	//BubbleWrap //it's cardboard you fuck
	name = "картон"
	desc = "Большие листы картона, выглядят как плоские коробки."
	singular_name = "лист картона"
	icon_state = "sheet-card"
	inhand_icon_state = "sheet-card"
	mats_per_unit = list(/datum/material/cardboard = MINERAL_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cardboard
	novariants = TRUE
	grind_results = list(/datum/reagent/cellulose = 10)
	material_type = /datum/material/cardboard

/obj/item/stack/sheet/cardboard/get_main_recipes()
	. = ..()
	. += GLOB.cardboard_recipes

/obj/item/stack/sheet/cardboard/fifty
	amount = 50

/obj/item/stack/sheet/cardboard/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stamp/clown) && !istype(loc, /obj/item/storage))
		var/atom/droploc = drop_location()
		if(use(1))
			playsound(I, 'sound/items/bikehorn.ogg', 50, TRUE, -1)
			to_chat(user, "<span class='notice'>Пнул картонку! Это клоунская коробка! Хонк!</span>")
			if (amount >= 0)
				new/obj/item/storage/box/clown(droploc) //bugfix
	if(istype(I, /obj/item/stamp/chameleon) && !istype(loc, /obj/item/storage))
		var/atom/droploc = drop_location()
		if(use(1))
			to_chat(user, "<span class='notice'>Зловеще пнул картонку.</span>")
			if (amount >= 0)
				new/obj/item/storage/box/syndie_kit(droploc)
	else
		. = ..()


/*
 * Runed Metal
 */

GLOBAL_LIST_INIT(runed_metal_recipes, list ( \
	new /datum/stack_recipe("руническая дверь (не слишком прочная дверь, оглушает коснувшихся не культистов))", /obj/machinery/door/airlock/cult, 1, time = 5 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe("руническая балка (не рекомендованное использование рунного металла)", /obj/structure/girder/cult, 1, time = 5 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe("пилон (лечит (и регенерирует кровь) находящихся поблизости кровавых культистов и конструктов, но также превращает полы поблизости в гравированные)", /obj/structure/destructible/cult/pylon, 4, time = 4 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe("демоническая кузня (можно создать защищенные робы, робы флагелянтов и зеркальные щиты)", /obj/structure/destructible/cult/forge, 3, time = 4 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe("архивы (можно создать глазные повязки фанатиков, сферы проклятия шатлов, и оборудование идущего по завесе)", /obj/structure/destructible/cult/tome, 3, time = 4 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe("алтарь (можно создать жуткие точильные камни, оболочки конструктов и фляги с несвятой водой)", /obj/structure/destructible/cult/talisman, 3, time = 4 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	))

/obj/item/stack/sheet/runed_metal
	name = "рунический металл"
	desc = "Листы холодного, покрытого меняющимися надписями, металла."
	singular_name = "лист рунического металла"
	icon_state = "sheet-runed"
	inhand_icon_state = "sheet-runed"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/runedmetal = MINERAL_MATERIAL_AMOUNT)
	sheettype = "runed"
	merge_type = /obj/item/stack/sheet/runed_metal
	novariants = TRUE
	grind_results = list(/datum/reagent/iron = 5, /datum/reagent/blood = 15)
	material_type = /datum/material/runedmetal

/obj/item/stack/sheet/runed_metal/attack_self(mob/living/user)
	if(!iscultist(user))
		to_chat(user, "<span class='warning'>Только обладающий запретными знаниями имеет шанс поработать с этим металлом.	</span>")
		return
	var/turf/T = get_turf(user) //we may have moved. adjust as needed...
	var/area/A = get_area(user)
	if((!is_station_level(T.z) && !is_mining_level(T.z)) || (A && !(A.flags_1 & CULT_PERMITTED_1)))
		to_chat(user, "<span class='warning'>Завеса здесь недостаточно слабая.</span>")
		return FALSE
	return ..()

/obj/item/stack/sheet/runed_metal/get_main_recipes()
	. = ..()
	. += GLOB.runed_metal_recipes

/obj/item/stack/sheet/runed_metal/fifty
	amount = 50

/obj/item/stack/sheet/runed_metal/ten
	amount = 10

/obj/item/stack/sheet/runed_metal/five
	amount = 5

/*
 * Bronze
 */

GLOBAL_LIST_INIT(bronze_recipes, list ( \
	new/datum/stack_recipe("wall gear", /obj/structure/girder/bronze, 2, time = 20, one_per_turf = TRUE, on_floor = TRUE), \
	null,
	new/datum/stack_recipe("directional bronze window", /obj/structure/window/bronze/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("fulltile bronze window", /obj/structure/window/bronze/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("pinion airlock assembly", /obj/structure/door_assembly/door_assembly_bronze, 4, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("bronze pinion airlock assembly", /obj/structure/door_assembly/door_assembly_bronze/seethru, 4, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("бронзовая шляпа", /obj/item/clothing/head/bronze), \
	new/datum/stack_recipe("бронзовый костюм", /obj/item/clothing/suit/bronze), \
	new/datum/stack_recipe("бронзовые ботинки", /obj/item/clothing/shoes/bronze), \
	null,
	new/datum/stack_recipe("Бронзовый стул", /obj/structure/chair/bronze, 1, time = 0, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("wall gear", /obj/structure/destructible/clockwork/wall_gear, 2, time = 20, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("brass grille", /obj/structure/grille/ratvar, 2, time=20, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("brass windoor", /obj/machinery/door/window/clockwork, 5, time=40, on_floor = TRUE, window_checks=TRUE), \
	null, \
	new/datum/stack_recipe("lever", /obj/item/wallframe/clocktrap/lever, 1, time=40, one_per_turf = FALSE, on_floor = FALSE), \
	new/datum/stack_recipe("timer", /obj/item/wallframe/clocktrap/delay, 1, time=40, one_per_turf = FALSE, on_floor = FALSE), \
	new/datum/stack_recipe("pressure sensor", /obj/structure/destructible/clockwork/trap/pressure_sensor, 4, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("brass skewer", /obj/structure/destructible/clockwork/trap/skewer, 12, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("brass flipper", /obj/structure/destructible/clockwork/trap/flipper, 10, time=40, one_per_turf = TRUE, on_floor = TRUE), \
))

/obj/item/stack/tile/bronze
	name = "латунь"
	desc = "При внимательном рассмотрении становится понятно, что совершенно-непригодная-для-строительства латунь на самом деле куда более структурно устойчивая бронза."
	singular_name = "лист бронзы"
	icon_state = "sheet-brass"
	inhand_icon_state = "sheet-brass"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/bronze = MINERAL_MATERIAL_AMOUNT)
	lefthand_file = 'icons/mob/inhands/misc/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/sheets_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	force = 5
	throwforce = 10
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	turf_type = /turf/open/floor/bronze
	novariants = FALSE
	grind_results = list(/datum/reagent/iron = 5, /datum/reagent/copper = 3) //we have no "tin" reagent so this is the closest thing
	merge_type = /obj/item/stack/tile/bronze
	tableVariant = /obj/structure/table/bronze
	material_type = /datum/material/bronze

/obj/item/stack/tile/bronze/attack_self(mob/living/user)
	if(!is_servant_of_ratvar(user))
		to_chat(user, "<span class='danger'>[src] кажется слишком хрупким, чтобы строить из него.</span>") //haha that's because it's actually replicant alloy you DUMMY << WOAH TOOO FAR!
	else
		return ..()

/obj/item/stack/tile/bronze/get_main_recipes()
	. = ..()
	. += GLOB.bronze_recipes

/obj/item/stack/sheet/paperframes/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	if(loc)
		forceMove(loc, 0, 0)

/obj/item/stack/tile/bronze/thirty
	amount = 30

/obj/item/stack/tile/bronze/cyborg
	custom_materials = list()
	is_cyborg = 1
	cost = 500

/*
 * Lesser and Greater gems - unused
 */
/obj/item/stack/sheet/lessergem
	name = "самоцветы поменьше"
	desc = "Редкий вид самоцветов, которые можно получить только путем кровавых жертвоприношений младшим богам. Они нужны для созданиможнощественных объектов."
	singular_name = "самоцвет поменьше"
	icon_state = "sheet-lessergem"
	inhand_icon_state = "sheet-lessergem"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/lessergem

/obj/item/stack/sheet/greatergem
	name = "самоцветы побольше"
	desc = "Редкий вид самоцветов, которые можно получить только путем кровавых жертвоприношений младшим богам. Они нужны для созданиможнощественных объектов."
	singular_name = "самоцвет побольше"
	icon_state = "sheet-greatergem"
	inhand_icon_state = "sheet-greatergem"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/greatergem

/*
 * Bones
 */
/obj/item/stack/sheet/bone
	name = "кости"
	icon = 'icons/obj/mining.dmi'
	icon_state = "bone"
	inhand_icon_state = "sheet-bone"
	mats_per_unit = list(/datum/material/bone = MINERAL_MATERIAL_AMOUNT)
	singular_name = "кость"
	desc = "Кто-то пил своё молоко."
	force = 7
	throwforce = 5
	max_amount = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	grind_results = list(/datum/reagent/carbon = 10)
	merge_type = /obj/item/stack/sheet/bone
	material_type = /datum/material/bone

GLOBAL_LIST_INIT(plastic_recipes, list(
	new /datum/stack_recipe("пластиковый пол", /obj/item/stack/tile/plastic, 1, 4, 20), \
	new /datum/stack_recipe("складной пластиковый стул", /obj/structure/chair/plastic, 2), \
	new /datum/stack_recipe("пластиковые заслонки", /obj/structure/plasticflaps, 5, one_per_turf = TRUE, on_floor = TRUE, time = 40), \
	new /datum/stack_recipe("бутылка для воды", /obj/item/reagent_containers/food/drinks/waterbottle/empty), \
	new /datum/stack_recipe("большая бутылка для воды", /obj/item/reagent_containers/food/drinks/waterbottle/large/empty, 3), \
	new /datum/stack_recipe("пластиковый стакан", /obj/item/reagent_containers/food/drinks/colocup, 1), \
	new /datum/stack_recipe("знак мокрый пол", /obj/item/clothing/suit/caution, 2), \
	new /datum/stack_recipe("пустой настенный знак", /obj/item/sign, 1), \
	new /datum/stack_recipe("конус", /obj/item/clothing/head/cone, 2)))

/obj/item/stack/sheet/plastic
	name = "пластик"
	desc = "Сжимайте динозавров более миллиона лет, затем очистите, разделите и формируйте и Вуаля! Вот он пластик."
	singular_name = "лист пластика"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "sheet-plastic"
	inhand_icon_state = "sheet-plastic"
	mats_per_unit = list(/datum/material/plastic=MINERAL_MATERIAL_AMOUNT)
	throwforce = 7
	material_type = /datum/material/plastic
	merge_type = /obj/item/stack/sheet/plastic

/obj/item/stack/sheet/plastic/fifty
	amount = 50

/obj/item/stack/sheet/plastic/five
	amount = 5

/obj/item/stack/sheet/plastic/get_main_recipes()
	. = ..()
	. += GLOB.plastic_recipes

GLOBAL_LIST_INIT(paperframe_recipes, list(
new /datum/stack_recipe("paper frame separator", /obj/structure/window/paperframe, 2, one_per_turf = TRUE, on_floor = TRUE, time = 10), \
new /datum/stack_recipe("paper frame door", /obj/structure/mineral_door/paperframe, 3, one_per_turf = TRUE, on_floor = TRUE, time = 10 )))

/obj/item/stack/sheet/paperframes
	name = "бумажные рамки"
	desc = "Тонкая деревянная рамка с прикрепленной бумагой."
	singular_name = "бумажная рамка"
	icon_state = "sheet-paper"
	inhand_icon_state = "sheet-paper"
	mats_per_unit = list(/datum/material/paper = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/paperframes
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 20)
	material_type = /datum/material/paper

/obj/item/stack/sheet/paperframes/get_main_recipes()
	. = ..()
	. += GLOB.paperframe_recipes
/obj/item/stack/sheet/paperframes/five
	amount = 5
/obj/item/stack/sheet/paperframes/twenty
	amount = 20
/obj/item/stack/sheet/paperframes/fifty
	amount = 50

/obj/item/stack/sheet/meat
	name = "листы мяса"
	desc = "Чье-то окровавленное мясо, спресованное в неплохой твердый лист."
	singular_name = "лист мяса"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_COLOR
	mats_per_unit = list(/datum/material/meat = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/meat
	material_type = /datum/material/meat
	material_modifier = 1 //None of that wussy stuff

/obj/item/stack/sheet/meat/fifty
	amount = 50
/obj/item/stack/sheet/meat/twenty
	amount = 20
/obj/item/stack/sheet/meat/five
	amount = 5

/obj/item/stack/sheet/pizza
	name = "ломтики пепперони "
	desc = "Это вкусные ломтики пепперони!"
	singular_name = "ломтик пепперони"
	icon_state = "sheet-pizza"
	mats_per_unit = list(/datum/material/pizza = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/pizza
	material_type = /datum/material/pizza
	material_modifier = 1

/obj/item/stack/sheet/pizza/fifty
	amount = 50
/obj/item/stack/sheet/pizza/twenty
	amount = 20
/obj/item/stack/sheet/pizza/five
	amount = 5

/obj/item/stack/sheet/sandblock
	name = "блоки песка"
	desc = "Я уже слишком стар для того чтобы играться с песочными замками. Теперь я строю... Песочные станции."
	singular_name = "блок песка"
	icon_state = "sheet-sandstone"
	mats_per_unit = list(/datum/material/sand = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/sandblock
	material_type = /datum/material/sand
	material_modifier = 1

/obj/item/stack/sheet/sandblock/fifty
	amount = 50
/obj/item/stack/sheet/sandblock/twenty
	amount = 20
/obj/item/stack/sheet/sandblock/five
	amount = 5


/obj/item/stack/sheet/hauntium
	name = "листы привидениума"
	desc = "Эти листы выглядят проклятыми."
	singular_name = "haunted sheet"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_COLOR
	mats_per_unit = list(/datum/material/hauntium = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/hauntium
	material_type = /datum/material/hauntium
	material_modifier = 1 //None of that wussy stuff

/obj/item/stack/sheet/hauntium/fifty
	amount = 50
/obj/item/stack/sheet/hauntium/twenty
	amount = 20
/obj/item/stack/sheet/hauntium/five
	amount = 5
