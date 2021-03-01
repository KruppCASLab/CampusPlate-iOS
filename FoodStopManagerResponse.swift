//
//  FoodStopManagerResponse.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/27/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class FoodStopManagerResponse : Codable {
    public var status:Int?
    public var error:String?
    public var data:[FoodStopManager]?
}
