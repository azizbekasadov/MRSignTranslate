//
//  ModelContainer+Ext.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import SwiftData
import MRSignMTArchitecture

@MainActor
extension ModelContainer {
    static func preview() async -> ModelContainer {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let schema = Schema([UserEntity.self])
            let modelContainer = try ModelContainer(for: schema, configurations: config)
            // TODO
            
            logger.info("ModelContainer preview: \(modelContainer)")
            return modelContainer
        } catch let error {
            fatalError("[ModelContainer] static preview(taskLists:): \(error.localizedDescription)")
        }
    }
   
    static func store() -> ModelContainer {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            let schema = Schema([UserEntity.self])
            let modelContainer = try ModelContainer(for: schema, configurations: config)
            
            logger.info("ModelContainer store: \(modelContainer)")
            return modelContainer
        } catch let error {
            fatalError("Hub Concierge: ModelContainer failed to create instance: \(error.localizedDescription)")
        }
    }

    static func deleteAll(context: ModelContext) throws {
        try context.delete(model: UserEntity.self)
    }
}

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(
            percentEncoded: false
        ) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
