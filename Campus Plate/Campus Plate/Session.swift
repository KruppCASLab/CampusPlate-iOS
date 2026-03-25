//
//  UserSession.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/25/26.
//

import Foundation

@Observable class Session {
    public var email = ""
    public var url:URL?
    
    public func configure(email: String) throws {
        url = try Environment.urlForEmail(email)
        self.email = email
    }
    
    static let shared = Session()
    
    private init() {
    }
    
}
