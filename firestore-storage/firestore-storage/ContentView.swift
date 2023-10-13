//
//  ContentView.swift
//  firestore-storage
//
//  Created by Praful Maka on 10/12/23.
//

import SwiftUI
import SwiftUI
import CoreLocation
import Firebase
import MapKit
import FirebaseFirestoreSwift
import FirebaseStorage
import SDWebImageSwiftUI
import URLImage

struct ContentView: View {
    
    @ObservedObject var imgurl: FirebaseTings

    
    var body: some View {
        VStack {
            
            Text("Image URL: \(imgurl.imgURL?.absoluteString ?? "URL not loaded")")
            
            AsyncImage(url: imgurl.imgURL) { image in
                image.resizable()
            } placeholder: {
                Text("Loading")
            }
            .scaledToFit()
            
            Button(action: {
                imgurl.loadImageFromFirebase()
            }) {
                Text("Press this button")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imgurl: FirebaseTings())
    }
}
