//
//  FoodStopManager.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/27/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class FoodStopManager:Codable {
    
    let foodStopId : Int
    let userId : Int

    init(foodStopId: Int, userId: Int) {
        self.foodStopId = foodStopId
        self.userId = userId
    }
}
