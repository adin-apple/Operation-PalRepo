/*:
 SettingsView.swift
 */

/*----------------------------------------------------------------------------------------------------------*/
/*  I M P O R T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
import Foundation
import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

/*----------------------------------------------------------------------------------------------------------*/
/*  S T R U C T S                                                                                           */
/*----------------------------------------------------------------------------------------------------------*/
struct SettingsView: View {
    @ObservedObject var baseData: BaseData
    @Environment(\.modelContext) private var context
    @State private var email = ""
    @State private var password = ""
    @StateObject var authManager = AuthManager()
    @State private var showLogoutAlert = false
    @State private var showAnotherUserAlert = false

    var body: some View {
        VStack {
            Text(authManager.isLoggedIn ? "Currently logged in!" : "Create an Account!")
                .padding()

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .padding(.horizontal)

            Button("Sign Up") {
                if authManager.isLoggedIn {
                    showAnotherUserAlert = true
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("Error signing up: \(error.localizedDescription)")
                        } else {
                            print("User signed up successfully")
                            email = ""
                            password = ""
                            authManager.isLoggedIn = true
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")

                            // Fetch base data after signing up
                            if let userId = Auth.auth().currentUser?.uid {
                                FirestoreManager.shared.getBaseData(userId: userId, baseData: baseData) { error in
                                    if let error = error {
                                        print("Error fetching base data: \(error.localizedDescription)")
                                    } else {
                                        print("Base data fetched successfully")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()

            Button("Sign In") {
                if authManager.isLoggedIn {
                    showAnotherUserAlert = true
                } else {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print("Error signing in: \(error.localizedDescription)")
                        } else {
                            print("User signed in successfully")
                            email = Auth.auth().currentUser?.email ?? ""
                            password = ""
                            authManager.isLoggedIn = true
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")

                            // Fetch base data after signing in
                            if let userId = Auth.auth().currentUser?.uid {
                                FirestoreManager.shared.getBaseData(userId: userId, baseData: baseData) { error in
                                    if let error = error {
                                        print("Error fetching base data: \(error.localizedDescription)")
                                    } else {
                                        print("Base data fetched successfully")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()

            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    print("User signed out successfully")
                    authManager.isLoggedIn = false
                    showLogoutAlert = true
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }
            .padding()
            .alert(isPresented: $showLogoutAlert) {
                Alert(title: Text("Logged Out"), message: Text("You have been logged out."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showAnotherUserAlert) {
                Alert(title: Text("Another User Logged In"), message: Text("Another user is currently logged in. Please sign out first."), dismissButton: .default(Text("OK")))
            }
        }
    }
}
