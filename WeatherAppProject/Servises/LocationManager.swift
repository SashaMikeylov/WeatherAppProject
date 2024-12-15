//
//  LocationManager.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import UIKit
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    private var locationFetchCompletion: ((CLLocation) -> Void)?
    
    
    static let shared = LocationManager()
    
    func getCurrentLocation(completion: @escaping(CLLocation) -> Void) {
        
        self.locationFetchCompletion = completion
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        locationFetchCompletion?(location)
        manager.stopUpdatingLocation()
    }
}
