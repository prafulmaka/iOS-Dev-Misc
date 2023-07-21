//
//  BalanceView.swift
//  observable-object
//
//  Created by Praful Maka on 6/17/23.
//

import SwiftUI

struct BalanceView: View {
    
    @EnvironmentObject var profile: Profile 
    
    var body: some View {
        
        VStack{
         
            if profile.isLoggedIn == true {
                Text("Your balance is $0")
            }
            else {
                Text("$XXX")
            }
        
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
