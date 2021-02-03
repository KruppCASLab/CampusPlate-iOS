//
//  FoodStopModel.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/26/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

class FoodStopModel{
    
    private var foodStops = Array<FoodStop>()
    
    private let url = URL(string: "https://mopsdev.bw.edu/food/rest.php/foodStops")
    
    private static let sharedInstance = FoodStopModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> FoodStopModel {
        return self.sharedInstance
    }
    
    public func getFoodStop(index: Int) -> FoodStop {
        return self.foodStops[index]
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


