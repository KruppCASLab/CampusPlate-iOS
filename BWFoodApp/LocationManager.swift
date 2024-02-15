//
//  LocationManager.swift
//  BWFoodApp
//
//  Created by Julia  Gersey on 2/14/24.
//  Copyright © 2024 Campus Plate - BW. All rights reserved.
//

import Foundation
import CoreLocation

  // only have this start when reservation -> food is clicked (use Dispatch.Main.async Queue) to change reserve/retrieve, stop tracking location when it view.Disappear()
  //pragma mark - location delegate
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//       print(locations)
//  }
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            print("Location permission denied.")
        }
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
}
