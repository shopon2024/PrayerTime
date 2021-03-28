//
//  LocationManager.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 23/3/21.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()

    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var currentCity: String?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedAlways, .authorizedWhenInUse:
//            manager.requestLocation()
//        default : break
//        }
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("LOCATION: \(location)")
            currentLocation = location.coordinate
            geocode(location)
        }   
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR :: \(error)")
    }
    
    private func geocode(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] places, _ in
            self?.currentCity = places?.first?.locality
        }
    }
}
