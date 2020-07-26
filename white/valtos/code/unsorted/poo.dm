////////////////////////////////////////////
// POO POO PEE PEE
// what the fuck now are you retarded?
/////////////////////////////////////

#define TRAIT_LIGHT_POOER		"legkoserya"

/obj/item/reagent_containers/food/snacks/poo
	name = "говно"
	desc = "Продукт человеческой единицы."
	icon = 'white/valtos/icons/poo.dmi'
	icon_state = "truepoo"
	tastes = list("shit" = 1, "poo" = 1)
	var/random_icon_states = list("poo1", "poo2", "poo3", "poo4", "poo5", "poo6")
	list_reagents = list(/datum/reagent/toxin/poo = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/poo/cooked
	filling_color = "#4B3320"
	foodtype = MEAT | RAW | TOXIC
	grind_results = list()

/obj/item/reagent_containers/food/snacks/poo/Initialize()
	. = ..()
	if (random_icon_states && (icon_state == initial(icon_state)) && length(random_icon_states) > 0)
		icon_state = pick(random_icon_states)

/obj/item/reagent_containers/food/snacks/poo/cooked
	name = "жареное говно"
	icon_state = "ppoo1"
	random_icon_states = list("ppoo1", "ppoo2", "ppoo3", "ppoo4", "ppoo5", "ppoo6")
	filling_color = "#4B3320"

/datum/reagent/toxin/poo
	name = "Говно"
	description = "Говно?"
	color = "#4B3320"
	toxpwr = 2.5
	taste_description = "говно"

/datum/reagent/toxin/poo/on_mob_life(mob/living/carbon/C)
	C.adjustPlasma(1)
	SSblackbox.record_feedback("tally", "poo", 1, "Poo Eaten")
	return ..()

/datum/reagent/toxin/poo/expose_turf(turf/open/T, reac_volume)//splash the poo all over the place
	if(!istype(T))
		return
	if(reac_volume >= 1)
		T.MakeSlippery(TURF_WET_WATER, 15 SECONDS, min(reac_volume * 2 SECONDS, 120))

	var/obj/effect/decal/cleanable/poo/B = locate() in T //find some poo here
	if(!B)
		B = new(T)

/datum/component/decal/poo
	dupe_mode = COMPONENT_DUPE_UNIQUE

/datum/component/decal/poo/Initialize(_icon, _icon_state, _dir, _cleanable=CLEAN_STRENGTH_BLOOD, _color, _layer=ABOVE_OBJ_LAYER)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_GET_EXAMINE_NAME, .proc/get_examine_name)

/datum/component/decal/poo/generate_appearance(_icon, _icon_state, _dir, _layer, _color)
	var/obj/item/I = parent
	if(!_icon)
		_icon = 'white/valtos/icons/poo.dmi'
	if(!_icon_state)
		_icon_state = "itempoo"
	var/icon = initial(I.icon)
	var/icon_state = initial(I.icon_state)
	if(!icon || !icon_state)
		icon = I.icon
		icon_state = I.icon_state
	var/static/list/poo_splatter_appearances = list()
	var/index = "[REF(icon)]-[icon_state]"
	pic = poo_splatter_appearances[index]

	if(!pic)
		var/icon/poo_splatter_icon = icon(initial(I.icon), initial(I.icon_state), , 1)
		poo_splatter_icon.Blend("#fff", ICON_ADD)
		poo_splatter_icon.Blend(icon(_icon, _icon_state), ICON_MULTIPLY)
		pic = mutable_appearance(poo_splatter_icon, initial(I.icon_state))
		poo_splatter_appearances[index] = pic
	return TRUE

/datum/component/decal/poo/proc/get_examine_name(datum/source, mob/user, list/override)
	var/atom/A = parent
	override[EXAMINE_POSITION_ARTICLE] = A.gender == PLURAL? "some" : "a"
	override[EXAMINE_POSITION_BEFORE] = " poo-stained "
	return COMPONENT_EXNAME_CHANGED

/obj/effect/decal/cleanable/poo
	name = "шоколадный каток"
	desc = "И кто это тут размазал?"
	icon = 'white/valtos/icons/poo.dmi'
	icon_state = "splat1"
	random_icon_states = list("splat1", "splat2", "splat3", "splat4", "splat5", "splat6", "splat7", "splat8")

