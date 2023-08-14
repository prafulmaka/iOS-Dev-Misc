//
//  LoginViewHandler.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/13/23.
//

import SwiftUI

struct LoginViewHandler: View {
    
    @StateObject var loginManager = AuthViewModel()
    
    var body: some View {
        if loginManager.userSession != nil {
            ContentView()
        } else {
            LoginView()
        }
    }
}

struct LoginViewHandler_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewHandler()
    }
}
