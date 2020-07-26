/obj/item/gun/ballistic/energy_smg
	name = "Low-power energy SMG"
	desc = "A prototype burst energy weapon. Uses special external batteries which cannot be recharged."
	icon = 'white/RedFoxIV/guns/energy_smg/energy_smg.dmi'
	icon_state = "energy_smg"
	inhand_icon_state = "energy_smg"
	custom_materials = list(/datum/material/titanium = 20000, /datum/material/glass = 2000, /datum/material/gold = 4000 , /datum/material/iron = 35000)
	lefthand_file = 'white/RedFoxIV/guns/guns_lefthand.dmi'
	righthand_file = 'white/RedFoxIV/guns/guns_righthand.dmi'
	fire_sound = 'white/RedFoxIV/guns/energy_smg/fire.ogg'
	fire_sound_volume = 100

	//характеристики ствола
	bolt_type = BOLT_TYPE_OPEN
	mag_type = /obj/item/ammo_box/magazine/energy_smg
	mag_display = TRUE
	burst_size = 10
	fire_delay = 0.7
	recoil = 0.12



//собственный прок для экзамайна, состоящий из кусков кода со всего света потому что я ебал эти затворы и навязанные кодом куски описания, которые мне не нужны

/obj/item/gun/ballistic/energy_smg/examine(mob/user)
	. = list("[ru_get_examine_string(user, TRUE)].")
	. += desc
	. += "Это [weightclass2text(w_class)] размера предмет."
	if(pin)
		. += "Внутри установлен боёк типа [pin.name]."
	else
		. += "Внутри отсутствует <b>боёк</b>, поэтому оно не будет стрелять."

	if(!magazine)
		. += "Аккумулятор отсутствует."
		return

	if(get_ammo())
		. += "Заряда хватает ещё на [get_ammo()] выстрелов"
	else
		. += "Аккумулятор разряжен."

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .) //не ебу что это, но пожалуй оставлю.

//копипаста из ballistic.dm, переделанная под мои нужды. (гильзы не вылетают на пол, а удаляются)
/obj/item/gun/ballistic/energy_smg/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	if(!semi_auto && from_firing)
		return
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(istype(AC)) //there's a chambered round
		if(casing_ejector || !from_firing)
			qdel(AC)
			chambered = null
		else if(empty_chamber)
			chambered = null
	if (chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round()

//копипаста из ballistics.dm, переделанная под мои нужды. (никаких звуков передёргивания, уведомлений в чат)
/obj/item/gun/ballistic/energy_smg/rack(mob/user = null)
	if(!bolt_locked)
		return
	if (user)
		return //не даём передёргивать затвор кому попало
	bolt_locked = FALSE
	process_chamber(!chambered, FALSE)
	update_icon()

/obj/item/gun/ballistic/energy_smg/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message = TRUE)
	..()
	rack()


/obj/item/gun/ballistic/eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null)
	..()
	bolt_locked = TRUE



//абсолютно тот же смг, но с пином для СБ. для спавна в армори
/obj/item/gun/ballistic/energy_smg/mindshield
	pin = /obj/item/firing_pin/implant/mindshield

//для протолата
/obj/item/gun/ballistic/energy_smg/nopin
	pin = null
	spawnwithmagazine = FALSE

//--магазин--
/obj/item/ammo_box/magazine/energy_smg
	name = "Low-power pulse battery"
	desc = "An external battery designed for a prototype weapon. Can't be recharged in standard weapon charging stations or battery  chargers."
	icon= 'white/RedFoxIV/guns/energy_smg/energy_smg.dmi'
	icon_state = "energy_smg_ammobox"
	ammo_type = /obj/item/ammo_casing/energy_smg
	max_ammo = 50
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/attack_self(mob/user)
	return //не даём вытаскивать пульки из аккумулятора


//--ржаказин--
/obj/item/ammo_box/magazine/energy_smg/debug
	max_ammo = 1488


//--пульки--
/obj/item/ammo_casing/energy_smg
	desc = "редфокс дебил"
	caliber = "energy" //на всякий случай
	projectile_type = /obj/projectile/bullet/energy_smg_bullet



/obj/projectile/bullet/energy_smg_bullet
	name = "energy pellet"
	damage = 3.2
	stamina = 1
	icon = 'white/RedFoxIV/guns/energy_smg/energy_smg.dmi'
	icon_state = "energy_smg_proj"



/datum/design/energy_smg
	name = "Prototype Energy SMG"
	desc = "A prototype burst energy weapon. Uses special external batteries"
	id = "energy_smg"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 15000, /datum/material/glass = 5000, /datum/material/gold = 4000 , /datum/material/iron = 30000)
	build_path = /obj/item/gun/ballistic/energy_smg/nopin
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE//убрать флаг РнД если чрезмерно охуеют

/datum/design/energy_smg_mag
	name = "Energy SMG cartridge"
	desc = "An external battery designed for a prototype weapon."
	id = "energy_smg_mag"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 5000, /datum/material/iron = 5000, /datum/material/glass = 2000)
	build_path = /obj/item/ammo_box/magazine/energy_smg
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE//убрать флаг РнД если чрезмерно охуеют
