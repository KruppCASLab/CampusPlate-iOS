//
//  RequestUtility.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/20/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import Foundation

public class RequestUtility {
    
    static func addAuth(original:URLRequest) -> URLRequest {
        
        var request = original
        
        let username = KeychainCredentialManager.getCredential()?.username
        let password = KeychainCredentialManager.getCredential()?.password
          let loginString = String(format: "%@:%@", username as! CVarArg, password as! CVarArg)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        // create the request
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return request
        
    }
}
