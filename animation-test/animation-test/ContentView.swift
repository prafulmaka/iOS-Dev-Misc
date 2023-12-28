//
//  ContentView.swift
//  animation-test
//
//  Created by Praful Maka on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange)
            Text("DevTechie")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 100)
        .offset(y: animate ? 200 : 0)
//        .animation(.spring())
        .onTapGesture {
            animate.toggle()
        }
    }
}

