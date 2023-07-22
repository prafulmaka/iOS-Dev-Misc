//
//  ContentView.swift
//  identifiable
//
//  Created by Praful Maka on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    
    private var oceans = [
        Ocean(name: "Pacific"),
        Ocean(name: "Atlantic"),
        Ocean(name: "Indian"),
        Ocean(name: "Southern"),
        Ocean(name: "Arctic")
    ]
    
    var body: some View {
        VStack {
            List(oceans) {
                Text($0.name)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
