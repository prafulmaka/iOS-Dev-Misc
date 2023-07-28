//
//  ContentView.swift
//  CL-test
//
//  Created by Praful Maka on 7/25/23.
//

import SwiftUI
import CoreLocation


struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
        
    var body: some View {
        VStack {
            switch locationDataManager.locationManager.authorizationStatus {
                
            case .authorizedWhenInUse:
                Text("Your current location is: ")
                Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                
            case .restricted, .denied:
                Text("Current location was restricted or denied")
                
            case .notDetermined:
                Text("Finding your location")
                ProgressView()
                
            default:
                ProgressView()
        
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
