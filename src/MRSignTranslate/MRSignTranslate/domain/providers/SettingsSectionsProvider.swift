//
//  SettingsSectionsProvider.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

protocol SettingsSectionsProvider: LastSessionRecordable {
    func fetchSections() async throws -> [SettingsDestination]
}
