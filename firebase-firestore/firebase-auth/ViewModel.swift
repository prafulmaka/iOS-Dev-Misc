//
//  ViewModel.swift
//  firebase-auth
//
//  Created by Praful Maka on 7/21/23.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    func addData(stringval: String) {
        let db = Firestore.firestore()
        
        db.collection("test").addDocument(data: ["val": stringval]) { error in
            if error == nil {
                print("Success")
            }
            else {
                print("Failure")
            }
        }
    }
}
