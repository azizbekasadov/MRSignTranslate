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
            case .privacy, .terms: LegalWebView(destination: option)
            default:
                SettingsDetailView(
                    viewModel: .init(destination: destination)
                )
            }
        case .mode(let option):
            switch option {
            case .offlineOnline:
                SettingsDetailView(
                    viewModel: .init(destination: destination)
                )
            }
        case .support(let option):
            switch option {
            default:
                SettingsDetailView(
                    viewModel: .init(destination: destination)
                )
            }
        case .voice(let option):
            switch option {
            case .input:
                SettingsDetailView(
                    viewModel: .init(destination: destination)
                )
            case .output:
                SettingsDetailView(
                    viewModel: .init(destination: destination)
                )
            }
        }
    }
}
