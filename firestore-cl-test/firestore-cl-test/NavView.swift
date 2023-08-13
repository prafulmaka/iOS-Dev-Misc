//
//  NavView.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/13/23.
//

import SwiftUI

struct NavView: View {
    @EnvironmentObject var authDetails: AuthViewModel
    
    var body: some View {
        Group {
            if AuthViewModel().userSession != nil {
                TestView()
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
