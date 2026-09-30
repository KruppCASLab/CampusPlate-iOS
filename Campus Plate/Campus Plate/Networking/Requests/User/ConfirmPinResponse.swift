//
//  ConfirmPinResponse.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/4/26.
//

enum ConfirmPinResponseStatus : Int, Codable {
    case success = 0
    case invalidMatch = 2
    case pinNotSent = 1
}

struct ConfirmPinData : Codable {
    var GUID:String
}

struct ConfirmPinResponse : Codable {
    var data:ConfirmPinData?
    var status:ConfirmPinResponseStatus
    var error:Int?
}
