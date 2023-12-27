//
//  SecondView.swift
//  binding-test
//
//  Created by Praful Maka on 12/27/23.
//

import SwiftUI

struct SecondView: View {
    
    @Binding var count: Int
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Text("Count is \(count)")
    }
}

