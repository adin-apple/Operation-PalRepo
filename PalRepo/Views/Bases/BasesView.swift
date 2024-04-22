/*:
    BasesView.swift
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
struct BasesView: View {
    @ObservedObject var baseData: BaseData
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Spacer()

            Text("Select A Base!")
                .bold()
                .font(.title)

            Spacer()

            HStack {
                Spacer()
                VStack {
                    myCircleButton(number: 1) {
                        path.append(1)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()

                VStack {
                    myCircleButton(number: 2) {
                        path.append(2)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()

                VStack {
                    myCircleButton(number: 3) {
                        path.append(3)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()
            }
            .navigationDestination(for: Int.self) { view in
                switch view {
                case 1:
                    BaseOneView(baseData: baseData, base: $baseData.base1, selectedPals: $baseData.base1Pals)

                case 2:
                    BaseTwoView(baseData: baseData, base: $baseData.base2, selectedPals: $baseData.base2Pals)

                case 3:
                    BaseThrView(baseData: baseData, base: $baseData.base3, selectedPals: $baseData.base3Pals)

                default:
                    MainView()
                }
            }
            Spacer()
            Spacer()
        }
    }
}


struct myCircleButton: View {
    let number: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 100, height: 100)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                
                Text("\(number)")
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
    }
}

