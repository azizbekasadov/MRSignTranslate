//
//  MockDestination.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation
import XCTest
import MRSignMTArchitecture

// MARK: - Mock NavigationStackDestination
enum TestDestination: NavigationStackDestination {
    case screen1
    case screen2
    case screen3
    
    // Conform to `CustomStringConvertible`
    var description: String {
        switch self {
        case .screen1: return "Screen 1"
        case .screen2: return "Screen 2"
        case .screen3: return "Screen 3"
        }
    }
    
    // Conform to `Equatable` and `Hashable`
    static func ==(lhs: TestDestination, rhs: TestDestination) -> Bool {
        return lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}
