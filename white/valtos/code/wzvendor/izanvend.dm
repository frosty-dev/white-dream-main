/obj/machinery/izanvend
	name = "Наци-вендор"
	desc = "Невероятная коллекция запрещённых вещей в одном месте."
	icon = 'white/valtos/icons/vending.dmi'
	icon_state = "trading"
	density = TRUE
	var/list/guns = list(/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/wzzzz/mg34, /obj/item/gun/energy/taser/wzzzz/carbine, /obj/item/gun/ballistic/automatic/wt550/wzzzz/german)

	var/list/melees = list(/obj/item/melee/cultblade/wzzzz/great,
						  /obj/item/melee/classic_baton/wzzzz/german,
						  /obj/item/melee/wzzzz/club,
						  /obj/item/melee/baton/loaded/german,
						  /obj/item/kitchen/knife/wzzzz/german)

	var/list/storages = list(/obj/item/storage/belt/military/assault/wzzzz)

	var/list/ammos = list(/obj/item/ammo_box/n792x57, /obj/item/ammo_box/magazine/wt550m9/wzzzz/mc9mmt)

	var/list/uniforms = list(/obj/item/clothing/under/rank/engineering/engineer/wzzzz/mechanic,
                    	  /obj/item/clothing/under/rank/engineering/atmospheric_technician/wzzzz/aether,
                    	  /obj/item/clothing/under/rank/cargo/qm/wzzzz/german,
                    	  /obj/item/clothing/under/rank/centcom/officer/wzzzz/centcom,
                    	  /obj/item/clothing/under/rank/security/detective/wzzzz/detective2,
                    	  /obj/item/clothing/under/rank/rnd/research_director/wzzzz/rdalt,
                    	  /obj/item/clothing/under/rank/civilian/head_of_personnel/wzzzz/hopwhimsy)

	var/list/suits = list(/obj/item/clothing/suit/armor/vest/bulletproofsuit/wzzzz/vest,
						  /obj/item/clothing/suit/armor/hos/wzzzz/german,
						  /obj/item/clothing/suit/imperium_monk/wzzzz/german,
                    	  /obj/item/clothing/suit/wizrobe/wzzzz/psyamp,
                    	  /obj/item/clothing/suit/armor/hos/trenchcoat/wzzzz/jensen,
                    	  /obj/item/clothing/suit/space/syndicate/wzzzz/german,
						  /obj/item/clothing/suit/armor/wzzzz/opvest)

	var/list/glasses = list(/obj/item/clothing/glasses/welding/wzzzz/r, /obj/item/clothing/glasses/hud/wzzzz/hacker_rig)

	var/list/shoes = list()

	var/list/masks = list(/obj/item/clothing/mask/balaclava/wzzzz/swatclava, /obj/item/clothing/mask/breath/wzzzz/half, /obj/item/clothing/mask/wzzzz/balaclavager)

	var/list/caps = list(/obj/item/clothing/head/wizard/wzzzz/amp, /obj/item/clothing/head/bomb_hood/wzzzz/german, /obj/item/clothing/head/cap/wzzzz/elite)

	var/list/gloves = list()

	var/list/misc = list(
                    /mob/living/simple_animal/pet/cat/wzzzz,
                    /mob/living/simple_animal/pet/cat/kitten/wzzzz)

	var/list/products = list()

	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	ui_x = 480
	ui_y = 550

/obj/machinery/izanvend/Initialize()
	. = ..()
	fill_vendor()

/obj/machinery/izanvend/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
									datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "Izanvend", name, ui_x, ui_y, master_ui, state)
		ui.open()

/obj/machinery/izanvend/ui_static_data()
	var/list/data = list()
	data["products"] = list()
	for(var/thing in products)
		var/datum/data/izanvend_product/P = thing
		if(!data["products"][P.cat])
			data["products"][P.cat] = list(
				"name" = P.cat,
				"packs" = list()
			)
		data["products"][P.cat]["packs"] += list(list(
			"name" = P.name,
			"product_path" = P.product_path
		))
	return data

