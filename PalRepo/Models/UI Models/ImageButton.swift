/*:
    ImageButton.swift
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
struct ImageButton: View {
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(10)
        }
    }
}
