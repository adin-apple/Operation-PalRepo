/*:
    PalDetailView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalDetailView: View {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @Environment(\.modelContext) private var context
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    let pal: PalCharacter
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  I N I T                                                                                             */
    /*------------------------------------------------------------------------------------------------------*/
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  U I   H A N D L I N G                                                                               */
    /*------------------------------------------------------------------------------------------------------*/
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

/*------------------------------------------------------------------------------------------------------*/
/*  P U B L I C   F U N C T I O N S                                                                     */
/*------------------------------------------------------------------------------------------------------*/
func imageName(from imagePath: String) -> String {
    return URL(fileURLWithPath: imagePath)
        .deletingPathExtension()
        .lastPathComponent
}

/*----------------------------------------------------------------------------------------------------------*/
/*  E X T E N S I O N S                                                                                     */
/*----------------------------------------------------------------------------------------------------------*/
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
