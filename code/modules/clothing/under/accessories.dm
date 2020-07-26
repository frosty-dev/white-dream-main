/obj/item/clothing/accessory //Ties moved to neck slot items, but as there are still things like medals and armbands, this accessory system is being kept as-is
	name = "Accessory"
	desc = "Something has gone wrong!"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "plasma"
	inhand_icon_state = ""	//no inhands
	slot_flags = 0
	w_class = WEIGHT_CLASS_SMALL
	var/above_suit = FALSE
	var/minimize_when_attached = TRUE // TRUE if shown as a small icon in corner, FALSE if overlayed
	var/datum/component/storage/detached_pockets
	var/attachment_slot = CHEST

/obj/item/clothing/accessory/proc/can_attach_accessory(obj/item/clothing/U, mob/user)
	if(!attachment_slot || (U && U.body_parts_covered & attachment_slot))
		return TRUE
	if(user)
		to_chat(user, "<span class='warning'>There doesn't seem to be anywhere to put [src]...</span>")

/obj/item/clothing/accessory/proc/attach(obj/item/clothing/under/U, user)
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	if(storage)
		if(SEND_SIGNAL(U, COMSIG_CONTAINS_STORAGE))
			return FALSE
		U.TakeComponent(storage)
		detached_pockets = storage
	U.attached_accessory = src
	forceMove(U)
	layer = FLOAT_LAYER
	plane = FLOAT_PLANE
	if(minimize_when_attached)
		transform *= 0.5	//halve the size so it doesn't overpower the under
		pixel_x += 8
		pixel_y -= 8
	U.add_overlay(src)

	if (islist(U.armor) || isnull(U.armor)) 										// This proc can run before /obj/Initialize has run for U and src,
		U.armor = getArmor(arglist(U.armor))	// we have to check that the armor list has been transformed into a datum before we try to call a proc on it
																					// This is safe to do as /obj/Initialize only handles setting up the datum if actually needed.
	if (islist(armor) || isnull(armor))
		armor = getArmor(arglist(armor))

	U.armor = U.armor.attachArmor(armor)

	if(isliving(user))
		on_uniform_equip(U, user)

	return TRUE

/obj/item/clothing/accessory/proc/detach(obj/item/clothing/under/U, user)
	if(detached_pockets && detached_pockets.parent == U)
		TakeComponent(detached_pockets)

	U.armor = U.armor.detachArmor(armor)

	if(isliving(user))
		on_uniform_dropped(U, user)

	if(minimize_when_attached)
		transform *= 2
		pixel_x -= 8
		pixel_y += 8
	layer = initial(layer)
	plane = initial(plane)
	U.cut_overlays()
	U.attached_accessory = null
	U.accessory_overlay = null

/obj/item/clothing/accessory/proc/on_uniform_equip(obj/item/clothing/under/U, user)
	return

/obj/item/clothing/accessory/proc/on_uniform_dropped(obj/item/clothing/under/U, user)
	return

