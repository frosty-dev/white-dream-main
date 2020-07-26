/obj/item/clothing/neck
	name = "ожерелье"
	icon = 'icons/obj/clothing/neck.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	strip_delay = 40
	equip_delay_other = 40

/obj/item/clothing/neck/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(body_parts_covered & HEAD)
			if(damaged_clothes)
				. += mutable_appearance('icons/effects/item_damage.dmi', "damagedmask")
			if(HAS_BLOOD_DNA(src))
				. += mutable_appearance('icons/effects/blood.dmi', "maskblood")

/obj/item/clothing/neck/tie
	name = "галстук"
	desc = "Привязной галстук из неоткани."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bluetie"
	inhand_icon_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = 60

/obj/item/clothing/neck/tie/blue
	name = "синий галстук"
	icon_state = "bluetie"

/obj/item/clothing/neck/tie/red
	name = "красный галстук"
	icon_state = "redtie"

/obj/item/clothing/neck/tie/black
	name = "чёрный галстук"
	icon_state = "blacktie"

/obj/item/clothing/neck/tie/horrible
	name = "ужасный галстук"
	desc = "Привязной галстук из неоткани. Этот выглядит отвратительно."
	icon_state = "horribletie"

/obj/item/clothing/neck/tie/detective
	name = "провисший галстук"
	desc = "Свободно связанный галстук, идеальный аксессуар для переутомленного детектива."
	icon_state = "detective"

/obj/item/clothing/neck/stethoscope
	name = "стетоскоп"
	desc = "Устаревший медицинский аппарат для прослушивания звуков человеческого тела. Это также заставляет вас выглядеть так, как будто вы знаете, что делаете."
	icon_state = "stethoscope"

/obj/item/clothing/neck/stethoscope/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] puts \the [src] to [user.p_their()] chest! It looks like [user.p_they()] won't hear much!</span>")
	return OXYLOSS

/obj/item/clothing/neck/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == INTENT_HELP)
			var/body_part = parse_zone(user.zone_selected)

			var/heart_strength = "<span class='danger'>отсутствие</span>"
			var/lung_strength = "<span class='danger'>отсутствие</span>"

			var/obj/item/organ/heart/heart = M.getorganslot(ORGAN_SLOT_HEART)
			var/obj/item/organ/lungs/lungs = M.getorganslot(ORGAN_SLOT_LUNGS)

			if(!(M.stat == DEAD || (HAS_TRAIT(M, TRAIT_FAKEDEATH))))
				if(heart && istype(heart))
					heart_strength = "<span class='danger'>нестабильность</span>"
					if(heart.beating)
						heart_strength = "здоровый звук"
				if(lungs && istype(lungs))
					lung_strength = "<span class='danger'>напряженно</span>"
					if(!(M.failed_last_breath || M.losebreath))
						lung_strength = "здоровый звук"

			var/diagnosis = (body_part == BODY_ZONE_CHEST ? "Слышу [heart_strength] пульса и [lung_strength] дыхания." : "Я еле слышу [heart_strength] пульс.")
			user.visible_message("<span class='notice'>[user] пристраивает [src] в [ru_exam_parse_zone(body_part)] [M] и слушает внимательно.</span>", "<span class='notice'>Прикладываю [src] к [ru_exam_parse_zone(body_part)] [M]. [diagnosis]</span>")
			return
	return ..(M,user)

///////////
//SCARVES//
///////////

/obj/item/clothing/neck/scarf //Default white color, same functionality as beanies.
	name = "белый шарф"
	icon_state = "scarf"
	desc = "Стильный шарф. Идеальный зимний аксессуар для тех, у кого острое чувство моды, и для тех, кто просто не может справиться с холодным бризом на шеях."
	dog_fashion = /datum/dog_fashion/head
	custom_price = 60

/obj/item/clothing/neck/scarf/black
	name = "чёрный шарф"
	icon_state = "scarf"
	color = "#4A4A4B" //Grey but it looks black

/obj/item/clothing/neck/scarf/pink
	name = "розовый шарф"
	icon_state = "scarf"
	color = "#F699CD" //Pink

/obj/item/clothing/neck/scarf/red
	name = "красный шарф"
	icon_state = "scarf"
	color = "#D91414" //Red

/obj/item/clothing/neck/scarf/green
	name = "зелёный шарф"
	icon_state = "scarf"
	color = "#5C9E54" //Green

/obj/item/clothing/neck/scarf/darkblue
	name = "тёмно-синий шарф"
	icon_state = "scarf"
	color = "#1E85BC" //Blue

/obj/item/clothing/neck/scarf/purple
	name = "фиолетовый шарф"
	icon_state = "scarf"
	color = "#9557C5" //Purple

/obj/item/clothing/neck/scarf/yellow
	name = "жёлтый шарф"
	icon_state = "scarf"
	color = "#E0C14F" //Yellow

/obj/item/clothing/neck/scarf/orange
	name = "оранжевый  шарф"
	icon_state = "scarf"
	color = "#C67A4B" //Orange

/obj/item/clothing/neck/scarf/cyan
	name = "голубой шарф"
	icon_state = "scarf"
	color = "#54A3CE" //Cyan


