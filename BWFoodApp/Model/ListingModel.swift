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
    private var listings = Array<Listing>()
    
    private static let sharedInstance = ListingModel()
    let session = URLSession.shared
    
    private init() {
        // Mock Data
//        self.listings.append(Listing(food: "Pizza", coordinate: CLLocationCoordinate2D(latitude: 41.3708812, longitude: -81.8478923), time: "9:41 AM", location: "MACs", quantity: "4", foodImage:UIImage(named: "pizza") ?? UIImage(named: "pizza")!))
//        self.listings.append(Listing(food: "Yogurt", coordinate: CLLocationCoordinate2D(latitude: 41.3684241, longitude: -81.8439512), time: "12:42 PM", location: "Lou Higgins Center", quantity: "4", foodImage:UIImage(named: "pizza") ?? UIImage(named: "pizza")!))
//        self.listings.append(Listing(food: "Hamburger", coordinate: CLLocationCoordinate2D(latitude: 41.3719144, longitude: -81.8478714), time: "2:35 PM", location: "The Union", quantity: "5", foodImage: UIImage(named: "pizza") ?? UIImage(named: "pizza")!))
//        self.listings.append(Listing(food: "Cheese", coordinate: CLLocationCoordinate2D(latitude: 41.3732252, longitude: -81.8509172), time: "7:29 PM", location: "Telfer Hall", quantity: "6", foodImage: UIImage(named: "pizza") ?? UIImage(named: "pizza")!))
//        self.listings.append(Listing(food: "Pizza", coordinate: CLLocationCoordinate2D(latitude: 41.3692863, longitude: -81.8478429), time: "10:41 AM", location: "Bonds Administration", quantity: "12", foodImage: UIImage(named: "pizza") ?? UIImage(named: "pizza")!))
//        self.listings.append(Listing(food: "Salad", coordinate: CLLocationCoordinate2D(latitude: 41.3692883, longitude: -81.8478439), time: "1:00 PM", location: "Malickey", quantity: "19", foodImage:UIImage(named: "pizza") ?? UIImage(named: "pizza")!))
    }
    
    static public func getSharedInstance() -> ListingModel {
        return self.sharedInstance
    }
    
    public func loadListings(completion:@escaping (Bool)->Void) {
        if let url = URL(string: "https://mops.bw.edu/food/rest.php/listings") {
            
            session.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            
                do {
                    let response = try decoder.decode(Response.self, from: data!)
                    //response.data!
                    print("Dan is here")
                    let someListing: WSListing = response.data![0]
                    completion(true)
                }
                catch {
                    
                }
                
                
                }.resume()
            
        }

    }
 
    
    public func update() {
        //TODO: Call service client to update
    }
    
    public func getListing(index:Int) -> Listing {
        return self.listings[index]
    }
    
    public func addListing(listing:Listing) {
        self.listings.append(listing)
        
    }
    
    public func removeListing(index:Int) {
        self.listings.remove(at: index)
    }

    public func getNumberOfListings() -> Int {
        return self.listings.count
    }
    
    
}
