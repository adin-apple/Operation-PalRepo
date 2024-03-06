//
//  Struct Character.swift
//  Operation Palworld
//
//  Created by Adin Donlagic on 3/5/24.
//

import Foundation

struct PalCharacter {
    var PalID               : Int
    var PalKey              : String
    var PalImage            : String
    var PalName             : String
    var PalWiki             : String
    var PalTyping           : Array<PalTyping>
    var PalWikiImage        : String
    var palWorkSuitability  : Array<PalWork>
    var PalDrops            : Array<String>
    var palAuraInfo         : Array<PalAura>
    var PalDescription      : String
    var PalSkills           : Array<PalSkills>
    var palStats            : Array<PalStats>
    var PalAsset            : String
    var PalGenus            : String
    var PalRarity           : Int
    var PalPrice            : Int
    var PalSize             : String
    var palSpawnMap         : Array<PalSpawning>
    var palBreedingInfo     : Array<PalBreeding>
}

struct PalAura : Codable {
    var auraName : String
    var auraDescription : String
    var palTech : String?
}

struct PalBreeding {
    var breedingRank : Int
    var breedingOrder : Int
    var childEligible : Bool
    var maleProbabilty : Double
}

struct PalSkills {
    var levelLearned : Int
    var skillName : String
    var skillType : String
    var skillCooldown : Int
    var skillPower : Int
    var skillDescription : String
}

struct PalSpawning {
    var daySpawns   : String
    var nightSpawns : String
}

struct PalWork {
    var workType    : String
    var workImage   : String
    var workLevel   : Int
}

struct PalStats {
    var PalHealth   : Int
    var PalAttack   : Array<Attacks>
    var PalDefense  : Int
    var PalSpeed    : Array<Speeds>
    var PalSupport  : Int
    var PalFood     : Int
    
}

struct Attacks {
    var PalMelee  : Int
    var PalRanged : Int
}

struct Speeds {
    var Riding  : Int
    var Running : Int
    var Walking : Int
}

struct PalTyping {
    var typeName  : String
    var typeImage : String
}
