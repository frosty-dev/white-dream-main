GLOBAL_LIST_INIT(bad_words, world.file2list("[global.config.directory]/autoeban/bad_words.fackuobema"))

GLOBAL_LIST_INIT(exc_start, world.file2list("[global.config.directory]/autoeban/exc_start.fackuobema"))
GLOBAL_LIST_INIT(exc_end, world.file2list("[global.config.directory]/autoeban/exc_end.fackuobema"))
GLOBAL_LIST_INIT(exc_full, world.file2list("[global.config.directory]/autoeban/exc_full.fackuobema"))

GLOBAL_LIST_INIT(neobuchaemie_debili, world.file2list("[global.config.directory]/autoeban/debix_list.fackuobema"))

/proc/proverka_na_detey(var/msg, var/mob/target)
	msg = r_lowertext(msg)
	for(var/W in GLOB.bad_words)
		W = r_lowertext(W)
		if(findtext(msg, W) && isliving(target))
			var/list/ML = splittext(msg, " ")

			if(W in GLOB.exc_start)
				for(var/WA in ML)
					if(findtext(WA, "[W]") < findtext(WA, regex("^[W]")))
						return

			if(W in GLOB.exc_end)
				for(var/WB in ML)
					if(findtext(WB, "[W]") > findtext(WB, regex("^[W]")))
						return

			if(W in GLOB.exc_full)
				for(var/WC in ML)
					if(findtext(WC, W) && (WC != W))
						return

			if(!ishuman(target))
				if(target.client)
					target.client.inc_metabalance(METACOIN_BADWORDS_REWARD, reason="Что я сказал...")
					target.client.prefs.muted |= MUTE_IC

			playsound(target.loc,'code/shitcode/hule/SFX/rjach.ogg', 200, 7, pressure_affected = FALSE)

			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				var/turf/T = get_step(get_step(H, NORTH), NORTH)
				T.Beam(target, icon_state="lightning[rand(1,12)]", time = 4.7)
				H.adjustFireLoss(47)
				H.electrocution_animation(47)
				H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 199, 199)
				H.gain_trauma(/datum/brain_trauma/severe/mute, TRAUMA_RESILIENCE_SURGERY)
				message_admins("Дружок [target.ckey] насрал на ИС. [ADMIN_COORDJMP(target)]")
			if(target.ckey in GLOB.neobuchaemie_debili)
				target.gib()

			spawn(30)
				qdel(target.client)

			to_chat(target, "<span class='userdanger'>You have been automatically punished for your sins!</span>")
			return
