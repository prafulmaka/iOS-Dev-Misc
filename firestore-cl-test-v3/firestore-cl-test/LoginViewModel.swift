//
//  LoginViewModel.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/20/23.
//

import Foundation

extension LoginView {
    class LoginViewModel: ObservableObject {
        @Published var username: String = ""
        @Published var password: String = ""
    }
}
