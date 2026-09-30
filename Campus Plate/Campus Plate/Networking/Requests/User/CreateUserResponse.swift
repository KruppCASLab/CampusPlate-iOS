//
//  CreateUserResponse.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/25/26.
//

import Foundation

enum CreateUserResponseStatus : Int, Codable {
    case success = 0
    case successAccountExists = 2
    case error = 1
}

struct CreateUserResponse : Codable {
    var data:User?
    var status:CreateUserResponseStatus
    var error:Int?
}
