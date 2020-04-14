//
//  Credential.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 4/14/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

class Credential {
    let username: String
    let password: String
    let url: String

    init(username:String, password:String, url:String) {
        self.username = username
        self.password = password
        self.url = url
    }
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
