//
//  UserModel.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/18/26.
//

import Foundation

struct UserModel {
    static private let path = "users"
    
    static func createUser(username:String) async throws -> CreateUserResponse {
        let request = CreateUserRequest(userName: username)
        
        let response:CreateUserResponse = try await Networking.post(path, request)
        
        return response
    }
    
    static func confirmUser(username:String, pin:String) async throws -> ConfirmPinResponse {
        
        let request = ConfirmPinRequest(pin: Int(pin) ?? 0)
        var tempPath = "\(path)/\(username)"
        
        let response:ConfirmPinResponse = try await Networking.patch(tempPath, request)
        
        return response
    }
}
