#define NITRILE_GLOVES_MULTIPLIER 0.5
//#define NITRILE_GLOVES_SURGERY_MULTIPLIER 0.1
///multiplies the time of do_mob by NITRILE_GLOVES_MULTIPLIER if the user has the TRAIT_FASTMED
#define CHEM_INTERACT_DELAY(delay, user) HAS_TRAIT(user, TRAIT_FASTMED) ? (delay * NITRILE_GLOVES_MULTIPLIER) : delay
//#define SURGERY_SPEED_INTERACT(speed, user) HAS_TRAIT(user, TRAIT_FASTMED) ? (delay * SURGERY_SPEED_INTERACT) : delay
