
/obj/item/banner/engineering/atmos
	name = "Kazakhstan banner"
	desc = "Сшит из плазмы с вкраплениями слез девственниц."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "banner_atmos"
	job_loyalties = list("Scientist", "Atmospheric Technician")
	warcry = "<b>КАЗАХСТАН УГРОЖАЕТ ВАМ БОМБАРДИРОВКОЙ!!</b>"


obj/item/banner/engineering/atmos/mundane
	inspiration_available = FALSE

/datum/crafting_recipe/atmos_banner
	name = "Kazakhstan Banner"
	result = /obj/item/banner/engineering/atmos/mundane
	time = 40
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/clothing/under/rank/engineering/atmospheric_technician = 1)
	category = CAT_MISC

/obj/item/stack/tile/carpet/peaks
	name = "peaks carpet"
	singular_name = "peaks carpet"
	desc = "A piece of carpet. It is the same size as a floor tile."
	icon = 'icons/obj/tiles.dmi'
	icon_state = "tile-carpet"
	turf_type = /turf/open/floor/carpet
	resistance_flags = FLAMMABLE

/turf/open/floor/carpet/peaks
	icon = 'white/pieceofcrap.dmi'
	icon_state = "carp_tp"
	floor_tile = /obj/item/stack/tile/carpet/peaks

/obj/structure/curtain/red
	name = "красный curtain"
	desc = "Contains less than 1% mercury."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "curtain-open"
	icon_type = "curtain"
	alpha = 255 //Mappers can also just set this to 255 if they want curtains that can't be seen through
	layer = SIGN_LAYER
	anchored = TRUE
	opacity = 0
	density = FALSE
	open = TRUE

/obj/item/device/flashlight/slamp
	name = "stand lamp"
	desc = "Floor lamp in a minimalist style."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "slamp"
	inhand_icon_state = "slamp"
	force = 9
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	color = LIGHT_COLOR_YELLOW
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	custom_materials = list()
	anchored = TRUE

/obj/structure/statue/sandstone/venus/afrodita
	name = "Afrodita"
	desc = "An ancient marble statue. The subject is depicted with a floor-length braid. By Jove, it's easily the most gorgeous depiction of a woman you've ever seen. The artist must truly be a master of his craft. Shame about the broken arm, though."
	icon = 'white/statue_w.dmi'
	icon_state = "venus"

/obj/structure/chair/comfy/arm
	name = "Armchair"
	desc = "It looks comfy.\n<span class='notice'>Alt-click to rotate it clockwise.</span>"
	icon = 'white/pieceofcrap.dmi'
	icon_state = "armchair"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	var/mutable_appearance/armresttp
	buildstackamount = 2
	item_chair = null

/obj/structure/chair/comfy/arm/Initialize()
	armresttp = mutable_appearance('white/pieceofcrap.dmi', "comfychair_armrest")
	armresttp.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/chair/comfy/arm/Destroy()
	QDEL_NULL(armresttp)
	return ..()

/obj/structure/chair/comfy/arm/post_buckle_mob(mob/living/M)
	..()
	if(has_buckled_mobs())
		add_overlay(armresttp)
	else
		cut_overlay(armresttp)

/area/ruin/redroom
	name = "The Red Room "

/datum/map_template/ruin/space/redroom
 	id = "redroom"
 	suffix = "redroom.dmm"
 	name = "Red Room"

/obj/item/reagent_containers/food/snacks/carpmeat/dry/donbas
	name = "Debaltsevo fish"
	desc = "Dryed fish with tomatoes. S vodoi v samiy raz."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "roasted"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/toxin/carpotoxin = 3)
	bitesize = 2
	filling_color = "#000000"
	tastes = list("рыба" = 1, "томаты" =1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/carpmeat/dry
	name = "Dryed fish"
	desc = "Just dryed fish. S pivkom v samiy raz."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "dry"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/carpotoxin = 1)
	bitesize = 2
	filling_color = "#FA8072"
	tastes = list("рыба" = 1)
	foodtype = MEAT

/datum/crafting_recipe/dryfish
	name = "Dryed Fish"
	result =  /obj/item/reagent_containers/food/snacks/carpmeat/dry
	time = 80
	reqs = list(/obj/item/reagent_containers/food/snacks/carpmeat = 3,
				/datum/reagent/fuel = 5)
	category = CAT_MISC

/datum/crafting_recipe/dryfish/donbass
	name = "Debaltsevo Fish"
	result =  /obj/item/reagent_containers/food/snacks/carpmeat/dry/donbas
	time = 40
	reqs = list(/obj/item/reagent_containers/food/snacks/carpmeat/dry = 1,
				/datum/reagent/consumable/tomatojuice = 10,
				/obj/item/reagent_containers/food/snacks/grown/tomato = 1)
	category = CAT_MISC

/obj/item/reagent_containers/food/snacks/meat/slab/dach
	name = "dach meat"
	desc = "Tastes like... well you know..."
	foodtype = RAW | MEAT | GROSS

/datum/supply_pack/organic/critter/dhund
	name = "Dachshund Crate"
	cost = 1000
	contains = list(/mob/living/simple_animal/pet/dog/dhund)
	crate_name = "dachshund crate"

