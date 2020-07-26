////////////////////////////////
//
// Donations. Reworked for /tg/ by valtos
//
////////////////////////////////

GLOBAL_LIST_INIT(donations_list, list(
	"Hats" = list(
		new /datum/donate_info("Collectable Pete hat",		/obj/item/clothing/head/collectable/petehat, 	150),
		new /datum/donate_info("Collectable Xeno hat",		/obj/item/clothing/head/collectable/xenom,		110),
		new /datum/donate_info("Collectable Top hat",		/obj/item/clothing/head/collectable/tophat,		120),
		new /datum/donate_info("Kitty Ears",				/obj/item/clothing/head/kitty,					100),
		new /datum/donate_info("Ushanka",					/obj/item/clothing/head/ushanka,				200),
		new /datum/donate_info("Beret",						/obj/item/clothing/head/beret,					150),
		new /datum/donate_info("Witch Wig",					/obj/item/clothing/head/witchwig,				135),
		new /datum/donate_info("Marisa hat",				/obj/item/clothing/head/witchwig,				130),
		new /datum/donate_info("Cake-hat",					/obj/item/clothing/head/hardhat/cakehat,		100),
		new /datum/donate_info("Wizard hat",				/obj/item/clothing/head/wizard/fake,			100),
		new /datum/donate_info("Flat-cap",					/obj/item/clothing/head/flatcap,				120),
		new /datum/donate_info("Collectable rabbit ears",	/obj/item/clothing/head/collectable/rabbitears,	120),
		new /datum/donate_info("Cardborg helment",			/obj/item/clothing/head/cardborg,				20),
		new /datum/donate_info("Bear pelt",					/obj/item/clothing/head/bearpelt,				175),
		new /datum/donate_info("Scarecrow Hat",				/obj/item/clothing/head/scarecrow_hat,			175),
		new /datum/donate_info("Arbiter Helmet",			/obj/item/clothing/head/helmet/arbiter,			175),
		new /datum/donate_info("Inquisitor Helmet",			/obj/item/clothing/head/helmet/arbiter/inquisitor,200),
		new /datum/donate_info("m35 Cap",					/obj/item/clothing/head/helmet/izanhelm,		120),
		new /datum/donate_info("m35 Elite Cap",				/obj/item/clothing/head/helmet/izanhelm/elite,	120),
		new /datum/donate_info("m35 Helmet",				/obj/item/clothing/head/helmet/izanhelm/helmet,	120),
		new /datum/donate_info("m35 Elite Helmet",			/obj/item/clothing/head/helmet/izanhelm/helmet/elite,120),
		new /datum/donate_info("Pickelhelm",				/obj/item/clothing/head/helmet/izanhelm/helmet/pickelhelm,200),
		new /datum/donate_info("Richard's Head",			/obj/item/clothing/head/helmet/richard,			250),
	),
	"Masks" = list(
		new /datum/donate_info("Fake Moustache",			/obj/item/clothing/mask/fakemoustache,			100),
		new /datum/donate_info("Pig Mask",					/obj/item/clothing/mask/pig,					150),
		new /datum/donate_info("Cow Mask",					/obj/item/clothing/mask/cowmask,				150),
		new /datum/donate_info("Horse Head Mask",			/obj/item/clothing/mask/horsehead,				150),
		new /datum/donate_info("Carp Mask",					/obj/item/clothing/mask/gas/carp,				150),
		new /datum/donate_info("Plague Doctor Mask",		/obj/item/clothing/mask/gas/plaguedoctor,		180),
		new /datum/donate_info("Monkey Mask",				/obj/item/clothing/mask/gas/monkeymask,			180),
		new /datum/donate_info("Owl Mask",					/obj/item/clothing/mask/gas/owl_mask,			180),
		new /datum/donate_info("Sack Mask",					/obj/item/clothing/mask/scarecrow,				180),
		new /datum/donate_info("Old Style Gas Mask",		/obj/item/clothing/mask/gas/izan,				200),
		new /datum/donate_info("German Gas Mask",			/obj/item/clothing/mask/gas/izan/german,		210),
		new /datum/donate_info("German Gas Mask Alt",		/obj/item/clothing/mask/gas/izan/german/alt,	200),
		new /datum/donate_info("Respirator Mask",			/obj/item/clothing/mask/gas/izan/respirator,	150),
		new /datum/donate_info("Balaclava",					/obj/item/clothing/mask/izanclava,				110),
		new /datum/donate_info("Swatclava",					/obj/item/clothing/mask/izanclava/swat,			120),
	),
	"Personal Stuff" = list(
		new /datum/donate_info("Eye patch",					/obj/item/clothing/glasses/eyepatch,			130),
		new /datum/donate_info("Orange glasses",			/obj/item/clothing/glasses/orange,				130),
		new /datum/donate_info("Heat goggles",				/obj/item/clothing/glasses/heat,				130),
		new /datum/donate_info("Cold goggles",				/obj/item/clothing/glasses/cold,				130),
		new /datum/donate_info("Cane",						/obj/item/cane,									130),
		new /datum/donate_info("Zippo",						/obj/item/lighter,								130),
		new /datum/donate_info("Cigarette packet",			/obj/item/storage/fancy/cigarettes,				20),
		new /datum/donate_info("DromedaryCo packet",		/obj/item/storage/fancy/cigarettes/dromedaryco,	50),
		new /datum/donate_info("Premium Havanian Cigar",	/obj/item/clothing/mask/cigarette/cigar/havana,	130),
		new /datum/donate_info("E-Cigarette",				/obj/item/clothing/mask/vape,					150),
		new /datum/donate_info("Beer bottle",				/obj/item/reagent_containers/food/drinks/beer,	80),
		new /datum/donate_info("Captain flask",				/obj/item/reagent_containers/food/drinks/flask,	200),
		new /datum/donate_info("Red glasses",				/obj/item/clothing/glasses/red,					180),
		new /datum/donate_info("Waistcoat",					/obj/item/clothing/accessory/waistcoat,			85),
		new /datum/donate_info("Cloak",						/obj/item/clothing/neck/cloak,					190),
		new /datum/donate_info("Donut Box",					/obj/item/storage/fancy/donut_box,				450),
		new /datum/donate_info("Red Armband",				/obj/item/clothing/accessory/armband,			100),
	),
	"Shoes" = list(
		new /datum/donate_info("Clown Shoes",				/obj/item/clothing/shoes/clown_shoes,			120),
		new /datum/donate_info("Cyborg Shoes",				/obj/item/clothing/shoes/cyborg,				120),
		new /datum/donate_info("Laceups Shoes",				/obj/item/clothing/shoes/laceup,				120),
		new /datum/donate_info("Wooden Sandals",			/obj/item/clothing/shoes/sandal,				80),
		new /datum/donate_info("Brown Shoes",				/obj/item/clothing/shoes/sneakers/brown,		120),
		new /datum/donate_info("Jackboots",					/obj/item/clothing/shoes/jackboots,				130),
		new /datum/donate_info("Arbiter Boots",				/obj/item/clothing/shoes/jackboots/arbiter,		150),
	),
	"Coats" = list(
		new /datum/donate_info("Leather Coat",				/obj/item/clothing/suit/jacket/leather/overcoat,160),
		new /datum/donate_info("Pirate Coat",				/obj/item/clothing/suit/pirate,					120),
		new /datum/donate_info("Red poncho",				/obj/item/clothing/suit/poncho/red,				140),
		new /datum/donate_info("Green poncho",				/obj/item/clothing/suit/poncho/green,			150),
		new /datum/donate_info("Puffer jacket",				/obj/item/clothing/suit/jacket/puffer,			120),
		new /datum/donate_info("Winter coat",				/obj/item/clothing/suit/hooded/wintercoat,		130),
		new /datum/donate_info("Cardborg",					/obj/item/clothing/suit/cardborg,				50),
		new /datum/donate_info("Cowl",						/obj/item/clothing/suit/cowl,					150),
		new /datum/donate_info("Robe",						/obj/item/clothing/suit/cowl/robe,				500),
		new /datum/donate_info("Bulletproof Vest",			/obj/item/clothing/suit/armor/vest/izan,		100),
		new /datum/donate_info("Arbiter Vest",				/obj/item/clothing/suit/armor/vest/izan/arbiter,165),
		new /datum/donate_info("m35 Coat",					/obj/item/clothing/suit/armor/vest/izan/army_coat,120),
		new /datum/donate_info("m35 Elite Coat",			/obj/item/clothing/suit/armor/vest/izan/elite_army_coat,135),
		new /datum/donate_info("m35 Super Elite Coat",		/obj/item/clothing/suit/armor/vest/izan/super_elite_army_coat,165),
	),
	"Jumpsuits" = list(
		new /datum/donate_info("Vice Policeman",			/obj/item/clothing/under/misc/vice_officer,		180),
		new /datum/donate_info("Pirate outfit",				/obj/item/clothing/under/costume/pirate,		130),
		new /datum/donate_info("Waiter outfit",				/obj/item/clothing/under/suit/waiter,			120),
		new /datum/donate_info("Black suit",				/obj/item/clothing/under/suit/black,			150),
		new /datum/donate_info("Central Command officer",	/obj/item/clothing/under/rank/centcom/officer,	390),
		new /datum/donate_info("Jeans",						/obj/item/clothing/under/pants/jeans,			160),
		new /datum/donate_info("Rainbow Suit",				/obj/item/clothing/under/color/rainbow,			130),
		new /datum/donate_info("Executive Skirt",			/obj/item/clothing/under/suit/black_really/skirt,130),
		new /datum/donate_info("Executive Suit",			/obj/item/clothing/under/suit/black_really,		130),
		new /datum/donate_info("Schoolgirl Uniform",		/obj/item/clothing/under/costume/schoolgirl,	130),
		new /datum/donate_info("Tacticool Turtleneck",		/obj/item/clothing/under/syndicate/tacticool,	130),
		new /datum/donate_info("Tacticool Skirtleneck",		/obj/item/clothing/under/syndicate/tacticool/skirt,130),
		new /datum/donate_info("Soviet Uniform",			/obj/item/clothing/under/costume/soviet,		130),
		new /datum/donate_info("Kilt",						/obj/item/clothing/under/costume/kilt,			100),
		new /datum/donate_info("Gladiator uniform",			/obj/item/clothing/under/costume/gladiator,		100),
		new /datum/donate_info("Assistant's formal uniform",/obj/item/clothing/under/misc/assistantformal,	100),
		new /datum/donate_info("Psychedelic jumpsuit",		/obj/item/clothing/under/misc/psyche,			220),
		new /datum/donate_info("m35 Jacket",				/obj/item/clothing/under/m35jacket,				120),
		new /datum/donate_info("m35 Officer Jacket",		/obj/item/clothing/under/m35jacket/officer,		130),
		new /datum/donate_info("m35 Elite Jacket",			/obj/item/clothing/under/m35jacket/elite,		125),
		new /datum/donate_info("m35 Super Elite Jacket",	/obj/item/clothing/under/m35jacket/elite/super,	125),
		new /datum/donate_info("Magistrate Uniform",		/obj/item/clothing/under/magistrate,			125),
		new /datum/donate_info("Arbiter Uniform",			/obj/item/clothing/under/arbiter,				125),
		new /datum/donate_info("Blue Galaxy Suit",			/obj/item/clothing/under/rank/civilian/lawyer/galaxy,225),
		new /datum/donate_info("Red Galaxy Suit",			/obj/item/clothing/under/rank/civilian/lawyer/galaxy/red,225),
		new /datum/donate_info("Jabroni Outfit",			/obj/item/clothing/under/costume/jabroni, 		100),
		new /datum/donate_info("Спортивный Костюм",			/obj/item/clothing/under/switer/tracksuit, 		228),
	),
	"Gloves" = list(
		new /datum/donate_info("White Gloves",				/obj/item/clothing/gloves/color/white,			125),
		new /datum/donate_info("Rainbow Gloves",			/obj/item/clothing/gloves/color/rainbow,		200),
		new /datum/donate_info("Black Gloves",				/obj/item/clothing/gloves/color/black,			130),
		new /datum/donate_info("Boxing Gloves",				/obj/item/clothing/gloves/boxing,				120),
		new /datum/donate_info("Green Gloves",				/obj/item/clothing/gloves/color/green,			100),
		new /datum/donate_info("Latex Gloves",				/obj/item/clothing/gloves/color/latex,			150),
		new /datum/donate_info("Fingerless Gloves",			/obj/item/clothing/gloves/fingerless,			90),
		new /datum/donate_info("Arbiter Gloves",			/obj/item/clothing/gloves/arbiter,				125),
		new /datum/donate_info("Undertaker Gloves",			/obj/item/clothing/gloves/arbiter/undertaker,	125),
	),
	"Bedsheets" = list(
		new /datum/donate_info("Clown Bedsheet",			/obj/item/bedsheet/clown,						100),
		new /datum/donate_info("Mime Bedsheet",				/obj/item/bedsheet/mime,						100),
		new /datum/donate_info("Rainbow Bedsheet",			/obj/item/bedsheet/rainbow,						100),
		new /datum/donate_info("Captain Bedsheet",			/obj/item/bedsheet/captain,						120),
		new /datum/donate_info("Cosmos Bedsheet",			/obj/item/bedsheet/cosmos,						150),
	),
	"Toys" = list(
		new /datum/donate_info("Rubber Duck",				/obj/item/bikehorn/rubberducky,					200),
		new /datum/donate_info("Champion Belt",				/obj/item/storage/belt/champion,				200),
		new /datum/donate_info("Toy pistol",				/obj/item/toy/gun,								150),
		new /datum/donate_info("Toy dualsaber",				/obj/item/dualsaber/toy,				280),
		new /datum/donate_info("Toy katana",				/obj/item/toy/katana,							215),
		new /datum/donate_info("Rainbow crayon",			/obj/item/toy/crayon/rainbow,					250),
	),
	"Special Stuff" = list(
		new /datum/donate_info("Santa Bag",					/obj/item/storage/backpack/santabag,			450),
		new /datum/donate_info("Bible",						/obj/item/storage/book/bible,					100),
	),
	"Inovations" = list(
		new /datum/donate_info("Game Kit",					/obj/item/game_kit,								100),
		new /datum/donate_info("Checkers Kit",				/obj/item/checkers_kit,							150),
		new /datum/donate_info("Casino Cards",				/obj/item/toy/cards/deck/shitspawn_deck,		450),
		new /datum/donate_info("Jukebox (Only one)",		/obj/machinery/turntable/donate,				100),
		new /datum/donate_info("Boombox (Only one)",		/obj/item/boombox/single,						150),
		new /datum/donate_info("Music Writer",				/obj/machinery/musicwriter,						450),
		new /datum/donate_info("TTS ears",					/obj/item/organ/ears/cat/tts,                   500),
		new /datum/donate_info("DIY Shuttle capsule",		/obj/item/shuttlespawner/diyshuttle,			500),
		new /datum/donate_info("Anonist Mask",				/obj/item/clothing/mask/gas/anonist,			100),
		new /datum/donate_info("Glitch Gun",				/obj/item/gun/magic/glitch,						300),
		new /datum/donate_info("Love Gun", 					/obj/item/gun/energy/lovegun, 					0,	"vanotyan", 1)
	)
))

