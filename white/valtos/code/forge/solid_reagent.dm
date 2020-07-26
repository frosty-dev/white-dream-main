/obj/item/reagent_containers/food/snacks/solid_reagent
	name = "solidified chemicals"
	desc = "Стоит ли это пробовать на вкус? Хмм..."
	icon = 'white/valtos/icons/forge/chemical.dmi'
	icon_state = "chembar"
	obj_flags = UNIQUE_RENAME
	var/reagent_type
	foodtype = TOXIC
	volume = 200
	reagent_flags = TRANSPARENT
	bitesize = 5

/obj/item/reagent_containers/food/snacks/solid_reagent/Initialize()
	. = ..()
	pixel_x = rand(8,-8)
	pixel_y = rand(8,-8)

/obj/item/reagent_containers/food/snacks/solid_reagent/microwave_act(obj/machinery/microwave/M)
	if(reagents)
		reagents.expose_temperature(1000)


/obj/item/reagent_containers/food/snacks/solid_reagent/ex_act()
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			R.on_ex_act()
	if(!QDELETED(src))
		..()

/obj/item/reagent_containers/food/snacks/solid_reagent/fire_act(exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)
	if(volume <= 0)
		qdel(src)

/obj/item/reagent_containers/food/snacks/solid_reagent/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness && reagents)
		reagents.expose_temperature(hotness)
		to_chat(user, "<span class='notice'>Нагреваю [src] при помощи [I].</span>")
		if(volume <= 0)
			qdel(src)


/obj/item/reagent_containers/food/snacks/solid_reagent/afterattack(obj/target, mob/user , proximity)
	if(!proximity)
		return
	if(target.is_open_container()/* || istype(target, /obj/effect/decal/cleanable/chempile) && target.reagents*/)
		if(!target.reagents.total_volume)
			to_chat(user, "<span class='warning'>[target] пуст! Надо бы заполнить чем-то жидким, чтобы растворить [src] внутри.</span>")
			return
		to_chat(user, "<span class='notice'>Элегантно растворяю [src] в [target].</span>")
		for(var/mob/O in viewers(2, user))	//viewers is necessary here because of the small radius
			to_chat(O, "<span class='warning'>[user] закидывает [src] в [target]!</span>")
		reagents.trans_to(target, reagents.total_volume)
		qdel(src)
