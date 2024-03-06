//
//  Struct Character.swift
//  Operation Palworld
//
//  Created by Adin Donlagic on 3/5/24.
//

import Foundation

struct PalCharacter {
    /* Comments are for Lamball from PalInformation.json */
    
    var PalID        : Int
    /* "id": 1 */
    
    var PalKey      : String
    /* "key": "001" */
    
    var PalImage    : String
    /* "image": "/public/images/paldeck/001.png" */
    
    var PalName     : String
    /* "name": "Lamball" */
    
    var PalWiki      : String
    /* "wiki": "https://palworld.fandom.com/wiki/Lamball" */
    
    var PalTyping : Array<PalTyping>
    /*  "types": [
        {
            "name": "neutral",
            "image": "/public/images/elements/neutral.png"
        } ]
    */
    
    var PalWikiImage : String
    /* "imageWiki": "https://static.wikia.nocookie.net/palworld/images/0/01/Lamball_menu.png/" */
    
    var palWorkSuitability : Array<PalWork>
    /*  "suitability": [
            {
                "type": "handiwork",
                "image": "/public/images/works/handiwork.png",
                "level": 1
            },
            {
                "type": "transporting",
                "image": "/public/images/works/transporting.png",
                "level": 1
            },
            {
                "type": "farming",
                "image": "/public/images/works/farming.png",
                "level": 1
            } ]
    */
    
    var PalDrops        : Array<String>
    /* "drops": ["wool", "lamball_mutton"] */
    
    var palAuraInfo : Array<PalAura>
    /*  "aura": {
            "name": "fluffy_shield",
            "description": "When activated, equips to the player and becomes a shield.\nSometimes drops Wool when assigned to Ranch.",
            "tech": null
        }
    */
    
    var PalDescription : String
    /*  "description": "A walk up a hill tends to end with this Pal tumbling backdown. This causes it to become dizzy and unable to move, making it easy to capture and kill. As a result, this pal has tumbled down to the very bottom of the food chain itself." */
    
    var PalSkills       : Array<PalSkills>
    /*  "skills": [
            {
                "level": 1,
                "name": "roly_poly",
                "type": "neutral",
                "cooldown": 1,
                "power": 35,
                "description": "Lamball's special skill. Curls into a ball, rolling after any enemies in its way. Becomes dizzy and unable to move after the attack ends.\n"
            },
            {
                "level": 7,
                "name": "air_cannon",
                "type": "neutral",
                "cooldown": 2,
                "power": 25,
                "description": "Quickly fires a burst of highly pressurized air.\n"
            }, ...
    */
    
    var palStats : Array<PalStats>
    /*  "stats": {
            "hp": 70,
            "attack": {
                "melee": 70,
                "ranged": 70
            },
            "defense": 70,
            "speed": {
                "ride": 550,
                "run": 400,
                "walk": 40
            },
            "stamina": 100,
            "support": 100,
            "food": 2
        }
    */
    
    var PalAsset : String
    /* "asset": "SheepBall" */
    
    var PalGenus : String
    /* "genus": "humanoid" */
    
    var PalRarity : Int
    /* "rarity": 1 */
    
    var PalPrice : Int
    /* "price": 1000 */
    
    var PalSize : String
    /* "size": "xs" */
    
    var palSpawnMap : Array<PalSpawning>
    /*  "maps": {
            "day": "/public/images/maps/001-day.png",
            "night": "/public/images/maps/001-night.png"
        }
    */
    
    var palBreedingInfo : Array<PalBreeding>
    /*  "breeding": {
            "rank": 1470,
            "order": 27,
            "child_eligble": true,
            "male_probability": 50.0
        }
    */
}
