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
                print("success")
                self.userSession = result?.user
            }
        }

    }
}
