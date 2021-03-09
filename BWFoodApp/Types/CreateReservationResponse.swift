//
//  CreateReservationResponse.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/8/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class CreateReservationResponse : Codable {
    public var status:Int?
    public var error:String?
    public var data:Reservation?
}
