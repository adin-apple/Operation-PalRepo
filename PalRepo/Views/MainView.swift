/*:
    MainView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData
import Firebase

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct MainView: View {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  A T T R I B U T E S                                                                                 */
    /*------------------------------------------------------------------------------------------------------*/
    @Environment(\.modelContext) private var context
    @Query var allPals: [PalCharacter]
    
    @StateObject var baseData = BaseData()
    @StateObject var authManager = AuthManager()
    
    @State var path = NavigationPath()

    /*------------------------------------------------------------------------------------------------------*/
    /*  U I   H A N D L I N G                                                                               */
    /*------------------------------------------------------------------------------------------------------*/    var body: some View {
        NavigationStack (path: $path) {
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
                            path.append("PalDeck View")
                        }
                        
                        ImageButton(imageName: "Bases Button") {
                            path.append("Bases View")
                        }
                        
                        
                        ImageButton(imageName: "Settings Button") {
                            path.append("Settings View")
                        }
                        Spacer().padding()
                        Spacer().padding()
                        Spacer().padding()
                        
                    }
                    .navigationDestination(for: String.self) { view in
                        switch view {
                        case "PalDeck View":
                            PalDeckView().navigationBarBackButtonHidden(false)
                            
                        case "Bases View":
                            BasesView(baseData: baseData, path: $path).navigationBarBackButtonHidden(false)
                            
                        case "Settings View":
                            SettingsView(baseData: baseData).navigationBarBackButtonHidden(false)
                            
                        default:
                            MainView()
                            
                        }
                    }
                }
            }
        }
        .onAppear {
                    if authManager.isLoggedIn {
                        authManager.signOut()
                    }
            
                    FirestoreManager.shared.setupPalDictionary(allPals: allPals)
                }
    }
}
