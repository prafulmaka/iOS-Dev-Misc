//
//  LoginView.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 8/6/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginView: View {

    @State private var userIsLoggedIn = false
    @ObservedObject var vm = LoginViewModel()
    
    @EnvironmentObject var testVal: AuthViewModel
    
    var body: some View {
        if userIsLoggedIn == true {
            ContentView()
        } else {
            login
        }
    }
    
    
    var login: some View {
        NavigationView {
            VStack (alignment: .center, spacing: 15) {
                Image(systemName: "star")
                    .imageScale(.small)
                    .foregroundColor(.black)
                Text("Work in Progress").padding(.bottom, 100)

                TextField("Username",
                          text: $vm.username,
                          prompt: Text("Username"))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)

                SecureField("Password",
                          text: $vm.password,
                          prompt: Text("Password"))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                Button {
                    AuthViewModel().login(email: vm.username, password: vm.password)
                } label: {
                    Text("Sign In")
                }
                .onAppear {
                    Auth.auth().addStateDidChangeListener {auth, user in
                        if user != nil {
                            userIsLoggedIn.toggle()
                        }
                    }
                }
    
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
