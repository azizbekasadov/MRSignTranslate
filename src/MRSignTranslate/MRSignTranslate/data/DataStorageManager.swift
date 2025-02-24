//
//  DataStorageManager.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import SwiftData

@Observable
class DataStorageManager {
    private(set) var selectedContainer: ModelContainer
    
    init(container: ModelContainer) {
        self.selectedContainer = container
    }
    
    @MainActor
    func switchToPreviewContainer() async {
        selectedContainer = await .preview()
    }
    
    @MainActor
    func switchToStoreContainer() {
        selectedContainer = .store()
    }
    
    func createNewContext() -> ModelContext {
        return ModelContext(selectedContainer)
    }
    
    @MainActor
    func resetAllData() async throws {
        let context = createNewContext()
        try ModelContainer.deleteAll(context: context)
    }
}
