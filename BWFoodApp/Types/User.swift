//
//  File.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/2/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class User: Codable {
    public var username:String?
    public var password:String?
    public var emailAddress:String?
    
 
    init(username: String, password: String, emailAddress: String) {
        self.username = username
        self.password = password
        self.emailAddress = emailAddress
    }
}
