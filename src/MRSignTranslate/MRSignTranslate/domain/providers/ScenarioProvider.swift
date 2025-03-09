//
//  ScenarioProvider.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

protocol ScenarioProvider: LastSessionRecordable {
    func fetchScenarios() async throws -> [Scenario]
    func fetchSessionsForScenario(_ scenario: Scenario) async throws -> [ScenarioSessionRecord]
}

