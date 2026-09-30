//
//  UserSession.swift
//  Campus Plate
//
//  Created by Brian Krupp on 3/25/26.
//

import Foundation

@Observable class Session {
    public var url:URL?
    private var credential:Credential?
    
    public func configure(credential:Credential) throws {
        url = try Environment.urlForEmail(credential.username)
        self.credential = credential
    }
    
    public func getCredentail() -> Credential? {
        return credential
    }
    
    static let shared = Session()
    
    private init() {
    }
    
}
