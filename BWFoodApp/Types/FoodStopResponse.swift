//
//  FoodStopResponse.swift
//  BWFoodApp
//
//  Created by Brian Krupp on 2/11/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class FoodStopResponse : Codable {
    public var status:Int?
    public var error:String?
    public var data:[FoodStop]?
}
