//
//  QuickLinkItem.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation

struct QuickLinkItem: Identifiable {
    let id: UUID
    let title: String
    let description: String
    
    init(
        id: UUID = .init(),
        title: String,
        description: String
    ) {
        self.id = id
        self.title = title
        self.description = description
    }
}
