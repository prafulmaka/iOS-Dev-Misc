//
//  ViewModel.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/1/23.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    func addData(stringval: String) {
        let db = Firestore.firestore()
        
        db.collection("test").addDocument(data: ["val": stringval]) {error in
            if error == nil {
                print("Success")
            }
            else {
                print("Failure")
            }
        }
    }
    
}
