import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    static let shared = LocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var userLocation: CLLocation?
    @Published var address: String = "Buscando endereço..."
    @Published var location: CLLocation? {
        didSet {
            fetchAddress(from: location)
        }
    }

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    private func fetchAddress(from location: CLLocation?) {
        guard let location = location else { return }

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Erro ao obter endereço: \(error.localizedDescription)")
                self?.address = "Erro ao obter endereço"
                return
            }

            guard let placemark = placemarks?.first else {
                self?.address = "Endereço não encontrado"
                return
            }

            let street = placemark.thoroughfare ?? ""
            let number = placemark.subThoroughfare ?? ""
            let city = placemark.locality ?? ""
            let state = placemark.administrativeArea ?? ""
            let country = placemark.country ?? ""

            self?.address = "\(street), \(number), \(city), \(state), \(country)"
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("DEBUG: Not determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("DEBUG: Authorized")
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        self.location = location
        manager.stopUpdatingLocation()
    }
}
