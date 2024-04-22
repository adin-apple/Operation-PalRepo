/*:
    PalMapCard.swift
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
struct PalMapCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        VStack {
            
            HStack{
                Text("Spawns")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            VStack {
                VStack{
                    Text("Daytime")
                        .bold()
                    
                    Image(imageName(from: pal.palMaps.spawnDay))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .padding()
                
                VStack{
                    Text("Nighttime")
                        .bold()
                    
                    Image(imageName(from: pal.palMaps.spawnNit))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .padding()
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
