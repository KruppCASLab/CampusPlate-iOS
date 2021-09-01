//
//  Credential.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 4/14/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

class KeychainCredential {
    let username: String
    let password: String
    

    init(username:String, password:String) {
        self.username = username
        self.password = password
        
    }
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
