//
//  EnvironmentConfig.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/25/26.
//

/*
 This is used instead of having the URLs in the dev and prod xcconfig files. This is easier to track and only requires one change
 to add a new endpoint for a Campus Plate deployment instead of adding a change to two configuration files and a plist.
 
 To add an endpoint, add the following to the configs property in the Environment struct
 
 "abc.edu" : EnvironmentConfig(devUrl: "https://cp.abc.edu/cp/rest.php",
                             prodUrl: "https://cp.abc.edu/cp/rest.php")
 */

import Foundation

struct Environment {
    static private var deployEnv = Bundle.main.infoDictionary?["DEPLOY_ENV"] as? String ?? "dev"
    
    static private var configs = [
        "case.edu" : EnvironmentConfig(devUrl: "https://caslab.case.edu/~briankrupp/rest.php",
                                       prodUrl: "https://caslab.case.edu/cp/rest.php"),
        "bw.edu" : EnvironmentConfig(devUrl: "https://mopsdev.bw.edu/cp/rest.php",
                                    prodUrl: "https://mops.bw.edu/cp/rest.php")
    ]
    
    static public func urlForEmail(_ email: String) throws -> URL {
        // Pull domain from email
        if let domain = email.split(separator: "@").last {
            if let config = configs[String(domain)] {
                switch deployEnv {
                    case "dev":
                        return config.devUrl
                    case "prod":
                        return config.prodUrl
                    default:
                        return config.devUrl
                }
            }
        }
        throw URLError(.badURL)
    }
    
}

struct EnvironmentConfig {
    var devUrl:URL
    var prodUrl:URL
    
    init(devUrl: String, prodUrl: String) {
        self.devUrl = URL(string: devUrl)!
        self.prodUrl = URL(string: prodUrl)!
    }
}


