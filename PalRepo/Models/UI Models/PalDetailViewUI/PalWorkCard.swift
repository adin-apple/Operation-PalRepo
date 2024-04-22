/*:
    PalWorkCard.swift
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
struct PalWorkCard: View {
    let pal: PalCharacter
    
    init(pal: PalCharacter) {
        self.pal = pal
    }
    
    var body: some View {
        
        VStack {
            HStack{
                Text("Work Suitability")
                    .font(.title2)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.5))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                
                ForEach(pal.palWork, id: \.self) { work in
                    VStack {
                        Text("\(work.workType.formatCapitalAndUnderscore())")
                            .bold()
                        Image(imageName(from: work.workImage))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        HStack(spacing: 5) {
                            ForEach(0..<4) { index in
                                Image(systemName: index < work.workLevel ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            }
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        

    }
}

