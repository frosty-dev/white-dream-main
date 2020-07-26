//max channel is 1024. Only go lower from here, because byond tends to pick the first availiable channel to play sounds on
#define CHANNEL_LOBBYMUSIC 1024
#define CHANNEL_ADMIN 1023
#define CHANNEL_VOX 1022
#define CHANNEL_JUKEBOX 1021
#define CHANNEL_JUSTICAR_ARK 1020
#define CHANNEL_HEARTBEAT 1019 //sound channel for heartbeats
#define CHANNEL_AMBIENCE 1018
#define CHANNEL_BUZZ 1017
#define CHANNEL_BICYCLE 1016
#define CHANNEL_CUSTOM_JUKEBOX 1015
#define CHANNEL_TTS_ANNOUNCER 1014
#define CHANNEL_BATTLETENSION 1013
//THIS SHOULD ALWAYS BE THE LOWEST ONE!
//KEEP IT UPDATED

#define CHANNEL_TTS_AVAILABLE 1012
#define CHANNEL_BOOMBOX_AVAILABLE 800
#define CHANNEL_HIGHEST_AVAILABLE 780


#define SOUND_MINIMUM_PRESSURE 10
#define FALLOFF_SOUNDS 1


//Ambience types

#define GENERIC list(	  'sound/ambience/white/ambi4.ogg',\
						  'sound/ambience/white/ambi5.ogg',\
						  'sound/ambience/white/ambi6.ogg',\
					 	  'sound/ambience/white/ambi7.ogg',\
						  'sound/ambience/white/ambi8.ogg',\
						  'sound/ambience/white/ambi9.ogg',\
					 	  'sound/ambience/white/ambi10.ogg',\
						  'sound/ambience/white/ambi12.ogg',\
						  'white/valtos/sounds/prison/amb8.ogg')

#define HOLY list(		  'sound/ambience/white/ambichurch1.ogg')

#define HIGHSEC list(	  'sound/ambience/white/ambidanger1.ogg',\
						  'sound/ambience/white/ambidanger2.ogg',\
						  'sound/ambience/white/ambidanger3.ogg')

#define RUINS list(		  'sound/ambience/white/ambidanger1.ogg',\
						  'sound/ambience/white/ambidanger2.ogg',\
						  'sound/ambience/white/ambi1.ogg',\
						  'sound/ambience/white/ambi2.ogg',\
						  'sound/ambience/white/ambi3.ogg')

#define ENGINEERING list( 'sound/ambience/white/ambieng1.ogg',\
						  'sound/ambience/white/ambidanger2.ogg')

#define MINING list(	  'sound/ambience/white/ambidanger1.ogg',\
						  'sound/ambience/white/ambidanger2.ogg',\
						  'sound/ambience/white/ambi12.ogg',\
						  'white/valtos/sounds/prison/amb6.ogg')

#define MEDICAL list(	  'sound/ambience/white/ambimed1.ogg')

#define SPOOKY list(	  'sound/ambience/white/ambimo1.ogg',\
						  'white/valtos/sounds/prison/amb7.ogg')

#define SPACE list(		  'sound/ambience/white/ambispace1.ogg',\
						  'sound/ambience/white/ambispace2.ogg',\
						  'sound/ambience/white/ambispace3.ogg',\
				   		  'sound/ambience/white/ambispace4.ogg') // Source - https://vk.com/wall-180293907_321

#define MAINTENANCE list( 'sound/ambience/white/ambimaint1.ogg',\
						  'sound/ambience/white/ambimaint2.ogg')

#define AWAY_MISSION list('sound/ambience/white/ambidanger2.ogg',\
						  'sound/ambience/white/ambidanger3.ogg',\
						  'sound/ambience/white/ambi12.ogg')

#define REEBE list(		  'sound/ambience/ambireebe1.ogg',\
						  'sound/ambience/ambireebe2.ogg',\
						  'sound/ambience/ambireebe3.ogg')

#define CREEPY_SOUNDS list('sound/effects/ghost.ogg',\
						   'sound/effects/ghost2.ogg',\
						   'sound/effects/heart_beat.ogg',\
						   'sound/effects/screech.ogg',\
						   'sound/hallucinations/behind_you1.ogg',\
						   'sound/hallucinations/behind_you2.ogg',\
						   'sound/hallucinations/far_noise.ogg',\
						   'sound/hallucinations/growl1.ogg',\
						   'sound/hallucinations/growl2.ogg',\
						   'sound/hallucinations/growl3.ogg',\
						   'sound/hallucinations/im_here1.ogg',\
						   'sound/hallucinations/im_here2.ogg',\
						   'sound/hallucinations/i_see_you1.ogg',\
						   'sound/hallucinations/i_see_you2.ogg',\
						   'sound/hallucinations/look_up1.ogg',\
						   'sound/hallucinations/look_up2.ogg',\
						   'sound/hallucinations/over_here1.ogg',\
						   'sound/hallucinations/over_here2.ogg',\
						   'sound/hallucinations/over_here3.ogg',\
						   'sound/hallucinations/turn_around1.ogg',\
						   'sound/hallucinations/turn_around2.ogg',\
						   'sound/hallucinations/veryfar_noise.ogg',\
						   'sound/hallucinations/wail.ogg')

#define SOVIET_AMB list(   'white/valtos/sounds/prison/amb6.ogg',\
						   'white/valtos/sounds/prison/amb7.ogg',\
						   'white/valtos/sounds/prison/amb8.ogg')

#define SOVIET_AMB_CAVES list('white/valtos/sounds/prison/ambout1.ogg')

#define SCARLET_DAWN_AMBIENT list('white/valtos/sounds/dz/ambidawn.ogg')

#define INTERACTION_SOUND_RANGE_MODIFIER -3
#define EQUIP_SOUND_VOLUME 30
#define PICKUP_SOUND_VOLUME 15
#define DROP_SOUND_VOLUME 20
#define YEET_SOUND_VOLUME 90
