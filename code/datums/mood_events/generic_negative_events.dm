/datum/mood_event/handcuffed
	description = "<span class='warning'>Кажется мои выходки кто-то заметил.</span>\n"
	mood_change = -1

/datum/mood_event/broken_vow //Used for when mimes break their vow of silence
  description = "<span class='boldwarning'>Моё имя было опозорено нарушением моего обета...</span>\n"
  mood_change = -8

/datum/mood_event/on_fire
	description = "<span class='boldwarning'>Я ГОРЮ!!!/span>\n"
	mood_change = -12

/datum/mood_event/suffocation
	description = "<span class='boldwarning'>НЕ.. МОГУ... ДЫШАТЬ...</span>\n"
	mood_change = -12

/datum/mood_event/burnt_thumb
	description = "<span class='warning'>Не стоило мне играть с зажигалкой.</span>\n"
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/cold
	description = "<span class='warning'>Тут очень холодно.</span>\n"
	mood_change = -5

/datum/mood_event/hot
	description = "<span class='warning'>Становится жарковато.</span>\n"
	mood_change = -5

/datum/mood_event/creampie
	description = "<span class='warning'>Меня окремили. На вкус как пирог.</span>\n"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/pooed
	description = "<span class='warning'>Меня обмазали говном. На вкус как говно.</span>\n"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/slipped
	description = "<span class='warning'>Опять подскальзываюсь. Надо быть аккуратней.</span>\n"
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/eye_stab
	description = "<span class='boldwarning'>I used to be an adventurer like you, until I took a screwdriver to the eye.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/delam //SM delamination
	description = "<span class='boldwarning'>Эти инженеры никогда не могут что-то сделать нормально...</span>\n"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/depression_minimal
	description = "<span class='warning'>Мне немного грустно.</span>\n"
	mood_change = -10
	timeout = 2 MINUTES

/datum/mood_event/depression_mild
	description = "<span class='warning'>Мне грустно без каких-либо причин.</span>\n"
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/depression_moderate
	description = "<span class='warning'>Мне грустно.</span>\n"
	mood_change = -14
	timeout = 2 MINUTES

/datum/mood_event/depression_severe
	description = "<span class='warning'>Хочу умереть.</span>\n"
	mood_change = -16
	timeout = 2 MINUTES

/datum/mood_event/shameful_suicide //suicide_acts that return SHAME, like sord
  description = "<span class='boldwarning'>Я даже не могу покончить со всем этим!</span>\n"
  mood_change = -15
  timeout = 60 SECONDS

/datum/mood_event/dismembered
  description = "<span class='boldwarning'>АА-А! МНЕ НУЖНА БЫЛА ЭТА КОНЕЧНОСТЬ!</span>\n"
  mood_change = -10
  timeout = 8 MINUTES

/datum/mood_event/tased
	description = "<span class='warning'>There's no \"z\" in \"taser\". It's in the zap.</span>\n"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/embedded
	description = "<span class='boldwarning'>Достаньте это из меня, достаньте!</span>\n"
	mood_change = -7

/datum/mood_event/table
	description = "<span class='warning'>Кто-то бросил меня на стол!</span>\n"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/table/add_effects()
	if(isfelinid(owner))
		var/mob/living/carbon/human/H = owner
		H.dna.species.start_wagging_tail(H)
		addtimer(CALLBACK(H.dna.species, /datum/species.proc/stop_wagging_tail, H), 30)
		description =  "<span class='nicegreen'>Со мной хотят поиграться на столе!</span>\n"
		mood_change = 2

/datum/mood_event/table_limbsmash
	description = "<span class='warning'>Моя голова... Больно блять...</span>\n"
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/table_limbsmash/add_effects(obj/item/bodypart/banged_limb)
	if(banged_limb)
		description = "<span class='warning'>My fucking [banged_limb.name], man that hurts...</span>\n"

/datum/mood_event/brain_damage
  mood_change = -3

/datum/mood_event/brain_damage/add_effects()
  var/damage_message = pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")
  description = "<span class='warning'>Хых... Хах... [damage_message]</span>\n"

/datum/mood_event/hulk //Entire duration of having the hulk mutation
  description = "<span class='warning'>ХАЛК БИТЬ!</span>\n"
  mood_change = -4

/datum/mood_event/epilepsy //Only when the mutation causes a seizure
  description = "<span class='warning'>Стоило обратить внимание на предупреждение об эпилепсии.</span>\n"
  mood_change = -3
  timeout = 5 MINUTES

/datum/mood_event/nyctophobia
	description = "<span class='warning'>Здесь темновато...</span>\n"
	mood_change = -3

/datum/mood_event/family_heirloom_missing
	description = "<span class='warning'>Я скучаю по моей семейной реликвии...</span>\n"
	mood_change = -4

