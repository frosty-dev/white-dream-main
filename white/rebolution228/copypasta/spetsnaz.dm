/datum/ert/spetsnaz
	roles = list(/datum/antagonist/ert/spetsnaz, /datum/antagonist/ert/spetsnaz/grenadier)
	leader_role = /datum/antagonist/ert/spetsnaz/leader
	teamsize = 5
	opendoors = FALSE
	rename_team = "Спецназ ВВ МВД"
	mission = "Уничтожить особо опасных террористов на станции."
	polldesc = "группе специального назначения"

/datum/antagonist/ert/spetsnaz/greet()
	if(!ert_team)
		return

	owner.current.playsound_local(get_turf(owner.current), 'white/rebolution228/sounds/spetsnaz_spawn.ogg',100,0, use_reverb = FALSE)
	to_chat(owner, "<B><font size=3 color=red>Я РОССИЙСКИЙ СПЕЦНАЗ!</font></B>")
	to_chat(owner, "Вы входите в состав спецподразделения <B>'Оборотень'</B>, отправленный на станцию <B>'[station_name()]'</B> с заданием от <B>Российского Отдела Службы Безопасности NanoTrasen.</B> Ваше тело имеет <B>иммунитет к вакууму и не требует кислорода.</B>")
	if(leader)
		to_chat(owner, "Являясь главой отряда, вы должны руководить своим составом, чтобы обеспечить выполнение миссии. Отправьтесь на станцию при помощи шаттла, когда вы будете готовы.")
	else
		to_chat(owner, "Следуйте приказам вашего командира отряда.")
	if(!rip_and_tear)
		to_chat(owner, "По возможности <B>избегайте</B> жертв среди гражданского населения.")
	to_chat(owner, "<BR><B>МИССИЯ:</B> [ert_team.mission.explanation_text]")

/datum/antagonist/ert/spetsnaz/on_gain()
	. = ..()
	givespaceproof()

/datum/antagonist/ert/spetsnaz/proc/givespaceproof()
	var/mob/living/carbon/C = owner.current
	if(!istype(C))
		return
	C.dna.add_mutation(/datum/mutation/human/spaceproof)

/datum/antagonist/ert/spetsnaz
	name = "Спецназ ВВ МВД"
	outfit = /datum/outfit/spetsnaz
	random_names = TRUE
	role = "Спецназовец"

/datum/antagonist/ert/spetsnaz/grenadier
	outfit = /datum/outfit/spetsnaz/grenadier

/datum/antagonist/ert/spetsnaz/leader
	name = "Лидер Спецназа ВВ МВД"
	outfit = /datum/outfit/spetsnaz/leader
	role = "Лидер Спецназа"
	leader = TRUE

/datum/antagonist/ert/spetsnaz/update_name()
	if(owner.current.gender == FEMALE)
		owner.current.fully_replace_character_name(owner.current.real_name,"[pick("Капитан", "Майор", "Подполковник")] [pick(name_source)]а")
	else
		owner.current.fully_replace_character_name(owner.current.real_name,"[pick("Капитан", "Майор", "Подполковник")] [pick(name_source)]")

/datum/antagonist/ert/spetsnaz/leader/update_name()
	if(owner.current.gender == FEMALE)
		owner.current.fully_replace_character_name(owner.current.real_name,"Полковник [pick(name_source)]а")
	else
		owner.current.fully_replace_character_name(owner.current.real_name,"Полковник [pick(name_source)]")


////////////////OUTFITS//////////////////////

/datum/outfit/spetsnaz
	name = "Спецназовец-стрелок"

	uniform = /obj/item/clothing/under/rank/spetsnaz
	suit = /obj/item/clothing/suit/armor/wzzzz/opvest/spetsnaz
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/headset_cent/alt
	mask = /obj/item/clothing/mask/balaclava/wzzzz/swatclava/grey
	belt = /obj/item/storage/belt/military/spetsnaz
	id = /obj/item/card/id/advanced/centcom/spetsnaz
	id_trim = /datum/id_trim/centcom/spetsnaz
	r_pocket = /obj/item/kitchen/knife/combat
	l_pocket = /obj/item/flashlight/seclite
	head = null	
	back = /obj/item/storage/backpack/security
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/handcuffs=1,\
		/obj/item/melee/classic_baton/wzzzz/german=1,\
		/obj/item/crowbar/red=1)

/datum/outfit/spetsnaz/pre_equip(mob/living/carbon/human/H)
	suit_store = /obj/item/gun/ballistic/automatic/ak74m
	var/randomhelmet = pick(/obj/item/clothing/head/helmet/maska, \
						/obj/item/clothing/head/helmet/maska/black, \
						/obj/item/clothing/head/helmet/maska/altyn, \
						/obj/item/clothing/head/helmet/maska/altyn/black)
	if(prob(3))
		head = /obj/item/clothing/head/helmet/maska/adidas
	else 
		head = randomhelmet

/datum/outfit/spetsnaz/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_sec
	R.recalculateChannels()

	var/obj/item/card/id/W = H.wear_id
	W.assignment = "MVD Spetsnaz Operative"
	W.registered_name = H.real_name
	W.update_label()

	var/obj/item/implant/mindshield/L = new/obj/item/implant/mindshield(H)
	L.implant(H, null, 1)

