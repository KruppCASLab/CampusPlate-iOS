//
//  ItemListRow.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/17/26.
//

import SwiftUI

struct ItemListRow: View {
    var listing:Listing
    var foodStop:FoodStop
    
    var body: some View {
        Group {
            HStack() {
                Capsule()
                    .foregroundStyle(Color(hexaRGB: foodStop.hexColor) ?? Color.secondary)
                    .frame(width:10)
                VStack(alignment: .leading) {
                    Text(listing.title ?? "(Missing Title)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                    Text(foodStop.name)
                    Text("\(listing.quantityRemaining ?? 0) Remaining")
                        .textCase(.uppercase)
                }
                Spacer()
                
            }.frame(height:120)
        }
        .padding()
    }
}

#Preview {
    let listing = Listing(title: "Chicken Wings (Kosher)", quantityRemaining: 10)
    let foodStop = FoodStop(foodStopId: 1, name: "CWRU Community Pantry", description: "Come by the Pantry!", streetAddress: "123 Main Street", lat: 0.0, lng: 0.0, hexColor: "003071", foodStopNumber: 1)
    ItemListRow(listing: listing, foodStop: foodStop)
}
