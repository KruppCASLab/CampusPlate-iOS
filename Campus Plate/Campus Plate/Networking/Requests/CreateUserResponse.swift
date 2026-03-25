//
//  CreateUserResponse.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/25/26.
//

import Foundation

struct CreateUserResponse : Codable{
    var data:Data?
    var status:Int
    var error:Int
}
