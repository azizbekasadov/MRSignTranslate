//
//  Scenario.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

struct Scenario: Identifiable, CustomLocalizedStringResourceConvertible {
    let id: UUID
    let title: String
    let thumbnail: String
    let backgroundImage: String
    let description: String
    let instructions: [Instruction]
    
    let localizedStringResource: LocalizedStringResource
}

typealias Instruction = String // TODO: set up Instruction object