/datum/donate_info
	var/name
	var/path_to
	var/cost = 0
	var/special = null
	var/stock = 30

/datum/donate_info/New(name, path, cost, special = null, stock = 30)
	src.name = name
	src.path_to = path
	src.cost = cost
	src.special = special
	src.stock = stock

/client/verb/new_donates_panel()
	set name = "#️⃣ Панель благотворца"
	set category = "Особенное"


	if(!SSticker || SSticker.current_state < GAME_STATE_PLAYING)
		to_chat(src,"<span class='warning'>Не так быстро, игра ещё не началась!</span>")
		return

	if (!GLOB.donators[ckey]) //If it doesn't exist yet
		load_donator(ckey)

	var/datum/donator/D = GLOB.donators[ckey]
	if(D)
		D.ShowPanel(src)
	else
		to_chat(src,"<span class='warning'>Вы не донатили, извините.</span>")

GLOBAL_LIST_EMPTY(donate_icon_cache)
GLOBAL_LIST_EMPTY(donators)

#define DONATIONS_SPAWN_WINDOW 6000

/datum/donator
	var/ownerkey
	var/money = 0
	var/maxmoney = 0
	var/allowed_num_items = 20

/datum/donator/New(ckey, money)
	..()
	ownerkey = ckey
	src.money = money
	maxmoney = money
	GLOB.donators[ckey] = src


