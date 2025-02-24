//
//  EnvironmentProperties.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

enum EnvironmentProperties {
    enum Keys {
        static let apiKey = "SIGN_MT"
        static let baseUrl = "SIGN_MT_BASE_URL"
        static let srsBaseUrl = "SRS_BASE_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist not found")
        }
        
        return dict
    }()
    
    static let baseUrl: String = {
        guard let baseURL = EnvironmentProperties.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("baseURL: plist not found")
        }
        
        return baseURL
    }()
    
    static let srsBaseUrl: String = {
        guard let baseURL = EnvironmentProperties.infoDictionary[Keys.srsBaseUrl] as? String else {
            fatalError("srsBaseUrl: plist not found")
        }
        
        return baseURL
    }()
    
    static let apiKey: String = {
        guard let apiKey = EnvironmentProperties.infoDictionary[Keys.apiKey] as? String else {
            fatalError("apiKey: plist not found")
        }
        
        return apiKey
    }()
}
