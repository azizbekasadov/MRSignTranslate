//
//  Scenario.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

struct Scenario: Identifiable, Hashable {
    let id: String
    let title: String
    let thumbnail: String
    let backgroundImage: String
    let level: Level
    let description: String
    let instructions: [Instruction]
    let scenarioWindowId: String
    let isImmersiveWindow: Bool
    let type: ScenarioType
    let localizedStringResource: String
    
    init(
        id: String = UUID().uuidString,
        title: String,
        thumbnail: String,
        backgroundImage: String,
        level: Level,
        description: String,
        instructions: [Instruction],
        scenarioWindowId: String,
        isImmersiveWindow: Bool = false,
        type: ScenarioType,
        localizedStringResource: String
    ) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.backgroundImage = backgroundImage
        self.level = level
        self.description = description
        self.instructions = instructions
        self.scenarioWindowId = scenarioWindowId
        self.isImmersiveWindow = isImmersiveWindow
        self.type = type
        self.localizedStringResource = localizedStringResource
    }
}

typealias Instruction = String // TODO: set up Instruction object

enum Level: String, CaseIterable {
    case easy
    case medium
    case hard
}
