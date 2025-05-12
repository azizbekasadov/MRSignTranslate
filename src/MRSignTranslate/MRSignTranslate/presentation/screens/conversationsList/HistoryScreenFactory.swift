//
//  HistoryScreenFactory.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import MRSignMTArchitecture
import SwiftUI

struct HistoryScreenFactory: ViewFactory {
    
    private let repository: (any HistoryItemRepositoryProtocol)
    
    init(repositoryType: RepositoryType = .preprod) {
        switch repositoryType {
//        case .local:
//            self.repository = LocalHistoryItemRepository()
        case .mock:
            self.repository = MockHistoryItemRepository()
//        case .preprod:
//            self.repository = PreprodHistoryItemRepository()
//        case .prod:
//            self.repository = ProdHistoryItemRepository()
        default:
            self.repository = MockHistoryItemRepository()
        }
    }
    
    func make() -> AnyView {
        AnyView(
            HistoryView(viewModel: .init(historyItemsRepository: self.repository))
        )
    }
}