/datum/donator/proc/ShowPanel(mob/user)
	var/list/dat = list("<center>")
	dat += "Пожертвования в материю!"
	dat += "</center>"

	dat += "<HR>"
	dat += "<h3>МАШИНА ДОНАТОВ. Баланс: [money]</h3>"
	dat += "<div class='statusDisplay'>"
	dat += "<table>"
	for(var/L in GLOB.donations_list)
		dat += "<tr><td></td><td><center><b>[L]</b></center></td><td></td><td></td></tr>"
		for(var/datum/donate_info/prize in GLOB.donations_list[L])
			dat += "<tr><td><img src='data:image/jpeg;base64,[GetIconForProduct(prize)]'/></td><td>[prize.name]</td><td>[prize.cost]</td><td><A href='?src=\ref[src];getdonate=\ref[prize]'>Получить</A></td></tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "miningvendor", "Donations Panel", 340, 700)
	popup.set_content(dat.Join())
	popup.open()

/datum/donator/proc/GetIconForProduct(datum/donate_info/P)
	if(GLOB.donate_icon_cache[P.path_to])
		return GLOB.donate_icon_cache[P.path_to]

	var/product = new P.path_to()
	GLOB.donate_icon_cache[P.path_to] = icon2base64(getFlatIcon(product, no_anim = TRUE))
	qdel(product)
	return GLOB.donate_icon_cache[P.path_to]

