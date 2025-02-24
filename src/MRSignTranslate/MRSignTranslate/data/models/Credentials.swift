//
//  Credentials.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

struct Credentials: Codable {
    typealias Password = String
    
    let id: UUID
    let username: String
    let password: Password
}
