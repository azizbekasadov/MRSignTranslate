//
//  ScenarioSmallRectItem.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation

struct ScenarioSmallRectItem: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let buttonIconName: String
    let buttonTitle: String
    let purchaseTitle: String
    
    init(
        id: UUID = .init(),
        title: String,
        description: String,
        buttonIconName: String,
        buttonTitle: String = "START",
        purchaseTitle: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.buttonIconName = buttonIconName
        self.buttonTitle = buttonTitle
        self.purchaseTitle = purchaseTitle
    }
}
