//
//  LocationManager.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/31/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class LocationManager: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        
            locationManager.delegate = self
        
            // Set initial location in Berea
            let initialLocation = CLLocationCoordinate2D(latitude: 41.371039, longitude: -81.847857)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.008,longitudeDelta: 0.008)
            let region = MKCoordinateRegion(center:initialLocation, span: span)
            mapView.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
