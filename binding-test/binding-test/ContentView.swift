//
//  ContentView.swift
//  binding-test
//
//  Created by Praful Maka on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var count: Int = 0
    
    @State var isSecondView: Bool = false
    
    var body: some View {
        if isSecondView == false {
            first
        } else {
            SecondView(count: $count)
        }
    }
    
    var first: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button(action: {
                count = count + 1
            }) {
                Image(systemName: "arcade.stick.and.arrow.up")
            }
            
            Button(action: {
                isSecondView.toggle()
                print(isSecondView)
            }) {
                Text("Navigate to Second View")
            }
            
            Text("Count is \(count)")
        }
        .padding()
    }
}

