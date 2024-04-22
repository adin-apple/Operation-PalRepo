/*:
    PalSkillCard.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalSkillCard: View {

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
                Text("Pal Skills")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            ForEach(pal.palSkills, id: \.self) { skill in
                VStack {
                    VStack(alignment: .leading) {
                        HStack{
                            Spacer()
                            
                            HStack {
                                Text(skill.skillName.formatCapitalAndUnderscore())
                                    .font(.headline)
                                    .bold()
                                Spacer()
                                Text("LvL: \(skill.skillLevel)")
                                    .bold()
                                Spacer()
                                Image(imageName(from: skill.skillType))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            .background(backgroundColor(for: imageName(from: skill.skillType)))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            
                            Spacer()
                        }
                        .padding(.top)

                        HStack {
                            Spacer()
                            
                            VStack{
                                Text("Power")
                                    .bold()
                                Text("\(skill.skillPower)")
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                            VStack{
                                Text("Cooldown")
                                    .bold()
                                Text("\(skill.skillCooldown)")
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            
                            Spacer()
                        }
                        
                        Text(skill.skillDetails)
                            .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
    
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  P U B L I C   F U N C T I O N S                                                                     */
    /*------------------------------------------------------------------------------------------------------*/
    func backgroundColor(for skillType: String) -> Color {
        switch skillType {
        case "fire":
            return Color.red
        case "water":
            return Color.blue.opacity(0.8)
        case "grass":
            return Color.green
        case "electric":
            return Color.yellow
        case "ground":
            return Color.brown
        case "ice":
            return Color.cyan
        case "dragon":
            return Color.purple
        case "dark":
            return Color.gray
        case "neutral":
            return Color.white
        default:
            return Color.black
        }
    }
}



