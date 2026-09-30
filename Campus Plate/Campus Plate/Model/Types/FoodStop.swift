//
//  FoodStop.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/18/26.
//

import Foundation

struct FoodStop:Codable {
    public var foodStopId:Int
    public var name:String
    public var description:String
    public var streetAddress:String
    public var lat:Double
    public var lng:Double
    public var hexColor:String
    public var foodStopNumber: Int
//    private var managed: Int
//    private var reservable: Int
    
}
