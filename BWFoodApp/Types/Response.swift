//
//  Response.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 9/9/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class Response: Codable {
    public var status:Int?
    public var error:String?
    
    init() {
    }
}
