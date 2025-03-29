//
//  HistoryViewModel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import Observation

@Observable
final class HistoryViewModel {
    var selectedHistoryItem: HistoryItem?
    
    private(set) var historyItems: [HistoryItem] = []
    
    @ObservationIgnored
    private(set) var historyItemsRepository: (any HistoryItemRepositoryProtocol)
    
    init(
        historyItemsRepository: (any HistoryItemRepositoryProtocol)
    ) {
        self.historyItemsRepository = historyItemsRepository
    }
    
    func fetchHistoryItems() async {
        do {
            let results = try await historyItemsRepository.fetchItems()
            self.historyItems = results
        } catch {
            logger.error(.init(stringLiteral: "Unable to fetch items: \(error.localizedDescription)"))
        }
    }
}
