import Foundation

class FoodStopModel{
    
    public var foodStops = Array<FoodStop>()
    public var managedFoodStops = Array<FoodStop>()
    
    private let url = URL(string: ServiceClient.serviceClientUrl() + "/foodstops")
    
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
            guard let data = data else {
                completion(false)
                return
            }
        
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(FoodStopResponse.self, from: data)
                
                guard let responseData = response.data else {
                    completion(false)
                    return
                }
                
                self.foodStops = responseData
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
            guard let data = data else {
                completion(false)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(FoodStopResponse.self, from: data)
                guard let responseData = response.data else {
                    completion(false)
                    return
                }
 
                self.managedFoodStops = responseData
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
