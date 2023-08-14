//
//  NavView.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/13/23.
//

import SwiftUI

struct NavView: View {
    @StateObject var authDetails = AuthViewModel()
    
    var body: some View {
        Group {
            if authDetails.userSession != nil {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
