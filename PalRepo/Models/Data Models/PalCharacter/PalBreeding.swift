/*:
    PalBreeding.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalBreeding : Codable {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    var breedRank          : Int
    var breedOrder         : Int
    var childEligble       : Bool
    var maleProbability    : Double
}

/*----------------------------------------------------------------------------------------------------------*/
/*  C O D I N G   K E Y S                                                                                   */
/*----------------------------------------------------------------------------------------------------------*/
enum BreedingCodingKeys: String, CodingKey {
    case breedRank = "rank"
    case breedOrder = "order"
    case childEligble = "child_eligble"
    case maleProbability = "male_probability"
}

