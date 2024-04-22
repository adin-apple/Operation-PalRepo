/*:
    BasesView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import SwiftUI

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct BasesView: View {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @ObservedObject var baseData: BaseData
    
    @Binding var path: NavigationPath

    /*------------------------------------------------------------------------------------------------------*/
    /*  U I   H A N D L I N G                                                                               */
    /*------------------------------------------------------------------------------------------------------*/
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
                    CircleButton(number: 1) {
                        path.append(1)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()

                VStack {
                    CircleButton(number: 2) {
                        path.append(2)
                    }
                }
                .frame(width: 100, height: 100)

                Spacer()

                VStack {
                    CircleButton(number: 3) {
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
