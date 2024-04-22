/*:
    FilterButton.swift
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
struct FilterButton: View {
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(5)
                .background(isSelected ? Color.blue.opacity(0.5) : Color.gray)
                .cornerRadius(10)
        }
    }
}
