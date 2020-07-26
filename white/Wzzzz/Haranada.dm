/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/asset_protection
	name = "asset protection hardsuit helmet"
	desc = "Helmet for special asset-protection hardsuit."
	alt_desc = "Helmet for special asset-protection hardsuit."
	icon_state = "asset_protection"
	inhand_icon_state = "asset_protection"
	hardsuit_type = "asset_protection"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 35, "bio" = 100, "rad" = 0, "fire" = 55, "acid" = 50)
	flash_protect = 1
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	brightness_on = 2
	on = FALSE
	slowdown = 0
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/asset_protection
	name = "asset protection hardsuit"
	desc = "Probably for protection."
	alt_desc = "Probably for protection."
	icon_state = "hardsuit0-asset_protection"
	inhand_icon_state = "hardsuit0-asset_protection"
	hardsuit_type = "asset_protection"
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 35, "bio" = 100, "rad" = 0, "fire" = 55, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/asset_protection
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/eng
	name = "engineer hardsuit helmet"
	desc = "For engineers."
	alt_desc = "For engineers."
	icon_state = "rig0-engineeringalt"
	inhand_icon_state = "rig0-engineeringalt"
	on = FALSE
	hardsuit_type = "engineeringalt"
	var/obj/item/clothing/head/helmet/space/hardsuit/syndi/wzzzz/eng = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	brightness_on = 1
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 75, "fire" = 50, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/eng
	icon_state = "hardsuit0-engineeringalt_rig"
	name = "engineer hardsuit"
	desc = "For engineers."
	alt_desc = "For engineers."
	inhand_icon_state = "hardsuit0-engineeringalt_rig"
	jetpack = null
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	hardsuit_type = "engineeringalt"
	icon = 'white/Wzzzz/icons/clothing/clothing/suits.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 25, "laser" = 30, "energy" = 30, "bomb" = 40, "bio" = 100, "rad" = 75, "fire" = 50, "acid" = 75)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/eng

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/breacher_cheap
	name = "breacher cheap hardsuit helmet"
	desc = "Not enough good like usual breacher suit, but too good."
	alt_desc = "Not enough good like usual breacher suit, but too good."
	icon_state = "breacher_rig_cheap"
	inhand_icon_state = "breacher_rig_cheap"
	hardsuit_type = "breacher_rig_cheap"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	on = FALSE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF| 52
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	clothing_flags = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/breacher_cheap = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	brightness_on = 2
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/breacher_cheap
	name = "breacher cheap hardsuit"
	desc = "Not enough good like usual breacher suit, but too good."
	alt_desc = "Not enough good like usual breacher suit, but too good."
	icon_state = "hardsuit0-breacher_rig_cheap"
	inhand_icon_state = "hardsuit0-breacher_rig_cheap"
	hardsuit_type = "breacher_rig_cheap"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 55, "bio" = 50, "rad" = 40, "fire" = 50, "acid" = 50)
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/breacher_cheap

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/breacher
	name = "breacher hardsuit"
	desc = "Good style, good protection, but heavy."
	alt_desc = "Good style, good protection, but heavy."
	icon_state = "hardsuit0-breacher_rig"
	inhand_icon_state = "hardsuit0-breacher_rig"
	hardsuit_type = "breacher_rig"
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 60, "bullet" = 75, "laser" = 50, "energy" = 40, "bomb" = 70, "bio" = 80, "rad" = 50, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/breacher
	resistance_flags = NONE|ACID_PROOF|FIRE_PROOF|FREEZE_PROOF|LAVA_PROOF

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/breacher
	name = "breacher hardsuit helmet"
	desc = "Good style, good protection, but heavy."
	alt_desc = "Good style, good protection, but heavy."
	icon_state = "breacher_rig"
	on = FALSE
	inhand_icon_state = "breacher_rig"
	hardsuit_type = "breacher_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40, "energy" = 35, "bomb" = 65, "bio" = 40, "rad" = 0, "fire" = 70, "acid" = 70)
	flash_protect = 5
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF | 52
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	clothing_flags = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT
	flags_inv = HIDEEARS|HIDEFACE|HIDEMASK
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/breacher = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE
	clothing_flags = STOPSPRESSUREDAMAGE
	resistance_flags = NONE|ACID_PROOF|FIRE_PROOF|FREEZE_PROOF|LAVA_PROOF
	brightness_on = 1





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/military_rig
	name = "military hardsuit helmet"
	desc = "A dual-mode advanced helmet designed for work in special operations. It is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A dual-mode advanced helmet designed for work in special operations. It is in combat mode. Property of Gorlex Marauders."
	icon_state = "hardsuit0-military_rig"
	inhand_icon_state = "hardsuit0-military_rig"
	hardsuit_type = "military_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	flash_protect = 1
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	armor = list("melee" = 65, "bullet" = 65, "laser" = 55, "energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100)
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/military_rig
	name = "military hardsuit"
	desc = "A dual-mode advanced hardsuit designed for work in special operations. It is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A dual-mode advanced hardsuit designed for work in special operations. It is in combat mode. Property of Gorlex Marauders."
	icon_state = "hardsuit0-military_rig"
	inhand_icon_state = "hardsuit0-military_rig"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	hardsuit_type = "military_rig"
	armor = list("melee" = 65, "bullet" = 65, "laser" = 55, "energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100)
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/military_rig





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/hazard_rig
	name = "hazard hardsuit helmet"
	desc = "Heavy protection for hazard situations."
	alt_desc = "Heavy protection for hazard situations."
	icon_state = "hardsuit0-hazard_rig"
	inhand_icon_state = "hardsuit0-hazard_rig"
	hardsuit_type = "hazard_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 40, "bullet" = 40, "laser" = 60,"energy" = 60, "bomb" = 50, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 100)
	flash_protect = 1
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	brightness_on = 2
	on = FALSE
	resistance_flags = NONE|FREEZE_PROOF|FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/hazard_rig
	name = "hazard hardsuit"
	desc = "Heavy protection for hazard situations."
	alt_desc = "Heavy protection for hazard situations."
	icon_state = "hardsuit0-hazard_rig"
	inhand_icon_state = "hardsuit0-hazard_rig"
	hardsuit_type = "hazard_rig"
	resistance_flags = NONE|FREEZE_PROOF|FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 40, "bullet" = 40, "laser" = 60,"energy" = 60, "bomb" = 50, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 100)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/hazard_rig

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/merc_rig
	name = "advanced blood-red hardsuit helmet"
	desc = "Advanced Syndicate red hardsuit helmet."
	alt_desc = "Advanced Syndicate red hardsuit helmet."
	icon_state = "hardsuit0-merc_rig"
	inhand_icon_state = "hardsuit0-merc_rig"
	hardsuit_type = "merc_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 60, "laser" = 45, "energy" = 40, "bomb" = 60, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 90)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	brightness_on = 1
	on = FALSE
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/merc_rig
	name = "advanced blood-red hardsuit"
	desc = "Advanced Syndicate red hardsuit."
	alt_desc = "Advanced Syndicate red hardsuit."
	icon_state = "hardsuit0-merc_rig"
	inhand_icon_state = "hardsuit0-merc_rig"
	hardsuit_type = "hazard_rig"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 60, "bullet" = 60, "laser" = 45, "energy" = 40, "bomb" = 60, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 90)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/merc_rig

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_miningalt
	name = "advanced miner hardsuit helmet"
	desc = "For miners, isn't it?"
	alt_desc = "For miners, isn't it?"
	icon_state = "rig_miningalt"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_miningalt"
	hardsuit_type = "rig_miningalt"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = TRUE
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 50, "fire" = 60, "acid" = 75)
	brightness_on = 5
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_miningalt
	name = "advanced miner hardsuit"
	desc = "For miners, isn't it?"
	alt_desc = "For miners, isn't it?"
	clothing_flags = STOPSPRESSUREDAMAGE
	icon_state = "rig_miningalt"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	inhand_icon_state = "rig_miningalt"
	slowdown = 0.7
	hardsuit_type = "rig_miningalt"
	w_class = WEIGHT_CLASS_NORMAL
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 50, "fire" = 60, "acid" = 75)
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_miningalt











