//
//  LocationManager.swift
//  BWFoodApp
//
//  Created by Julia  Gersey on 2/14/24.
//  Copyright © 2024 Campus Plate - BW. All rights reserved.
//

import Foundation
import CoreLocation
import CoreLocationUI

protocol LocationManagerDelegate {
    func receiveLocation(location:CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    public var delegate:LocationManagerDelegate?
    
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            if let delegate = delegate {
                delegate.receiveLocation(location: location)
            }
        }
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
