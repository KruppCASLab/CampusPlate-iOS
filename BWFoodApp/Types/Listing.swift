//
//  Types.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/27/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit
import Foundation

class Listing {
    public let food:String
    public let location:String
    public let time:String
    
    init(food:String, location:String, time:String) {
        self.location = location
        self.food = food
        self.time = time
    }
    
}


