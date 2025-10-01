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
    private let managed: Int
    private let reservable: Int
    

    init(foodStopID:Int, name:String, description: String, streetAddress:String, lat: Double, lng: Double, hexColor: String, foodStopNumber:Int, managed:Int, reservable:Int) {
    
        self.foodStopId = foodStopID
        self.name = name
        self.description = description
        self.streetAddress = streetAddress
        self.lat = lat
        self.lng = lng
        self.hexColor = hexColor
        self.foodStopNumber = foodStopNumber
        self.managed = managed
        self.reservable = reservable
    }
    
    public func isReservable() -> Bool {
        return reservable == 1
    }
    public func isManaged() -> Bool {
        return managed == 1
    }
}

