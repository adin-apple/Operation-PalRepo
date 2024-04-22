/*:
    PalBreedingCard.swift
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
struct PalBreedingCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
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
