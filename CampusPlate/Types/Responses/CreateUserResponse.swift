//
//  CreateUserResponse.swift
//  BWFoodApp
//
//  Created by Brian Krupp on 4/7/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class CreateUserResponse : Codable {
    public var status:Int?
    public var error:Int?
    public var data:String?
}
