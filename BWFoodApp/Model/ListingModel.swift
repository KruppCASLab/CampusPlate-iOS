//
//  ListingModel.swift
//  BWFoodApp
//
//  Created by Brian Krupp on 8/20/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import Foundation
import MapKit

class ListingModel {
    private var listings = Array<WSListing>()
    
    private let url = URL(string: "https://mops.bw.edu/food/rest.php/listings")
    
    private static let sharedInstance = ListingModel()
    let session = URLSession.shared
    
    private init() {
    }
    
    static public func getSharedInstance() -> ListingModel {
        return self.sharedInstance
    }
    
    public func loadListings(completion:@escaping (Bool)->Void) {
        session.dataTask(with: url!) { (data, response, error) in
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(Response.self, from: data!)
                self.listings = response.data!
                completion(true)
            }
            catch {
                
            }
        
            }.resume()
    }
    
    
    public func update() {
        //TODO: Call service client to update
    }
    
    public func getListing(index:Int) -> WSListing {
        return self.listings[index]
    }
    
    public func addListing(listing:WSListing, completion:@escaping (Bool)->Void) {
        self.listings.append(listing)
        var request = URLRequest(url: self.url!)
        
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(listing)
            session.uploadTask(with: request, from: data) { (data, response, error) in
                completion(true)
            }.resume()
        }
        catch {
            
        }
    }
    
    public func removeListing(index:Int) {
        self.listings.remove(at: index)
    }
    
    public func getNumberOfListings() -> Int {
        return self.listings.count
    }
    
    
}
