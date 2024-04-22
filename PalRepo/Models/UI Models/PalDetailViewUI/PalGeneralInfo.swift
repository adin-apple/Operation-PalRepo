/*:
    PalGeneralInfo.swift
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
struct PalGeneralInfo: View {
    let pal: PalCharacter

    init(pal: PalCharacter) {
        self.pal = pal
    }
    

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

struct CircleButton: View {
    let imageName: String

    var body: some View {
        Circle()
            .foregroundColor(.blue)
            .frame(width: 50, height: 50)
            .overlay(
                Image(systemName: imageName)
                    .foregroundColor(.white)
            )
    }
}

func getPreviousKey(from key: String) -> String {
    guard let intKey = Int(key) else {
        return ""
    }
    
    return String(format: "%03d", intKey - 1)
}

func getNextKey(from key: String) -> String {
    guard let intKey = Int(key) else {
        return ""
    }
    
    return String(format: "%03d", intKey + 1)
}