/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/merc_rig_heavy
	name = "heavy blood-red hardsuit helmet"
	desc = "Very heavy, but nice protection."
	alt_desc = "Very heavy, but nice protection."
	icon_state = "hardsuit0-merc_rig_heavy"
	inhand_icon_state = "hardsuit0-merc_rig_heavy"
	hardsuit_type = "merc_rig_heavy"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 90, "bullet" = 85, "laser" = 80,"energy" = 85, "bomb" = 90, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	slowdown = 0.5
	brightness_on = 1

	resistance_flags = NONE|FREEZE_PROOF|FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/merc_rig_heavy
	name = "heavy blood-red hardsuit"
	desc = "Very heavy, but nice protection."
	alt_desc = "Very heavy, but nice protection."
	icon_state = "hardsuit0-merc_rig_heavy"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	inhand_icon_state = "hardsuit0-merc_rig_heavy"
	hardsuit_type = "merc_rig_heavy"
	w_class = WEIGHT_CLASS_NORMAL
	slowdown = 2
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 90, "bullet" = 85, "laser" = 80,"energy" = 85, "bomb" = 90, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/merc_rig_heavy






/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/security_rig
	name = "security hardsuit helmet"
	desc = "New model of security hardsuit for station."
	alt_desc = "New model of security hardsuit for station."
	icon_state = "hardsuit0-security_rig"
	inhand_icon_state = "hardsuit0-security_rig"
	hardsuit_type = "security_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 50, "bio" = 50, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/security_rig
	name = "security hardsuit"
	desc = "New model of security hardsuit for station."
	alt_desc = "New model of security hardsuit for station."
	icon_state = "hardsuit0-security_rig"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	inhand_icon_state = "hardsuit0-security_rig"
	hardsuit_type = "security_rig"
	w_class = WEIGHT_CLASS_NORMAL
	armor = list("melee" = 50, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 50, "bio" = 50, "rad" = 0, "fire" = 60, "acid" = 50)
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/security_rig






/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/medical_rig
	name = "medical hardsuit helmet"
	desc = "New model of medical hardsuit for station."
	alt_desc = "New model of medical hardsuit for station."
	icon_state = "hardsuit0-medical_rig"
	inhand_icon_state = "hardsuit0-medical_rig"
	hardsuit_type = "medical_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 30, "bomb" = 40, "bio" = 100, "rad" = 70, "fire" = 60, "acid" = 70)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	brightness_on = 1
	on = FALSE
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/medical_rig
	name = "medical hardsuit"
	desc = "New model of medical hardsuit for station."
	alt_desc = "New model of medical hardsuit for station."
	icon_state = "hardsuit0-medical_rig"
	slowdown = 0.5
	inhand_icon_state = "hardsuit0-medical_rig"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	hardsuit_type = "medical_rig"
	w_class = WEIGHT_CLASS_NORMAL
	flags_inv = NONE
	clothing_flags = STOPSPRESSUREDAMAGE
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 30, "bomb" = 40, "bio" = 100, "rad" = 70, "fire" = 60, "acid" = 70)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/medical_rig

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/medical_rig/blue
	icon_state = "hardsuit0-medical_rigalt"
	inhand_icon_state = "hardsuit0-medical_rigalt"
	hardsuit_type = "medical_rigalt"
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'

