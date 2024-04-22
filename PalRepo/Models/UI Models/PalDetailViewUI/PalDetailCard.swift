/*:
    PalDetailCard.swift
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
struct PalDetailCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Details")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            
            Text(pal.palDetails)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}
