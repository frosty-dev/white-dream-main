//These objects are used in the cardinal sin-themed ruins (i.e. Gluttony, Pride...)

/obj/structure/cursed_slot_machine //Greed's slot machine: Used in the Greed ruin. Deals clone damage on each use, with a successful use giving a d20 of fate.
	name = "игровой автомат Жадности"
	desc = "Большие ставки, большие выигрыши."
	icon = 'icons/obj/computer.dmi'
	icon_state = "slots1"
	anchored = TRUE
	density = TRUE
	var/win_prob = 5

/obj/structure/cursed_slot_machine/interact(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(obj_flags & IN_USE)
		return
	obj_flags |= IN_USE
	user.adjustCloneLoss(20)
	if(user.stat)
		to_chat(user, "<span class='userdanger'>Нет... еще один разок...</span>")
		user.gib()
	else
		user.visible_message("<span class='warning'>[user] дергает [src] рычаг с блеском в [user.ru_ego()] глахах!</span>", "<span class='warning'>Вы чувствуете истощение и слабость во всем теле как только дергаете рычаг, но вы \
		знаете, что оно того стоит.</span>")
	icon_state = "slots2"
	playsound(src, 'sound/lavaland/cursed_slot_machine.ogg', 50, FALSE)
	addtimer(CALLBACK(src, .proc/determine_victor, user), 50)

/obj/structure/cursed_slot_machine/proc/determine_victor(mob/living/user)
	icon_state = "slots1"
	obj_flags &= ~IN_USE
	if(prob(win_prob))
		playsound(src, 'sound/lavaland/cursed_slot_machine_jackpot.ogg', 50, FALSE)
		new/obj/structure/cursed_money(get_turf(src))
		if(user)
			to_chat(user, "<span class='boldwarning'>Ты сорвал куш. Отголоски смеха постепенно исчезают, пока твой приз появляется внутри автомата.</span>")
		qdel(src)
	else
		if(user)
			to_chat(user, "<span class='boldwarning'>Чёртова железяка! Точно подкручивает. Но... еще один разок не повредит, так?</span>")


/obj/structure/cursed_money
	name = "мешок с деньгами"
	desc = "БОГАТ! ДА! ТЫ ЗНАЛ, ЧТО ОНО ТОГО СТОИТ! ТЫ БОГАТ! БОГАТ! БОГАТ!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "moneybag"
	anchored = FALSE
	density = TRUE

/obj/structure/cursed_money/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/collapse), 600)

/obj/structure/cursed_money/proc/collapse()
	visible_message("<span class='warning'>[capitalize(src.name)] складывается в себя, \
		пока ткань очень быстро сгнивает, а содержимое исчезает.</span>")
	qdel(src)

/obj/structure/cursed_money/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.visible_message("<span class='warning'>[user] открывает мешок и \
		достает кубик. Мешок исчезает.</span>",
		"<span class='boldwarning'>Вы открываете мешок...!</span>\n\
		<span class='danger'>И видите, что в нем лежат кубики. Растерянно \
		берете один кубик... и мешок исчезает.</span>")
	var/turf/T = get_turf(user)
	var/obj/item/dice/d20/fate/one_use/critical_fail = new(T)
	user.put_in_hands(critical_fail)
	qdel(src)

/obj/effect/gluttony //Gluttony's wall: Used in the Gluttony ruin. Only lets the overweight through.
	name = "стена Чревоугодия"
	desc = "Лишь те пройдут, кто воистину предан греху."
	anchored = TRUE
	density = TRUE
	icon_state = "blob"
	icon = 'icons/mob/blob.dmi'
	color = rgb(145, 150, 0)

/obj/effect/gluttony/CanAllowThrough(atom/movable/mover, turf/target)//So bullets will fly over and stuff.
	. = ..()
	if(ishuman(mover))
		var/mob/living/carbon/human/H = mover
		if(H.nutrition >= NUTRITION_LEVEL_FAT)
			H.visible_message("<span class='warning'>[H] проходит сквозь [src]!</span>", "<span class='notice'>Вы видели и ели вещи похуже этого.</span>")
			return TRUE
		else
			to_chat(H, "<span class='warning'>Вам не хочется даже смотреть на [src]. Лишь свинья смогла бы заставить себя пройти сквозь это.</span>")
	if(istype(mover, /mob/living/simple_animal/hostile/morph))
		return TRUE

/obj/structure/mirror/magic/pride //Pride's mirror: Used in the Pride ruin.
	name = "зеркало Гордыни"
	desc = "Чем выше лезешь, тем больнее..."
	icon_state = "magic_mirror"

/obj/structure/mirror/magic/pride/New()
	for(var/speciestype in subtypesof(/datum/species))
		var/datum/species/S = speciestype
		if(initial(S.changesource_flags) & MIRROR_PRIDE)
			choosable_races += initial(S.id)
	..()

/obj/structure/mirror/magic/pride/curse(mob/user)
	user.visible_message("<span class='danger'><B>Земля раскалывается под [user] когда [user.ru_ego()] рука выходит из зеркала!</B></span>", \
	"<span class='notice'>Идеально. Гораздо лучше! Теперь <i>никто</i> не сможет перед тобой устоять.</span>")

	var/turf/T = get_turf(user)
	var/list/levels = SSmapping.levels_by_trait(ZTRAIT_DYNAMIC_LEVEL)
	var/turf/dest
	if (levels.len)
		dest = locate(T.x, T.y, pick(levels))

	T.ChangeTurf(/turf/open/chasm, flags = CHANGETURF_INHERIT_AIR)
	var/turf/open/chasm/C = T
	C.set_target(dest)
	C.drop(user)

//can't be bothered to do sloth right now, will make later

/obj/item/kitchen/knife/envy //Envy's knife: Found in the Envy ruin. Attackers take on the appearance of whoever they strike.
	name = "нож Зависти"
	desc = "Их успех будет твоим."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "render"
	inhand_icon_state = "knife"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	force = 18
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/kitchen/knife/envy/afterattack(atom/movable/AM, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(user.real_name != H.dna.real_name)
			user.real_name = H.dna.real_name
			H.dna.transfer_identity(user, transfer_SE=1)
			user.updateappearance(mutcolor_update=1)
			user.domutcheck()
			user.visible_message("<span class='warning'>[user] превращается в [H]!</span>", \
			"<span class='boldannounce'>[H.ru_who(TRUE)] думает что [H.p_s()] [H.p_theyre()] <i>гораааздо</i> лучше чем ты. Больше [H.ru_who()] так думать не будет.</span>")
