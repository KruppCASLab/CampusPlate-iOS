//
//  FoodPickUpSite.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 9/10/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import MapKit

class FoodPickUpSites: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    
    
    
    
}
