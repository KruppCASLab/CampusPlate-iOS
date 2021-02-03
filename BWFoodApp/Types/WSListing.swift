//
//  WSListing.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 9/9/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class WSListing: Codable {
    public var listingId:Int?
    public var foodStopId:Int?
    public var userId:Int?
    public var title:String?
    public var description:String?
    public var creationTime:Int?
    public var quantity:Int?
    public var image: String?
 
    init(listingId:Int, foodStopId:Int, userId:Int, title:String, description:String, creationTime:Int, quantity:Int, image:String) {
        
        self.listingId = listingId
        self.foodStopId = foodStopId
        self.userId = userId
        self.title = title
        self.description = description
        self.creationTime = creationTime
        self.quantity = quantity
        self.image = image
        
    }
}
