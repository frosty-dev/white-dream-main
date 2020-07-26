/datum/bounty/item/slime
	reward = 3000

/datum/bounty/item/slime/New()
	..()
	description = "РД НТ охотится за редким и экзотическим [name]. За это было предложено вознаграждение."
	reward += rand(0, 4) * 500

/datum/bounty/item/slime/green
	name = "Экстракт зелёного слайма"
	wanted_types = list(/obj/item/slime_extract/green)

/datum/bounty/item/slime/pink
	name = "Экстракт розового слайма"
	wanted_types = list(/obj/item/slime_extract/pink)

/datum/bounty/item/slime/gold
	name = "Экстракт золотого слайма"
	wanted_types = list(/obj/item/slime_extract/gold)

/datum/bounty/item/slime/oil
	name = "Экстракт масляного слайма"
	wanted_types = list(/obj/item/slime_extract/oil)

/datum/bounty/item/slime/black
	name = "Экстракт чёрного слайма"
	wanted_types = list(/obj/item/slime_extract/black)

/datum/bounty/item/slime/lightpink
	name = "Экстракт светло-розового слайма"
	wanted_types = list(/obj/item/slime_extract/lightpink)

/datum/bounty/item/slime/adamantine
	name = "Экстракт адамантиновго слайма"
	wanted_types = list(/obj/item/slime_extract/adamantine)

/datum/bounty/item/slime/rainbow
	name = "Экстракт радужного слайма"
	wanted_types = list(/obj/item/slime_extract/rainbow)
