/turf/closed/wall/r_wall
	name = "армированная стена"
	desc = "Здоровенный укреплённый кусок металла, который служит для разделения помещений."
	icon = 'icons/turf/walls/tall/reinforced_wall.dmi'
	icon_state = "base-0"
	base_icon_state = "base"
	opacity = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK
	hardness = 10
	sheet_type = /obj/item/stack/sheet/plasteel
	sheet_amount = 1
	girder_type = /obj/structure/girder/reinforced
	explosion_block = 2
	rad_insulation = RAD_HEAVY_INSULATION
	frill_icon = 'icons/effects/frills/wall_reinforced_frill.dmi'
	///Dismantled state, related to deconstruction.
	var/d_state = INTACT


/turf/closed/wall/r_wall/deconstruction_hints(mob/user)
	switch(d_state)
		if(INTACT)
			return "<span class='notice'>Внешняя <b>решетка</b> цела.</span>"
		if(SUPPORT_LINES)
			return "<span class='notice'>Внешняя <i>решетка</i> надкусана, теперь её можно <b>открутить</b>.</span>"
		if(COVER)
			return "<span class='notice'>Поддерживающие линии <i>откручены</i>, металлическое покрытие <b>приварено</b> крепко.</span>"
		if(CUT_COVER)
			return "<span class='notice'>Металлическое покрытие <i>проварено насквозь</i> и <b>болтается</b> на основании.</span>"
		if(ANCHOR_BOLTS)
			return "<span class='notice'>Металлическое покрытие <i>снято</i>, а также болты всё ещё <b>прикручены</b> на месте.</span>"
		if(SUPPORT_RODS)
			return "<span class='notice'>Болты удерживающие каркас <i>откручены</i>, но всё ещё <b>приварены</b> крепко к основанию.</span>"
		if(SHEATH)
			return "<span class='notice'>Поддерживающие каркас болты <i>срезаны</i>, внутреннее покрытие <b>прикручено слабо</b> к основанию.</span>"

/turf/closed/wall/r_wall/devastate_wall()
	new sheet_type(src, sheet_amount)
	new /obj/item/stack/sheet/metal(src, 2)

/turf/closed/wall/r_wall/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if(!M.environment_smash)
		return
	if(M.environment_smash & ENVIRONMENT_SMASH_RWALLS)
		dismantle_wall(1)
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		to_chat(M, "<span class='warning'>Эта стена слишком крепка для меня.</span>")

/turf/closed/wall/r_wall/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 41)
	return ..()

