//
//  SettingsScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import Observation
import MRSignMTArchitecture

struct SettingsScreen: View {
    @Environment(\.openURL) private var openURL
    
    @State private var selectedSection: SettingsDestination?
    @StateObject private var viewModel: SettingsModel = .init()
    
    var body: some View {
        NavigationStack(path: viewModel.$router.path) {
            List {
                Section("General") {
                    settingsRow("Language", destination: .general(.language))
                    settingsRow("Privacy", destination: .general(.privacy))
                    settingsRow("Terms & Conditions", destination: .general(.terms))
                    settingsRow("Appearance", destination: .general(.appearance))
                }

                Section("Mode") {
                    settingsRow("Offline / Online", destination: .mode(.offlineOnline))
                }

                Section("Voice") {
                    settingsRow("Voice Input", destination: .voice(.input))
                    settingsRow("Voice Output", destination: .voice(.output))
                }

                Section("Support") {
                    settingsRow("Contact Us", destination: .support(.contactUs))
                    settingsRow("About", destination: .support(.about))
                }
            }
            .navigationTitle("Settings")
            .navigationDestination(
                for: SettingsDestination.self,
                destination: SettingsDestinationFactory.viewForDemoDestination
            )
        }
    }

    // MARK: - Helper for Navigation Links
    @ViewBuilder
    private func settingsRow(
        _ title: String,
        destination: SettingsDestination
    ) -> some View {
        if case .support(.contactUs) = destination {
            Text(title)
                .onTapGesture {
                    viewModel.handleSupport()
            }
            .id(destination.commonString)
        } else {
            NavigationLink(value: destination) {
                Text(title)
            }
            .id(destination.commonString)
        }
    }
}

#Preview {
    SettingsScreen()
}
