//
//  File.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

@propertyWrapper
public struct Keychain<T> where T: Codable {
    public let service: KeychainServiceKeys
    public let account: KeychainAccountKeys = .signMT
    
    public var wrappedValue: T? {
        get {
            return KeychainHelper.shared.read(service: service, account: account, type: T.self)
        }
        set {
            if let newValue {
                KeychainHelper.shared.save(newValue, service: service, account: account)
            }
            else {
                KeychainHelper.shared.delete(service: service, account: account)
            }
        }
    }
}

public protocol KeychainHelperLogic {
    func save<T>(
        _ item: T,
        service: KeychainServiceKeys,
        account: KeychainAccountKeys
    ) where T: Codable
    
    func read<T>(
        service: KeychainServiceKeys,
        account: KeychainAccountKeys,
        type: T.Type
    ) -> T? where T: Codable
    
    func save(
        _ data: Data,
        service: KeychainServiceKeys,
        account: KeychainAccountKeys
    ) throws
    
    func read(
        service: KeychainServiceKeys,
        account: KeychainAccountKeys
    ) throws -> Data?
    
    func delete(
        service: KeychainServiceKeys,
        account: KeychainAccountKeys
    ) 
}

public enum KeychainServiceKeys: String {
    case userInfo = "user-info"
    case userName = "user-name"
    case userSimulatedName = "user-simulated-name"
    case userPassword = "user-password"
}

public enum KeychainAccountKeys: String {
    case signMT
}

public enum KeychainAccessError: Error {
    case someError(OSStatus)
}

public class KeychainHelper: KeychainHelperLogic {
    
    
    private init() {}
    
    public static let shared = KeychainHelper()
    
    public func save<T>(_ item: T, service: KeychainServiceKeys, account: KeychainAccountKeys) where T: Codable {
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            try save(data, service: service, account: account)
        } catch {
            assertionFailure("Fail to encode and save item in keychain: \(error)")
        }
    }
    
    public func read<T>(service: KeychainServiceKeys, account: KeychainAccountKeys = .signMT, type: T.Type) -> T? where T: Codable {
        // Read item data from keychain
        guard let data = try? read(service: service, account: account) else {
            return nil
        }
        // Decode JSON data to object
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            assertionFailure("Fail to decode item from keychain: \(error)")
            return nil
        }
    }
    
    public func save(_ data: Data, service: KeychainServiceKeys, account: KeychainAccountKeys = .signMT) throws {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue
        ] as [CFString: Any] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service.rawValue,
                kSecAttrAccount: account.rawValue,
                kSecClass: kSecClassGenericPassword
            ] as [CFString: Any] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
            return
        }
        
        if status != errSecSuccess {
            throw KeychainAccessError.someError(status)
        }
    }
    
    public func read(service: KeychainServiceKeys, account: KeychainAccountKeys = .signMT) throws -> Data? {
        
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as [CFString: Any] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        if status != errSecSuccess {
            throw KeychainAccessError.someError(status)
        }
        
        return (result as? Data)
    }
    
    public func delete(service: KeychainServiceKeys, account: KeychainAccountKeys = .signMT) {
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecClass: kSecClassGenericPassword
        ] as [CFString: Any] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
}
