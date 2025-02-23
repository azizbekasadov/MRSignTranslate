//
//  MainRouter.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import MRSignMTArchitecture

enum MainDestination: NavigationStackDestination {
    case login
    case home
    case languageList
    case realTime
    case recordings
}

enum SettingsDestination: NavigationStackDestination {
    case support(SettingsCategories.Support)
    case general(SettingsCategories.General)
    case mode(SettingsCategories.Mode)
    case voice(SettingsCategories.Voice)
}

enum SettingsCategories {
    enum Support: NavigationStackDestination {
        case contactUs
        case about
    }
    
    enum General: NavigationStackDestination {
        case language
        case privacy
        case terms
        case appearance
    }
    
    enum Mode: NavigationStackDestination {
        case offlineOnline
    }
    
    enum Voice: NavigationStackDestination {
        case input
        case output
    }
}