/obj/item/clothing/glasses/hud/wzzzz/hacker_rig
	name = "хакочки"
	desc = "А ты заслуживаешь это?"
	alt_desc = "Глупая свинья."
	name = "hacker googless"
	desc = "Do you deserve that?"
	alt_desc = "Do you deserve that?"
	icon_state = "hardsuit1-hacker_rig"
	inhand_icon_state = "hardsuit1-hacker_rig"
	darkness_view = 10
	flash_protect = 3
	resistance_flags = NONE
	var/list/datahuds = list(DATA_HUD_SECURITY_ADVANCED, DATA_HUD_DIAGNOSTIC_BASIC)
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	hud_type = DATA_HUD_SECURITY_ADVANCED | DATA_HUD_SECURITY_ADVANCED | DATA_HUD_SECURITY_ADVANCED | DATA_HUD_HACKER
	vision_flags = SEE_MOBS | SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	hud_trait = TRAIT_SECURITY_HUD

/obj/item/clothing/suit/space/wzzzz/hacker_rig
	name = "интересный костюм"
	desc = "А ты заслуживаешь этот костюм?"
	alt_desc = "Глупая свинья."
	name = "hacker suit"
	desc = "Do you deserve this hardsuit?"
	alt_desc = "Do you deserve this hardsuit?"
	icon_state = "hardsuit0-hacker_rig"
	clothing_flags = STOPSPRESSUREDAMAGE
	inhand_icon_state = "hardsuit0-hacker_rig"
	resistance_flags = INDESTRUCTIBLE
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	slowdown = -1
	color = "#00ffff"
	strip_delay = 1300
	armor = list("melee" = 60, "bullet" = 50, "laser" = 100,"energy" = 100, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 50)











/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_engineer_rig
	name = "ert engineer hardsuit helmet"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_engineer_rig"
	inhand_icon_state = "hardsuit0-ert_engineer_rig"
	hardsuit_type = "ert_engineer_rig"
	on = FALSE
	slowdown = 0
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/ert_engineer_rig
	name = "ert engineer hardsuit"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_engineer_rig"
	inhand_icon_state = "hardsuit0-ert_engineer_rig"
	hardsuit_type = "ert_engineer_rig"
	slowdown = 0
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 45, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_engineer_rig



/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_commander_rig
	name = "ert commander hardsuit helmet"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_commander_rig"
	slowdown = 0
	inhand_icon_state = "hardsuit0-ert_commander_rig"
	hardsuit_type = "ert_commander_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/ert_commander_rig
	name = "ert commander hardsuit"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_commander_rig"
	inhand_icon_state = "hardsuit0-ert_commander_rig"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	slowdown = 0
	hardsuit_type = "ert_commander_rig"
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 45, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_commander_rig


/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_security_rig
	name = "ert security hardsuit helmet"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_security_rig"
	inhand_icon_state = "hardsuit0-ert_security_rig"
	slowdown = 0
	hardsuit_type = "ert_security_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	brightness_on = 1
	on = FALSE
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/ert_security_rig
	name = "ert security hardsuit"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_security_rig"
	inhand_icon_state = "hardsuit0-ert_security_rig"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	slowdown = 0
	hardsuit_type = "ert_security_rig"
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 45, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_security_rig




/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_medical_rig
	name = "ert medical hardsuit helmet"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_medical_rig"
	inhand_icon_state = "hardsuit0-ert_medical_rig"
	hardsuit_type = "ert_medical_rig"
	slowdown = 0
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	brightness_on = 1
	on = FALSE
	slowdown = 0
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/ert_medical_rig
	name = "ert medical hardsuit"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	icon_state = "hardsuit0-ert_medical_rig"
	inhand_icon_state = "hardsuit0-ert_medical_rig"
	slowdown = 0
	hardsuit_type = "ert_medical_rig"
	slowdown = 0
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 45, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_medical_rig



/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_janitor_rig
	name = "ert janitor hardsuit helmet"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_janitor_rig"
	slowdown = 0
	inhand_icon_state = "hardsuit0-ert_janitor_rig"
	hardsuit_type = "ert_janitor_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/ert_janitor_rig
	name = "ert janitor hardsuit"
	desc = "Old style of ert hardsuit."
	alt_desc = "Old style of ert hardsuit."
	icon_state = "hardsuit0-ert_janitor_rig"
	inhand_icon_state = "hardsuit0-ert_janitor_rig"
	slowdown = 0
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	hardsuit_type = "ert_janitor_rig"
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 45, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/ert_janitor_rig



/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/skrell_helmet_white
	name = "screll hardsuit helmet"
	desc = "For skrells, for space"
	alt_desc = "For skrells, for space"
	icon_state = "skrell_helmet_white"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "skrell_suit_white"
	hardsuit_type = "skrell_helmet_white"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/skrell_suit_white
	name = "screll hardsuit"
	desc = "For skrells, for space"
	alt_desc = "For skrells, for space"
	icon_state = "skrell_suit_white"
	inhand_icon_state = "skrell_suit_white"
	clothing_flags = STOPSPRESSUREDAMAGE
	slowdown = 0.5
	hardsuit_type = "skrell_suit_white"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 45, "bio" = 50, "rad" = 50, "fire" = 50, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/skrell_helmet_white









