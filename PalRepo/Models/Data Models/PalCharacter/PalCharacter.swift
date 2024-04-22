/*:
    PalCharacter.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI
import SwiftData

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
@Model
class PalCharacter: Codable {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
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
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  D E C O D I N G                                                                                     */
    /*------------------------------------------------------------------------------------------------------*/
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        /* Pal ID */
        self.palID = try container.decode(Int.self, forKey: .palID)
        
        /* Pal Key*/
        self.palKey = try container.decode(String.self, forKey: .palKey)
        
        /* Pal Name */
        self.palName = try container.decode(String.self, forKey: .palName)
        
        /* Pal Image */
        self.palImage = try container.decode(String.self, forKey: .palImage)
        
        /* Pal Drops */
        self.palDrops = try container.decode([String].self, forKey: .palDrops)
        
        /* Pal Aura */
        if let auraContainer = try? container.nestedContainer(keyedBy: AuraCodingKeys.self, forKey: .palAura) {
            let name = try auraContainer.decode(String.self, forKey: .auraName)
            let details = try auraContainer.decode(String.self, forKey: .auraDetails)
            let tech = try auraContainer.decodeIfPresent(String.self, forKey: .auraTech)
            self.palAura = PalAura(auraName: name, auraDetails: details, auraTech: tech)
        } else {
            self.palAura = nil
        }
        
        /* Pal Details*/
        self.palDetails = try container.decode(String.self, forKey: .palDetails)
        
        /* Pal Stats */
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
        
        /* Pal Assets */
        self.palAsset = try container.decode(String.self, forKey: .palAsset)
        
        /* Pal Genus */
        self.palGenus = try container.decode(String.self, forKey: .palGenus)
        
        /* Pal Rarity */
        self.palRarity = try container.decode(Int.self, forKey: .palRarity)
        
        /* Pal Price */
        self.palPrice = try container.decode(Int.self, forKey: .palPrice)
        
        /* Pal Size*/
        self.palSize = try container.decode(String.self, forKey: .palSize)
        
        /* Pal Maps*/
        let mapContainer = try? container.nestedContainer(keyedBy: MapsCodingKeys.self, forKey: .palMaps)
        let day = try? mapContainer?.decode(String.self, forKey: .spawnDay)
        let night = try? mapContainer?.decode(String.self, forKey: .spawnNit)
        self.palMaps = PalMap(spawnDay: day ?? "", spawnNit: night ?? "")

        /* Pal Breeding */
        let breedingContainer = try container.nestedContainer(keyedBy: BreedingCodingKeys.self,
                                                              forKey: .palBreeding)
        let breedRank = try breedingContainer.decode(Int.self, forKey: .breedRank)
        let breedOrder = try breedingContainer.decode(Int.self, forKey: .breedOrder)
        let childEligble = try breedingContainer.decode(Bool.self, forKey: .childEligble)
        let maleProbability = try breedingContainer.decode(Double.self, forKey: .maleProbability)
        self.palBreeding = PalBreeding(breedRank: breedRank, breedOrder: breedOrder,
                                       childEligble: childEligble, maleProbability: maleProbability)
        
        /* Pal Wiki URL */
        palWiki = try container.decode(URL.self, forKey: .palWiki)
        
        /* Pal Wiki Image */
        palImageWiki = try container.decode(URL.self, forKey: .palImageWiki)
        
        /* Pal Typing */
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
        
        /* Pal Work Suitability */
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
        
        /* Pal Skills */
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
    
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  E N C O D I N G                                                                                     */
    /*------------------------------------------------------------------------------------------------------*/
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        /* Pal ID */
        try container.encode(palID, forKey: .palID)
        
        /* Pal Key*/
        try container.encode(palKey, forKey: .palKey)
        
        /* Pal Name */
        try container.encode(palName, forKey: .palName)
        
        /* Pal Image */
        try container.encode(palImage, forKey: .palImage)
        
        /* Pal Wiki URL */
        try container.encode(palWiki, forKey: .palWiki)
        
        /* Pal Wiki Image */
        try container.encode(palImageWiki, forKey: .palImageWiki)
        
        
        /* Pal Drops */
        try container.encode(palDrops, forKey: .palDrops)
        
        /* Pal Aura */
        if let palAura = palAura {
            var auraContainer = container.nestedContainer(keyedBy: AuraCodingKeys.self, forKey: .palAura)
            try auraContainer.encode(palAura.auraName, forKey: .auraName)
            try auraContainer.encode(palAura.auraDetails, forKey: .auraDetails)
            try auraContainer.encode(palAura.auraTech, forKey: .auraTech)
        }
        
        /* Pal Details */
        try container.encode(palDetails, forKey: .palDetails)

        /* Pal Asset */
        try container.encode(palAsset, forKey: .palAsset)
        
        /* Pal Genus */
        try container.encode(palGenus, forKey: .palGenus)
        
        /* Pal Rarity */
        try container.encode(palRarity, forKey: .palRarity)
        
        /* Pal Price */
        try container.encode(palPrice, forKey: .palPrice)
        
        /* Pal Size */
        try container.encode(palSize, forKey: .palSize)
        
        /* Pal Maps*/
        var mapContainer = container.nestedContainer(keyedBy: MapsCodingKeys.self, forKey: .palMaps)
        try mapContainer.encode(palMaps.spawnDay, forKey: .spawnDay)
        try mapContainer.encode(palMaps.spawnNit, forKey: .spawnNit)
        
        /* Pal Breeding */
        try container.encode(palBreeding, forKey: .palBreeding)
        var breedingContainer = container.nestedContainer(keyedBy: BreedingCodingKeys.self, forKey: .palBreeding)
        try breedingContainer.encode(palBreeding.breedRank, forKey: .breedRank)
        try breedingContainer.encode(palBreeding.breedOrder, forKey: .breedOrder)
        try breedingContainer.encode(palBreeding.childEligble, forKey: .childEligble)
        try breedingContainer.encode(palBreeding.maleProbability, forKey: .maleProbability)
        
        /* Pal Typing */
        var typingContainer = container.nestedUnkeyedContainer(forKey: .palTyping)
        for type in palTyping {
            var typeContainer = typingContainer.nestedContainer(keyedBy: TypingCodingKeys.self)
            try typeContainer.encode(type.typeName, forKey: .typeName)
            try typeContainer.encode(type.typeImage, forKey: .typeImage)
        }
        
        /* Pal Work */
        var workingContainer = container.nestedUnkeyedContainer(forKey: .palTyping)
        for work in palWork {
            var workContainer = workingContainer.nestedContainer(keyedBy: WorkCodingKeys.self)
            try workContainer.encode(work.workType, forKey: .workType)
            try workContainer.encode(work.workImage, forKey: .workImage)
            try workContainer.encode(work.workLevel, forKey: .workType)
        }
        
        /* Pal Skills */
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
        
        /* Pal Stats */
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
