//
//  ScenarioSmallRectItem.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation

enum ScenarioSmallRectType: String, CaseIterable, Hashable {
    case translator
    case dictionary
    case instructions
    case statistics
    case feedback
}
struct ScenarioSmallRectItem: Identifiable, Hashable {
    let id: UUID
    let type: ScenarioSmallRectType
    let title: String
    let description: String
    let buttonIconName: String
    let buttonTitle: String
    let purchaseTitle: String

    init(
        id: UUID = .init(),
        type: ScenarioSmallRectType,
        title: String,
        description: String,
        buttonIconName: String,
        buttonTitle: String = "START",
        purchaseTitle: String
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.buttonIconName = buttonIconName
        self.buttonTitle = buttonTitle
        self.purchaseTitle = purchaseTitle
    }
}

extension ScenarioSmallRectType: Identifiable {
    var id: String { self.rawValue }
}
