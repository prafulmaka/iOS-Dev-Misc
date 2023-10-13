//
//  LocationDetailView.swift
//  firestore-cl-test
//
//  Created by Praful Maka on 9/10/23.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    let location: Location
    
    var body: some View {
        VStack {
            Text(location.title)
                .font(.title)
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: Location.init(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -118.2437), title: "Los Angeles"))
    }
}
