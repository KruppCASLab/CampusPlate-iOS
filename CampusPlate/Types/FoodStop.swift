//
//  FoodStop.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 11/23/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class FoodStop:Codable {
    
    let foodStopId : Int
    let name : String
    let description : String
    let streetAddress : String
    let lat : Double
    let lng : Double
    let hexColor: String
    let foodStopNumber: Int
    let type: String
    

    init(foodStopID:Int, name:String, description: String, streetAddress:String, lat: Double, lng: Double, hexColor: String, foodStopNumber:Int, type:String) {
    
        self.foodStopId = foodStopID
        self.name = name
        self.description = description
        self.streetAddress = streetAddress
        self.lat = lat
        self.lng = lng
        self.hexColor = hexColor
        self.foodStopNumber = foodStopNumber
        self.type = type
    }
}

