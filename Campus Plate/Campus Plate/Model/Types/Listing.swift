//
//  Listing.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/17/26.
//

import Foundation

struct Listing:Codable, Hashable {
    public var listingId:Int?
    public var foodStopId:Int?
    public var userId:Int?
    public var title:String?
    public var description:String?
    public var creationTime:Int?
    public var quantity:Int?
    public var image: String?
    public var expirationTime: Int?
    public var weightOunces: Double?
    public var quantityRemaining: Int?
}
