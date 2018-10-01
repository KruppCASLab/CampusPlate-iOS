//
//  Types.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/27/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class Listing : NSObject, MKAnnotation {
    
    public let food:String
    public let coordinate:CLLocationCoordinate2D
    public let time:String
    public let location: String
    
    
    
    init(food:String, coordinate:CLLocationCoordinate2D, time:String, location:String) {
        self.coordinate = coordinate
        self.food = food
        self.time = time
        self.location = location
    }
    
    public var title:String? {
        return self.food
    }
    public var subtitle:String? {
        return self.time
    }
    
    public var locationSubTitle:String? {
        return self.location
    }
    

    

}


