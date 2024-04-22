/*:
    PalMiscInfoCard.swift
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
struct PalMiscInfoCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Misc. Info")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            HStack{
                Text("Rarity:")
                Spacer()
                Text("\(pal.palRarity)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Price:")
                Spacer()
                Text("\(pal.palPrice)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Size:")
                Spacer()
                Text("\(pal.palSize)")
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