/datum/mood_event/healsbadman
	description = "<span class='warning'>Меня держит тонкая нить, и у меня ощущение, что я могу развалиться в любой момент!</span>\n"
	mood_change = -4
	timeout = 2 MINUTES

/datum/mood_event/jittery
	description = "<span class='warning'>Я нервничаю, нервничаю и не могу стоять ровно!</span>\n"
	mood_change = -2

/datum/mood_event/vomit
	description = "<span class='warning'>Меня только что вырвало. Мерзость.</span>\n"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/vomitself
	description = "<span class='warning'>Меня только что стошнило на себя. Это отвратительно.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/painful_medicine
	description = "<span class='warning'>Медицина может быть и хороша для меня, но сейчас она адово жалит!</span>\n"
	mood_change = -5
	timeout = 60 SECONDS

/datum/mood_event/spooked
	description = "<span class='warning'>Дребезжание тех костей... Я не могу это забыть.</span>\n"
	mood_change = -4
	timeout = 4 MINUTES

/datum/mood_event/loud_gong
	description = "<span class='warning'>Этот гонг и правда очень громок!</span>\n"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/notcreeping
	description = "<span class='warning'>Голоса не рады тому, что я не выполняю своё задание, и они болезненно заставляют мои мысли выполнять его.</span>\n"
	mood_change = -6
	timeout = 30
	hidden = TRUE

/datum/mood_event/notcreepingsevere//not hidden since it's so severe
	description = "<span class='boldwarning'>ОНИИИ ХОТЯЯЯТ ЕГООО!!</span>\n"
	mood_change = -30
	timeout = 30

/datum/mood_event/notcreepingsevere/add_effects(name)
	var/list/unstable = list(name)
	for(var/i in 1 to rand(3,5))
		unstable += copytext_char(name, -1)
	var/unhinged = uppertext(unstable.Join(""))//example Tinea Luxor > TINEA LUXORRRR (with randomness in how long that slur is)
	description = "<span class='boldwarning'>ОНИИИ ХОТЯЯЯТ [unhinged]!!</span>\n"

/datum/mood_event/sapped
	description = "<span class='boldwarning'>Необъяснимая печаль пожирает меня...</span>\n"
	mood_change = -15
	timeout = 90 SECONDS

/datum/mood_event/back_pain
	description = "<span class='boldwarning'>Сумки никогда не сидят ровно на моей спине, это очень больно!</span>\n"
	mood_change = -15

/datum/mood_event/sad_empath
	description = "<span class='warning'>Кто-то видимо грустит...</span>\n"
	mood_change = -1
	timeout = 60 SECONDS

/datum/mood_event/sad_empath/add_effects(mob/sadtarget)
	description = "<span class='warning'>[sadtarget.name] кажется грустит...</span>\n"

/datum/mood_event/sacrifice_bad
	description ="<span class='warning'>Эти чёртовы дикари!</span>\n"
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/artbad
	description = "<span class='warning'>У меня получалось и лучше чем это.</span>\n"
	mood_change = -2
	timeout = 1200

/datum/mood_event/graverobbing
	description ="<span class='boldwarning'>I just desecrated someone's grave... I can't believe I did that...</span>\n"
	mood_change = -8
	timeout = 3 MINUTES

/datum/mood_event/deaths_door
	description = "<span class='boldwarning'>This is it... I'm really going to die.</span>\n"
	mood_change = -20

/datum/mood_event/gunpoint
	description = "<span class='boldwarning'>This guy is insane! I better be careful....</span>\n"
	mood_change = -10

/datum/mood_event/tripped
	description = "<span class='boldwarning'>I can't believe I fell for the oldest trick in the book!</span>\n"
	mood_change = -10
	timeout = 2 MINUTES

/datum/mood_event/untied
	description = "<span class='boldwarning'>I hate when my shoes come untied!</span>\n"
	mood_change = -5
	timeout = 1 MINUTES

/datum/mood_event/gates_of_mansus
	description = "<span class='boldwarning'>LIVING IN A PERFORMANCE IS WORSE THAN DEATH</span>\n"
	mood_change = -25
	timeout = 4 MINUTES

//These are unused so far but I want to remember them to use them later
/datum/mood_event/surgery
	description = "<span class='boldwarning'>МЕНЯ РЕЖУТ НА КУСОЧКИ!!</span>\n"
	mood_change = -8

/datum/mood_event/nanite_sadness
	description = "<span class='warning robot'>+++++++HAPPINESS SUPPRESSION+++++++</span>\n"
	mood_change = -7

/datum/mood_event/nanite_sadness/add_effects(message)
	description = "<span class='warning robot'>+++++++[message]+++++++</span>\n"

/datum/mood_event/bald
	description ="<span class='warning'>I need something to cover my head...</span>\n"
	mood_change = -3
