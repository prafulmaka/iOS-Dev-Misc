//
//  ContentView.swift
//  firebase-auth
//
//  Created by Praful Maka on 6/18/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {

    @State var email: String = ""
    @State var password: String = ""
    
    @ObservedObject var model = ViewModel()
    

    var body: some View {
        VStack(alignment: .center, spacing: 15) {

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
            
            Button(action: { login() }) {
                Text("Sign In")
                
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
        
        model.addData(stringval: "test-value")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
