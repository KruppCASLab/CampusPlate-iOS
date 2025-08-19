//
//  ListingResponse.swift
//  BWFoodApp
//
//  Created by Brian Krupp on 2/21/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class ListingResponse : Codable {
    public var status:Int?
    public var error:String?
    public var data:[Listing]?
}

