//
//  ItemsList.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/17/26.
//

import SwiftUI

func findFoodStop(foodStops:[FoodStop], foodStopId: Int) -> FoodStop? {
    for foodStop in foodStops {
        if foodStop.foodStopId == foodStopId {
            return foodStop
        }
    }

    return nil
}

struct ItemsList: View {
    @State var listings:[Listing] = []
    @State var foodStops:[FoodStop] = []
    
    var body: some View {
        List(listings, id:\.self) { listing in
            if let foodStopId = listing.foodStopId, let foodStop = findFoodStop(foodStops: foodStops, foodStopId: foodStopId) {
                ItemListRow(listing: listing, foodStop: foodStop)
            }
        }
        .task {
            do {
                let listingResponse = try await ListingModel.getListings()
                let foodStopResponse = try await FoodStopModel.getFoodStops()
                listings = listingResponse.data
                foodStops = foodStopResponse.data
            }
            catch {
                print(error)
            }
        }
    }
}

#Preview {
    ItemsList()
}