/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/eva_rig
	name = "eva hardsuit helmet"
	desc = "New style of EVA hardsuit, more warm and comfortable."
	alt_desc = "New style of EVA hardsuit, more warm and comfortable."
	icon_state = "hardsuit0-eva_rig"
	inhand_icon_state = "hardsuit0-eva_rig"
	hardsuit_type = "eva_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30,"energy" = 30, "bomb" = 40, "bio" = 60, "rad" = 0, "fire" = 40, "acid" = 50)
	flash_protect = 1
	actions_types = list(/datum/action/item_action/toggle_helmet_mode)
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	slowdown = 0.6
	brightness_on = 1
	resistance_flags = NONE|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/eva_rig
	name = "eva hardsuit"
	desc = "New style of EVA hardsuit, more warm and comfortable."
	resistance_flags = NONE|FREEZE_PROOF
	alt_desc = "New style of EVA hardsuit, more warm and comfortable."
	icon_state = "hardsuit0-eva_rig"
	inhand_icon_state = "hardsuit0-eva_rig"
	hardsuit_type = "eva_rig"
	w_class = WEIGHT_CLASS_NORMAL
	slowdown = 0.6
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30,"energy" = 30, "bomb" = 40, "bio" = 60, "rad" = 0, "fire" = 40, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/eva_rig
	cold_protection = 750






/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_atmosalt
	name = "atmospherical hardsuit helmet"
	desc = "New style of atmospherical hardsuit."
	alt_desc = "New style of atmospherical hardsuit."
	icon_state = "rig_atmosalt"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_atmosalt"
	hardsuit_type = "rig_atmosalt"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 25, "fire" = 100, "acid" = 75)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_atmosalt
	name = "atmospherical hardsuit"
	desc = "New style of atmospherical hardsuit."
	alt_desc = "New style of atmospherical hardsuit."
	icon_state = "rig_atmosalt"
	inhand_icon_state = "rig_atmosalt"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	hardsuit_type = "rig_atmosalt"
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	clothing_flags = STOPSPRESSUREDAMAGE
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 25, "fire" = 100, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_atmosalt





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_secalt
	name = "security hardsuit helmet"
	desc = "New style of security hardsuit."
	alt_desc = "New style of security hardsuit."
	icon_state = "rig_secalt"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_secalt"
	hardsuit_type = "rig_secalt"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_secalt
	name = "security hardsuit"
	desc = "New style of security hardsuit."
	alt_desc = "New style of security hardsuit."
	icon_state = "rig_secalt"
	inhand_icon_state = "rig_secalt"
	slowdown = 0.7
	hardsuit_type = "rig_secalt"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_secalt





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_sec
	name = "security hardsuit helmet"
	desc = "New style of security hardsuit."
	alt_desc = "New style of security hardsuit."
	icon_state = "rig_sec"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_sec"
	hardsuit_type = "rig_sec"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 70, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 60, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_sec
	name = "security hardsuit"
	desc = "New style of security hardsuit."
	alt_desc = "New style of security hardsuit."
	icon_state = "rig_sec"
	inhand_icon_state = "rig_sec"
	hardsuit_type = "rig_sec"
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 70, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 60, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_sec
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_medicalalt
	name = "medical hardsuit helmet"
	desc = "New style of medical hardsuit."
	alt_desc = "New style of medical hardsuit."
	icon_state = "rig_medicalalt"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_medicalalt"
	slowdown = 0.5
	hardsuit_type = "rig_medicalalt"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 20, "laser" = 10, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF


/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_medicalalt
	name = "medical hardsuit"
	desc = "New style of medical hardsuit."
	alt_desc = "New style of medical hardsuit."
	icon_state = "rig_medicalalt"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	inhand_icon_state = "rig_medicalalt"
	slowdown = 0.5
	hardsuit_type = "rig_medicalalt"
	w_class = WEIGHT_CLASS_NORMAL
	clothing_flags = STOPSPRESSUREDAMAGE
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 20, "laser" = 10, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_medicalalt





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_salvage
	name = "salvage hardsuit helmet"
	desc = "Salvaged hardsuit."
	alt_desc = "Salvaged hardsuit."
	icon_state = "rig_salvage"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_salvage"
	hardsuit_type = "rig_salvage"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20,"energy" = 10, "bomb" = 50, "bio" = 100, "rad" = 20, "fire" = 70, "acid" = 30)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_salvage
	name = "salvaged hardsuit"
	desc = "Salvaged hardsuit."
	alt_desc = "Salvaged hardsuit."
	icon_state = "rig_salvage"
	inhand_icon_state = "rig_salvage"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	hardsuit_type = "rig_salvage"
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	slowdown = 2
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20,"energy" = 10, "bomb" = 50, "bio" = 100, "rad" = 20, "fire" = 70, "acid" = 30)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_salvage




