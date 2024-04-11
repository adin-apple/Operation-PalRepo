/*:
    PalCharacter.swift
    Created by Adin Donlagic on 04/10/24
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S E S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
@Model
class PalCharacter: Codable {
    enum CodingKeys: CodingKey {
        case id
        case key
        case image
        case name
        case wiki
    }
    
    var palID: Int
    var palKey: String
    var palImage: String
    var palName: String
    var palWiki: String
    
    init(id: Int, key: String, image: String, name: String, wiki: String) {
        self.palID = id
        self.palKey = key
        self.palImage = image
        self.palName = name
        self.palWiki = wiki
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.palID = try container.decode(Int.self, forKey: .id)
        self.palKey = try container.decode(String.self, forKey: .key)
        self.palImage = try container.decode(String.self, forKey: .image)
        self.palName = try container.decode(String.self, forKey: .name)
        self.palWiki = try container.decode(String.self, forKey: .wiki)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(palID, forKey: .id)
        try container.encode(palKey, forKey: .key)
        try container.encode(palImage, forKey: .image)
        try container.encode(palName, forKey: .name)
        try container.encode(palWiki, forKey: .wiki)
    }
}

