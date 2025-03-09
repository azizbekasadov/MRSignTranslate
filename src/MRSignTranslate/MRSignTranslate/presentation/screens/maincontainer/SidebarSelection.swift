//
//  SidebarSelection.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

enum SidebarSection: String, CaseIterable, Identifiable {
    case home = "Home"
    case scenarios = "Scenarios"
    case settings = "Settings"
    case history = "History"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .scenarios: return "list.bullet.rectangle"
        case .settings: return "gearshape.fill"
        case .history: return "clock.arrow.circlepath"
        }
    }
    
    var order: Int {
        switch self {
        case .home:
            return 0
        case .scenarios:
            return 1
        case .settings:
            return 3
        case .history:
            return 2
        }
    }
}