/datum/outfit/spetsnaz/grenadier
	name = "Спецназовец-гранатометчик"

	belt = /obj/item/storage/belt/military/spetsnaz/grenadier

/datum/outfit/spetsnaz/grenadier/pre_equip(mob/living/carbon/human/H)
	suit_store = /obj/item/gun/ballistic/automatic/ak74m/gp25
	var/randomhelmet = pick(/obj/item/clothing/head/helmet/maska, \
						/obj/item/clothing/head/helmet/maska/black, \
						/obj/item/clothing/head/helmet/maska/altyn, \
						/obj/item/clothing/head/helmet/maska/altyn/black)
	if(prob(3))
		head = /obj/item/clothing/head/helmet/maska/adidas
	else 
		head = randomhelmet

/datum/outfit/spetsnaz/grenadier/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_sec
	R.recalculateChannels()

	var/obj/item/card/id/W = H.wear_id
	W.assignment = "MVD Spetsnaz Operative"
	W.registered_name = H.real_name
	W.update_label()

	var/obj/item/implant/mindshield/L = new/obj/item/implant/mindshield(H)
	L.implant(H, null, 1)


/datum/outfit/spetsnaz/leader
	name = "Спецназовец-лидер☆"

	uniform = /obj/item/clothing/under/rank/spetsnaz
	suit = /obj/item/clothing/suit/armor/wzzzz/opvest/spetsnaz
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/headset_cent/alt
	head = /obj/item/clothing/head/hos/beret/spetsnaz
	mask = null
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/storage/belt/military/spetsnaz/leader
	id = /obj/item/card/id/advanced/centcom/spetsnaz/leader
	id_trim = /datum/id_trim/centcom/spetsnaz/leader
	r_pocket = /obj/item/kitchen/knife/combat
	l_pocket = /obj/item/flashlight/seclite
	back = /obj/item/storage/backpack/satchel/sec
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/handcuffs=1,\
		/obj/item/melee/classic_baton/wzzzz/german=1,\
		/obj/item/crowbar/red=1,\
		/obj/item/autosurgeon/organ=1,\
		/obj/item/organ/eyes/robotic/thermals=1,\
		/obj/item/organ/cyberimp/eyes/hud/security=1)

/datum/outfit/spetsnaz/leader/pre_equip(mob/living/carbon/human/H)
	suit_store = /obj/item/gun/ballistic/automatic/asval

/datum/outfit/spetsnaz/leader/post_equip(mob/living/carbon/human/H, visualsOnly)
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/hos
	R.recalculateChannels()

	var/obj/item/card/id/W = H.wear_id
	W.assignment = "MVD Spetsnaz Leader"
	W.registered_name = H.real_name
	W.update_label()

	var/obj/item/implant/mindshield/L = new/obj/item/implant/mindshield(H)
	L.implant(H, null, 1)

////////////////////ITEMS//////////////////////

/obj/item/storage/belt/military/spetsnaz
	desc = "Набор тактических ремней, которые носят некоторые вооруженные отряды."

/obj/item/storage/belt/military/spetsnaz/grenadier

/obj/item/storage/belt/military/spetsnaz/leader

/obj/item/storage/belt/military/spetsnaz/PopulateContents()
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/reagent_containers/hypospray/medipen/stimpack/traitor(src)
		new /obj/item/grenade/stingbang(src)

/obj/item/storage/belt/military/spetsnaz/grenadier/PopulateContents()
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_box/magazine/ak74m(src)
		new /obj/item/ammo_casing/a40mm/vog25(src)
		new /obj/item/reagent_containers/hypospray/medipen/stimpack/traitor(src)
		new /obj/item/grenade/stingbang(src)

/obj/item/storage/belt/military/spetsnaz/leader/PopulateContents()
		new /obj/item/ammo_box/magazine/asval(src)
		new /obj/item/ammo_box/magazine/asval(src)
		new /obj/item/ammo_box/magazine/asval(src)
		new /obj/item/ammo_box/magazine/asval(src)
		new /obj/item/reagent_containers/hypospray/medipen/stimpack/traitor(src)
		new /obj/item/reagent_containers/hypospray/medipen/stimpack/traitor(src)

/obj/item/clothing/suit/armor/wzzzz/opvest/spetsnaz
	armor = list(MELEE = 70, BULLET = 70, LASER = 40, ENERGY = 40, BOMB = 50, BIO = 20, RAD = 20, WOUND = 10)
	strip_delay = 100

/obj/item/clothing/head/hos/beret/spetsnaz // ДАААААА БЛЯДЬ МЫ СОЗДАЕМ 99993393 ТИПОВ ОБЪЕКТОВ С РАЗНИЦЕЙ ЛИШЬ В ОПИСАНИИ ДААА БЛЯЯДЬ ДАА!!!!11
	name = "берет спецназа"
	desc = "Прочный черный берет, показывающий его обладателя как самого настоящего профессионала в своем деле. В каком - пока что неизвестно."
