//
//  FoodStopModel.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/26/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

class FoodStopModel{
    
    public var foodStops = Array<FoodStop>()
    public var managedFoodStops = Array<FoodStop>()
    
    private let url = URL(string: "https://mops.bw.edu/cp/rest.php/foodstops")
    
    private static let sharedInstance = FoodStopModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> FoodStopModel {
        return self.sharedInstance
    }
    
    public func loadFoodStops(completion:@escaping (Bool)->Void) {
        var request = URLRequest(url: self.url!)

        request.httpMethod = "GET"
        request = RequestUtility.addAuth(original: request)
        session.dataTask(with: request){ (data, response, error) in
        
            let decoder = JSONDecoder()
        
            do {
                let jsonString = String(data: data!, encoding: .utf8)
                let response = try decoder.decode(FoodStopResponse.self, from: data!)
                self.foodStops = response.data!
                completion(true)
            }
            catch {
                completion(false)
            }
            
        }.resume()
    }
    
    public func loadManagedFoodStops(completion:@escaping (Bool)->Void) {
        var request = URLRequest(url: self.url!.appendingPathComponent("/manage"))

        request.httpMethod = "GET"
        request = RequestUtility.addAuth(original: request)
        session.dataTask(with: request){ (data, response, error) in
        
            let decoder = JSONDecoder()
        
            do {
                let jsonString = String(data: data!, encoding: .utf8)
                let response = try decoder.decode(FoodStopResponse.self, from: data!)
                self.managedFoodStops = response.data!
                completion(true)
            }
            catch {
                completion(false)
            }
            
        }.resume()
    }
    
    public func getFoodStop(foodStopId: Int) -> FoodStop? {
        for foodStop in self.foodStops {
            if foodStop.foodStopId == foodStopId {
                return foodStop
            }
        }
    
        return nil
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