/mob/living/simple_animal/pet/dog/dhund
	name = "\improper Dachshund"
	real_name = "Dachshund"
	desc = "It's a dachshund."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "dachshund"
	icon_living = "dachshund"
	icon_dead = "dachshund_dead"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/dach = 3)
	gold_core_spawnable = 2

/mob/living/simple_animal/pet/dog/shepherd
	name = "\improper Shepherd"
	real_name = "Shepherd"
	desc = "It's a Shepherd."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "shepherd"
	icon_living = "shepherd"
	icon_dead = "shepherd_dead"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/shepherd = 3)
	gold_core_spawnable = 2

/mob/living/simple_animal/pet/dog/jack
	name = "\improper Jack"
	real_name = "Jack russell terrier"
	desc = "It's a jack russell terrier."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "jack"
	icon_living = "jack"
	icon_dead = "jack_dead"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/jack = 3)
	gold_core_spawnable = 2

/mob/living/simple_animal/pet/dog/pug/chi
	name = "\improper Chi"
	real_name = "Chihuahua"
	desc = "It's a chihuahua."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "chi"
	icon_living = "chi"
	icon_dead = "chi_dead"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chi = 1)
	gold_core_spawnable = 2

/obj/item/reagent_containers/food/snacks/meat/slab/jack
	name = "jack meat"
	desc = "Tastes like... well you know..."
	foodtype = RAW | MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/chi
	name = "chihuahua meat"
	desc = "Tastes like... well you know..."
	foodtype = RAW | MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/shepherd
	name = "shepherd meat"
	desc = "Tastes like... well you know..."
	foodtype = RAW | MEAT | GROSS

/datum/supply_pack/organic/critter/shepherd
	name = "German Shepherd"
	cost = 1000
	contains = list(/mob/living/simple_animal/pet/dog/shepherd)
	crate_name = "shepherd crate"

/datum/supply_pack/organic/critter/doggies
	name = "Doggies crate"
	cost = 1000
	contains = list(/mob/living/simple_animal/pet/dog/jack, /mob/living/simple_animal/pet/dog/pug/chi)
	crate_name = "doggies crate"

//doggo sprites by Arkblader

/obj/item/gun/ballistic/shotgun/sniper
	name = "Hunting rifle"
	desc = "A traditional hunting rifle with 4x scope and a four-shell capacity underneath."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "tranqshotgun"
	inhand_icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	force = 4
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	casing_ejector = FALSE
	weapon_weight = WEAPON_MEDIUM

/obj/item/ammo_casing/shotgun/dart/sleeping
	name = "shotgun dart"
	desc = "A dart for use in shotguns. Filled with tranquilizers."
	icon_state = "cshell"
	projectile_type = /obj/projectile/bullet/dart

/obj/item/ammo_casing/shotgun/dart/sleeping/Initialize()
	. = ..()
	reagents.add_reagent("tirizene", 20)
	reagents.add_reagent("skewium", 5)
	reagents.add_reagent("spewium", 5)

/obj/item/storage/box/sleeping
	name = "box of tranquilizer darts"
	desc = "A box full of darts, filled with tranquilizers."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "tranqshot"
	illustration = null

/obj/item/storage/box/sleeping/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/dart/sleeping(src)

/obj/item/book/ruchinese
	name = "Russian-chinese dictionary"
	desc = "Apply to the moths and flies."
	icon = 'white/pieceofcrap.dmi'
	icon_state = "slovar"
	inhand_icon_state = "bible"
	lefthand_file = 'icons/mob/inhands/misc/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/books_righthand.dmi'
	force = 17
	block_chance = 70
	hitsound = 'white/fogmann/yebal.ogg'
	dat = {"<html><body>
	<img src=https://pp.userapi.com/c638421/v638421709/50c5d/RbBWfRq8b8Q.jpg>
	</body>
	</html>"}


/obj/item/book/ruchinese/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] бьет себя словарем по голове, кажется он чувствует себя хуево!</span>")
	var/delay_offset = 0
	for(var/mob/M in viewers(src, 7))
		var/mob/living/carbon/human/C = M
		if (ishuman(M))
			addtimer(CALLBACK(C, /mob/.proc/emote, "blyadiada"), delay_offset * 0.3)
			delay_offset++
	return (BRUTELOSS)

/datum/uplink_item/role_restricted/ruchinese
	name = "Russian-chinese dictionary"
	desc = "Русско-китайский словарь, особо эффективен против моли и мух."
	item = /obj/item/book/ruchinese
	cost = 18
	restricted_roles = list("Chaplain", "Curator", "Assistant")
	surplus = 5

/datum/emote/living/carbon/blyad
	key = "blyadiada"
	key_third_person = "blyads"
	message = "blyads."
	muzzle_ignore = FALSE
	restraint_check = FALSE
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/blyad/run_emote(mob/living/user, params)
	. = ..()
	if (.)
		if (ishuman(user))
			if (!user.get_bodypart("tongue"))
				return
			var/blyad = pick('white/fogmann/blyead.ogg')
			playsound(user, blyad, 25, 1, -1)