/obj/machinery/izanvend/ui_act(action, params, datum/tgui/ui)
	if(..())
		return
	switch(action)
		if("vend")
			. = TRUE
			var/obj/R = text2path(params["product_path"])
			new R(get_turf(src))
			playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)


/obj/machinery/izanvend/proc/fill_vendor()
	// guns
	guns 	 += subtypesof(/obj/item/gun/ballistic/automatic/wzzzz)
	guns 	 += subtypesof(/obj/item/gun/ballistic/automatic/pistol/wzzzz)
	guns 	 += subtypesof(/obj/item/gun/ballistic/rifle/boltaction/wzzzz)
	build_inventory(guns, "Пушки")

	//melee
	melees   += subtypesof(/obj/item/melee/sabre/wzzzz)
	build_inventory(melees, "Ближний")

	//storages
	storages += subtypesof(/obj/item/storage/belt/military/wzzzz)
	storages += subtypesof(/obj/item/storage/pill_bottle/wzzzz)
	storages += subtypesof(/obj/item/storage/belt/military/army/wzzzz)
	storages += subtypesof(/obj/item/storage/belt/mining/wzzzz)
	build_inventory(storages, "Сумочки")

	//uniforms
	uniforms += subtypesof(/obj/item/clothing/under/wzzzz)
	uniforms += subtypesof(/obj/item/clothing/under/rank/cargo/tech/wzzzz)
	uniforms += subtypesof(/obj/item/clothing/under/rank/security/officer/wzzzz)
	uniforms += subtypesof(/obj/item/clothing/under/rank/medical/doctor/wzzzz)
	uniforms += subtypesof(/obj/item/clothing/under/rank/security/head_of_security/wzzzz)
	uniforms += subtypesof(/obj/item/clothing/under/rank/security/warden/wzzzz)
	uniforms += subtypesof(/obj/item/clothing/under/syndicate/wzzzz)
	build_inventory(uniforms, "Униформы")

	//suits
	suits 	 += subtypesof(/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/space/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/armor/vest/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/toggle/labcoat/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/bomb_suit/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/radiation/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/hazardvest/wzzzz)
	suits 	 += subtypesof(/obj/item/clothing/suit/wzzzz)
	suits  	 += subtypesof(/obj/item/clothing/suit/toggle/wzzzz)
	build_inventory(suits, "Костюмы")

	//glasses
	glasses  += subtypesof(/obj/item/clothing/glasses/wzzzz)
	build_inventory(glasses, "Очки")

	//shoes
	shoes 	 += subtypesof(/obj/item/clothing/shoes/combat/wzzzz)
	shoes 	 += subtypesof(/obj/item/clothing/shoes/wzzzz)
	build_inventory(shoes, "Обувь")

	//masks
	masks 	 += subtypesof(/obj/item/clothing/mask/gas/wzzzz)
	build_inventory(masks, "Маски")

	//caps
	caps 	 += subtypesof(/obj/item/clothing/head/helmet/space/wzzzz)
	caps 	 += subtypesof(/obj/item/clothing/head/wzzzz)
	caps 	 += subtypesof(/obj/item/clothing/head/soft/wzzzz)
	caps 	 += subtypesof(/obj/item/clothing/head/helmet/wzzzz)
	caps 	 += subtypesof(/obj/item/clothing/head/welding/wzzzz)
	build_inventory(caps, "Шапочки")

	//gloves
	gloves 	 += subtypesof(/obj/item/clothing/gloves/combat/wzzzz)
	build_inventory(gloves, "Перчатки")

	//ammos
	ammos    += subtypesof(/obj/item/ammo_box/magazine/wzzzz)
	build_inventory(ammos, "Аммуниция")

	build_inventory(misc)

/datum/data/izanvend_product
	name = "что-то"
	var/product_path = null
	var/cat = "Другое"

/obj/machinery/izanvend/proc/build_inventory(list/productlist, var/category = "Другое")
	for(var/typepath in productlist)
		var/atom/temp = typepath
		var/datum/data/izanvend_product/R = new /datum/data/izanvend_product()
		R.name = initial(temp.name)
		R.product_path = typepath
		R.cat = category
		products += R
