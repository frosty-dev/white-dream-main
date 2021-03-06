/obj/item/reagent_containers/glass/rag
	name = "влажная тряпка"
	desc = "Предположительно для устраненя беспорядка."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_flags = NOBLUDGEON
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 5
	spillable = FALSE

/obj/item/reagent_containers/glass/rag/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is smothering [user.ru_na()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (OXYLOSS)

/obj/item/reagent_containers/glass/rag/afterattack(atom/A as obj|turf|area, mob/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(iscarbon(A) && reagents?.total_volume)
		var/mob/living/carbon/C = A
		var/reagentlist = pretty_string_from_reagent_list(reagents)
		var/log_object = "containing [reagentlist]"
		if(user.a_intent == INTENT_HARM && !C.is_mouth_covered())
			reagents.trans_to(C, reagents.total_volume, transfered_by = user, methods = INGEST)
			C.visible_message("<span class='danger'>[user] душит [C] используя [src]!</span>", "<span class='userdanger'>[user] душит вас используя [src]!</span>", "<span class='hear'>Слышу звуки борьбы и приглушенные удивленные вскрики.</span>")
			log_combat(user, C, "задушен", src, log_object)
		else
			reagents.expose(C, TOUCH)
			reagents.clear_reagents()
			C.visible_message("<span class='notice'>[user] трогает [C] [src].</span>")
			log_combat(user, C, "потроган", src, log_object)

	else if(istype(A) && (src in user))
		user.visible_message("<span class='notice'>[user] начинает стирать [A] используя [src]!</span>", "<span class='notice'>Начал стирать [A] используя [src]...</span>")
		if(do_after(user,30, target = A))
			user.visible_message("<span class='notice'>[user] заканчивает стирать [A]!</span>", "<span class='notice'>Закончил стирать [A].</span>")
			A.wash(CLEAN_SCRUB)
