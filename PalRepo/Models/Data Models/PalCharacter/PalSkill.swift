/*:
    PalSkill.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalSkill : Codable, Hashable {
    var skillLevel       : Int
    var skillName        : String
    var skillType        : String
    var skillCooldown    : Int
    var skillPower       : Int
    var skillDetails     : String
}

enum SkillCodingKeys : String, CodingKey {
    case skillLevel = "level"
    case skillName = "name"
    case skillType = "type"
    case skillCooldown = "cooldown"
    case skillPower = "power"
    case skillDetails = "details"
}
