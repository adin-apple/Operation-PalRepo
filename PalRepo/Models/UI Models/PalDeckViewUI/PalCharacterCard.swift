/*:
    PalCharacterCard.swift
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
struct PalCharacterCard: View {
    let pal: PalCharacter

    init(pal: PalCharacter) {
        self.pal = pal
    }

    var body: some View {
        NavigationLink(destination: PalDetailView(pal: pal)) {
            VStack {
                Text(pal.palKey)
                    .padding(.top)
                Image(pal.palKey)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .padding()
                Text(pal.palName)
                    .font(.subheadline)
                    .padding(.bottom)
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
        }
    }
}
