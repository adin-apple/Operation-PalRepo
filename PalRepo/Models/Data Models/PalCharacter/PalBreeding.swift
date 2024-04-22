/*:
    PalBreeding.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalBreeding : Codable {
    var breedRank          : Int
    var breedOrder         : Int
    var childEligble       : Bool
    var maleProbability    : Double
}

enum BreedingCodingKeys: String, CodingKey {
    case breedRank = "rank"
    case breedOrder = "order"
    case childEligble = "child_eligble"
    case maleProbability = "male_probability"
}
