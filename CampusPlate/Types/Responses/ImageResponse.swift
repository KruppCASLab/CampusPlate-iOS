//
//  ImageResponse.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/15/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class ImageResponse : Codable {
    public var status:Int?
    public var error:String?
    public var data:String?
}

