/obj/effect/landmark/stationroom
	icon = 'white/valtos/icons/map_icon_templates.dmi'
	var/list/template_names = list()
	layer = BULLET_HOLE_LAYER
	invisibility = 0

/obj/effect/landmark/stationroom/New()
	..()
	GLOB.stationroom_landmarks += src

/obj/effect/landmark/stationroom/Destroy()
	if(src in GLOB.stationroom_landmarks)
		GLOB.stationroom_landmarks -= src

	return ..()

/obj/effect/landmark/stationroom/proc/load(template_name)
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	if(!template_name)
		for(var/t in template_names)
			if(!SSmapping.station_room_templates[t])
				log_world("Station room spawner placed at ([T.x], [T.y], [T.z]) has invalid ruin name of \"[t]\" in its list")
				template_names -= t
		template_name = pickweight(template_names)
	if(!template_name)
		GLOB.stationroom_landmarks -= src
		qdel(src)
		return FALSE

	var/datum/map_template/ruin/template = SSmapping.station_room_templates[template_name]
	if(!template)
		return FALSE
	testing("Station part \"[template_name]\" placed at ([T.x], [T.y], [T.z])")
	template.load(T, centered = FALSE)
	if(template.always_spawn_with)
		for(var/v in template.always_spawn_with)
			var/turf/LO = locate(T.x, T.y, T.z - 1)
			var/datum/map_template/MT = new v
			var/datum/map_template/ruin/below_temp = SSmapping.station_room_templates[MT.name]
			below_temp.load(LO, centered = FALSE)
			below_temp.loaded++
	template.loaded++
	GLOB.stationroom_landmarks -= src
	qdel(src)

	return TRUE

/obj/effect/landmark/stationroom/brig
	template_names = list(
		"Default Brig" = 10,
		"Loose Brig" = 4,
		"Armored Brig" = 3
	)
	icon_state = "brig"

/obj/effect/landmark/stationroom/bar
	template_names = list(
		"Default Bar" = 10,
		"Neon Bar" = 4,
		"Lava Bar" = 3
	)
	icon_state = "bar"

/obj/effect/landmark/stationroom/bridge
	template_names = list(
		"Default Central" = 10,
		"Compact Central" = 4,
		"Interesting Central" = 3
	)
	icon_state = "central"

/obj/effect/landmark/stationroom/engine
	//template_names = list("Supermatter" = 8, "Singulo or Tesla" = 10, "Antimatter" = 8, "Budget" = 1, "Teg" = 7)
	template_names = list(
		//"Supermatter" = 1,
		//"Singulo or Tesla" = 1,
		//"Antimatter" = 1,
		//"Budget" = 1,
		"Teg" = 0
	)
	icon_state = "engine"

/obj/effect/landmark/stationroom/maint_sw
	template_names = list(
		"Default Maint SW" = 10,
		"Arena Maint SW" = 4,
		"Chess Maint SW" = 3
	)
	icon_state = "maint"

/obj/effect/landmark/stationroom/medbay
	template_names = list(
		"Default Medbay" = 10,
		"Old Medbay" = 7,
		"Durka Fortress" = 10
	)
	icon_state = "med"

/obj/effect/landmark/stationroom/maint/rdm3x3
	template_names = list(
		"Random 3x3: 9storage" = 1,
		"Random 3x3: shrine" = 1,
		"Random 3x3: plasma" = 1,
		"Random 3x3: tanning" = 1,
		"Random 3x3: wash" = 1,
		"Random 3x3: gibs" = 1,
		"Random 3x3: radspill" = 1,
		"Random 3x3: 2storage" = 1,
		"Random 3x3: airstation" = 1,
		"Random 3x3: hazmat" = 1,
		"Random 3x3: boxwindow" = 1,
		"Random 3x3: boxclutter2" = 1,
		"Random 3x3: boxclutter3" = 1,
		"Random 3x3: boxclutter4" = 1,
		"Random 3x3: boxclutter5" = 1,
		"Random 3x3: boxclutter6" = 1,
		"Random 3x3: boxchemcloset" = 1,
		"Random 3x3: boxbedroom" = 1,
		"Random 3x3: boxclutter8" = 1,
		"Random 3x3: hullbreach" = 1,
		"Random 3x3: tranquility" = 1,
		"Random 3x3: owloffice" = 1,
		"Random 3x3: deltajanniecloset" = 1,
		"Random 3x3: deltaorgantrade" = 1,
		"Random 3x3: medicloset" = 1,
		"Random 3x3: metagamergear" = 1,
		"Random 3x3: metaclutter2" = 1,
		"Random 3x3: metaclutter4" = 1,
		"Random 3x3: pubbyclutter1" = 1,
		"Random 3x3: pubbyclutter2" = 1,
		"Random 3x3: pubbyclutter3" = 1,
		"Random 3x3: pubbyartism" = 1,
		"Random 3x3: donutcapgun" = 1,
		"Random 3x3: kilomechcharger" = 1,
		"Random 3x3: kilotheatre" = 1,
		"Random 3x3: kilolustymaid" = 1,
		"Random 3x3: biohazard" = 1,
		"Random 3x3: hobohut" = 1,
		"Random 3x3: bubblegumaltar" = 1,
		"Random 3x3: banana" = 1,
		"Random 3x3: communism" = 1,
		"Random 3x3: hardclown" = 1,
		"Random 3x3: lipidchamber" = 1,
		"Random 3x3: naughtyroom" = 1,
		"Random 3x3: containmentcell" = 1
	)

