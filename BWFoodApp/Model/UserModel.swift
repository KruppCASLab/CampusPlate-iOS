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
    
    public func updateAccountVerificationFlag(userName: String, pin: Int, completion:@escaping (Bool)->Void) {
        
        // TODO : Add to URL listingId
        let patchUrl = self.url?.appendingPathComponent(userName)
    
        var request = URLRequest(url: patchUrl!)
        
        request.httpMethod = "PATCH"
        
        var userUpdate = Dictionary<String, Int>()
        userUpdate["pin"] = pin
        
        let encoder = JSONEncoder()
        
        do{
            //TODO:
            let data = try encoder.encode(userUpdate)
            session.uploadTask(with: request, from: data) { (data, response, error) in
                let decoder = JSONDecoder()
                
                //Todo: decode data into pin verify response and then check response codes, if not 0 completion(false)
                do{
                    let response = try decoder.decode(PinVerifyResponse.self, from: data!)
                    
                    if response.status != 0{
                        completion(false)
                    }else{
                        completion(true)
                    }
                    
                }
                catch{
                    
                }

                
            }.resume()
        }
        catch {
            
        }
    }
    
    public func getNumberOfUsers() -> Int {
        return self.users.count
    }
    
    
}

