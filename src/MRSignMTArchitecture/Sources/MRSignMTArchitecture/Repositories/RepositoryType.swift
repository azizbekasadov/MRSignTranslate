//
//  RepositoryType.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation

public enum RepositoryType: CustomStringConvertible  {
    case mock
    case local
    case prod
    case preprod
    case custom((any Repository))
    
    public var description: String {
        switch self {
        case .mock:
            return "Mock Repository"
        case .local:
            return "Local Repository"
        case .prod:
            return "Prod Repository"
        case .preprod:
            return "Preprod Repository"
        case .custom:
            return "Custom Repository"
        }
    }
}
