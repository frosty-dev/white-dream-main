/datum/map_generator_module/bottom_layer/prikolwoodsTurfs
	spawnableTurfs = list(/turf/open/floor/plating/grass/planetary = 100)

/datum/map_generator_module/bottom_layer/prikolwoodsWalls
	spawnableTurfs = list(/turf/closed/mineral = 100)

/datum/map_generator_module/border/prikolwoodsWalls
	spawnableAtoms = list()
	spawnableTurfs = list(/turf/closed/mineral = 100)

/datum/map_generator_module/splatterLayer/prikolwoodsWalls
	clusterCheckFlags = CLUSTER_CHECK_NONE
	spawnableAtoms = list()
	spawnableTurfs = list(/turf/closed/mineral = 30)

//////////////////////////////////////////////////////////////////

/datum/map_generator_module/prikolwoodsTrees
	spawnableAtoms = list(/obj/structure/flora/tree/jungle/prikol = 3, /obj/structure/flora/tree/jungle/small/prikol = 7)

/datum/map_generator_module/prikolwoodsDeadTrees
	spawnableAtoms = list(/obj/structure/flora/tree/dead = 2)

/////////////////////////////////////////////////////////////////////

/datum/map_generator_module/prikolwoodsTreesDense
	spawnableAtoms = list(/obj/structure/flora/tree/jungle/prikol = 7, /obj/structure/flora/tree/jungle/small/prikol = 15)

/datum/map_generator_module/prikolwoodsDeadTreesDense
	spawnableAtoms = list(/obj/structure/flora/tree/dead = 5)

////////////////////////////////////////////////////////////////////

/datum/map_generator_module/prikolwoodsRandBushes
	spawnableAtoms = list()

/datum/map_generator_module/prikolwoodsRandBushes/New()
	..()
	spawnableAtoms = typesof(/obj/structure/flora/ausbushes)
	for(var/i in spawnableAtoms)
		spawnableAtoms[i] = 10

/datum/map_generator_module/prikolwoodsRandRocks
	spawnableAtoms = list(/obj/structure/flora/rock = 10, /obj/structure/flora/rock/pile = 5)






/datum/map_generator/prikolwoods
	modules = list(
					/datum/map_generator_module/bottom_layer/prikolwoodsTurfs,
					/datum/map_generator_module/border/prikolwoodsWalls,
					/datum/map_generator_module/prikolwoodsTrees,
					/datum/map_generator_module/prikolwoodsRandRocks,
					/datum/map_generator_module/prikolwoodsRandBushes

				)
	buildmode_name = "Pattern: Prikolwoods"

/datum/map_generator/prikolwoods/grasslands
	modules = list(
					/datum/map_generator_module/bottom_layer/prikolwoodsTurfs,
					/datum/map_generator_module/border/prikolwoodsWalls,
					/datum/map_generator_module/prikolwoodsRandRocks,
					/datum/map_generator_module/prikolwoodsRandBushes

				)
	buildmode_name = "Pattern: Prikolwoods Grasslands"

/datum/map_generator/prikolwoods/dense
	modules = list(
					/datum/map_generator_module/bottom_layer/prikolwoodsTurfs,
					/datum/map_generator_module/border/prikolwoodsWalls,
					/datum/map_generator_module/prikolwoodsTreesDense,
					/datum/map_generator_module/prikolwoodsRandRocks,
					/datum/map_generator_module/prikolwoodsRandBushes

				)
	buildmode_name = "Pattern: Prikolwoods Dense"
