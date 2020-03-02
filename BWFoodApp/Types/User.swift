//
//  File.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/2/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class User: Codable {
    public var userName:String?
    public var password:String?


    init(userName: String) {
        self.userName = userName
    }
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
}
 
