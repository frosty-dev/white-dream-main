GLOBAL_VAR_INIT(detnumoftheday, hex2num(copytext(md5(time2text(world.realtime, "MMM DD YYYY")), 1, 7)))

/mob/proc/make_possess_obj(obj/O)
	loc = O
	reset_perspective(O)
	control_object = O

/atom/proc/make_aneme_mimic()
	var/mob/living/simple_animal/hostile/mimic/copy/C = new(drop_location(), src)
	C.cut_overlay(C.googly_eyes)
	C.add_overlay(mutable_appearance('white/baldenysh/icons/mob/aneme.dmi', "chaika_eyes"))
	return C
