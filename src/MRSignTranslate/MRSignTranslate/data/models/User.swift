//
//  User.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

struct User: Codable {
    let id: UUID
    let username: String
    let credentials: Credentials?
    
    init(
        username: String,
        credentials: Credentials? = nil
    ) {
        self.id = UUID()
        self.username = username
        self.credentials = credentials
    }
    
    static let mock: User = .init(
        username: "DEMO-USER"//UUID().uuidString + Date().description
    )
}
