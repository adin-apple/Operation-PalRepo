/*:
    MainView.swift
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
struct MainView: View {
    @State var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack (path: $path) {
            setupUI(path: $path)
        }
    }
    /*------------------------------------------------------------------------------------------------------*/
    /*  P U B L I C   F U N C T I O N S                                                                     */
    /*------------------------------------------------------------------------------------------------------*/
    func setupUI(path: Binding<NavigationPath>) -> some View {
        ZStack {
            Image("PalWorldCover")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Image("Welcome Label")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(12)
                    
                    ImageButton(imageName: "PalDeck Button") {
                        path.wrappedValue.append("PalDeck View")
                    }
                    
                    ImageButton(imageName: "Camps Button") {
                        path.wrappedValue.append("Camps View")
                    }
                    
                    ImageButton(imageName: "World Map Button") {
                        path.wrappedValue.append("World Map View")
                    }
                    
                    ImageButton(imageName: "Settings Button") {
                        path.wrappedValue.append("Settings View")
                    }
                    Spacer().padding()
                    Spacer().padding()
                    Spacer().padding()
                    
                }
                .navigationDestination(for: String.self) { view in
                    switch view {
                    case "PalDeck View":
                        PalDeckView()
                        
                    case "Camps View":
                        CampsView()
                        
                    case "World Map View":
                        WorldMapView()
                        
                    case "Settings View":
                        SettingsView()
                        
                    default:
                        MainView()
                        
                    }
                }
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



