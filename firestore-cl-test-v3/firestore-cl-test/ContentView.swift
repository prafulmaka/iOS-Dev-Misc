import SwiftUI
import CoreLocation
import Firebase
import MapKit
import FirebaseFirestoreSwift

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

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

let locations: [Location] = [
    Location(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), title: "San Francisco"),
    Location(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -118.2437), title: "Los Angeles")
]




struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @State var tracking:MapUserTrackingMode = .follow
    
    @State private var selectedLocation: Location?
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.33,
            longitude: -122.07
        ), span: MKCoordinateSpan(
            latitudeDelta: 0.5, longitudeDelta: 0.5
        )
    )
    
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
    
                Map(coordinateRegion: $region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking,
                    annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        // Customize the content of the marker here
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                selectedLocation = location
                            }
                    }
                }
                .sheet(item: $selectedLocation) { location in
                    LocationDetailView(location: location)
                }
                

                
                
                                                
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
            
            Button(action: {
                AuthViewModel().getList()
            }) {
                Text("getList")
            }
    
        }

    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
