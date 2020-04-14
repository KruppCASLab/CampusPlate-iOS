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

    static public func saveCredential(credential:Credential) -> Bool {
        let account = credential.username
        let password = credential.password.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrLabel as String: "Tready",
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: credential.url,
                                    kSecValueData as String: password]

        SecItemAdd(query as CFDictionary, nil)

        return true

    }

    static public func getCredential() -> Credential? {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
        kSecAttrLabel as String: "Tready",
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnAttributes as String: true,
        kSecReturnData as String: true]

        var item: CFTypeRef?
        SecItemCopyMatching(query as CFDictionary, &item)

        guard let existingItem = item as? [String : Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let username = existingItem[kSecAttrAccount as String] as? String,
            let url = existingItem[kSecAttrServer as String] as? String
        else {
            return nil
        }

        return Credential(username: username, password: password, url: url)

    }


}
