//
//  Reservation.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/1/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class Reservation: Codable{
    
    public var reservationId: Int?
    public var userId : Int?
    public var listingId: Int?
    public var quantity : Int?
    public var status: Int?
    public var code: Int?
    public var timeCreated: Int?
    public var timeExpired: Int?
    
    init(reservationId: Int, userId: Int, listingId: Int, quantity: Int, status: Int, code: Int, timeCreated: Int, timeExpired: Int) {
        
        self.reservationId = reservationId
        self.userId = userId
        self.listingId = listingId
        self.quantity = quantity
        self.status = status
        self.code = code
        self.timeCreated = timeCreated
        self.timeExpired = timeExpired
    }
    
    init(listingId: Int, quantity: Int) {
        self.listingId = listingId
        self.quantity = quantity
    }
    
}