/datum/donator/Topic(href, href_list)
	var/datum/donate_info/prize = locate(href_list["getdonate"])
	var/mob/living/carbon/human/user = usr

	if(!SSticker || SSticker.current_state < 3)
		to_chat(user,"<span class='warning'>Игра ещё не началась!</span>")
		return 0

	if((world.time-SSticker.round_start_time)>DONATIONS_SPAWN_WINDOW && !istype(get_area(user), /area/shuttle/arrival))
		to_chat(user,"<span class='warning'>Вам нужно быть на шаттле прибытия.</span>")
		return 0

	if(prize.cost > money)
		to_chat(user,"<span class='warning'>У вас недостаточно баланса.</span>")
		return 0

	if(!allowed_num_items)
		to_chat(user,"<span class='warning'>Вы достигли максимума. Молодец.</span>")
		return 0

	if(!user)
		to_chat(user,"<span class='warning'>Вам нужно быть живым.</span>")
		return 0

	if(!ispath(prize.path_to))
		return 0

	if(user.stat)
		return 0

	if(prize.stock <= 0)
		to_chat(user,"<span class='warning'>Поставки <b>[prize.name]</b> закончились.</span>")
		return 0

	if(prize.special)
		if (prize.special != user.ckey)
			to_chat(user,"<span class='warning'>Этот предмет предназначен для <b>[prize.special]</b>.</span>")
			return 0

	var/list/slots = list(
		"сумке" = ITEM_SLOT_BACKPACK,
		"левом кармане" = ITEM_SLOT_LPOCKET,
		"правом кармане" = ITEM_SLOT_RPOCKET,
		"руке" = ITEM_SLOT_DEX_STORAGE
	)

	prize.stock--

	var/obj/spawned = new prize.path_to(user.loc)
	var/where = null

	if (ishuman(user))
		where = user.equip_in_one_of_slots(spawned, slots, qdel_on_fail=0)

	if (!where)
		to_chat(user,"<span class='info'>Ваш [prize.name] был создан!</span>")
		spawned.anchored = FALSE
	else
		to_chat(user,"<span class='info'>Ваш [prize.name] был создан в [where]!</span>")

	money -= prize.cost
	allowed_num_items--

	ShowPanel(user)
	return

/proc/load_donator(ckey)
	if(!SSdbcore.IsConnected())
		return 0

	var/datum/db_query/query_donators = SSdbcore.NewQuery("SELECT round(sum) FROM donations WHERE byond=:ckey", list("ckey" = ckey))
	query_donators.Execute()
	while(query_donators.NextRow())
		var/money = round(text2num(query_donators.item[1]))
		new /datum/donator(ckey, money)
	qdel(query_donators)
	return 1

/proc/check_donations(ckey)
	if (!GLOB.donators[ckey]) //If it doesn't exist yet
		return 0
	var/datum/donator/D = GLOB.donators[ckey]
	if(D)
		if (D.maxmoney >= 50)
			return 1
	return 0