/obj/item/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/reagent_containers/food/snacks/poo/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/poo(T)
	if(reagents && reagents.total_volume)
		reagents.expose(hit_atom, TOUCH)
	if(ishuman(hit_atom))
		var/mob/living/carbon/human/H = hit_atom
		var/mutable_appearance/pooverlay = mutable_appearance('white/valtos/icons/poo.dmi')
		//H.Paralyze(5) //splat!
		H.adjust_blurriness(1)
		H.visible_message("<span class='warning'><b>[H]</b> ловит <b>[src]</b> своим телом!</span>", "<span class='userdanger'>Ловлю <b>[src]</b> своим телом!</span>")
		playsound(H, "desceration", 50, TRUE)
		if(!H.pooed) // one layer at a time
			pooverlay.icon_state = "facepoo"
			H.add_overlay(pooverlay)
			pooverlay.icon_state = "uniformpoo"
			H.add_overlay(pooverlay)
			pooverlay.icon_state = "suitpoo"
			H.add_overlay(pooverlay)
			H.pooed = TRUE
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "pooed", /datum/mood_event/pooed)
			SSblackbox.record_feedback("tally", "poo", 1, "Poo Splats")
	qdel(src)

/datum/emote/living/poo
	key = "poo"
	key_third_person = "shits on the floor"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/poo/run_emote(mob/user, params)
	. = ..()
	if(. && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(HAS_TRAIT(H, TRAIT_LIGHT_POOER) && H.nutrition >= NUTRITION_LEVEL_WELL_FED)
			H.visible_message("<span class='notice'><b>[H]</b> срёт себе прямо в руку!</span>", \
					"<span class='notice'>Выдавливаю какаху из своего тела.</span>")
			playsound(H, 'white/valtos/sounds/poo2.ogg', 25, 1) //silence hunter
			var/obj/item/reagent_containers/food/snacks/poo/P = new(get_turf(H))
			H.put_in_hands(P)
			if(!H.in_throw_mode)
				H.throw_mode_on()
			H.nutrition -= 50
			SSblackbox.record_feedback("tally", "poo", 1, "Poo Created")
			return
		else if (H.nutrition >= NUTRITION_LEVEL_FULL)
			if(H.get_item_by_slot(ITEM_SLOT_ICLOTHING))
				H.visible_message("<span class='notice'><b>[H]</b> срёт себе в штаны!</span>", \
						"<span class='notice'>Сру себе в штаны.</span>")
				playsound(H, 'white/valtos/sounds/poo2.ogg', 50, 1)
				H.nutrition -= 75
				if(!H.pooed)
					var/mutable_appearance/pooverlay = mutable_appearance('white/valtos/icons/poo.dmi')
					pooverlay.icon_state = "uniformpoo"
					H.add_overlay(pooverlay)
					pooverlay.icon_state = "suitpoo"
					H.add_overlay(pooverlay)
					H.pooed = TRUE
					SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "pooed", /datum/mood_event/pooed)
				SSblackbox.record_feedback("tally", "poo", 1, "Poo Self")
				return
			else
				H.visible_message("<span class='notice'><b>[H]</b> срёт на пол!</span>", \
						"<span class='notice'>Выдавливаю какаху из своего тела.</span>")
				playsound(H, 'white/valtos/sounds/poo2.ogg', 50, 1)
				new /obj/item/reagent_containers/food/snacks/poo(H.loc)
				H.nutrition -= 75
				SSblackbox.record_feedback("tally", "poo", 1, "Poo Created")
				return
		else
			H.visible_message("<span class='notice'><b>[H]</b> тужится!</span>", \
					"<span class='notice'>Вам нечем какать.</span>")
			H.adjust_blurriness(1)
			SSblackbox.record_feedback("tally", "poo", 1, "Poo Creation Failed")
			return

/atom/proc/wash_poo()
	return TRUE

/mob/living/carbon/human/wash_poo()
	if(pooed)
		cut_overlay(mutable_appearance('white/valtos/icons/poo.dmi', "facepoo"))
		cut_overlay(mutable_appearance('white/valtos/icons/poo.dmi', "uniformpoo"))
		cut_overlay(mutable_appearance('white/valtos/icons/poo.dmi', "suitpoo"))
		pooed = FALSE

/datum/quirk/legkoserya
	name = "Light Pooer"
	desc = "You poo right in your hands and prepare to throw."
	value = 2
	mob_trait = TRAIT_LIGHT_POOER
	gain_text = "<span class='notice'>You know ancient defecation techniques.</span>"
	lose_text = "<span class='danger'>You forget how to poo professionally.</span>"
	medical_record_text = "Patient's defecation skills are on another level." //prikol
