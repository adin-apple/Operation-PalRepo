/*:
 PalDetailView.swift
 Created by Adin Donlagic on 04/10/24
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalDetailView: View {
    @Environment(\.modelContext) private var context
    
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        ScrollView {
            VStack {
                PalGeneralInfo(pal: pal)
                
                PalDetailCard(pal: pal)
                
                PalStatsCard(pal: pal)
                
                PalMiscInfoCard(pal: pal)
                
                PalDropCard(pal: pal)
                
                PalAuraCard(pal: pal)

                PalWorkCard(pal: pal)
                
                PalSkillCard(pal: pal)
                
                PalBreedingCard(pal: pal)
                
                PalMapCard(pal: pal)
            }
        }
        .padding()
    }
}

func imageName(from imagePath: String) -> String {
    return URL(fileURLWithPath: imagePath)
        .deletingPathExtension()
        .lastPathComponent
}

extension String {
    func insertSpacesBeforeCapitals() -> String {
        var result = ""
        var isFirstChar = true
        for char in self {
            if char.isUppercase {
                if !isFirstChar {
                    result.append(" ")
                }
                isFirstChar = false
            }
            result.append(char)
        }
        return result
    }
}

extension String {
    func formatCapitalAndUnderscore() -> String {
        let words = self.components(separatedBy: "_")
        let capitalizedWords = words.map { $0.capitalized }
        return capitalizedWords.joined(separator: " ")
    }
}
