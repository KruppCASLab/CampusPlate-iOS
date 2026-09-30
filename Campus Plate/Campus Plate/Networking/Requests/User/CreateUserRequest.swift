//
//  CreateUserRequest.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/25/26.
//

import Foundation

struct CreateUserRequest : Encodable {
    var userName : String
    var credential : Credential
    
    struct Credential : Encodable {
        var label = "iPhone"
    }
    
    init(userName: String) {
        self.userName = userName
        self.credential = Credential()
    }
}