/obj/effect/landmark/stationroom/maint/rdm3x5
	template_names = list("Random 3x5: boxkitchen" = 1,
		"Random 3x5: boxclutter7" = 1,
		"Random 3x5: pubbyclutter5" = 1,
		"Random 3x5: pubbyrobotics" = 1,
		"Random 3x5: pubbyclutter6" = 1,
		"Random 3x5: kilomobden" = 1,
		"Random 3x5: monky" = 1,
		"Random 3x5: hank" = 1,
		"Random 3x5: laststand" = 1,
		"Random 3x5: junkcloset" = 1,
		"Random 3x5: canisterroom" = 1,
		"Random 3x5: durandwreck" = 1,
		"Random 3x5: chromosomes" = 1,
		"Random 3x5: dissection" = 1,
		"Random 3x5: emergencyoxy" = 1,
		"Random 3x5: krebs" = 1,
		"Random 3x5: oreboxes" = 1,
		"Random 3x5: tinyshrink" = 1,
		"Random 3x5: crossroads" = 1
	)

/obj/effect/landmark/stationroom/maint/rdm5x3
	template_names = list("Random 5x3: boxclutter1" = 1,
		"Random 5x3: deltaclutter2" = 1,
		"Random 5x3: deltaclutter3" = 1,
		"Random 5x3: metaclutter1" = 1,
		"Random 5x3: metaclutter3" = 1,
		"Random 5x3: pubbyclutter4" = 1,
		"Random 5x3: pubbybedroom" = 1,
		"Random 5x3: pubbyclutter7" = 1,
		"Random 5x3: pubbykitchen" = 1,
		"Random 5x3: kiloclutter1" = 1,
		"Random 5x3: cloner" = 1,
		"Random 5x3: nastytrap" = 1,
		"Random 5x3: incompletefloor" = 1,
		"Random 5x3: minibreakroom" = 1,
		"Random 5x3: stroreroom" = 1,
		"Random 5x3: pills" = 1,
		"Random 5x3: chestburst" = 1,
		"Random 5x3: gloveroom" = 1,
		"Random 5x3: spareparts" = 1,
		"Random 5x3: magicroom" = 1
	)

/obj/effect/landmark/stationroom/maint/rdm5x4
	template_names = list("Random 5x4: boxbar" = 1,
		"Random 5x4: boxdinner" = 1,
		"Random 5x4: boxsurgery" = 1,
		"Random 5x4: deltabar" = 1,
		"Random 5x4: deltalounge" = 1,
		"Random 5x4: deltaEVA" = 1,
		"Random 5x4: deltadetective" = 1,
		"Random 5x4: deltasurgery" = 1,
		"Random 5x4: deltadressing" = 1,
		"Random 5x4: deltagamble" = 1,
		"Random 5x4: metarobotics" = 1,
		"Random 5x4: metatheatre" = 1,
		"Random 5x4: metakitchen" = 1,
		"Random 5x4: metamedical" = 1,
		"Random 5x4: pubbysurgery" = 1,
		"Random 5x4: kilosurgery" = 1,
		"Random 5x4: kilohauntedlibrary" = 1,
		"Random 5x4: tinybarbershop" = 1,
		"Random 5x4: comproom" = 1,
		"Random 5x4: firemanroom" = 1,
		"Random 5x4: cheese" = 1,
		"Random 5x4: honkaccident" = 1,
		"Random 5x4: musicroom" = 1,
		"Random 5x4: nanitechamber" = 1,
		"Random 5x4: oldcryoroom" = 1
	)

/obj/effect/landmark/stationroom/maint/rdm10x5
	template_names = list("Random 10x5: barbershop" = 1,
		"Random 10x5: deltarobotics" = 1,
		"Random 10x5: deltaclutter1" = 1,
		"Random 10x5: deltabotnis" = 1,
		"Random 10x5: deltacafeteria" = 1,
		"Random 10x5: deltaarcade" = 1,
		"Random 10x5: maintmedical" = 1,
		"Random 10x5: skidrow" = 1,
		"Random 10x5: meetingroom" = 1,
		"Random 10x5: phage" = 1,
		"Random 10x5: courtroom" = 1,
		"Random 10x5: gaschamber" = 1,
		"Random 10x5: oldaichamber" = 1,
		"Random 10x5: radiationtherapy" = 1,
		"Random 10x5: cratewindow" = 1,
		"Random 10x5: smallmedlobby" = 1,
		"Random 10x5: ratburger" = 1,
		"Random 10x5: geneticsoffice" = 1,
		"Random 10x5: hobowithpeter" = 1,
		"Random 10x5: butchersden" = 1,
		"Random 10x5: punjiconveyor" = 1,
		"Random 10x5: interchange" = 1
	)

/obj/effect/landmark/stationroom/maint/rdm10x10
	template_names = list("Random 10x10: deltalibrary" = 1,
		"Random 10x10: snakefighter" = 1,
		"Random 10x10: roosterdome" = 1,
		"Random 10x10: pubbybar" = 1,
		"Random 10x10: bigtheatre" = 1,
		"Random 10x10: bigconstruction" = 1,
		"Random 10x10: graffitiroom" = 1,
		"Random 10x10: podrepairbay" = 1,
		"Random 10x10: sanitarium" = 1,
		"Random 10x10: beach" = 1,
		"Random 10x10: benoegg" = 1,
		"Random 10x10: confinementroom" = 1,
		"Random 10x10: conveyorroom" = 1,
		"Random 10x10: oldoffice" = 1,
		"Random 10x10: snowforest" = 1,
		"Random 10x10: 6sectorsdown" = 1,
		"Random 10x10: olddiner" = 1,
		"Random 10x10: gamercave" = 1,
		"Random 10x10: smallmagician" = 1,
		"Random 10x10: altar" = 1,
		"Random 10x10: interchange" = 1,
		"Random 10x10: apiary" = 1,
		"Random 10x10: advbotany" = 1
	)
