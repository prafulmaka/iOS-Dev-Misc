import SwiftUI
import CoreLocation
import Firebase
import MapKit

class DBClass {
    func addData(lat: Float, long: Float) {
        let db = Firestore.firestore()
        
        db.collection("locations").document("TEST").setData(["latitude": lat, "longitude": long]) {error in
            if error == nil {
                print("Success")
            }
            else {
                print("Failure")
            }
        }
    }
}


struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @State var tracking:MapUserTrackingMode = .follow
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.33,
            longitude: -122.07
        ), span: MKCoordinateSpan(
            latitudeDelta: 0.5, longitudeDelta: 0.5
        )
    )
        
    var body: some View {
        VStack {
            switch locationDataManager.locationManager.authorizationStatus {
                
            case .authorizedWhenInUse:
                Text("Your current location is: ")
                Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                let _ = DBClass().addData(lat: Float(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "0.00") ?? 0.00,long: Float(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "0.00") ?? 0.00)
    
                
                Map(coordinateRegion: $region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking)
                                                
            case .restricted, .denied:
                Text("Current location was restricted or denied")
                
            case .notDetermined:
                Text("Finding your location")
                ProgressView()
                
            default:
                ProgressView()
        
            }
            
            Button(action: { AuthViewModel().signOut() }) {
                Text("Sign Out")
            }
    
        }

    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
