/obj/item/gun/ballistic/shotgun/makeshift
	var/debug
	var/jammed = FALSE
	var/jamchance
	var/time_to_unjam
	name = "Captain's bane"
	desc = "Гротескное изделие явно кустарного производства. Выглядит слегка ненадежно."
	icon = 'white/hule/icons/obj/weapons.dmi'
	icon_state = "smshotgun"
	inhand_icon_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_MEDIUM
	mag_type = /obj/item/ammo_box/magazine/makeshift
	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	can_suppress = FALSE
	pin = /obj/item/firing_pin
	burst_size = 1
	fire_delay = 1
	internal_magazine = FALSE
	spawnwithmagazine = FALSE
	mag_display = TRUE


//legendary ass wipes
/obj/item/gun/ballistic/shotgun/makeshift/Initialize()
	. = ..()
	jamchance = rand(5,25) //TODO: золотой ореол вокруг дробовиков с шансом клина 5 процентов
	update_icon()
	if(debug == 1)
		name = "Chad " + name //чтобы не переделывать инишиалайз прок с нуля, включая всё то, что есть в ..().
		jamchance = 0         //я за то, чтобы ржака присутствовала даже в дебаг вещах.
		return
	if(debug == 2)
		name = "Virgin " + name
	if(jamchance <= 5)
		jamchance = 80
		name = "Legendary "+ name
		return
	if(jamchance <= 10)
		name = "Epic "+ name
		return
	if(jamchance <= 20)
		name = "Rare "+ name
		return
	if(prob(50))
		name = pick("Common ","Uncommon ","Shit ", "Bad ", "Regular ", "Crap")+ name


/*
//не ебу, зачем было переделывать этот прок, если он уже имел весь необходимый функционал. сэкономить пару if-блоков? meh
obj/item/gun/ballistic/shotgun/makeshift/update_icon()
	cut_overlays()
	if(magazine)
		add_overlay("[magazine.icon_state]")
	icon_state = "smshotgun"

*/

/obj/item/gun/ballistic/shotgun/makeshift/examine()
	. = ..()
	switch(jamchance)
		if(5 to 10)
			.+= "Сделано настолько искуссно, насколько позволяют подручные средства."
		if(11 to 15)
			.+= "Сделано не хорошо, но и не плохо."
		if(16 to 25)
			.+= "Оставляет желать лучшего."
		if(26 to 30)
			.+= "Из него было совершено пару выстрелов."
		if(31 to 40)
			.+= "Кое-что болтается, но им всё ещё можно стрелять."
		if(41 to 50)
			.+= "Имеет смысл задуматься о новом дробовике."
		if(51 to 60)
			.+= "Кое-что болтается. Очень много кое-чего."
		if(61 to 70)
			.+= "Металлолом."
		if (71 to 80)
			.+= "Проще забить руками."
		if(81 to INFINITY)
			.+= "Вас кто-то очень сильно недолюбливает." //admemes


/obj/item/gun/ballistic/shotgun/makeshift/afterattack()
	..()
	if(prob(jamchance) && !jammed)
		jammed = TRUE
		time_to_unjam = rand(jamchance,50+jamchance) //низкий jamchance даёт меньшее минимальное время для починки
		to_chat(usr, "<span class='warning'>[src] malfunctions!</span>")

/obj/item/gun/ballistic/shotgun/makeshift/can_shoot()
	.=..()
	if(jammed)
		playsound(src, "gun_dry_fire", 30, 1)
		to_chat(usr, "<span class='warning'>The [src] is jammed and won't shoot until fixed with a screwdriver.</span>")
		return FALSE



/obj/item/gun/ballistic/shotgun/makeshift/attackby(obj/item/A, mob/user, params)
	..()

	if(istype(A, /obj/item/screwdriver))
		if(magazine)
			to_chat(user, "<span class='warning'>Take out the magazine first!</span>")
			return

		user.visible_message("<span class='notice'>[user] fiddles with the [src]...</span>", "<span class='notice'>You to unjam the [src]...</span>")

		if(do_after(user, time_to_unjam, 1, target = src, progress = 1, extra_checks = null))
			jammed = FALSE

			//рандом дохуя
			if(prob(35))
				var/damaged = rand(1,10)
				var/damage_desc
				var/class
				switch(damaged)
					if(1,2)
						damage_desc = "scratching it a bit"
						class = "notice"
						if(prob(50))
							return
					if(3,4)
						damage_desc = "damaging it"
						class = "warning"
					if(5 to 7)
						damage_desc = "severely damaging it"
						class = "warning"
					if(8 to 10)
						damage_desc = "almost breaking it"
						class = "warning"
						if(prob(50))
							damaged *=2
				jamchance = min(jamchance += damaged,80)
				to_chat(usr, "<span class='[class]'>You manage to unjam the [src], [damage_desc] in the progress.</span>")
			else
				to_chat(usr, "<span class='notice'>You unjam the [src].</span>")

/obj/item/gun/ballistic/shotgun/makeshift/chad
	debug = 1

/obj/item/gun/ballistic/shotgun/makeshift/virgin
	debug = 2


/obj/item/ammo_box/magazine/makeshift
	name = "shotgun magazine"
	desc = "A shotgun magazine."
	icon = 'white/hule/icons/obj/weapons.dmi'
	icon_state = "smshotgun_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "shotgun"
	max_ammo = 4
	start_empty = TRUE

/obj/item/ammo_box/magazine/makeshift/chad
	start_empty = FALSE
	max_ammo = 1488
	ammo_type = /obj/item/ammo_casing/shotgun/bombslug //лимиткострел
