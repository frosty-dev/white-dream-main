/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/poo_mortar
	name = "R3801U710N two-twenty-eight poo mortar"
	desc = "Охае."
	icon_state = "mecha_bananamrtr"
	projectile = /obj/item/reagent_containers/food/snacks/poo
	fire_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	projectile_energy_cost = 100
	equip_cooldown = 20
	projectiles = 12
	projectiles_cache = 12
	projectiles_cache_max = 128
	ammo_type = "poo"

/obj/item/mecha_ammo/poo
	name = "poo case"
	desc = "A box of ammunition for use with exosuit weapons."
	icon_state = "clusterbang"
	rounds = 12
	ammo_type = "poo"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/poo_mortar/can_attach(obj/mecha/M)
	if(..())
		return 1
	else if(M.equipment.len < M.max_equip && istype(M))
		return 1
	return 0

/datum/crafting_recipe/poomortar  //мне лень искать как замутить дизайн для фабиркатораа
	name = "poo mortar"
	result = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/poo_mortar
	time = 300
	reqs = list(/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma = 1,
				/datum/reagent/fuel = 100,
				/obj/item/reagent_containers/food/snacks/poo = 15,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WRENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/pooammo
	name = "poo mortar ammunition"
	result = /obj/item/mecha_ammo/poo
	time = 60
	reqs = list(/obj/item/reagent_containers/food/snacks/poo = 5,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WIRECUTTER)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
