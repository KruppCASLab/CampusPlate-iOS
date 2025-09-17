//
//  ServiceClient.swift
//  BWFoodApp
//
//  Created by Julia  Gersey on 9/5/21.
//  Copyright © 2021 Campus Plate - BW. All rights reserved.
//

import Foundation


class ServiceClient {
    static private func environmentKey(for username: String?) -> String {
        // Take username, in email format, and create environment variable
        if let parts = username?.split(separator: "@") {
            let domainParts = parts[1].split(separator: ".")
            let key = domainParts[0].uppercased() + "_" + domainParts[1].uppercased()
            return key
        }
        return ""
    }
    
    static func serviceClientUrl() -> String {
        return serviceClientUrl(for: nil)
    }
    
    static func serviceClientUrl(for username: String?) -> String {
        var key = ""
        if let username = username {
            key = environmentKey(for: username)
        }
        else {
            // Get username from Credential Manager (stored previously)
            key = environmentKey(for: KeychainCredentialManager.getCredential()?.username)
        }
        
        let url = (Bundle.main.infoDictionary?[key] as! String)
        return url
    }
}
