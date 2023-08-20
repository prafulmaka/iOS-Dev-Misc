//
//  AuthViewModel.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/13/23.
//

import Foundation
import Firebase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Success")
                DispatchQueue.main.async {
                    self.userSession = result?.user
                }
//                self.userSession = result?.user
            }
        }
    }
    
    func signOut() {
        do {
            // Aug 18
            deleteData(userid: String(Auth.auth().currentUser?.uid ?? "NIL"))
            
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.userSession = nil
            }

        }
        catch {
            print(error)
        }
    }
    // Aug 18
    func deleteData(userid: String) {
        let db = Firestore.firestore()
        
        db.collection("locations").document("mY8u0bJwZleDt24qfkf2sqq83ex1").delete() {error in
            if error == nil {
                print("Success")
            }
            else {
                print("Failure")
            }
        }
    }
}
