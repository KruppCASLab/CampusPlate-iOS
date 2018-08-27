//
//  ListingModel.swift
//  BWFoodApp
//
//  Created by Brian Krupp on 8/20/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import Foundation

class ListingModel {
    private var listings = Array<Listing>()
    
    init() {
        //TODO: Remove this stub code
        self.listings.append(Listing(food: "Pizza", location: "Beech Street", time: "Today"))
        self.listings.append(Listing(food: "Yogurt", location: "Berea Street", time: "Tomorrow"))
        self.listings.append(Listing(food: "Hamburger", location: "Lincoln Street", time: "Yesterday"))
        self.listings.append(Listing(food: "Cheese", location: "Dan Street", time: "Today"))
        self.listings.append(Listing(food: "Pizza", location: "Brian Street", time: "Tommorrow"))
        self.listings.append(Listing(food: "Salad", location: "Coffee Street", time: "Friday"))
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
