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
    
//    func getClosestUser() {
//        let db = Firestore.firestore()
//        let docRef = db.collection("locations").document(String(Auth.auth().currentUser?.uid ?? "NIL"))
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                let userid = dataDescription?["userid"]
//                print(userid ?? "NIL")
//                print("Document data: \(String(describing: dataDescription))")
//            }
//
//        }
//
//    }
    
    func getClosestUser(completion: @escaping (NSArray) -> ()) {
        let db = Firestore.firestore()
//        let docRef = db.collection("locations").document(String(Auth.auth().currentUser?.uid ?? "NIL"))
        // Hardcoded for testing
        let docRef = db.collection("locations").document("sUuRMJ85QaUpE1T579P1juX68sZ2")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let closest_users = dataDescription?["Closest_Users"]
                print(closest_users ?? "NIL")
                print("Document data: \(String(describing: dataDescription))")
                completion(closest_users as! NSArray)
            }

        }

    }
    
    
    func deleteData(userid: String) {
        let db = Firestore.firestore()
        
        db.collection("locations").document(userid).delete() {error in
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
