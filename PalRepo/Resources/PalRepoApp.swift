/*:
    PalRepoApp.swift
 */

/*------------------------------------------------------------------------------------------------------------
    I M P O R T S
------------------------------------------------------------------------------------------------------------*/
import SwiftUI
import SwiftData
import Firebase

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
@main
struct PalRepoApp: App {
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  I N I T                                                                                             */
    /*------------------------------------------------------------------------------------------------------*/
    init() {
        FirebaseApp.configure()
    }
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    let palContainer: ModelContainer = {
        let schema = Schema([PalCharacter.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  U I   H A N D L I N G                                                                               */
    /*------------------------------------------------------------------------------------------------------*/
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: PalCharacter.self) { result in
            do {
                let container = try result.get()

                /* Check we haven't already added our users. */
                let descriptor = FetchDescriptor<PalCharacter>()
                let existingUsers = try container.mainContext.fetchCount(descriptor)
                guard existingUsers == 0 else { return }

                /* Load and decode the JSON. */
                guard let url = Bundle.main.url(forResource: "pals", withExtension: "json") else {
                    fatalError("Failed to find users.json")
                }

                let data = try Data(contentsOf: url)
                let pals = try JSONDecoder().decode([PalCharacter].self, from: data)
                
                /* Add all our data to the context. */
                for pal in pals {
                    container.mainContext.insert(pal)
                }
            } catch {
                print("Failed to pre-seed database with error: \(error)")
            }
        }
    }
    
}





    




