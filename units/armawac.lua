unitDef = {
  unitname            = [[armawac]],
  name                = [[Eagle]],
  description         = [[Stealth Radar/Sonar Plane]],
  altfromsealevel     = [[1]],
  amphibious          = true,
  buildCostEnergy     = 300,
  buildCostMetal      = 300,
  builder             = false,
  buildPic            = [[ARMAWAC.png]],
  buildTime           = 300,
  canAttack           = false,
  canDropFlare        = false,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canstop             = [[1]],
  canSubmerge         = false,
  category            = [[UNARMED FIXEDWING]],
  collide             = false,
  corpse              = [[HEAP]],
  cruiseAlt           = 250,

  customParams        = {
    description_bp = [[Avi?o batedor invisível a radar com radar e sonar]],
    description_fr = [[Avion Sonar/Radar Furtif]],
    helptext       = [[Sonar, Radar, and a large LOS (Line of Sight) make this plane your swiss army knife for scouting.]],
    helptext_bp    = [[Este avi?o possui radar, sonar e um grande raio de vis?o, e desta forma pode encontrar inimigos escondidos com maior facilidade que a maioria das unidades batedoras.]],
    helptext_fr    = [[Sonar, radar, et large champ de vision font de cet avion votre couteau suisse de l'éclairage.]],
  },

  defaultmissiontype  = [[VTOL_standby]],
  energyUse           = 1.5,
  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  iconType            = [[radarplane]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  maneuverleashlength = [[1280]],
  mass                = 150,
  maxAcc              = 0.5,
  maxDamage           = 800,
  maxVelocity         = 11,
  minCloakDistance    = 75,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK]],
  objectName          = [[bellbutt.s3o]],
  radarDistance       = 2400,
  scale               = [[1]],
  seismicSignature    = 0,
  selfDestructAs      = [[GUNSHIPEX]],
  side                = [[ARM]],
  sightDistance       = 1275,
  smoothAnim          = true,
  sonarDistance       = 1200,
  stealth             = true,
  TEDClass            = [[VTOL]],
  workerTime          = 0,

  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Eagle]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 800,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 120,
      object           = [[wreck3x3b.s3o]],
      reclaimable      = true,
      reclaimTime      = 120,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    DEAD2 = {
      description      = [[Debris - Eagle]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 800,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 120,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 120,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Eagle]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 800,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 60,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 60,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ armawac = unitDef })
