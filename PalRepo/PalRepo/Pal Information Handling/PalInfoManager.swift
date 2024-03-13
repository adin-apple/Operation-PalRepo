//
//  Struct Character.swift
//  Operation Palworld
//
//  Created by Adin Donlagic on 3/5/24.
//

/*------------------------------------------------------------------------------------------------*/

import Foundation
import SwiftData

class PalInfoManager {
    static let shared = PalInfoManager()
    
    private init() {}
    
    func loadPals() -> [PalCharacter] {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "PalInfo", withExtension: "json") else {
            fatalError("Failed to locate PalInfo.json in the bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode([PalCharacter].self, from: data)
        } catch {
            fatalError("Failed to decode PalInfo.json: \(error)")
        }
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: "PalInfo", withExtension: "json") else {
            fatalError("Could not find \(file) in the project!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project!")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project!")
        }
        
        return loadedData
    }
}

struct PalCharacter : Decodable {
    let palID               : Int
    let palKey              : String
    let palImage            : String
    let palName             : String
    let palWiki             : String
    let palType             : Array<PalTyping>
    let palWikiImage        : String
    let palWorkSuitability  : Array<PalWork>
    let palDrops            : Array<String>
    let palAuraInfo         : Array<PalAura>
    let palDescription      : String
    let palSkills           : Array<PalSkills>
    let palStats            : Array<PalStats>
    let palAsset            : String
    let palGenus            : String
    let palRarity           : Int
    let palPrice            : Int
    let palSize             : String
    let palSpawnMap         : Array<PalSpawning>
    let palBreedingInfo     : Array<PalBreeding>
    
    enum CodingKeys: String, CodingKey {
        case palID = "id"
        case palKey = "key"
        case palImage = "image"
        case palName = "name"
        case palWiki = "wiki"
        case palType = "types"
        case palWikiImage = "imageWiki"
        case palWorkSuitability = "suitability"
        case palDrops = "drops"
        case palAuraInfo = "aura"
        case palDescription = "description"
        case palSkills = "skills"
        case palStats = "stats"
        case palAsset = "asset"
        case palGenus = "genus"
        case palRarity = "rarity"
        case palPrice = "price"
        case palSize = "size"
        case palSpawnMap = "maps"
        case palBreedingInfo = "breeding"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        palID = try container.decode(Int.self, forKey: .palID)
        palKey = try container.decode(String.self, forKey: .palKey)
        palImage = try container.decode(String.self, forKey: .palImage)
        palName = try container.decode(String.self, forKey: .palName)
        palWiki = try container.decode(String.self, forKey: .palWiki)
        palType = try container.decode(Array<PalTyping>.self, forKey: .palType)
        palWikiImage = try container.decode(String.self, forKey: .palWikiImage)
        palWorkSuitability = try container.decode(Array<PalWork>.self, forKey: .palWorkSuitability)
        palDrops = try container.decode(Array<String>.self, forKey: .palDrops)
        palAuraInfo = try container.decode(Array<PalAura>.self, forKey: .palAuraInfo)
        palDescription = try container.decode(String.self, forKey: .palDescription)
        palSkills = try container.decode(Array<PalSkills>.self, forKey: .palSkills)
        palStats = try container.decode(Array<PalStats>.self, forKey: .palStats)
        palAsset = try container.decode(String.self, forKey: .palAsset)
        palGenus = try container.decode(String.self, forKey: .palGenus)
        palRarity = try container.decode(Int.self, forKey: .palRarity)
        palPrice = try container.decode(Int.self, forKey: .palPrice)
        palSize = try container.decode(String.self, forKey: .palSize)
        palSpawnMap = try container.decode(Array<PalSpawning>.self, forKey: .palSpawnMap)
        palBreedingInfo = try container.decode(Array<PalBreeding>.self, forKey: .palBreedingInfo)
    }
    
    static let allPals: [PalCharacter] = Bundle.main.decode(file: "PalInfo.json")
    
    static let samplePal: PalCharacter = allPals[0]
}

struct PalAura : Codable {
    var auraName : String
    var auraDescription : String
    var palTech : String?
}

struct PalBreeding : Codable {
    var breedingRank : Int
    var breedingOrder : Int
    var childEligible : Bool
    var maleProbabilty : Double
}

struct PalSkills : Codable {
    var levelLearned : Int
    var skillName : String
    var skillType : String
    var skillCooldown : Int
    var skillPower : Int
    var skillDescription : String
}

struct PalSpawning : Codable {
    var daySpawns   : String
    var nightSpawns : String
}

struct PalWork : Codable {
    var workType    : String
    var workImage   : String
    var workLevel   : Int
}

struct PalStats : Codable {
    var PalHealth   : Int
    var PalAttack   : Array<Attacks>
    var PalDefense  : Int
    var PalSpeed    : Array<Speeds>
    var PalSupport  : Int
    var PalFood     : Int
    
}

struct Attacks : Codable {
    var PalMelee  : Int
    var PalRanged : Int
}

struct Speeds : Codable {
    var Riding  : Int
    var Running : Int
    var Walking : Int
}

struct PalTyping  : Codable {
    var typeName  : String
    var typeImage : String
}
