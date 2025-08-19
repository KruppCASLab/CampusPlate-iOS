//
//  WSListing.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 9/9/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class Listing: Codable {
    public var listingId:Int?
    public var foodStopId:Int?
    public var userId:Int?
    public var title:String?
    public var description:String?
    public var creationTime:Int?
    public var quantity:Int?
    public var image: String?
    public var expirationTime: Int?
    public var weightOunces: Double?
    public var quantityRemaining: Int?
 
    init(listingId:Int, foodStopId:Int, userId:Int, title:String, description:String, creationTime:Int, quantity:Int, image:String, expirationTime: Int, weightOunces: Double) {
        
        self.listingId = listingId
        self.foodStopId = foodStopId
        self.userId = userId
        self.title = title
        self.description = description
        self.creationTime = creationTime
        self.quantity = quantity
        self.image = image
        self.expirationTime = expirationTime
        self.weightOunces = weightOunces
        
    }
    
    init(foodStopId:Int, title:String, description:String,quantity:Int, image:String, expirationTime: Int, weightOunces: Double) {
        
        self.foodStopId = foodStopId
        self.title = title
        self.description = description
        self.quantity = quantity
        self.image = image
        self.expirationTime = expirationTime
        self.weightOunces = weightOunces
        
    }
    init(foodStopId:Int, title:String, description:String,quantity:Int, expirationTime: Int, weightOunces: Double) {
        
        self.foodStopId = foodStopId
        self.title = title
        self.description = description
        self.quantity = quantity
        self.expirationTime = expirationTime
        self.weightOunces = weightOunces
    }
}
