//
//  SettingsDestinationFacotry.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import SwiftUI

enum SettingsDestinationFactory {
    
    @ViewBuilder
    static func viewForDemoDestination(_ destination: SettingsDestination) -> some View {
        switch destination {
        case .general(let option):
            switch option {
            case .language: LanguageListView(destination: option)
            case .appearance: SettingsDetailView(destination: destination)
            case .privacy, .terms: LegalWebView(destination: option)
            }
        case .mode(let option):
            switch option {
            case .offlineOnline:
                SettingsDetailView(destination: destination)
            }
        case .support(let option):
            switch option {
            case .contactUs:
                SettingsDetailView(destination: destination)
            case .about:
                SettingsDetailView(destination: destination)
            }
        case .voice(let option):
            switch option {
            case .input:
                SettingsDetailView(destination: destination)
            case .output:
                SettingsDetailView(destination: destination)
            }
        }
    }
}
