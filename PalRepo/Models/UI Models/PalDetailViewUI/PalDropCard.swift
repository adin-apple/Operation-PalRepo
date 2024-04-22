/*:
    PalDropCard.swift
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
struct PalDropCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Drops")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            VStack(alignment: .leading) {
                    ForEach(pal.palDrops, id: \.self) { drop in
                        HStack{
                            Text("• \(drop.formatCapitalAndUnderscore())")
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}
