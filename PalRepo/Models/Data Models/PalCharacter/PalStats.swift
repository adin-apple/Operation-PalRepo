/*:
    PalStats.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalStats: Codable {
    let statHP: Int
    let statAttack: Attack
    let statDefense: Int
    let statSpeed: Speed
    let statStamina: Int
    let statSupport: Int
    let statFood: Int
}

struct Attack: Codable {
    let melee: Int
    let ranged: Int
}

struct Speed: Codable {
    let ride: Int
    let run: Int
    let walk: Int
}

enum StatsCodingKeys: String, CodingKey {
    case statHP = "hp"
    case statAttack = "attack"
    case statDefense = "defense"
    case statSpeed = "speed"
    case statStamina = "stamina"
    case statSupport = "support"
    case statFood = "food"
}
