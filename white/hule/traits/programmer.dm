/obj/item/integrated_circuit_printer/upgraded/prog
	name = "Advanced ICP"
	icon_state = "adv_icp"
	w_class = WEIGHT_CLASS_NORMAL

/datum/quirk/programmer
	name = "Professional Hardware Engineer"
	desc = "Arriving at station while having programming socks on gives you special ICP."
	value = 1
	mob_trait = "programmer"
	gain_text = "<span class='notice'>You know everything about compiling and crossdressing.</span>"
	lose_text = "<span class='danger'>You feel like a normie.</span>"
	medical_record_text = "Patient says that you will code better if you dress like a japaneese schoolgirl."

/datum/quirk/programmer/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.socks == "Stockings (Programmer)" && H.jumpsuit_style == "Jumpskirt")
		var/obj/item/integrated_circuit_printer/upgraded/prog/P = new(get_turf(H))
		var/list/slots = list(
							"backpack" = ITEM_SLOT_BACKPACK,
							"hands" = ITEM_SLOT_HANDS,
							)
		H.equip_in_one_of_slots(P, slots, qdel_on_fail = FALSE)
	else
		var/obj/item/integrated_circuit_printer/IC = new(get_turf(H))
		H.put_in_hands(IC)
