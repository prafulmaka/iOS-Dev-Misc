//
//  observable_objectApp.swift
//  observable-object
//
//  Created by Praful Maka on 6/17/23.
//

import SwiftUI

@main
struct observable_objectApp: App {
    var body: some Scene {
        WindowGroup {
            AccountView()
                .environmentObject(Profile())
        }
    }
}
