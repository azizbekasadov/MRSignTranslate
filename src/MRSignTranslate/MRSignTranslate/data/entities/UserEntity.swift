//
//  UserEntity.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

import Foundation
import SwiftData

@Model
class UserEntity {
    var id: String
    var username: String
    var lastSynDate: Date
    
    init(
        id: String,
        username: String,
        lastSynDate: Date
    ) {
        self.id = id
        self.username = username
        self.lastSynDate = lastSynDate
    }
}