/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_excavation
	name = "excavation hardsuit helmet"
	desc = "Hardsuit for exploring."
	alt_desc = "Hardsuit for exploring."
	icon_state = "rig_excavation"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_excavation"
	hardsuit_type = "rig_excavation"
	clothing_flags = STOPSPRESSUREDAMAGE
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 10, "rad" = 0, "fire" = 60, "acid" = 50)
	flash_protect = 1
	armor = list(melee = 30, bullet = 20, laser = 35,energy = 20, bomb = 30, bio = 100, rad = 100, fire = 50, acid = 40)
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	slowdown = 0.5
	resistance_flags = NONE|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_excavation
	name = "excavation hardsuit"
	desc = "Hardsuit for exploring."
	alt_desc = "Hardsuit for exploring."
	icon_state = "rig_excavation"
	inhand_icon_state = "rig_excavation"
	hardsuit_type = "rig_excavation"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = NONE|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	jetpack = null
	slowdown = 0.5
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list(melee = 30, bullet = 20, laser = 35,energy = 20, bomb = 30, bio = 100, rad = 100, fire = 50, acid = 40)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_excavation





/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_engineeringalt
	name = "engineer hardsuit helmet"
	desc = "New style of engineer hardsuit."
	alt_desc = "New style of engineer hardsuit."
	slowdown = 0.7
	icon_state = "rig_engineeringalt"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "rig_engineeringalt"
	hardsuit_type = "rig_engineeringalt"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 50, "fire" = 60, "acid" = 50)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_engineeringalt
	name = "engineer hardsuit"
	desc = "New style of engineer hardsuit."
	alt_desc = "New style of engineer hardsuit."
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	icon_state = "rig_engineeringalt"
	inhand_icon_state = "rig_engineeringalt"
	hardsuit_type = "rig_engineeringalt"
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	slowdown = 0.7
	clothing_flags = STOPSPRESSUREDAMAGE
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 50, "fire" = 60, "acid" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_engineeringalt



/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/skrell_helmet_black
	name = "screll hardsuit helmet"
	desc = "For skrells, for space"
	alt_desc = "For skrells, for space"
	icon_state = "skrell_helmet_black"
	var/obj/item/clothing/head/helmet/space/hardsuit/wzzzz/asset_protection = null
	inhand_icon_state = "skrell_suit_black"
	hardsuit_type = "skrell_helmet_black"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 0, "fire" = 50, "acid" = 40)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/skrell_suit_black
	name = "screll hardsuit"
	desc = "For skrells, for space"
	alt_desc = "For skrells, for space"
	icon_state = "skrell_suit_black"
	inhand_icon_state = "skrell_suit_black"
	hardsuit_type = "skrell_suit_black"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	slowdown = 0.5
	jetpack = null
	clothing_flags = STOPSPRESSUREDAMAGE
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 0, "fire" = 50, "acid" = 40)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/skrell_helmet_black

/obj/item/clothing/suit/toggle/wzzzz/hoodie/black
	color = "#404040"

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_secalt_sec
	name = "security hardsuit"
	desc = "New style of security hardsuit."
	alt_desc = "New style of security hardsuit."
	icon_state = "rig_secalt_sec"
	inhand_icon_state = "rig_secalt_sec"
	slowdown = 0.7
	hardsuit_type = "rig_secalt"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_secalt



/obj/item/clothing/head/helmet/space/hardsuit/medical/wzzzz
	name = "paramedical hardsuit helmet"
	icon_state = "hardsuit0-paramedic"
	inhand_icon_state = "hardsuit0_paramedic"
	hardsuit_type = "paramedic"
	icon = 'white/Wzzzz/icons/Ora/ve/hats.dmi'
	worn_icon = 'white/Wzzzz/icons/Ora/li/head.dmi'
	armor = list("melee" = 35, "bullet" = 15, "laser" = 15, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SCAN_REAGENTS | SNUG_FIT

/obj/item/clothing/suit/space/hardsuit/medical/wzzzz
	name = "paramedical hardsuit"
	icon_state = "hardsuit_paramedic"
	inhand_icon_state = "hardsuit_paramedic"
	icon = 'white/Wzzzz/icons/Ora/ve/suits.dmi'
	worn_icon = 'white/Wzzzz/icons/Ora/li/suits.dmi'
	armor = list("melee" = 35, "bullet" = 15, "laser" = 15, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/medical/wzzzz
	slowdown = 0.5

/obj/item/clothing/suit/wizrobe/wzzzz/battlemage
	icon_state = "battlemage"
	inhand_icon_state = "battlemage"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	slowdown = 0.7
	clothing_flags = STOPSPRESSUREDAMAGE
	icon = 'white/Wzzzz/icons/Ora/ve/suits.dmi'
	worn_icon = 'white/Wzzzz/icons/Ora/li/suits.dmi'
	resistance_flags = NONE|ACID_PROOF|INDESTRUCTIBLE|UNACIDABLE|FIRE_PROOF|FREEZE_PROOF|LAVA_PROOF
	armor = list("melee" = 80, "bullet" = 60, "laser" = 70,"energy" = 80, "bomb" = 90, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100, "magic" = 75)

/mob/living/simple_animal/hostile/pirate/ranged/space/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/pirate/melee/space/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/russian/ranged/officer/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/russian/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/russian/ranged/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/syndicate/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/syndicate/melee/sword/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/syndicate/melee/sword/space/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/syndicate/ranged/smg/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/syndicate/ranged/smg/space/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

//mob/living/simple_animal/hostile/syndicate/ranged/shotgun/space/stormtrooper/wzzzz
//	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'

/mob/living/simple_animal/hostile/faithless/wzzzz
	icon = 'white/Wzzzz/icons/Ora/li/simple_human.dmi'
	maxHealth = 100
	melee_damage_lower = 20
	melee_damage_upper = 20
	unsuitable_atmos_damage = 5
	harm_intent_damage = 15

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/pilot_helm
	name = "pilot hardsuit helmet"
	desc = "For space pilots."
	alt_desc = "For space pilots."
	icon_state = "pilot_helm"
	inhand_icon_state = "pilot_helm"
	hardsuit_type = "pilot"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 10, "fire" = 70, "acid" = 60)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/pilot
	name = "pilot hardsuit"
	desc = "For space pilots."
	alt_desc = "For space pilots."
	icon_state = "pilot"
	inhand_icon_state = "pilot"
	slowdown = 0.7
	hardsuit_type = "pilot"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 30, "bio" = 100, "rad" = 10, "fire" = 70, "acid" = 60)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/pilot_helm

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/helm_explorer
	name = "explorer void suit helmet"
	desc = "For space explorers."
	alt_desc = "For space explorers."
	icon_state = "helm_explorer"
	inhand_icon_state = "helm_explorer"
	hardsuit_type = "pilot"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 35, "bio" = 100, "rad" = 90, "fire" = 80, "acid" = 80)
	flash_protect = 2
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/void_explorer
	name = "explorer void suit"
	desc = "For space explorers."
	alt_desc = "For space explorers."
	icon_state = "void_explorer"
	inhand_icon_state = "void_explorer"
	slowdown = 0.8
	hardsuit_type = "void_explorer"
	resistance_flags = NONE|FIRE_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 35, "bio" = 100, "rad" = 90, "fire" = 80, "acid" = 80)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/helm_explorer

