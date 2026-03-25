//
//  Networking.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/18/26.
//

import Foundation

struct Networking {
    private static func buildURL(withPath path: String) throws -> URL {
        if let url = Session.shared.url {
            return url.appendingPathComponent(path)
        }
        throw URLError(.badURL)
    }
    
    static func fetch<T: Decodable>(_ path: String) async throws -> T {
        let url = try buildURL(withPath: path)
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            if let httpResponse = urlResponse as? HTTPURLResponse {
                
                if httpResponse.statusCode == 404 {
                    //TODO: Throw errors
                }
                
            }
            let response = try decoder.decode(T.self, from: data)
            return response
        }
        catch {
            throw error
        }
    }
    
    static func upload<T:Encodable, R:Decodable>(_ path: String, _ body: T) async throws -> R {
        let url = try buildURL(withPath: path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            let data = try encoder.encode(body)
            
            let (responseData, urlResponse) = try await URLSession.shared.upload(for: request, from: data)
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
}
