//
//  FoodStop.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 11/23/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class FoodStop:Codable {
    
    let foodStopID : Int
    let name : String
    let description : String
    let lat : Double
    let lng : Double
    

    init(foodStopID:Int, name:String, description: String, lat : Double, lng : Double) {
        
        self.foodStopID = foodStopID
        self.name = name
        self.description = description
        self.lat = lat
        self.lng = lng
        
    }
}

