/*:
    PalWork.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation

struct PalWork: Codable, Hashable {
    var workType: String
    var workImage: String
    var workLevel: Int
}


enum WorkCodingKeys : String, CodingKey {
    case workType = "type"
    case workImage = "image"
    case workLevel = "level"
}
