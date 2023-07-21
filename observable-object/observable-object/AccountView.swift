//
//  AccountView.swift
//  observable-object
//
//  Created by Praful Maka on 6/17/23.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var profile: Profile
    
    var body: some View {
        
        VStack {
            
        if profile.isLoggedIn == true {
            Text("Hello and welcome back!")
        }
        else {
            Text("Please log in")
        }
        
        // Balance
        BalanceView()
            
        Button(action: {
            profile.isLoggedIn = true
        }, label: {
            Text("Log in")
        })
            
        }
        
            
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
