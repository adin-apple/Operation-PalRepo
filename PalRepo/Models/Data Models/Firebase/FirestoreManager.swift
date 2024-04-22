/*:
    FirestoreManager.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Firebase

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
class FirestoreManager {

    /*------------------------------------------------------------------------------------------------------*/
    /*  V A R I A B L E   H A N D L I N G                                                                   */
    /*------------------------------------------------------------------------------------------------------*/
    static let shared = FirestoreManager()
    let db: Firestore
    let usersCollection: CollectionReference
    
    var palDictionary: [Int: PalCharacter] = [:]

    /*------------------------------------------------------------------------------------------------------*/
    /*  I N I T                                                                                             */
    /*------------------------------------------------------------------------------------------------------*/
    private init() {
        db = Firestore.firestore()
        usersCollection = db.collection("users")
    }
    
    /*------------------------------------------------------------------------------------------------------*/
    /*  P U B L I C   F U N C T I O N S                                                                     */
    /*------------------------------------------------------------------------------------------------------*/
    /* Takes in all pals and converts to a dictionary */
    func setupPalDictionary(allPals: [PalCharacter]) {
        palDictionary = allPals.reduce(into: [:]) { dict, pal in
            dict[pal.palID] = pal
        }
    }

    /* Takes in the data from a base and uploads it to the Firestore */
    func storeBaseData(base: Base, selectedPals: [Int], baseNumber: Int, userId: String) {
        let baseData: [String: Any] = [
            "name": base.name,
            "label": base.label,
            "pals": selectedPals
        ]

        usersCollection.document(userId).collection("bases").document("base\(baseNumber)").setData(baseData) { error in
            if let error = error {
                print("Error storing base data: \(error.localizedDescription)")
            } else {
                print("Base data stored successfully")
            }
        }
    }
    
    /* Retrieves base information from Firestore */
    func getBaseData(userId: String, baseData: BaseData, completion: @escaping (Error?) -> Void) {

        usersCollection.document(userId).collection("bases").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching base data: \(error.localizedDescription)")
                completion(error)
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(nil)
                return
            }

            print("Fetched \(documents.count) documents")

            for document in documents {
                
                if let baseNumberString = document.documentID.components(separatedBy: "base").last,
                   let baseNumber = Int(baseNumberString),
                   let baseName = document["name"] as? String,
                   let baseLabel = document["label"] as? String,
                   let palIDs = document["pals"] as? [Int] {

                    var selectedPals: [PalCharacter] = []
                    for palID in palIDs {
                        if let pal = self.palDictionary[palID] {
                            selectedPals.append(pal)
                        } else {
                            print("No pal found for palID: \(palID)")
                        }
                    }

                    switch baseNumber {
                    case 1:
                        baseData.base1 = Base(id: baseNumber, name: baseName, label: baseLabel)
                        baseData.base1Pals = selectedPals
                    case 2:
                        baseData.base2 = Base(id: baseNumber, name: baseName, label: baseLabel)
                        baseData.base2Pals = selectedPals
                    case 3:
                        baseData.base3 = Base(id: baseNumber, name: baseName, label: baseLabel)
                        baseData.base3Pals = selectedPals
                    default:
                        break
                    }
                }
            }
            
            completion(nil)
        }
    }
}