/obj/machinery/vending/wzzzz/dude
	payment_department = null
	name = "Great feast"
	desc = "Only you can stop evil."
	slogan_delay = 25000
	max_integrity = 750
	icon_state = "dude"
	product_slogans = "The earth is hungry, its heart shrinks and demands purification, the earth is thirsty.;Be blessed, the humble, for they are a convenient target.;The air smells of death and decay, the smell of victory.;Life is cheap, death is free. Hurry up, the offer is limited.;I will put the mutilated organs of my enemies on my head like a hat, and tie their guts like a tie. Oh, how good my dance will be.;Human garbage seeps through the clutching fingers of death.;Blood spatter everywhere. Like a river that flows around me and drags me into its flow.;The smell of dark skin seeps into my nostrils, followed by the smell of death. The human remains are stuck to my clothes like jewelry, and I'm still walking on bones, knee-deep in blood and guts.;Enjoy the frozen excrement of death machines relentlessly grinding flesh...;Who said they had fallen and could not be brought back to the right path?"
	product_ads = "The earth is hungry, its heart shrinks and demands purification, the earth is thirsty.;Be blessed, the humble, for they are a convenient target.;The air smells of death and decay, the smell of victory.;Life is cheap, death is free. Hurry up, the offer is limited.;I will put the mutilated organs of my enemies on my head like a hat, and tie their guts like a tie. Oh, how good my dance will be.;Human garbage seeps through the clutching fingers of death.;Blood spatter everywhere. Like a river that flows around me and drags me into its flow.;The smell of dark skin seeps into my nostrils, followed by the smell of death. The human remains are stuck to my clothes like jewelry, and I'm still walking on bones, knee-deep in blood and guts.;Enjoy the frozen excrement of death machines relentlessly grinding flesh...;Who said they had fallen and could not be brought back to the right path?"
	vend_reply = "Only my weapon undersrand me."
	circuit = /obj/item/circuitboard/machine/vending/donksofttoyvendor/wzzzz/dude
	resistance_flags = NONE|ACID_PROOF|FIRE_PROOF|FREEZE_PROOF
	icon = 'white/Wzzzz/icons/vera.dmi'
	armor = list("melee" = 30, "bullet" = 20, "laser" = 10, "energy" = 0, "bomb" = 30, "bio" = 30, "rad" = 0, "fire" = 80, "acid" = 50)
	refill_canister = /obj/item/vending_refill/custom
	default_price = 0
	extra_price = 0
	refill_canister = /obj/item/vending_refill/wzzzz/dude
	products = list(
		/obj/item/grenade/chem_grenade/incendiary = 1.#INF,
		/obj/item/kitchen/knife/free = 1.#INF,
		/obj/item/kitchen/knife/butcher/free = 1.#INF,
		/obj/item/kitchen/knife/wzzzz/german = 1.#INF,
		/obj/item/restraints/legcuffs/bola/tactical = 1.#INF,
		/obj/item/restraints/legcuffs/bola = 1.#INF,
		/obj/item/twohanded/required/chainsaw = 1.#INF,
		/obj/item/storage/belt/bandolier = 1.#INF,
		/obj/item/storage/backpack/fireproof = 1.#INF,
		/obj/item/clothing/shoes/jackboots = 1.#INF,
		/obj/item/clothing/glasses/sunglasses = 1.#INF,
		/obj/item/clothing/suit/jacket/leather/overcoat = 1.#INF,
		/obj/item/storage/pill_bottle/happy = 1.#INF,
		/obj/item/stack/medical/gauze/improvised/free = 1.#INF,
		/obj/item/storage/firstaid/advanced = 1.#INF,
		/obj/item/ammo_casing/shotgun/improvised = 1.#INF,
		/obj/item/gun/ballistic/shotgun/doublebarrel/improvised = 1.#INF,
		/obj/item/ammo_box/a357 = 1.#INF,
		/obj/item/gun/ballistic/revolver/mateba = 1.#INF,
		/obj/item/tank/internals/plasma/full = 1.#INF,
		/obj/item/flamethrower = 1.#INF,
		/obj/item/ammo_box/magazine/ak47mag = 1.#INF,
		/obj/item/gun/ballistic/automatic/ak47 = 1.#INF,
		/obj/item/gun/ballistic/crossbow/improv = 1.#INF,
		/obj/item/stack/rods/twentyfive = 1.#INF,
		/obj/item/gun/ballistic/crossbow = 1.#INF,
		/obj/item/grenade/iedcasing = 1.#INF,
		/obj/item/grenade/frag = 1.#INF,
		/obj/item/grenade/c4/x4 = 1.#INF,
		/obj/item/spear = 1.#INF,
		/obj/item/gun/ballistic/automatic/wt550/wzzzz/german = 1.#INF,
		/obj/item/gun/ballistic/shotgun/doublebarrel = 1.#INF,
		/obj/item/ammo_casing/caseless/rocket = 1.#INF,
		/obj/item/ammo_casing/caseless/rocket/hedp = 1.#INF,
		/obj/item/gun/ballistic/rocketlauncher/unrestricted = 1.#INF,
		/obj/item/ammo_box/magazine/wt550m9/wzzzz/mc9mmt = 1.#INF,
		/obj/item/restraints/legcuffs/beartrap = 1.#INF,
		/obj/item/grenade/c4 = 1.#INF,
		/obj/item/storage/box/lethalshot = 1.#INF,
		/obj/item/ammo_box/magazine/m12g = 1.#INF,
		/obj/item/gun/ballistic/shotgun/bulldog/unrestricted = 1.#INF,
		/obj/item/spear/explosive/wzzzz = 1.#INF,
		/obj/item/gun/ballistic/automatic/tommygun = 1.#INF,
		/obj/item/ammo_box/magazine/tommygunm45 = 1.#INF,
		/obj/item/gun/ballistic/shotgun/lethal = 1.#INF,
		/obj/item/ammo_box/magazine/uzim9mm = 1.#INF,
		/obj/item/gun/ballistic/automatic/mini_uzi = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/aps = 1.#INF,
		/obj/item/ammo_box/magazine/m9mm = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/makarov = 1.#INF,
		/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted = 1.#INF,
		/obj/item/ammo_box/a40mm = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/tanner = 1.#INF,
		/obj/item/ammo_box/magazine/m10mm = 1.#INF,
		/obj/item/switchblade = 1.#INF,
		/obj/item/lighter/greyscale/free = 1.#INF,
		/obj/item/kitchen/knife/butcher/wzzzz/machete = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/assault_rifle = 1.#INF,
		/obj/item/gun/ballistic/automatic/wzzzz/assault_rifle = 1.#INF,
		/obj/item/storage/pill_bottle/wzzzz/soldier = 1.#INF,
		/obj/item/clothing/mask/gas/wzzzz/germanfull = 1.#INF,
		/obj/item/clothing/suit/armor/vest/leather/wzzzz/tailcoat/black = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/wzzzz/mauser = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/mauser/battle = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/wzzzz/luger = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/luger/battle = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1.#INF,
		/obj/item/ammo_box/magazine/m45 = 1.#INF,
		/obj/item/gun/ballistic/automatic/pistol/deagle = 1.#INF,
		/obj/item/ammo_box/magazine/m50 = 1.#INF,
		/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k/scope = 1.#INF,
		/obj/item/gun/ballistic/rifle/boltaction/wzzzz/kar98k = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/a792x57 = 1.#INF,
		/obj/item/gun/ballistic/automatic/c20r/unrestricted = 1.#INF,
		/obj/item/ammo_box/magazine/smgm45 = 1.#INF,
		/obj/item/gun/ballistic/automatic/gyropistol = 1.#INF,
		/obj/item/ammo_box/magazine/m75 = 1.#INF,
		/obj/item/gun/ballistic/automatic/surplus = 1.#INF,
		/obj/item/ammo_box/magazine/m10mm/rifle = 1.#INF,
		/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/wzzzz/mg34 = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/a762d = 1.#INF,
		/obj/item/gun/ballistic/automatic/l6_saw/unrestricted = 1.#INF,
		/obj/item/ammo_box/magazine/mm712x82 = 1.#INF,
		/obj/item/gun/ballistic/automatic/ar = 1.#INF,
		/obj/item/ammo_box/magazine/m556 = 1.#INF,
		/obj/item/gun/ballistic/automatic/ar/wzzzz = 1.#INF,
		/obj/item/ammo_box/magazine/m556/arg/wzzzz = 1.#INF,
		/obj/item/gun/ballistic/automatic/m90/unrestricted = 1.#INF,
		/obj/item/ammo_box/magazine/m556 = 1.#INF,
		/obj/item/gun/ballistic/automatic/proto/unrestricted = 1.#INF,
		/obj/item/ammo_box/magazine/smgm9mm = 1.#INF,
		/obj/item/gun/ballistic/automatic/wzzzz/mp40 = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/mp40 = 1.#INF,
		/obj/item/gun/ballistic/automatic/wzzzz/g43 = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/g43 = 1.#INF,
		/obj/item/gun/ballistic/automatic/wzzzz/stg = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/stg = 1.#INF,
		/obj/item/gun/ballistic/shotgun/automatic/combat = 1.#INF,
		/obj/item/gun/ballistic/shotgun/doublebarrel/hook = 1.#INF,
		/obj/item/gun/ballistic/shotgun/sniper = 1.#INF,
		/obj/item/gun/ballistic/shotgun/automatic/dual_tube = 1.#INF,
		/obj/item/ammo_box/magazine/m12g/slug = 1.#INF,
		/obj/item/ammo_box/magazine/m12g/dragon = 1.#INF,
		/obj/item/gun/ballistic/rifle/boltaction = 1.#INF,
		/obj/item/clothing/suit/armor/vest = 1.#INF,
		/obj/item/clothing/suit/armor/wzzzz/opvest = 1.#INF,
		/obj/item/clothing/under/wzzzz/victorian/vest/black = 1.#INF,
		/obj/item/clothing/suit/hooded/chaplainsuit/wzzzz/star_traitor = 1.#INF,
		/obj/item/clothing/shoes/jackboots/wzzzz/fiendshoes = 1.#INF,
		/obj/item/clothing/suit/hooded/chaplainsuit/wzzzz/fiendcowl = 1.#INF,
		/obj/item/clothing/under/syndicate/wzzzz/fiendsuit = 1.#INF,
		/obj/item/shovel = 1.#INF,
		/obj/item/shovel/serrated = 1.#INF,
		/obj/item/pickaxe = 1.#INF,
		/obj/item/fireaxe = 1.#INF,
		/obj/item/melee/sabre/wzzzz/german = 1.#INF,
		/obj/item/melee/wzzzz/club = 1.#INF,
		/obj/item/melee/classic_baton/wzzzz/german = 1.#INF,
		/obj/item/melee/sabre/wzzzz/marine = 1.#INF,
		/obj/item/gun/ballistic/automatic/ar/wzzzz/fg42 = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/fg42 = 1.#INF,
		/obj/item/gun/ballistic/automatic/m90/unrestricted/wzzzz/z8 = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/a556carbine = 1.#INF,
		/obj/item/gun/ballistic/automatic/wzzzz/carbine = 1.#INF,
		/obj/item/ammo_box/magazine/wzzzz/carbine = 1.#INF,
		/obj/item/suppressor = 1.#INF,
		/obj/item/clothing/suit/armor/vest/wzzzz/german/webvest = 1.#INF,
		/obj/item/clothing/suit/armor/vest/wzzzz/german/mercwebvest = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/Kar98 = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/STG = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/MP40 = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/G43 = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/FG42 = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/AK47 = 1.#INF,
		/obj/item/storage/toolbox/ammo/wzzzz/WT550 = 1.#INF,
		/obj/item/clothing/head/helmet/space/eva/wzzzz/black = 1.#INF)
	contraband = list(/obj/item/clothing/suit/armor/vest/wzzzz/swatarmor_german/grey = 1.#INF)

/obj/item/vending_refill/wzzzz/dude
	machine_name = "Great feast"
	icon_state = "refill_dude"
	icon = 'white/Wzzzz/icons/vera.dmi'

/obj/item/circuitboard/machine/vending/donksofttoyvendor/wzzzz/dude
	name = "Thirsty circuitboard"
	desc = "The earth is hungry, its heart shrinks and demands purification, the earth is thirsty."

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_secb
	name = "security hardsuit helmet"
	desc = "For space security."
	alt_desc = "For space security."
	icon_state = "sec_helm1"
	inhand_icon_state = "sec_helm1"
	hardsuit_type = "rig_sec1"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	flash_protect = 1
	actions_types = null
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 1
	resistance_flags = NONE|FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/rig_secb
	name = "security hardsuit"
	desc = "For space security."
	alt_desc = "For space security."
	icon_state = "rig_sec1"
	inhand_icon_state = "rig_sec1"
	slowdown = 0.7
	hardsuit_type = "pilot"
	resistance_flags = NONE|FIRE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/rig_secb

/obj/item/reagent_containers/food/drinks/bottle/molotov/wzzzz
	reagents = list(/datum/reagent/napalm = 100)

/obj/item/spear/explosive/wzzzz
	explosive = /obj/item/grenade/frag

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/null
	name = "hardsuit helmet"
	desc = "Just hardsuit helmet."
	alt_desc = "Just hardsuit helmet."
	icon_state = "hardsuit0-null_rig"
	inhand_icon_state = "hardsuit0-null_rig"
	hardsuit_type = "null_rig"
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hardhead.dmi'
	icon = 'white/Wzzzz/icons/clothing/clothing/hardhead.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	flash_protect = 1
	clothing_flags = STOPSPRESSUREDAMAGE
	on = FALSE
	brightness_on = 4
	resistance_flags = NONE|FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/null
	name = "hardsuit"
	desc = "Just hardsuit."
	alt_desc = "Just hardsuit."
	slowdown = 0.7
	hardsuit_type = "null_rig"
	resistance_flags = NONE|FIRE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "hardsuit0-null_rig"
	inhand_icon_state = "hardsuit0-null_rig"
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/null

/obj/item/clothing/suit/space/hardsuit/syndi/elite/wzzzz/null_f
	name = "hardsuit"
	desc = "Just hardsuit."
	alt_desc = "Just hardsuit."
	slowdown = 0.7
	hardsuit_type = "null_rig_f"
	resistance_flags = NONE|FIRE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "hardsuit0-null_rig_f"
	inhand_icon_state = "hardsuit0-null_rig_f"
	jetpack = null
	icon = 'white/Wzzzz/icons/clothing/clothing/hard.dmi'
	worn_icon = 'white/Wzzzz/icons/clothing/mob1/hard.dmi'
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 30, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 85)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/wzzzz/null

/obj/item/kitchen/knife/free
	custom_price = 0

/obj/item/kitchen/knife/butcher/free
	custom_price = 0

/obj/item/lighter/greyscale/free
	custom_price = 0

/obj/item/stack/medical/gauze/improvised/free
	custom_price = 0
