/*:
    SelectPalsView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
struct SelectPalsView: View {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedPals: [PalCharacter]
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    var allPals: [PalCharacter]
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  U I   H A N D L I N G                                                                               */
    /*------------------------------------------------------------------------------------------------------*/
    var body: some View {
        NavigationView {
            List(allPals.sorted(by: { $0.palName < $1.palName }), id: \.id) { pal in
                HStack {
                    Image(imageName(from: pal.palImage))
                        .resizable()
                        .frame(width: 35, height: 35)
                    
                    Spacer()
                    
                    Text(pal.palName)
                    
                    Spacer()
                    
                    if selectedPals.contains(pal) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    if let index = selectedPals.firstIndex(of: pal) {
                        selectedPals.remove(at: index)
                    } else {
                        selectedPals.append(pal)
                    }
                }
            }
            .navigationTitle("Select Pals")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
