//
//  ConfirmPinRequest.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/4/26.
//

struct ConfirmPinRequest : Codable {
    var pin: Int
  
    init(pin: Int) {
        self.pin = pin
    }
}

