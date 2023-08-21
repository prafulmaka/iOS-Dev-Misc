//
//  firestore_cl_testApp.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/1/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        print("Firebase is configured")

        return true
    }
}

@main
struct firebase_authApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavView()
        }
    }
}
