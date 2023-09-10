//
//  ContentView.swift
//  api-test
//
//  Created by Praful Maka on 8/18/23.
//

import SwiftUI
import MapKit

final class Checkpoint: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

struct MapViewAdvance: UIViewRepresentable {
    @Binding var checkpoints: [Checkpoint]

    func makeUIView(context: Context) -> MKMapView{
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(checkpoints)
        uiView.showsUserLocation = true
    }

    var locationManager = CLLocationManager()

    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }

}

struct ContentView: View {

    @State var checkpoints: [Checkpoint] = [
        Checkpoint(title: "Walnut Creek", coordinate: .init(latitude: 37.918567, longitude: -122.085356)),
        Checkpoint(title: "Sacramento", coordinate: .init(latitude: 38.572209, longitude: -121.495964))
    ]

    var body: some View {

        MapViewAdvance(checkpoints: $checkpoints)
        //        VStack {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundColor(.accentColor)
        //            Text("Hello, world!")
        //        }
            .padding()
    }
}

//import SwiftUI
//import MapKit
//
//final class Checkpoint: NSObject, MKAnnotation {
//    let title: String?
//    let coordinate: CLLocationCoordinate2D
//
//    init(title: String?, coordinate: CLLocationCoordinate2D) {
//        self.title = title
//        self.coordinate = coordinate
//    }
//}
//
//struct MapViewAdvance: UIViewRepresentable {
//
//    var locationManager = CLLocationManager()
//
//    func makeUIView(context: Context) -> MKMapView{
//        setupManager()
//        let mapView = MKMapView(frame: UIScreen.main.bounds)
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//    }
//
//
//    func setupManager() {
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestAlwaysAuthorization()
//    }
//
//}
//
//struct ContentView: View {
//
//    @State var checkpoints: [Checkpoint] = [
//        Checkpoint(title: "Walnut Creek", coordinate: .init(latitude: 37.918567, longitude: -122.085356)),
//        Checkpoint(title: "Sacramento", coordinate: .init(latitude: 38.572209, longitude: -121.495964))
//    ]
//
//    var body: some View {
//
//        MapViewAdvance()
//        //        VStack {
//        //            Image(systemName: "globe")
//        //                .imageScale(.large)
//        //                .foregroundColor(.accentColor)
//        //            Text("Hello, world!")
//        //        }
//            .padding()
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
