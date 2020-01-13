/obj/item/clothing/gloves/color
	dying_key = DYE_REGISTRY_GLOVES

/obj/item/clothing/gloves/color/yellow
	desc = "Эти перчатки защитят пользователя от поражения электрическим током."
	name = "резиновые перчатки"
	icon_state = "yellow"
	item_state = "ygloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	resistance_flags = NONE
	custom_price = 1200
	custom_premium_price = 1200

/obj/item/clothing/gloves/color/fyellow                             //Cheap Chinese Crap
	desc = "Эти перчатки являются дешевыми подделками желанных перчаток - это может плохо кончиться."
	name = "бюджетные резиновые перчатки"
	icon_state = "yellow"
	item_state = "ygloves"
	siemens_coefficient = 1			//Set to a default of 1, gets overridden in Initialize()
	permeability_coefficient = 0.05
	resistance_flags = NONE

/obj/item/clothing/gloves/color/fyellow/Initialize()
	. = ..()
	siemens_coefficient = pick(0,0.5,0.5,0.5,0.5,0.75,1.5)

/obj/item/clothing/gloves/color/fyellow/old
	desc = "Эти перчатки защитят пользователя от поражения электрическим током. Староватые."
	name = "старенькие резиновые перчатки"

/obj/item/clothing/gloves/color/fyellow/old/Initialize()
	. = ..()
	siemens_coefficient = pick(0,0,0,0.5,0.5,0.5,0.75)

/obj/item/clothing/gloves/color/black
	desc = "Эти перчатки огнеупорные."
	name = "чёрные перчатки"
	icon_state = "black"
	item_state = "blackgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	var/can_be_cut = TRUE

/obj/item/clothing/gloves/color/black/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		if(can_be_cut && icon_state == initial(icon_state))//only if not dyed
			to_chat(user, "<span class='notice'>You snip the fingertips off of [src].</span>")
			I.play_tool_sound(src)
			new /obj/item/clothing/gloves/fingerless(drop_location())
			qdel(src)
	..()

/obj/item/clothing/gloves/color/orange
	name = "оранжевые перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "orange"
	item_state = "orangegloves"

/obj/item/clothing/gloves/color/red
	name = "красные перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "red"
	item_state = "redgloves"


/obj/item/clothing/gloves/color/red/insulated
	name = "резиновые перчатки"
	desc = "Эти перчатки защитят пользователя от поражения электрическим током."
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	resistance_flags = NONE

/obj/item/clothing/gloves/color/rainbow
	name = "радужные перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "rainbow"
	item_state = "rainbowgloves"

/obj/item/clothing/gloves/color/blue
	name = "синие перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "blue"
	item_state = "bluegloves"

/obj/item/clothing/gloves/color/purple
	name = "фиолетовые перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "purple"
	item_state = "purplegloves"

/obj/item/clothing/gloves/color/green
	name = "зелёные перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "green"
	item_state = "greengloves"

/obj/item/clothing/gloves/color/grey
	name = "серые перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "gray"
	item_state = "graygloves"

/obj/item/clothing/gloves/color/light_brown
	name = "светло-коричневые перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "lightbrown"
	item_state = "lightbrowngloves"

/obj/item/clothing/gloves/color/brown
	name = "коричневые перчатки"
	desc = "Пара перчаток, они ни в коем случае не выглядят особенными."
	icon_state = "brown"
	item_state = "browngloves"

/obj/item/clothing/gloves/color/captain
	desc = "Царственно-синие перчатки с красивой золотой отделкой, алмазным противоударным покрытием и встроенным тепловым барьером. Шикарно."
	name = "капитанские перчатки"
	icon_state = "captain"
	item_state = "egloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 60
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 50)

/obj/item/clothing/gloves/color/latex
	name = "латексные перчатки"
	desc = "Дешевые стерильные перчатки из латекса. Передает второстепенные парамедицинские знания пользователю через бюджетные наночипы."
	icon_state = "latex"
	item_state = "latex"
	siemens_coefficient = 0.3
	permeability_coefficient = 0.01
	transfer_prints = TRUE
	resistance_flags = NONE
	var/carrytrait = TRAIT_QUICK_CARRY

/obj/item/clothing/gloves/color/latex/equipped(mob/user, slot)
	..()
	if(slot == ITEM_SLOT_GLOVES)
		ADD_TRAIT(user, carrytrait, CLOTHING_TRAIT)

/obj/item/clothing/gloves/color/latex/dropped(mob/user)
	..()
	REMOVE_TRAIT(user, carrytrait, CLOTHING_TRAIT)

/obj/item/clothing/gloves/color/latex/nitrile
	name = "нитриловые перчатки"
	desc = "Ценные стерильные перчатки толще латекса. Передача интимных знаний парамедиков пользователю через наночипы."
	icon_state = "nitrile"
	item_state = "nitrilegloves"
	transfer_prints = FALSE
	carrytrait = TRAIT_QUICKER_CARRY

/obj/item/clothing/gloves/color/latex/engineering
	name = "tinker's gloves"
	desc = "Overdesigned engineering gloves that have automated construction subrutines dialed in, allowing for faster construction while worn."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_gauntlets"
	item_state = "clockwork_gauntlets"
	siemens_coefficient = 0.8
	permeability_coefficient = 0.3
	carrytrait = TRAIT_QUICK_BUILD
	custom_materials = list(/datum/material/iron=2000, /datum/material/silver=1500, /datum/material/gold = 1000)

/obj/item/clothing/gloves/color/white
	name = "белые перчатки"
	desc = "Выглядят довольно причудливо."
	icon_state = "white"
	item_state = "wgloves"

/obj/effect/spawner/lootdrop/gloves
	name = "случайные перчатки"
	desc = "These gloves are supposed to be a random color..."
	icon = 'icons/obj/clothing/gloves.dmi'
	icon_state = "random_gloves"
	loot = list(
		/obj/item/clothing/gloves/color/orange = 1,
		/obj/item/clothing/gloves/color/red = 1,
		/obj/item/clothing/gloves/color/blue = 1,
		/obj/item/clothing/gloves/color/purple = 1,
		/obj/item/clothing/gloves/color/green = 1,
		/obj/item/clothing/gloves/color/grey = 1,
		/obj/item/clothing/gloves/color/light_brown = 1,
		/obj/item/clothing/gloves/color/brown = 1,
		/obj/item/clothing/gloves/color/white = 1,
		/obj/item/clothing/gloves/color/rainbow = 1)
