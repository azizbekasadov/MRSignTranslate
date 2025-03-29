//
//  Scenario.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

struct Scenario: Identifiable, CustomLocalizedStringResourceConvertible {
    let id: String
    let title: String
    let thumbnail: String
    let backgroundImage: String
    let level: Level
    let description: String
    let instructions: [Instruction]
    let scenarioWindowId: String
    
    let localizedStringResource: LocalizedStringResource
}

typealias Instruction = String // TODO: set up Instruction object

enum Level: String, CaseIterable {
    case easy
    case medium
    case hard
}