//Striped scarves get their own icons

/obj/item/clothing/neck/scarf/zebra
	name = "зебровый шарф"
	icon_state = "zebrascarf"

/obj/item/clothing/neck/scarf/christmas
	name = "рождественский шарф"
	icon_state = "christmasscarf"

//The three following scarves don't have the scarf subtype
//This is because Ian can equip anything from that subtype
//However, these 3 don't have corgi versions of their sprites
/obj/item/clothing/neck/stripedredscarf
	name = "полосатый красный шарф"
	icon_state = "stripedredscarf"
	custom_price = 10

/obj/item/clothing/neck/stripedgreenscarf
	name = "полосатый зелёный шарф"
	icon_state = "stripedgreenscarf"
	custom_price = 10

/obj/item/clothing/neck/stripedbluescarf
	name = "полосатый синий шарф"
	icon_state = "stripedbluescarf"
	custom_price = 10

/obj/item/clothing/neck/petcollar
	name = "ошейник"
	desc = "Это для домашних животных."
	icon_state = "petcollar"
	var/tagname = null
/*
/obj/item/clothing/neck/petcollar/mob_can_equip(mob/M, mob/equipper, slot, disable_warning = 0)
	if(ishuman(M))
		return FALSE
	return ..()
*/
/obj/item/clothing/neck/petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Хотите изменить имя на теге?", "Назовите своего нового питомца", "Шепард", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

//////////////
//DOPE BLING//
//////////////

/obj/item/clothing/neck/necklace/dope
	name = "золотая цепочка"
	desc = "Как же заебись быть гангстером."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bling"

/obj/item/clothing/neck/necklace/dope/merchant
	desc = "Don't ask how it works, the proof is in the holochips!"
	/// scales the amount received in case an admin wants to emulate taxes/fees.
	var/profit_scaling = 1
	/// toggles between sell (TRUE) and get price post-fees (FALSE)
	var/selling = FALSE

/obj/item/clothing/neck/necklace/dope/merchant/attack_self(mob/user)
	. = ..()
	selling = !selling
	to_chat(user, "<span class='notice'>[src] has been set to [selling ? "'Sell'" : "'Get Price'"] mode.</span>")

/obj/item/clothing/neck/necklace/dope/merchant/afterattack(obj/item/I, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	var/datum/export_report/ex = export_item_and_contents(I, allowed_categories = (ALL), dry_run=TRUE)
	var/price = 0
	for(var/x in ex.total_amount)
		price += ex.total_value[x]

	if(price)
		var/true_price = round(price*profit_scaling)
		to_chat(user, "<span class='notice'>[selling ? "Sold" : "Getting the price of"] [I], value: <b>[true_price]</b> credits[I.contents.len ? " (exportable contents included)" : ""].[profit_scaling < 1 && selling ? "<b>[round(price-true_price)]</b> credit\s taken as processing fee\s." : ""]</span>")
		if(selling)
			new /obj/item/holochip(get_turf(user),true_price)
			for(var/i in ex.exported_atoms_ref)
				var/atom/movable/AM = i
				if(QDELETED(AM))
					continue
				qdel(AM)
	else
		to_chat(user, "<span class='warning'>There is no export value for [I] or any items within it.</span>")


/obj/item/clothing/neck/neckerchief
	icon = 'icons/obj/clothing/masks.dmi' //In order to reuse the bandana sprite
	w_class = WEIGHT_CLASS_TINY
	var/sourceBandanaType

/obj/item/clothing/neck/neckerchief/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/realOverlay = mutable_appearance('icons/mob/clothing/mask.dmi', icon_state)
		realOverlay.pixel_y = -3
		. += realOverlay

/obj/item/clothing/neck/neckerchief/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.get_item_by_slot(ITEM_SLOT_NECK) == src)
			to_chat(user, "<span class='warning'>Не могу развязать [src] пока оно на мне!</span>")
			return
		if(user.is_holding(src))
			var/obj/item/clothing/mask/bandana/newBand = new sourceBandanaType(user)
			var/currentHandIndex = user.get_held_index_of_item(src)
			var/oldName = src.name
			qdel(src)
			user.put_in_hand(newBand, currentHandIndex)
			user.visible_message("<span class='notice'>Развязываю [oldName] обратно к [newBand.name].</span>", "<span class='notice'>[user] развязывает [oldName] обратно к [newBand.name].</span>")
		else
			to_chat(user, "<span class='warning'>Надо бы держать в руках [src], чтобы развязать!</span>")

/obj/item/clothing/neck/beads
	name = "plastic bead necklace"
	desc = "A cheap, plastic bead necklace. Show team spirit! Collect them! Throw them away! The posibilites are endless!"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "beads"
	color = "#ffffff"
	custom_price = 10
	custom_materials = (list(/datum/material/plastic = 500))

/obj/item/clothing/neck/beads/Initialize()
	. = ..()
	color = color = pick("#ff0077","#d400ff","#2600ff","#00ccff","#00ff2a","#e5ff00","#ffae00","#ff0000", "#ffffff")