/turf/closed/wall/r_wall/try_decon(obj/item/W, mob/user, turf/T)
	//DECONSTRUCTION
	switch(d_state)
		if(INTACT)
			if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				d_state = SUPPORT_LINES
				update_icon()
				to_chat(user, "<span class='notice'>Откусываю внешнюю решетку.</span>")
				return TRUE

		if(SUPPORT_LINES)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, "<span class='notice'>Начинаю откручивать поддерживающие линии...</span>")
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_LINES)
						return TRUE
					d_state = COVER
					update_icon()
					to_chat(user, "<span class='notice'>Откручиваю поддерживающие линии.</span>")
				return TRUE

			else if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				d_state = INTACT
				update_icon()
				to_chat(user, "<span class='notice'>Чиню внешнюю решетку.</span>")
				return TRUE

		if(COVER)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>Начинаю разваривать металлическое покрытие...</span>")
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return TRUE
					d_state = CUT_COVER
					update_icon()
					to_chat(user, "<span class='notice'>Слегка давлю на него и оно немного отходит от стены.</span>")
				return TRUE

			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, "<span class='notice'>Начинаю прикручивать поддерживающие линии обратно...</span>")
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return TRUE
					d_state = SUPPORT_LINES
					update_icon()
					to_chat(user, "<span class='notice'>Прикручиваю поддерживающие линии.</span>")
				return TRUE

		if(CUT_COVER)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, "<span class='notice'>Начинаю выдавливать покрытие...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					d_state = ANCHOR_BOLTS
					update_icon()
					to_chat(user, "<span class='notice'>Выдавливаю покрытие.</span>")
				return TRUE

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>Начинаю приваривать покрытие обратно на место...</span>")
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					d_state = COVER
					update_icon()
					to_chat(user, "<span class='notice'>Привариваю металлическое покрытие обратно на место.</span>")
				return TRUE

		if(ANCHOR_BOLTS)
			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "<span class='notice'>Начинаю откручивать болты удерживающие каркас...</span>")
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return TRUE
					d_state = SUPPORT_RODS
					update_icon()
					to_chat(user, "<span class='notice'>Откручиваю болты удерживающие каркас.</span>")
				return TRUE

			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, "<span class='notice'>Начинаю ставить покрытие обратно на место...</span>")
				if(W.use_tool(src, user, 20, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return TRUE
					d_state = CUT_COVER
					update_icon()
					to_chat(user, "<span class='notice'>Ставлю покрытие обратно на место.</span>")
				return TRUE

		if(SUPPORT_RODS)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>Начинаю разрезать поддерживающий каркас...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return TRUE
					d_state = SHEATH
					update_icon()
					to_chat(user, "<span class='notice'>Прорезаюсь через поддерживающий каркас.</span>")
				return TRUE

			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "<span class='notice'>Начинаю затягивать болты поддерживающие каркас...</span>")
				W.play_tool_sound(src, 100)
				if(W.use_tool(src, user, 40))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return TRUE
					d_state = ANCHOR_BOLTS
					update_icon()
					to_chat(user, "<span class='notice'>Затягиваю болты поддерживающие каркас.</span>")
				return TRUE

		if(SHEATH)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, "<span class='notice'>Начинаю выдавливать каркас...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					to_chat(user, "<span class='notice'>Выдавливаю каркас.</span>")
					dismantle_wall()
				return TRUE

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, "<span class='notice'>Начинаю сваривать поддерживающий каркас обратно...</span>")
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					d_state = SUPPORT_RODS
					update_icon()
					to_chat(user, "<span class='notice'>Привариваю всё как было.</span>")
				return TRUE
	return FALSE

/turf/closed/wall/r_wall/update_icon()
	. = ..()
	if(d_state != INTACT)
		smoothing_flags = NONE
	else
		smoothing_flags = SMOOTH_BITMASK
		QUEUE_SMOOTH_NEIGHBORS(src)
		QUEUE_SMOOTH(src)

/turf/closed/wall/r_wall/update_icon_state()
	if(d_state != INTACT)
		icon_state = "r_wall-[d_state]"
	else
		icon_state = "[base_icon_state]-[smoothing_junction]"

/turf/closed/wall/r_wall/wall_singularity_pull(current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/r_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.canRturf)
		return ..()


/turf/closed/wall/r_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	if(the_rcd.canRturf)
		return ..()

/turf/closed/wall/r_wall/rust_heretic_act()
	if(prob(50))
		return
	if(prob(70))
		new /obj/effect/temp_visual/glowing_rune(src)
	ChangeTurf(/turf/closed/wall/r_wall/rust)


/turf/closed/wall/r_wall/syndicate
	name = "обшивка"
	desc = "Бронированный корпус зловещего корабля."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	explosion_block = 20
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SYNDICATE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_SYNDICATE_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)
	frill_icon = null


/turf/closed/wall/r_wall/syndicate/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	return FALSE

/turf/closed/wall/r_wall/syndicate/nodiagonal
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "map-shuttle_nd"
	base_icon_state = "plastitanium_wall"
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/r_wall/syndicate/nosmooth
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall"
	smoothing_flags = NONE

/turf/closed/wall/r_wall/syndicate/overspace
	icon_state = "map-overspace"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)
