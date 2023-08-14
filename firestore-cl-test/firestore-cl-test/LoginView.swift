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

    @State var email: String = ""
    @State var password: String = ""
    @State private var userIsLoggedIn = false
    
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
                          text: $email,
                          prompt: Text("Username"))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)

                SecureField("Password",
                          text: $password,
                          prompt: Text("Password"))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                Button {
                    AuthViewModel().login(email: email, password: password)
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
                    
                Text("\(userIsLoggedIn.description)")
    
                
//                NavigationLink(destination: ContentView()) {
//                    Button(action: { AuthViewModel().login(email: email, password: password) }) {
//                        Text("Sign In")
//                    }
//                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
