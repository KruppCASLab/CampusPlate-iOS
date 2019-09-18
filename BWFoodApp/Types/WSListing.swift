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
    public var userId:Int?
    public var title:String?
    public var lat:Double?
    public var lng:Double?
    public var creationTime:String?
    public var quantity:Int?
    
    init() {
        
    }
}
