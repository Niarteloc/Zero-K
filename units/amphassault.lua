unitDef = {
  unitname            = [[amphassault]],
  name                = [[Grizzly]],
  description         = [[Heavy Amphibious Assault Walker]],
  acceleration        = 0.1,
  brakeRate           = 0.1,
  buildCostEnergy     = 2000,
  buildCostMetal      = 2000,
  buildPic            = [[amphassault.png]],
  buildTime           = 2000,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND SINK]],
  collisionVolumeOffsets  = [[0 0 0]],
  --collisionVolumeScales   = [[70 70 70]],
  --collisionVolumeType	  = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    floattoggle    = [[1]],
    description_pl = [[Ciezki amfibijny bot szturmowy]],
    helptext       = [[The Grizzly is a classic assault unit - relatively slow, clumsy and next to unstoppable. Its weapon is a high power laser beam with high range and damage, ineffective against swarmers and fast aircraft but not much else. While its weapon cannot fire underwater, the Grizzly can float to surface in order to shoot.]],
    helptext_pl    = [[Grizzly to klasyczna jednostka szturmowa - dosc wolna i niezdarna, lecz prawie niepowstrzymana. Jego bronia jest laser o duzym zasiegu i obrazeniach, ktory ma problemy wlasciwie tylko przeciwko szybkim jednostkom atakujacym w grupach i lotnictwu. Grizzly moze sie wynurzyc do strzalu, ale nie moze strzelac pod woda.]],
	aimposoffset   = [[0 30 0]],
	midposoffset   = [[0 6 0]],
	modelradius    = [[35]],
  },

  explodeAs           = [[BIG_UNIT]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[amphassault]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maxDamage           = 9000,
  maxSlope            = 36,
  maxVelocity         = 1.6,
  maxWaterDepth       = 5000,
  minCloakDistance    = 75,
  movementClass       = [[AKBOT4]],
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName          = [[amphassault.s3o]],
  script              = [[amphassault.lua]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNIT]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:watercannon_muzzle]],
    },

  },

  sightDistance       = 605,
  trackOffset         = 0,
  trackStrength       = 8,
  trackStretch        = 1,
  trackType           = [[ComTrack]],
  trackWidth          = 66,
  turnRate            = 500,
  upright             = false,

  weapons                       = {
    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
	{
      def                = [[FAKE_LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

  weaponDefs                    = {

    LASER = {
      name                    = [[High-Energy Laserbeam]],
      areaOfEffect            = 14,
      beamTime                = 0.8,
      beamttl                 = 1,
      coreThickness           = 0.5,
      craterBoost             = 0,
      craterMult              = 0,
      
      customParams            = {
        statsprojectiles = 1,
        statsdamage = 1500,
      },

      damage                  = {
        default = 300,
        planes  = 300,
        subs    = 15,
      },

      explosionGenerator      = [[custom:flash1bluedark]],
      fireStarter             = 90,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 10.4,
      minIntensity            = 1,
      noSelfDamage            = true,
      projectiles             = 5,
      range                   = 600,
      reloadtime              = 6,
      rgbColor                = [[0 0 1]],
      scrollSpeed             = 5,
      soundStart              = [[weapon/laser/heavy_laser3]],
	  soundStartVolume        = 3,
      sweepfire               = false,
      targetMoveError         = 0.2,
      texture1                = [[largelaserdark]],
      texture2                = [[flaredark]],
      texture3                = [[flaredark]],
      texture4                = [[smallflaredark]],
      thickness               = 10.4024486300101,
      tileLength              = 300,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 2250,
    },

    FAKE_LASER = {
      name                    = [[Fake High-Energy Laserbeam]],
      areaOfEffect            = 14,
      beamTime                = 0.8,
	  beamttl                 = 1,
      coreThickness           = 0.5,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 300,
        planes  = 300,
        subs    = 15,
      },

      explosionGenerator      = [[custom:flash1bluedark]],
      fireStarter             = 90,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 10.4,
      minIntensity            = 1,
      noSelfDamage            = true,
	  projectiles             = 5,
      range                   = 550,
      reloadtime              = 6,
      rgbColor                = [[0 0 1]],
      scrollSpeed             = 5,
      soundStart              = [[weapon/laser/heavy_laser3]],
	  soundStartVolume        = 3,
      sweepfire               = false,
      targetMoveError         = 0.2,
      texture1                = [[largelaserdark]],
      texture2                = [[flaredark]],
      texture3                = [[flaredark]],
      texture4                = [[smallflaredark]],
      thickness               = 10.4024486300101,
      tileLength              = 300,
      tolerance               = 10000,
      turret                  = true,
	  waterWeapon             = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 2250,
    },
  },

  featureDefs         = {

    DEAD = {
      description      = [[Wreckage - Grizzly]],
      blocking         = true,
      damage           = 9000,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      metal            = 800,
      object           = [[amphassault_wreck.s3o]],
      reclaimable      = true,
      reclaimTime      = 800,
    },

    HEAP = {
      description      = [[Debris - Grizzly]],
      blocking         = false,
      damage           = 9000,
      energy           = 0,
      footprintX       = 3,
      footprintZ       = 3,
      metal            = 400,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 400,
    },

  },

}

return lowerkeys({ amphassault = unitDef })
