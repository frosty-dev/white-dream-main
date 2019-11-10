/datum/mapGeneratorModule/bottomLayer/prikolwoodsTurfs
	spawnableTurfs = list(/turf/open/floor/plating/grass/planetary = 100)

/datum/mapGeneratorModule/bottomLayer/prikolwoodsWalls
	spawnableTurfs = list(/turf/closed/mineral = 100)

/datum/mapGeneratorModule/border/prikolwoodsWalls
	spawnableAtoms = list()
	spawnableTurfs = list(/turf/closed/mineral = 100)

/datum/mapGeneratorModule/splatterLayer/prikolwoodsWalls
	clusterCheckFlags = CLUSTER_CHECK_NONE
	spawnableAtoms = list()
	spawnableTurfs = list(/turf/closed/mineral = 30)

//////////////////////////////////////////////////////////////////

/datum/mapGeneratorModule/prikolwoodsTrees
	spawnableAtoms = list(/obj/structure/flora/tree/jungle/prikol = 3, /obj/structure/flora/tree/jungle/small/prikol = 7)

/datum/mapGeneratorModule/prikolwoodsDeadTrees
	spawnableAtoms = list(/obj/structure/flora/tree/dead = 2)

/////////////////////////////////////////////////////////////////////

/datum/mapGeneratorModule/prikolwoodsTreesDense
	spawnableAtoms = list(/obj/structure/flora/tree/jungle/prikol = 7, /obj/structure/flora/tree/jungle/small/prikol = 15)

/datum/mapGeneratorModule/prikolwoodsDeadTreesDense
	spawnableAtoms = list(/obj/structure/flora/tree/dead = 5)

////////////////////////////////////////////////////////////////////

/datum/mapGeneratorModule/prikolwoodsRandBushes
	spawnableAtoms = list()

/datum/mapGeneratorModule/prikolwoodsRandBushes/New()
	..()
	spawnableAtoms = typesof(/obj/structure/flora/ausbushes)
	for(var/i in spawnableAtoms)
		spawnableAtoms[i] = 10

/datum/mapGeneratorModule/prikolwoodsRandRocks
	spawnableAtoms = list(/obj/structure/flora/rock = 10, /obj/structure/flora/rock/pile = 5)






/datum/mapGenerator/prikolwoods/
	modules = list(
					/datum/mapGeneratorModule/bottomLayer/prikolwoodsTurfs,
					/datum/mapGeneratorModule/border/prikolwoodsWalls,
					/datum/mapGeneratorModule/prikolwoodsTrees,
					/datum/mapGeneratorModule/prikolwoodsRandRocks,
					/datum/mapGeneratorModule/prikolwoodsRandBushes

				)
	buildmode_name = "Pattern: Prikolwoods"

/datum/mapGenerator/prikolwoods/grasslands
	modules = list(
					/datum/mapGeneratorModule/bottomLayer/prikolwoodsTurfs,
					/datum/mapGeneratorModule/border/prikolwoodsWalls,
					/datum/mapGeneratorModule/prikolwoodsRandRocks,
					/datum/mapGeneratorModule/prikolwoodsRandBushes

				)
	buildmode_name = "Pattern: Prikolwoods Grasslands"

/datum/mapGenerator/prikolwoods/dense
	modules = list(
					/datum/mapGeneratorModule/bottomLayer/prikolwoodsTurfs,
					/datum/mapGeneratorModule/border/prikolwoodsWalls,
					/datum/mapGeneratorModule/prikolwoodsTreesDense,
					/datum/mapGeneratorModule/prikolwoodsRandRocks,
					/datum/mapGeneratorModule/prikolwoodsRandBushes

				)
	buildmode_name = "Pattern: Prikolwoods Dense"
