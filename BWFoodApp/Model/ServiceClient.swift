//
//  ServiceClient.swift
//  BWFoodApp
//
//  Created by Julia  Gersey on 9/5/21.
//  Copyright © 2021 Campus Plate - BW. All rights reserved.
//

import Foundation


class ServiceClient {
    
    static func serviceClientUrl() -> String {
        let url = "https://" + (Bundle.main.infoDictionary?["BASE_URL"] as! String) + "/cp/rest.php/"
        
        return url
        
    }
}
