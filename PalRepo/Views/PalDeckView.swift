/*:
    PalDeckView.swift
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
struct PalDeckView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \PalCharacter.palKey) var pals: [PalCharacter]
    
    var body: some View {
        VStack{
            
            ImageButton(imageName: "PalDeck Button") {
                
            }
            .aspectRatio(3, contentMode: .fit)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                    ForEach(pals, id: \.id) { pal in
                        PalCharacterCard(pal: pal)
                    }
                }
            }
        }.background(Color.blue)
            
    }
}

struct PalDeckView_Previews: PreviewProvider {
    static var previews: some View {
        PalDeckView()
    }
}
