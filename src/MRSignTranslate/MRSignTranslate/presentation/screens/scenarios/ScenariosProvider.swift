//
//  ScenariosProvider.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 28.03.2025.
//

import Foundation
import MRSignMTArchitecture

protocol ScenariosRepositoryProtocol: Repository where Item == Scenario {}

protocol ScenariosSmallRectRepositoryProtocol: Repository where Item == [ScenarioSmallRectItem] {}

final class ScenariosRepository: ScenariosRepositoryProtocol {
    init(){}
    
    nonisolated func fetchItems() -> [Scenario] {
        return Scenario.scenarios
    }
}

final class ScenariosSmallRectRepository: ScenariosSmallRectRepositoryProtocol {

    init(){}
    
    nonisolated func fetchItems() -> [[ScenarioSmallRectItem]] {
        return ScenarioSmallRectItem.options.chunked(into: 2)
    }
}

protocol QuickLinksRepositoryProtocol: Repository where Item == QuickLinkItem {}

final class QuickLinksRepository: QuickLinksRepositoryProtocol {
    func fetchItems() -> [QuickLinkItem] {
        QuickLinkItem.links
    }
}

@preconcurrency
protocol ScenarioDataProviderProtocol: AnyObject {
    
    func retrieveScenarios() -> [Scenario]
    func retrieveSmallCardItems() -> [[ScenarioSmallRectItem]]
    func retrievewQuickLinks() -> [QuickLinkItem]
}

final class ScenariosDataProvider: ScenarioDataProviderProtocol {
    
    private let smallCardsRepository: (any ScenariosSmallRectRepositoryProtocol)
    private let scenariosRepository: (any ScenariosRepositoryProtocol)
    private let quickLinksRepository: (any QuickLinksRepositoryProtocol)
    
    init(
        smallCardsRepository: (any ScenariosSmallRectRepositoryProtocol) = ScenariosSmallRectRepository(),
        scenariosRepository: (any ScenariosRepositoryProtocol) = ScenariosRepository(),
        quickLinksRepository: (any QuickLinksRepositoryProtocol) = QuickLinksRepository()
    ) {
        self.smallCardsRepository = smallCardsRepository
        self.scenariosRepository = scenariosRepository
        self.quickLinksRepository = quickLinksRepository
    }
    
    @MainActor @preconcurrency
    func retrievewQuickLinks() -> [QuickLinkItem] {
        quickLinksRepository.fetchItems()
    }
    
    @MainActor @preconcurrency
    func retrieveScenarios() -> [Scenario] {
        scenariosRepository.fetchItems()
    }
    
    @MainActor @preconcurrency
    func retrieveSmallCardItems() -> [[ScenarioSmallRectItem]] {
        smallCardsRepository.fetchItems()
    }
}
