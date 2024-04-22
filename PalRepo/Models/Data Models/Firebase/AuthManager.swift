/*:
    AuthManager.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Firebase

/*----------------------------------------------------------------------------------------------------------*/
/*  C L A S S                                                                                               */
/*----------------------------------------------------------------------------------------------------------*/
class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            print("User signed out successfully")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
