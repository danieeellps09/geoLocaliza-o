import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager.shared

    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {
                Text("Latitude: \(userLocation.coordinate.latitude)")
                Text("Longitude: \(userLocation.coordinate.longitude)")
                Text(locationManager.address)
                    .padding()
            } else {
                LocationRequestView()
            }

            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            locationManager.requestLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
