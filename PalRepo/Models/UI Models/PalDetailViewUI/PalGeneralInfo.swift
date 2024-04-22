/*:
    PalGeneralInfo.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct PalGeneralInfo: View {
    
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
        Text("\(pal.palName)")
            .font(.title)
            .bold()
        
        HStack{
            Spacer()

            VStack{
                Circle()
                    .frame(width: 150, height: 150)
                    .overlay(
                        Image(pal.palKey)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                    )
                
                Text("\(pal.palKey)")
                    .bold()
                    .padding()
            }
            
            Spacer()
        }

        Text(pal.palAsset.insertSpacesBeforeCapitals())
            .font(.callout)
        
        VStack(alignment: .leading, spacing: 10) {
            ForEach(pal.palTyping, id: \.self) { typing in
                HStack {
                    Image(imageName(from: typing.typeImage))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    
                    Text(typing.typeName.capitalized)
                    
                    Image(imageName(from: typing.typeImage))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
        }
        .padding()
        
        Link("\(pal.palName) Wiki", destination: URL(string: pal.palWiki.absoluteString)!)
            .padding()
    }
}
