//
//  Struct Stats.swift
//  PalRepo
//
//  Created by Adin Donlagic on 3/5/24.
//

import Foundation

struct PalStats {
    var PalHealth   : Int
    var PalAttack   : Array<Attacks>
    var PalDefense  : Int
    var PalSpeed    : Array<Speeds>
    var PalSupport  : Int
    var PalFood     : Int
    
}

struct Attacks {
    var PalMelee  : Int
    var PalRanged : Int
}

struct Speeds {
    var Riding  : Int
    var Running : Int
    var Walking : Int
}