/obj/item/clothing/accessory/AltClick(mob/user)
	if(istype(user) && user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		if(initial(above_suit))
			above_suit = !above_suit
			to_chat(user, "[src] will be worn [above_suit ? "above" : "below"] your suit.")

/obj/item/clothing/accessory/examine(mob/user)
	. = ..()
	. += "<span class='notice'>\The [src] can be attached to a uniform. Alt-click to remove it once attached.</span>"
	if(initial(above_suit))
		. += "<span class='notice'>\The [src] can be worn above or below your suit. Alt-click to toggle.</span>"

/obj/item/clothing/accessory/waistcoat
	name = "waistcoat"
	desc = "For some classy, murderous fun."
	icon_state = "waistcoat"
	inhand_icon_state = "waistcoat"
	minimize_when_attached = FALSE
	attachment_slot = null

/obj/item/clothing/accessory/maidapron
	name = "maid apron"
	desc = "The best part of a maid costume."
	icon_state = "maidapron"
	inhand_icon_state = "maidapron"
	minimize_when_attached = FALSE
	attachment_slot = null

//////////
//Medals//
//////////

/obj/item/clothing/accessory/medal
	name = "бронзовая медаль"
	desc = "Прикольн."
	icon_state = "bronze"
	custom_materials = list(/datum/material/iron=1000)
	resistance_flags = FIRE_PROOF
	var/medaltype = "medal" //Sprite used for medalbox
	var/commended = FALSE

//Pinning medals on people
/obj/item/clothing/accessory/medal/attack(mob/living/carbon/human/M, mob/living/user, params)
	if(ishuman(M) && (user.a_intent == INTENT_HELP))

		if(M.wear_suit)
			if((M.wear_suit.flags_inv & HIDEJUMPSUIT)) //Check if the jumpsuit is covered
				to_chat(user, "<span class='warning'>Медали могут быть повешены только на нижнюю одежду.</span>")
				return

		if(M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			var/delay = 20
			if(user == M)
				delay = 0
			else
				user.visible_message("<span class='notice'><b>[user]</b> начинает вешать <b>[src.name]</b> на грудь <b>[M]</b>.</span>", \
									 "<span class='notice'>Пытаюсь повесить <b>[src.name]</b> на грудь <b>[M]</b>.</span>")
			var/input
			if(!commended && user != M)
				input = stripped_input(user,"Напишите комментарий к награде. Это будет рассматриваться Нанотрейзеном в дальнейшем.", ,"", 140)
			if(do_after(user, delay, target = M))
				if(U.attach_accessory(src, user, 0, params)) //Attach it, do not notify the user of the attachment
					if(user == M)
						to_chat(user, "<span class='notice'>Прикрепляю <b>[src.name]</b> на <b>[U]</b>.</span>")
					else
						user.visible_message("<span class='notice'><b>[user]</b> прикрепляет <b>[src.name]</b> на грудь <b>[M]</b>.</span>", \
											 "<span class='notice'>Прикрепляю <b>[src.name]</b> на грудь <b>[M]</b>.</span>")
						if(input)
							SSblackbox.record_feedback("associative", "commendation", 1, list("commender" = "[user.real_name]", "commendee" = "[M.real_name]", "medal" = "[src.name]", "reason" = input))
							GLOB.commendations += "[user.real_name] awarded <b>[M.real_name]</b> the <span class='medaltext'>[name]</span>! \n- [input]"
							commended = TRUE
							desc += "<br>Подпись гласит: [input] - [user.real_name]"
							log_game("<b>[key_name(M)]</b> was given the following commendation by <b>[key_name(user)]</b>: [input]")
							message_admins("<b>[key_name_admin(M)]</b> was given the following commendation by <b>[key_name_admin(user)]</b>: [input]")

		else
			to_chat(user, "<span class='warning'>Медали могут быть повешены только на нижнюю одежду!</span>")
	else
		..()

/obj/item/clothing/accessory/medal/conduct
	name = "медаль за выдающееся поведение"
	desc = "Бронзовая медаль за выдающееся поведение. Хотя это большая честь, это самая основная награда, присуждаемая Nanotrasen. Он часто присуждается капитаном члену его команды."

/obj/item/clothing/accessory/medal/bronze_heart
	name = "бронзовая медаль за жертву"
	desc = "Бронзовая медаль в форме сердца, вручаемая за жертву. Он часто присуждается посмертно или за тяжелые травмы при исполнении служебных обязанностей."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/ribbon
	name = "лента"
	desc = "Ленточка!"
	icon_state = "cargo"

/obj/item/clothing/accessory/medal/ribbon/cargo
	name = "\"грузчик смены\""
	desc = "Награда присуждалась только тем карготехам, которые проявили преданность своему долгу в соответствии с высочайшими традициями Каргонии."

/obj/item/clothing/accessory/medal/silver
	name = "серебрянная медаль"
	desc = "Сверкает."
	icon_state = "silver"
	medaltype = "medal-silver"
	custom_materials = list(/datum/material/silver=1000)

/obj/item/clothing/accessory/medal/silver/valor
	name = "медаль отваги"
	desc = "Серебряная медаль присуждается за акты исключительной доблести."

/obj/item/clothing/accessory/medal/silver/security
	name = "надежная награда за безопасность"
	desc = "Награда за выдающиеся бои и жертвы в защиту коммерческих интересов Нанотрейзена. Часто присуждается сотрудникам службы безопасности."

/obj/item/clothing/accessory/medal/silver/excellence
	name = "награда руководителя персонала за выдающиеся достижения в области передового опыта"
	desc = "Словарь Нанотрейзен определяет превосходство как \"качество или условие отличного качества\". Это присуждается тем редким членам экипажа, которые соответствуют этому определению."

/obj/item/clothing/accessory/medal/gold
	name = "золотая медаль"
	desc = "Престижная золотая медаль."
	icon_state = "gold"
	medaltype = "medal-gold"
	custom_materials = list(/datum/material/gold=1000)

/obj/item/clothing/accessory/medal/gold/captain
	name = "медаль капитана"
	desc = "Золотая медаль присуждается исключительно тем, кто получил звание капитана. Это означает кодифицированную ответственность капитана перед Нанотрейзен и их бесспорную власть над своей командой."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/accessory/medal/gold/heroism
	name = "медаль исключительного героизма"
	desc = "Чрезвычайно редкая золотая медаль, присуждаемая только CentCom. Получить такую медаль - высшая честь, и как таковые существуют очень немногие. Эта медаль почти никогда не вручается никому, кроме командиров."

/obj/item/clothing/accessory/medal/plasma
	name = "медаль из плазмы"
	desc = "Эксцентричная медаль из плазмы."
	icon_state = "plasma"
	medaltype = "medal-plasma"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = -10, "acid" = 0) //It's made of plasma. Of course it's flammable.
	custom_materials = list(/datum/material/plasma=1000)

/obj/item/clothing/accessory/medal/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		atmos_spawn_air("plasma=20;TEMP=[exposed_temperature]")
		visible_message("<span class='danger'><b>[src.name]</b> загорается!</span>", "<span class='userdanger'>Моя <b>[src.name]</b> начинает гореть!</span>")
		qdel(src)

/obj/item/clothing/accessory/medal/plasma/nobel_science
	name = "премия нобелевских наук"
	desc = "Медаль из плазмы, которая представляет значительный вклад в области науки или техники."



////////////
//Armbands//
////////////

/obj/item/clothing/accessory/armband
	name = "красный armband"
	desc = "An fancy red armband!"
	icon_state = "redband"
	attachment_slot = null

/obj/item/clothing/accessory/armband/deputy
	name = "security deputy armband"
	desc = "An armband, worn by personnel authorized to act as a deputy of station security."

/obj/item/clothing/accessory/armband/cargo
	name = "cargo bay guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is brown."
	icon_state = "cargoband"

/obj/item/clothing/accessory/armband/engine
	name = "engineering guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is orange with a reflective strip!"
	icon_state = "engieband"

/obj/item/clothing/accessory/armband/science
	name = "science guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is purple."
	icon_state = "rndband"

/obj/item/clothing/accessory/armband/hydro
	name = "hydroponics guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is green and blue."
	icon_state = "hydroband"

/obj/item/clothing/accessory/armband/med
	name = "medical guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is white."
	icon_state = "medband"

/obj/item/clothing/accessory/armband/medblue
	name = "medical guard armband"
	desc = "An armband, worn by the station's security forces to display which department they're assigned to. This one is white and blue."
	icon_state = "medblueband"

//////////////
//OBJECTION!//
//////////////

/obj/item/clothing/accessory/lawyers_badge
	name = "attorney's badge"
	desc = "Fills you with the conviction of JUSTICE. Lawyers tend to want to show it to everyone they meet."
	icon_state = "lawyerbadge"

/obj/item/clothing/accessory/lawyers_badge/attack_self(mob/user)
	if(prob(1))
		user.say("The testimony contradicts the evidence!", forced = "attorney's badge")
	user.visible_message("<span class='notice'>[user] shows [user.p_their()] attorney's badge.</span>", "<span class='notice'>You show your attorney's badge.</span>")

/obj/item/clothing/accessory/lawyers_badge/on_uniform_equip(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(L)
		L.bubble_icon = "lawyer"

/obj/item/clothing/accessory/lawyers_badge/on_uniform_dropped(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(L)
		L.bubble_icon = initial(L.bubble_icon)

////////////////
//HA HA! NERD!//
////////////////
/obj/item/clothing/accessory/pocketprotector
	name = "pocket protector"
	desc = "Can protect your clothing from ink stains, but you'll look like a nerd if you're using one."
	icon_state = "pocketprotector"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/pocketprotector

/obj/item/clothing/accessory/pocketprotector/full/Initialize()
	. = ..()
	new /obj/item/pen/red(src)
	new /obj/item/pen(src)
	new /obj/item/pen/blue(src)

/obj/item/clothing/accessory/pocketprotector/cosmetology/Initialize()
	. = ..()
	for(var/i in 1 to 3)
		new /obj/item/lipstick/random(src)

////////////////
//REAL BIG FAN//
////////////////

/obj/item/clothing/accessory/fan_clown_pin
	name = "Clown Pin"
	desc = "A pin to show off your appreciation for clowns and clowning"
	icon_state = "fan_clown_pin"
	above_suit = FALSE
	minimize_when_attached = TRUE
	attachment_slot = CHEST

/obj/item/clothing/accessory/fan_clown_pin/on_uniform_equip(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(HAS_TRAIT(L, TRAIT_FAN_CLOWN))
		SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "fan_clown_pin", /datum/mood_event/fan_clown_pin)

/obj/item/clothing/accessory/fan_clown_pin/on_uniform_dropped(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(HAS_TRAIT(L, TRAIT_FAN_CLOWN))
		SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "fan_clown_pin")

/obj/item/clothing/accessory/fan_mime_pin
	name = "Mime Pin"
	desc = "A pin to show off your appreciation for mimes and miming"
	icon_state = "fan_mime_pin"
	above_suit = FALSE
	minimize_when_attached = TRUE
	attachment_slot = CHEST

/obj/item/clothing/accessory/fan_mime_pin/on_uniform_equip(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(HAS_TRAIT(L, TRAIT_FAN_MIME))
		SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "fan_mime_pin", /datum/mood_event/fan_mime_pin)

/obj/item/clothing/accessory/fan_mime_pin/on_uniform_dropped(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(HAS_TRAIT(L, TRAIT_FAN_MIME))
		SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "fan_mime_pin")

////////////////
//OONGA BOONGA//
////////////////

/obj/item/clothing/accessory/talisman
	name = "bone talisman"
	desc = "A hunter's talisman, some say the old gods smile on those who wear it."
	icon_state = "talisman"
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 20, "bio" = 20, "rad" = 5, "fire" = 0, "acid" = 25)
	attachment_slot = null

/obj/item/clothing/accessory/skullcodpiece
	name = "skull codpiece"
	desc = "A skull shaped ornament, intended to protect the important things in life."
	icon_state = "skull"
	above_suit = TRUE
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 20, "bio" = 20, "rad" = 5, "fire" = 0, "acid" = 25)
	attachment_slot = GROIN

/obj/item/clothing/accessory/skilt
	name = "Sinew Skirt"
	desc = "For the last time. IT'S A KILT not a skirt."
	icon_state = "skilt"
	above_suit = TRUE
	minimize_when_attached = FALSE
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 20, "bio" = 20, "rad" = 5, "fire" = 0, "acid" = 25)
	attachment_slot = GROIN

/obj/item/clothing/accessory/allergy_dogtag
	name = "Allergy dogtag"
	desc = "Dogtag with a list of your allergies"
	icon_state = "allergy"
	above_suit = FALSE
	minimize_when_attached = TRUE
	attachment_slot = CHEST
	///Display message
	var/display

/obj/item/clothing/accessory/allergy_dogtag/examine(mob/user)
	. = ..()
	. += "The dogtag has a listing of allergies : [display]"

/obj/item/clothing/accessory/allergy_dogtag/on_uniform_equip(obj/item/clothing/under/U, user)
	. = ..()
	RegisterSignal(U,COMSIG_PARENT_EXAMINE,.proc/on_examine)

/obj/item/clothing/accessory/allergy_dogtag/on_uniform_dropped(obj/item/clothing/under/U, user)
	. = ..()
	UnregisterSignal(U,COMSIG_PARENT_EXAMINE)

///What happens when we examine the uniform
/obj/item/clothing/accessory/allergy_dogtag/proc/on_examine(datum/source, mob/user, list/examine_list)
	examine_list += "The dogtag has a listing of allergies : [display]"
