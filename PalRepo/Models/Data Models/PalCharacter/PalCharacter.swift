/*:
    PalCharacter.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
@Model
class PalCharacter: Codable {
    var palID: Int
    var palKey: String
    var palName: String
    var palImage: String
    var palTyping: [PalTyping]
    var palWiki: URL
    var palImageWiki: URL
    var palWork: [PalWork]
    var palDrops: [String]
    var palAura: PalAura?
    var palDetails: String
    var palSkills: [PalSkill]
    var palStats: PalStats
    var palAsset: String
    var palGenus: String
    var palRarity: Int
    var palPrice: Int
    var palSize: String
    var palMaps: PalMap
    var palBreeding: PalBreeding
    
    enum CodingKeys: String, CodingKey {
        case palID = "id"
        case palKey = "key"
        case palName = "name"
        case palImage = "image"
        case palTyping = "types"
        case palWiki = "wiki"
        case palImageWiki = "imageWiki"
        case palWork = "suitability"
        case palDrops = "drops"
        case palAura = "aura"
        case palDetails = "details"
        case palSkills = "skills"
        case palStats = "stats"
        case palAsset = "asset"
        case palGenus = "genus"
        case palRarity = "rarity"
        case palPrice = "price"
        case palSize = "size"
        case palMaps = "maps"
        case palBreeding = "breeding"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.palID = try container.decode(Int.self, forKey: .palID)
        self.palKey = try container.decode(String.self, forKey: .palKey)
        self.palName = try container.decode(String.self, forKey: .palName)
        self.palImage = try container.decode(String.self, forKey: .palImage)
        self.palDrops = try container.decode([String].self, forKey: .palDrops)
        
        if let auraContainer = try? container.nestedContainer(keyedBy: AuraCodingKeys.self, forKey: .palAura) {
            let name = try auraContainer.decode(String.self, forKey: .auraName)
            let details = try auraContainer.decode(String.self, forKey: .auraDetails)
            let tech = try auraContainer.decodeIfPresent(String.self, forKey: .auraTech)
            self.palAura = PalAura(auraName: name, auraDetails: details, auraTech: tech)
        } else {
            self.palAura = nil
        }
        
        self.palDetails = try container.decode(String.self, forKey: .palDetails)
        
        let statsContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .palStats)
        let statHP = try statsContainer.decode(Int.self, forKey: .statHP)
        let statATT = try statsContainer.decode(Attack.self, forKey: .statAttack)
        let statDEF = try statsContainer.decode(Int.self, forKey: .statDefense)
        let statSTA = try statsContainer.decode(Int.self, forKey: .statStamina)
        let statSUP = try statsContainer.decode(Int.self, forKey: .statSupport)
        let statSPD = try statsContainer.decode(Speed.self, forKey: .statSpeed)
        let statFOD = try statsContainer.decode(Int.self, forKey: .statFood)
        self.palStats = PalStats(statHP: statHP,
                                 statAttack: statATT,
                                 statDefense: statDEF,
                                 statSpeed: statSPD,
                                 statStamina: statSTA,
                                 statSupport: statSUP,
                                 statFood: statFOD)
        
        self.palAsset = try container.decode(String.self, forKey: .palAsset)
        self.palGenus = try container.decode(String.self, forKey: .palGenus)
        self.palRarity = try container.decode(Int.self, forKey: .palRarity)
        self.palPrice = try container.decode(Int.self, forKey: .palPrice)
        self.palSize = try container.decode(String.self, forKey: .palSize)
        
        let mapContainer = try? container.nestedContainer(keyedBy: MapsCodingKeys.self, forKey: .palMaps)
        let day = try? mapContainer?.decode(String.self, forKey: .spawnDay)
        let night = try? mapContainer?.decode(String.self, forKey: .spawnNit)
        self.palMaps = PalMap(spawnDay: day ?? "", spawnNit: night ?? "")

        let breedingContainer = try container.nestedContainer(keyedBy: BreedingCodingKeys.self,
                                                              forKey: .palBreeding)
        let breedRank = try breedingContainer.decode(Int.self, forKey: .breedRank)
        let breedOrder = try breedingContainer.decode(Int.self, forKey: .breedOrder)
        let childEligble = try breedingContainer.decode(Bool.self, forKey: .childEligble)
        let maleProbability = try breedingContainer.decode(Double.self, forKey: .maleProbability)
        self.palBreeding = PalBreeding(breedRank: breedRank, breedOrder: breedOrder,
                                       childEligble: childEligble, maleProbability: maleProbability)
        
        palWiki = try container.decode(URL.self, forKey: .palWiki)
        palImageWiki = try container.decode(URL.self, forKey: .palImageWiki)
        
        var typingContainer = try container.nestedUnkeyedContainer(forKey: .palTyping)
        var typingArray: [PalTyping] = []
        
        while !typingContainer.isAtEnd {
            let typeContainer = try typingContainer.nestedContainer(keyedBy: TypingCodingKeys.self)
            let name = try typeContainer.decode(String.self, forKey: .typeName)
            let image = try typeContainer.decode(String.self, forKey: .typeImage)
            
            let typing = PalTyping(typeName: name, typeImage: image)
            typingArray.append(typing)
        }
        self.palTyping = typingArray
        
        
        var workingContainer = try container.nestedUnkeyedContainer(forKey: .palWork)
        var workArray: [PalWork] = []
        
        while !workingContainer.isAtEnd {
            let workContainer = try workingContainer.nestedContainer(keyedBy: WorkCodingKeys.self)
            let workType    = try workContainer.decode(String.self, forKey: .workType)
            let workImage   = try workContainer.decode(String.self, forKey: .workImage)
            let workLevel   = try workContainer.decode(Int.self, forKey: .workLevel)
            
            let working = PalWork(workType: workType, workImage: workImage, workLevel: workLevel)
            workArray.append(working)
        }
        self.palWork = workArray
        
        var skillingContainer = try container.nestedUnkeyedContainer(forKey: .palSkills)
        var skillArray: [PalSkill] = []
        
        while !skillingContainer.isAtEnd {
            let skillContainer  = try skillingContainer.nestedContainer(keyedBy: SkillCodingKeys.self)
            let skillLevel      = try skillContainer.decode(Int.self, forKey: .skillLevel)
            let skillName       = try skillContainer.decode(String.self, forKey: .skillName)
            let skillType       = try skillContainer.decode(String.self, forKey: .skillType)
            let skillCooldown   = try skillContainer.decode(Int.self, forKey: .skillCooldown)
            let skillPower      = try skillContainer.decode(Int.self, forKey: .skillPower)
            let skillDetails    = try skillContainer.decode(String.self, forKey: .skillDetails)
            
            let skilling = PalSkill(skillLevel: skillLevel, skillName: skillName, skillType: skillType,
                                    skillCooldown: skillCooldown, skillPower: skillPower,
                                    skillDetails: skillDetails)
            skillArray.append(skilling)
        }
        self.palSkills = skillArray
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(palID, forKey: .palID)
        try container.encode(palKey, forKey: .palKey)
        try container.encode(palName, forKey: .palName)
        try container.encode(palImage, forKey: .palImage)
        try container.encode(palWiki, forKey: .palWiki)
        try container.encode(palImageWiki, forKey: .palImageWiki)
        try container.encode(palWork, forKey: .palWork)
        try container.encode(palDrops, forKey: .palDrops)
        
        if let palAura = palAura {
            var auraContainer = container.nestedContainer(keyedBy: AuraCodingKeys.self, forKey: .palAura)
            try auraContainer.encode(palAura.auraName, forKey: .auraName)
            try auraContainer.encode(palAura.auraDetails, forKey: .auraDetails)
            try auraContainer.encode(palAura.auraTech, forKey: .auraTech)
        }
        
        try container.encode(palDetails, forKey: .palDetails)
        try container.encode(palSkills, forKey: .palSkills)
        try container.encode(palAsset, forKey: .palAsset)
        try container.encode(palGenus, forKey: .palGenus)
        try container.encode(palRarity, forKey: .palRarity)
        try container.encode(palPrice, forKey: .palPrice)
        try container.encode(palSize, forKey: .palSize)
        try container.encode(palMaps, forKey: .palMaps)
        
        var mapContainer = container.nestedContainer(keyedBy: MapsCodingKeys.self, forKey: .palMaps)
        try mapContainer.encode(palMaps.spawnDay, forKey: .spawnDay)
        try mapContainer.encode(palMaps.spawnNit, forKey: .spawnNit)
        
        
        try container.encode(palBreeding, forKey: .palBreeding)
        var breedingContainer = container.nestedContainer(keyedBy: BreedingCodingKeys.self, forKey: .palBreeding)
        try breedingContainer.encode(palBreeding.breedRank, forKey: .breedRank)
        try breedingContainer.encode(palBreeding.breedOrder, forKey: .breedOrder)
        try breedingContainer.encode(palBreeding.childEligble, forKey: .childEligble)
        try breedingContainer.encode(palBreeding.maleProbability, forKey: .maleProbability)
        
        var typingContainer = container.nestedUnkeyedContainer(forKey: .palTyping)
        for type in palTyping {
            var typeContainer = typingContainer.nestedContainer(keyedBy: TypingCodingKeys.self)
            try typeContainer.encode(type.typeName, forKey: .typeName)
            try typeContainer.encode(type.typeImage, forKey: .typeImage)
        }
        
        var workingContainer = container.nestedUnkeyedContainer(forKey: .palTyping)
        for work in palWork {
            var workContainer = workingContainer.nestedContainer(keyedBy: WorkCodingKeys.self)
            try workContainer.encode(work.workType, forKey: .workType)
            try workContainer.encode(work.workImage, forKey: .workImage)
            try workContainer.encode(work.workLevel, forKey: .workType)
        }
        
        var skillingContainer = container.nestedUnkeyedContainer(forKey: .palSkills)
        for skill in palSkills {
            var skillContainer = skillingContainer.nestedContainer(keyedBy: SkillCodingKeys.self)
            try skillContainer.encode(skill.skillLevel, forKey: .skillLevel)
            try skillContainer.encode(skill.skillName, forKey: .skillName)
            try skillContainer.encode(skill.skillType, forKey: .skillType)
            try skillContainer.encode(skill.skillCooldown, forKey: .skillCooldown)
            try skillContainer.encode(skill.skillPower, forKey: .skillPower)
            try skillContainer.encode(skill.skillDetails, forKey: .skillDetails)
        }
        
        var statContainer = container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .palStats)
        try statContainer.encode(palStats.statHP, forKey: .statHP)
        try statContainer.encode(palStats.statAttack, forKey: .statAttack)
        try statContainer.encode(palStats.statDefense, forKey: .statDefense)
        try statContainer.encode(palStats.statStamina, forKey: .statStamina)
        try statContainer.encode(palStats.statSupport, forKey: .statSupport)
        try statContainer.encode(palStats.statSpeed, forKey: .statSpeed)
        try statContainer.encode(palStats.statFood, forKey: .statFood)
        
    }
}
