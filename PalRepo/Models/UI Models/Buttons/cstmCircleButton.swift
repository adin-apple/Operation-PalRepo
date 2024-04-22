/*:
    cstmCircleButton.swift
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
struct cstmCircleButton: View {
    let number: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .foregroundColor(isSelected ? Color.blue : Color.gray)
                    .frame(width: 100, height: 100)
                
                if isSelected {
                    Text("\(number)")
                        .foregroundColor(.white)
                        .font(.title)
                } else {
                    Text("+")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
        }
    }
}
