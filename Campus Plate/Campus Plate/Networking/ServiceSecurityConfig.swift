//
//  SecurityConfig.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/28/26.
//

import Foundation
struct ServiceSecurityConfig {
    static func isAuthenticationRequired(request:URLRequest) -> Bool {
        if let url = request.url, url.pathComponents.contains("users") && (request.httpMethod == "GET" || request.httpMethod == "POST") {
            return false
        }
        
        return true
    }
}
