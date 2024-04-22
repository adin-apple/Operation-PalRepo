/*:
    PalStatsCard.swift
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
struct PalStatsCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Stats")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            HStack{
                Text("Hit Points:")
                Spacer()
                Text("\(pal.palStats.statHP)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Melee Attack:")
                Spacer()
                Text("\(pal.palStats.statAttack.melee)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Range Attack:")
                Spacer()
                Text("\(pal.palStats.statAttack.ranged)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Defense:")
                Spacer()
                Text("\(pal.palStats.statDefense)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Stamina:")
                Spacer()
                Text("\(pal.palStats.statStamina)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Support:")
                Spacer()
                Text("\(pal.palStats.statSupport)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Walking Speed:")
                Spacer()
                Text("\(pal.palStats.statSpeed.walk)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Running Speed:")
                Spacer()
                Text("\(pal.palStats.statSpeed.run)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Riding Speed:")
                Spacer()
                Text("\(pal.palStats.statSpeed.ride)")
            }
            .padding(.horizontal)
            
            HStack{
                Text("Food Usage:")
                Spacer()
                Text("\(pal.palStats.statFood)")
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
