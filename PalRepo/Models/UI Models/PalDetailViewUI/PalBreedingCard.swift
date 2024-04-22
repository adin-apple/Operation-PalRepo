/*:
    PalBreedingCard.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalBreedingCard: View {
    
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
        VStack {
            HStack{
                Text("Breeding")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            HStack{
                Text("Rank:")
                Spacer()
                Text("\(pal.palBreeding.breedRank)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Order:")
                Spacer()
                Text("\(pal.palBreeding.breedOrder)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Eligible:")
                Spacer()
                Text("\(pal.palBreeding.childEligble)".capitalized)
            }
            .padding(.horizontal)
            
            HStack {
                Text("Male Probability:")
                Spacer()
                Text("\(String(format: "%.1f%%", pal.palBreeding.maleProbability))")
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

func formatPercentage(_ value: Double) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    formatter.maximumFractionDigits = 1
    return formatter.string(from: NSNumber(value: value))
}
