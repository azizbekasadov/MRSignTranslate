//
//  HistoryItemRepositoryProtocol.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import MRSignMTArchitecture

protocol HistoryItemRepositoryProtocol: AsyncRepository where Item == HistoryItem {}

final class MockHistoryItemRepository: HistoryItemRepositoryProtocol {
    func fetchItems() async throws -> [HistoryItem] {
        return HistoryItem.mocks
    }
}
