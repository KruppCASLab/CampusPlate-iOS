//
//  User.swift
//  Campus Plate
//
//  Created by Brian Krupp on 1/15/26.
//

import Foundation

struct User : Codable {
    public let username: String
    public var password:String?
    public var pin: Int?
//    var credential:Credential?
}
