//
//  FirebaseTings.swift
//  firestore-storage
//
//  Created by Praful Maka on 10/13/23.
//

import Foundation
import SwiftUI
import FirebaseStorage

class FirebaseTings: ObservableObject {
    
    @Published var imgURL: URL?

    func loadImageFromFirebase() {
        let storage = Storage.storage()
        
        let gsReference = storage.reference(forURL: "gs://swift-auth-ee592.appspot.com/test-img.jpg")
        
    //    let imgRef = gsReference.child("test-img.jpg")
        
        gsReference.downloadURL { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(url!)
                self.imgURL = url
            }
        }
    }
    
}
