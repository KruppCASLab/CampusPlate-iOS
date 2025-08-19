//
//  FoodStopManagerModel.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/27/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

class FoodStopManagerModel{
    
    private var foodStopManagers = Array<FoodStopManager>()
    
    private let url = URL(string: "https://mopsdev.bw.edu/food/rest.php/foodStopManagers")
    
    private static let sharedInstance = FoodStopManagerModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> FoodStopManagerModel {
        return self.sharedInstance
    }
    
    public func loadFoodStopManagers(completion:@escaping (Bool)->Void) {
        var request = URLRequest(url: self.url!)

        request.httpMethod = "GET"
        request = RequestUtility.addAuth(original: request)
        session.dataTask(with: request){ (data, response, error) in
        
            let decoder = JSONDecoder()
        
            do {
                let jsonString = String(data: data!, encoding: .utf8)
                let response = try decoder.decode(FoodStopManagerResponse.self, from: data!)
                self.foodStopManagers = response.data!
                completion(true)
            }
            catch {
                completion(false)
            }
            
        }.resume()
    }
    
    public func getFoodStopManager(foodStopId: Int) -> FoodStopManager? {
        for foodStopManager in self.foodStopManagers {
            if foodStopManager.foodStopId == foodStopId {
                return foodStopManager
            }
        }
    
        return nil
    }
}

