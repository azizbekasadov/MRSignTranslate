//
//  ScenarioSmallRectItemStubs.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation

extension ScenarioSmallRectItem {
    static let options: [ScenarioSmallRectItem] = [
        ScenarioSmallRectItem(
            title: "Translator",
            description: "Use SignMT to translate from your language",
            buttonIconName: "options/translator",
            purchaseTitle: "In-App Purchase"
        ),
        ScenarioSmallRectItem(
            title: "Dictionary",
            description: "Learn basic signs instantly",
            buttonIconName: "options/dictionary",
            purchaseTitle: "Free"
        ),
        ScenarioSmallRectItem(
            title: "Instructions",
            description: "Follow the instructions to get started",
            buttonIconName: "options/instructions",
            purchaseTitle: "32 mins read"
        ),
        ScenarioSmallRectItem(
            title: "Statistics",
            description: "Track your progress here",
            buttonIconName: "options/statistics",
            purchaseTitle: "Browse your history"
        ),
        ScenarioSmallRectItem(
            title: "Feedback",
            description: "Send your precious feedback",
            buttonIconName: "options/feedback",
            purchaseTitle: "Help us grow"
        ),
    ]
}
