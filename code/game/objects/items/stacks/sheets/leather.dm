/obj/item/stack/sheet/animalhide
	name = "кожа"
	desc = "Something went wrong."
	icon_state = "sheet-hide"
	inhand_icon_state = "sheet-hide"
	novariants = TRUE

/obj/item/stack/sheet/animalhide/human
	name = "человеческая кожа"
	desc = "Побочный продукт человеческого происхождения... Мудак?"
	singular_name = "кусок человеческой кожи"
	novariants = FALSE

GLOBAL_LIST_INIT(human_recipes, list( \
	new/datum/stack_recipe("раздутый человеческий костюм", /obj/item/clothing/suit/hooded/bloated_human, 5), \
	))

/obj/item/stack/sheet/animalhide/human/get_main_recipes()
	. = ..()
	. += GLOB.human_recipes

/obj/item/stack/sheet/animalhide/generic
	name = "кожа"
	desc = "Кусочек кожи."
	singular_name = "кусочек кожи"
	novariants = FALSE

/obj/item/stack/sheet/animalhide/corgi
	name = "шкура корги"
	desc = "Побочный продукт выращивания корги."
	singular_name = "кусочек кожи корги"
	icon_state = "sheet-corgi"
	inhand_icon_state = "sheet-corgi"


GLOBAL_LIST_INIT(gondola_recipes, list ( \
	new/datum/stack_recipe("маска гондолы", /obj/item/clothing/mask/gondola, 1), \
	new/datum/stack_recipe("костюм гондолы", /obj/item/clothing/under/costume/gondola, 2), \
	))

/obj/item/stack/sheet/animalhide/gondola
	name = "шкура гондолы"
	desc = "Чрезвычайно ценный продукт охоты на гондол."
	singular_name = "кусочек шкуры гондолы"
	icon_state = "sheet-gondola"
	inhand_icon_state = "sheet-gondola"

/obj/item/stack/sheet/animalhide/gondola/get_main_recipes()
	. = ..()
	. += GLOB.gondola_recipes

GLOBAL_LIST_INIT(corgi_recipes, list ( \
	new/datum/stack_recipe("костюм корги", /obj/item/clothing/suit/hooded/ian_costume, 3), \
	))

/obj/item/stack/sheet/animalhide/corgi/get_main_recipes()
	. = ..()
	. += GLOB.corgi_recipes

/obj/item/stack/sheet/animalhide/cat
	name = "кошачья шкура"
	desc = "Побочный продукт разведения кошек."
	singular_name = "кусок шкуры кошки"
	icon_state = "sheet-cat"
	inhand_icon_state = "sheet-cat"

/obj/item/stack/sheet/animalhide/monkey
	name = "шкура обезьяны"
	desc = "Побочный продукт разведения обезьян."
	singular_name = "кусок шкуры обезьяны"
	icon_state = "sheet-monkey"
	inhand_icon_state = "sheet-monkey"

GLOBAL_LIST_INIT(monkey_recipes, list ( \
	new/datum/stack_recipe("маска обезьяны", /obj/item/clothing/mask/gas/monkeymask, 1), \
	new/datum/stack_recipe("костюм обезьяны", /obj/item/clothing/suit/monkeysuit, 2), \
	))

/obj/item/stack/sheet/animalhide/monkey/get_main_recipes()
	. = ..()
	. += GLOB.monkey_recipes

/obj/item/stack/sheet/animalhide/lizard
	name = "кожа ящерицы"
	desc = "Ссссссс..."
	singular_name = "кусок кожи ящерицы"
	icon_state = "sheet-lizard"
	inhand_icon_state = "sheet-lizard"

/obj/item/stack/sheet/animalhide/xeno
	name = "инопланетная шкура"
	desc = "Кожа ужасного существа."
	singular_name = "кусок кожи инопланетянина"
	icon_state = "sheet-xeno"
	inhand_icon_state = "sheet-xeno"

GLOBAL_LIST_INIT(xeno_recipes, list ( \
	new/datum/stack_recipe("голова ксеноса", /obj/item/clothing/head/xenos, 1), \
	new/datum/stack_recipe("костюм ксеноса", /obj/item/clothing/suit/xenos, 2), \
	))

/obj/item/stack/sheet/animalhide/xeno/get_main_recipes()
	. = ..()
	. += GLOB.xeno_recipes

//don't see anywhere else to put these, maybe together they could be used to make the xenos suit?
/obj/item/stack/sheet/xenochitin
	name = "инопланетный хитин"
	desc = "Кусок шкуры ужасного существа."
	singular_name = "кусок кожи инопланетянина"
	icon = 'icons/mob/alien.dmi'
	icon_state = "chitin"
	novariants = TRUE

/obj/item/xenos_claw
	name = "инопланетный коготь"
	desc = "Коготь ужасного существа."
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/weed_extract
	name = "экстракт сорняков"
	desc = "Кусочек слизистой пурпурной травы."
	icon = 'icons/mob/alien.dmi'
	icon_state = "weed_extract"

