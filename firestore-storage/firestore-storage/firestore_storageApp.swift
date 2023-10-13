//
//  firestore_storageApp.swift
//  firestore-storage
//
//  Created by Praful Maka on 10/12/23.
//

import SwiftUI

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("Firebase is configured")

        return true
    }
}


@main
struct firestore_storageApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(imgurl: FirebaseTings())
        }
    }
}

