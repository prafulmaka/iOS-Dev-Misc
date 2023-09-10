
import SwiftUI
import CoreLocation
import Firebase
import MapKit

class DBClass {
    func addData(userid: String, lat: Float, long: Float) {
        let db = Firestore.firestore()

        db.collection("locations").document(userid).updateData(["userid": userid, "latitude": lat, "longitude": long]) {error in
            if error == nil {
                print("Success")
            }
            else {
                print("Failed to update. New document to be added.")
                db.collection("locations").document(userid).setData(["userid": userid, "latitude": lat, "longitude": long])
            }
        }
    }
}

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
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(checkpoints)
        uiView.showsUserLocation = true
    }

}


struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @State var tracking:MapUserTrackingMode = .follow
    
    @State var checkpoints: [Checkpoint] = [
        Checkpoint(title: "Walnut Creek", coordinate: .init(latitude: 37.918567, longitude: -122.085356)),
        Checkpoint(title: "Sacramento", coordinate: .init(latitude: 38.572209, longitude: -121.495964))
    ]

    // Signout state
    @State var signout = false

    // If signout is true - go back to LoginView
    // If signout is false - use mainmap view
    var body: some View {
        if signout == true {
            LoginView()
        } else {
            mainmap
        }
    }

    var mainmap: some View {

        VStack {
            switch locationDataManager.locationManager.authorizationStatus {

            case .authorizedWhenInUse:
                Text("Your current location is: ")
                Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")


                let _ = DBClass().addData(userid: String(Auth.auth().currentUser?.uid ?? "NIL"), lat: Float(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "0.00") ?? 0.00,long: Float(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "0.00") ?? 0.00)
                
                MapViewAdvance(checkpoints: $checkpoints)

            case .restricted, .denied:
                Text("Current location was restricted or denied")

            case .notDetermined:
                Text("Finding your location")
                ProgressView()

            default:
                ProgressView()

            }

            Button(action: {
                // Sign out
                AuthViewModel().signOut()

                // Stop updating location
                // Toggle signout
                locationDataManager.locationManager.stopUpdatingLocation() }) {
                Text("Sign Out")
                    .onAppear {
                        Auth.auth().addStateDidChangeListener { auth, user in
                            if user == nil {
                                signout.toggle()
                            }

                        }
                    }
            }

            Button(action: {
                AuthViewModel().fetchFromAPI(userid: Auth.auth().currentUser?.uid ?? "NIL")
            }) {
                Text("Execute API")
            }


        }

    }

}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
