//
//  ListingModel.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/21/26.
//

struct GetListingResponse : Codable {
    var data:[Listing]
    var status:String?
    var error:Int?
}

struct GetFoodStopResponse : Codable {
    var data:[FoodStop]
    var status:String?
    var error:Int?
}

struct ListingModel {
    static private let path = "listings"
    
    static func getListings() async throws -> GetListingResponse {
        
        let response:GetListingResponse = try await Networking.get(path)
        
        return response
    }
}

struct FoodStopModel {
    static private let path = "foodstops"
    
    static func getFoodStops() async throws -> GetFoodStopResponse {
        
        let response:GetFoodStopResponse = try await Networking.get(path)
        
        return response
    }
}
