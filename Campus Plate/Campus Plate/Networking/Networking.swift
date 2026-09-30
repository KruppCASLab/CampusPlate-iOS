//
//  Networking.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/18/26.
//

import Foundation

struct Networking {
    private static let authenticationProvider:AuthenticationProvider = BasicAuthenticationProvider()
    
    private static func buildURL(withPath path: String) throws -> URL {
        if let url = Session.shared.url {
            return url.appendingPathComponent(path)
        }
        throw URLError(.badURL)
    }
    
    private static func send<T:Encodable, R:Decodable>(_ path: String, _ body: T?, method: String) async throws -> R {
        let url = try buildURL(withPath: path)
        var request = URLRequest(url: url)
        
        // Add authentication to the reuqest if it is needed
        if ServiceSecurityConfig.isAuthenticationRequired(request: request), let credential = Session.shared.getCredentail() {
            request = authenticationProvider.addAuthentication(original: request, credential: credential)
        }
        
        let decoder = JSONDecoder()
        
        request.httpMethod = method
        
        do {
            var urlResponse:URLResponse?
            var responseData:Data
            
            // If we are sending a PATCH, PUT, or POST, use upload
            if let body {
                let encoder = JSONEncoder()
                let data = try encoder.encode(body)
                
                (responseData, urlResponse) = try await URLSession.shared.upload(for: request, from: data)
            }
            else {
                (responseData, urlResponse) = try await URLSession.shared.data(for: request)
            }
            if let httpResponse = urlResponse as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    //TODO: Throw errors
                }
                
            }
            let response = try decoder.decode(R.self, from: responseData)
            return response
        }
        catch {
            throw error
        }
    }
    
    
    static func get<T: Decodable>(_ path: String) async throws -> T {
        // This is done so the type can be inferred
        var emptyBody:String?
        return try await self.send(path, emptyBody, method:"GET")
    }
    
    static func patch<T:Encodable, R:Decodable>(_ path: String, _ body: T) async throws -> R {
        return try await self.send(path, body, method: "PATCH")
    }
    
    static func post<T:Encodable, R:Decodable>(_ path: String, _ body: T) async throws -> R {
        return try await self.send(path, body, method: "POST")
    }
}
