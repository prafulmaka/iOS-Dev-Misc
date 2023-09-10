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
            }
        }
    }
    
    func signOut() {
        do {
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
    
    func fetchFromAPI(userid: String) {
        var url = URLRequest(url: URL(string: "https://adb-1074186372755222.2.azuredatabricks.net/api/2.1/jobs/run-now")!)
        
        url.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.setValue("application/json", forHTTPHeaderField: "Accept")
        url.httpMethod = "POST"
        
        url.allHTTPHeaderFields = ["Authorization": "Bearer "]
        
//        let json: [String: Any] = ["job_id": 1112480374427870, "notebook_params": ["userid": "mY8u0bJwZleDt24qfkf2sqq83ex1"]]
        let json: [String: Any] = ["job_id": 1112480374427870, "notebook_params": ["userid": userid]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        url.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8),
               let response = response {
                print(string)
                print(response)
            }
        }
        
        
        task.resume()
        
    }
}
