/*:
    PalCharacterCard.swift
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
struct PalCharacterCard: View {
    let pal: PalCharacter

    var body: some View {
        VStack {
            Image(pal.palKey)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 75, height: 75)
                .padding()
            Text(pal.palName)
                .font(.caption)
            Text(pal.palKey)
                .font(.caption)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

