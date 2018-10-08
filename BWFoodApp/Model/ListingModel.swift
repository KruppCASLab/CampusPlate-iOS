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
    
    private init() {
        // Mock Data
        self.listings.append(Listing(food: "Pizza", coordinate: CLLocationCoordinate2D(latitude: 41.3708812, longitude: -81.8478923), time: "Today", location: "MACs"))
        self.listings.append(Listing(food: "Yogurt", coordinate: CLLocationCoordinate2D(latitude: 41.3684241, longitude: -81.8439512), time: "Tomorrow", location: "Lou Higgins Center"))
        self.listings.append(Listing(food: "Hamburger", coordinate: CLLocationCoordinate2D(latitude: 41.3719144, longitude: -81.8478714), time: "Yesterday", location: "The Union"))
        self.listings.append(Listing(food: "Cheese", coordinate: CLLocationCoordinate2D(latitude: 41.3732252, longitude: -81.8509172), time: "Today", location: "Telfer Hall"))
        self.listings.append(Listing(food: "Pizza", coordinate: CLLocationCoordinate2D(latitude: 41.3692863, longitude: -81.8478429), time: "Tommorrow", location: "Bonds Administration"))
        self.listings.append(Listing(food: "Salad", coordinate: CLLocationCoordinate2D(latitude: 41.3692883, longitude: -81.8478439), time: "Friday", location: "Malickey"))
    }
    
    
    static public func getSharedInstance() -> ListingModel {
        return self.sharedInstance
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
