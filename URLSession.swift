//
//  URLSession.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 9/8/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import Foundation

public func post(){
    
    let info = ["Food": "Pizza"]
    
    guard let url = URL(string: "https://mops.bw.edu/food/rest.php/listings") else {return}
    let session = URLSession.shared
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    guard let httpBody = try? JSONSerialization.data(withJSONObject: info, options: []) else{
        return
    }
    
    request.httpBody = httpBody
    
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data{
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }catch{
                print(error)
            }
        }
        }.resume()
    
}

