//
//  Authentication.swift
//  Campus Plate
//
//  Created by Brian Krupp on 9/21/26.
//

import Foundation

// If we support different authentication forms in the future, this can provide it
protocol AuthenticationProvider {
    func addAuthentication(original:URLRequest, credential:Credential) -> URLRequest
}

struct BasicAuthenticationProvider: AuthenticationProvider {
    func addAuthentication(original:URLRequest, credential:Credential) -> URLRequest {
        var request = original
        
        let loginString = String(format: "%@:%@", credential.username, credential.password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
