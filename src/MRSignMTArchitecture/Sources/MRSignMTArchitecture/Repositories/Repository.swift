//
//  File.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation


/// Used for emulating fetching of various items be it either mock or prod repo
public protocol Repository {
    associatedtype Item
    
    func fetchItems() -> [Item]
}

/// Used for fetching items asynchronously
public protocol AsyncRepository {
    associatedtype Item
    
    func fetchItems() async throws -> [Item]
}
