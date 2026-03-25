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
        
        let response:CreateUserResponse = try await Networking.upload(path, request)
        
        return response
    }
}
