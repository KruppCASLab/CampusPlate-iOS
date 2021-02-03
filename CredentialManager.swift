//
//  CredentialManager.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 4/14/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import Foundation

class CredentialManager {
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    
    static public func clearCredentials() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrLabel as String: "Campus Plate"]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return
        }
        
        
    }
    
    static public func saveCredential(credential:Credential) -> Bool {
        clearCredentials()
        let account = credential.username
        let password = credential.password.data(using: .utf8)!
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrLabel as String: "Campus Plate",
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: password]
        
        SecItemAdd(query as CFDictionary, nil)
        
        return true
        
    }
    
    static public func getCredential() -> Credential? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrLabel as String: "Campus Plate",
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        SecItemCopyMatching(query as CFDictionary, &item)
        
        
        guard let existingItem = item as? [String : Any],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8),
              let username = existingItem[kSecAttrAccount as String] as? String
        //let url = existingItem[kSecAttrServer as String] as? String
        else {
            return nil
        }
        
        return Credential(username: username, password: password)
        
        
    }
    
    
}
