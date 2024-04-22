/*:
    PalSkill.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalSkill : Codable, Hashable {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    var skillLevel       : Int
    var skillName        : String
    var skillType        : String
    var skillCooldown    : Int
    var skillPower       : Int
    var skillDetails     : String
}

/*----------------------------------------------------------------------------------------------------------*/
/*  C O D I N G   K E Y S                                                                                   */
/*----------------------------------------------------------------------------------------------------------*/
enum SkillCodingKeys : String, CodingKey {
    case skillLevel = "level"
    case skillName = "name"
    case skillType = "type"
    case skillCooldown = "cooldown"
    case skillPower = "power"
    case skillDetails = "details"
}