/obj/item/stack/sheet/hairlesshide
	name = "безволосая шкура"
	desc = "Эта шкура была лишена волос, но все еще нуждается в мытье и загаре."
	singular_name = "кусок безволосой шкуры"
	icon_state = "sheet-hairlesshide"
	inhand_icon_state = "sheet-hairlesshide"

/obj/item/stack/sheet/wethide
	name = "мокрая шкура"
	desc = "Эта шкура была очищена, но все еще нуждается в сушке."
	singular_name = "мокрая шкура"
	icon_state = "sheet-wetleather"
	inhand_icon_state = "sheet-wetleather"
	var/wetness = 30 //Reduced when exposed to high temperautres
	var/drying_threshold_temperature = 500 //Kelvin to start drying

/*
 * Leather SHeet
 */
/obj/item/stack/sheet/leather
	name = "кожа"
	desc = "Побочный продукт разведения животных."
	singular_name = "кусок кожи"
	icon_state = "sheet-leather"
	inhand_icon_state = "sheet-leather"

GLOBAL_LIST_INIT(leather_recipes, list ( \
	new/datum/stack_recipe("бумажник", /obj/item/storage/wallet, 1), \
	new/datum/stack_recipe("намордник", /obj/item/clothing/mask/muzzle, 2), \
	new/datum/stack_recipe("ботанические перчатки", /obj/item/clothing/gloves/botanic_leather, 3), \
	new/datum/stack_recipe("пояс с инструментами", /obj/item/storage/belt/utility, 4), \
	new/datum/stack_recipe("кожаная сумка", /obj/item/storage/backpack/satchel/leather, 5), \
	new/datum/stack_recipe("патронташ", /obj/item/storage/belt/bandolier, 5), \
	new/datum/stack_recipe("кожаный пиджак", /obj/item/clothing/suit/jacket/leather, 7), \
	new/datum/stack_recipe("кожаные ботинки", /obj/item/clothing/shoes/laceup, 2), \
	new/datum/stack_recipe("кожаное пальто", /obj/item/clothing/suit/jacket/leather/overcoat, 10), \
	new/datum/stack_recipe("седло", /obj/item/saddle, 5), \
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.leather_recipes
/*
 * Sinew
 */
/obj/item/stack/sheet/sinew
	name = "сухожилия стражника"
	icon = 'icons/obj/mining.dmi'
	desc = "Длинные волокнистые нити, которые предположительно пришли с крыльев наблюдателя."
	singular_name = "сухожилие стражника"
	icon_state = "sinew"
	novariants = TRUE

/obj/item/stack/sheet/sinew/wolf
	name = "волчьи сухожилия"
	desc = "Длинные волокнистые нити, которые пришли изнутри волка."
	singular_name = "волчье сухожилие"


GLOBAL_LIST_INIT(sinew_recipes, list ( \
	new/datum/stack_recipe("сухожильные наручники", /obj/item/restraints/handcuffs/cable/sinew, 1), \
))

/obj/item/stack/sheet/sinew/get_main_recipes()
	. = ..()
	. += GLOB.sinew_recipes

		/*
 * Plates
 		*/
/obj/item/stack/sheet/animalhide/goliath_hide
	name = "шкурные пластины голиафа"
	desc = "Осколки скалистой шкуры Голиафа могут сделать ваш костюм более стойким к атакам местной фауны."
	icon = 'icons/obj/mining.dmi'
	icon_state = "goliath_hide"
	singular_name = "шкурная пластина"
	max_amount = 6
	novariants = FALSE
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER

/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide
	name = "шкура полярного медведя"
	desc = "Кусочки меха белого медведя могут сделать ваш костюм более стойким к атакам местной фауны."
	icon_state = "polar_bear_hide"
	singular_name = "шкура медведя"

/obj/item/stack/sheet/animalhide/ashdrake
	name = "шкура пепельного дракона"
	desc = "Сильная чешуйчатая шкура пепельного дракона."
	icon = 'icons/obj/mining.dmi'
	icon_state = "dragon_hide"
	singular_name = "драконьи пластины"
	max_amount = 10
	novariants = FALSE
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER


//Step one - dehairing.

/obj/item/stack/sheet/animalhide/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message("<span class='notice'><b>[user]</b> начинает срезать шерсть с <b>[src]</b>.</span>", "<span class='notice'>Начинаю срезать шерсть с <b>[src]</b>...</span>", "<span class='hear'>Слыш как нож режет плоть.</span>")
		if(do_after(user, 50, target = src))
			to_chat(user, "<span class='notice'>Срезаю шерсть с <b>[src.singular_name]</b>.</span>")
			new /obj/item/stack/sheet/hairlesshide(user.drop_location(), 1)
			use(1)
	else
		return ..()


//Step two - washing..... it's actually in washing machine code.

//Step three - drying
/obj/item/stack/sheet/wethide/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	..()
	if(exposed_temperature >= drying_threshold_temperature)
		wetness--
		if(wetness == 0)
			new /obj/item/stack/sheet/leather(drop_location(), 1)
			wetness = initial(wetness)
			use(1)

/obj/item/stack/sheet/wethide/microwave_act(obj/machinery/microwave/MW)
	..()
	new /obj/item/stack/sheet/leather(drop_location(), amount)
	qdel(src)
