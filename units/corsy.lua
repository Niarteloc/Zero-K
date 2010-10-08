unitDef = {
  unitname               = [[corsy]],
  name                   = [[Shipyard]],
  description            = [[Produces Ships, Builds at 6 m/s]],
  acceleration           = 0,
  bmcode                 = [[0]],
  brakeRate              = 0,
  buildCostEnergy        = 550,
  buildCostMetal         = 550,
  builder                = true,

  buildoptions           = {
    [[corcs]],
    [[armpt]],
    [[coresupp]],
    [[dclship]],
    [[corsub]],
    [[armroy]],
    [[corroy]],
    [[corcrus]],
    [[cornukesub]],
    [[armcarry]],
    [[corbats]],
    [[corarch]],
    [[armtboat]],
  },

  buildPic               = [[CORSY.png]],
  buildTime              = 550,
  canMove                = true,
  canPatrol              = true,
  canStop                = true,
  category               = [[UNARMED FLOAT]],
  collisionVolumeOffsets = [[-50 -15 0]],
  collisionVolumeScales  = [[70 60 260]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[Box]],
  corpse                 = [[DEAD]],

  customParams           = {
    sortName = [[7]],
  },

  energyMake             = 0.3,
  energyUse              = 0,
  explodeAs              = [[LARGE_BUILDINGEX]],
  footprintX             = 3,
  footprintZ             = 16,
  iconType               = [[facship]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  mass                   = 275,
  maxDamage              = 4000,
  maxSlope               = 15,
  maxVelocity            = 0,
  metalMake              = 0.3,
  minCloakDistance       = 150,
  minWaterDepth          = 30,
  noAutoFire             = false,
  objectName             = [[seafac.s3o]],
  seismicSignature       = 4,
  selfDestructAs         = [[LARGE_BUILDINGEX]],
  side                   = [[CORE]],
  sightDistance          = 273,
  smoothAnim             = true,
  TEDClass               = [[PLANT]],
  turnRate               = 0,
  waterline              = 1,
  workerTime             = 6,
  yardMap                = [[ooYYYYYYYY ooCCCCCCYY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCCY ooCCCCCCYY ooYYYYYYYY]],

  featureDefs            = {

    DEAD  = {
      description      = [[Wreckage - Shipyard]],
      blocking         = false,
      category         = [[corpses]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[DEAD2]],
      footprintX       = 7,
      footprintZ       = 7,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 220,
      object           = [[wreck7x7a.s3o]],
      reclaimable      = true,
      reclaimTime      = 220,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Shipyard]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 8,
      footprintZ       = 8,
      hitdensity       = [[100]],
      metal            = 220,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 220,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Shipyard]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 8,
      footprintZ       = 8,
      hitdensity       = [[100]],
      metal            = 110,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 110,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corsy = unitDef })
