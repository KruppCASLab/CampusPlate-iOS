//
//  File.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/2/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

class UserModel {
    private var users = Array<User>()
    
    private let url = URL(string: "https://mopsdev.bw.edu/food/rest.php/users")
    
    private static let sharedInstance = UserModel()
    let session = URLSession.shared
    
    static public func getSharedInstance() -> UserModel {
        return self.sharedInstance
    }
    
    
    public func update() {
        //TODO: Call service client to update
    }
    
    public func addUser(user:User, completion:@escaping (Bool)->Void) {
        self.users.append(user)
        var request = URLRequest(url: self.url!)
        
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            session.uploadTask(with: request, from: data) { (data, response, error) in
                completion(true)
            }.resume()
        }
        catch {
            
        }
    }
    
    public func getNumberOfUsers() -> Int {
        return self.users.count
    }
    
    
}

