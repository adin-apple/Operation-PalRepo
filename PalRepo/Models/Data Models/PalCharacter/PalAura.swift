/*:
    PalAura.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalAura : Codable {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    var auraName    : String
    var auraDetails : String
    var auraTech    : String?
}

/*----------------------------------------------------------------------------------------------------------*/
/*  C O D I N G   K E Y S                                                                                   */
/*----------------------------------------------------------------------------------------------------------*/
enum AuraCodingKeys : String, CodingKey {
    case auraName = "name"
    case auraDetails = "details"
    case auraTech = "tech"
}
