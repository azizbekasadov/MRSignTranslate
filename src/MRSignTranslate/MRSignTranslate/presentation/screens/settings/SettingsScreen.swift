//
//  SettingsScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

struct SettingsScreen: View {
    @Environment(\.openURL) private var openURL
    @Inject private var router: SettingsRouter
    
    @StateObject private var viewModel: SettingsModel = .init()
    
    var body: some View {
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
                    .onTapGesture {
                        viewModel.handleSupport()
                    }
                settingsRow("About", destination: .support(.about))
            }
        }
        .navigationTitle("Settings")
        .navigationDestination(
            for: SettingsDestination.self,
            destination: SettingsDestinationFactory.viewForDemoDestination
        )
    }

    // MARK: - Helper for Navigation Links
    private func settingsRow(
        _ title: String,
        destination: SettingsDestination
    ) -> some View {
        NavigationLink(value: destination) {
            Text(title)
        }
    }
}

// MARK: - Detail View for Subcategories
struct SettingsDetailView: View {
    let destination: SettingsDestination

    var body: some View {
        VStack {
            Text(detailText(for: destination))
                .font(.title2)
                .padding()
            
            Spacer()
        }
        .navigationTitle(title(for: destination))
    }

    // MARK: - Title based on Destination
    private func title(for destination: SettingsDestination) -> String {
        switch destination {
        case .support(.contactUs): return "Contact Us"
        case .support(.about): return "About"
        case .general(.language): return "Language"
        case .general(.privacy): return "Privacy Policy"
        case .general(.terms): return "Terms & Conditions"
        case .general(.appearance): return "Appearance"
        case .mode(.offlineOnline): return "Offline / Online Mode"
        case .voice(.input): return "Voice Input"
        case .voice(.output): return "Voice Output"
        }
    }

    // MARK: - Detail Text for Each Page
    private func detailText(for destination: SettingsDestination) -> String {
        switch destination {
        case .support(.contactUs): return "Get in touch with our support team."
        case .support(.about): return "Learn more about our app."
        case .general(.language): return "Choose your preferred language."
        case .general(.privacy): return "Review our privacy policies."
        case .general(.terms): return "Read our terms and conditions."
        case .general(.appearance): return "Customize the app's appearance."
        case .mode(.offlineOnline): return "Switch between offline and online modes. Currently not supported"
        case .voice(.input): return "Voice input language selection is not yet implemented." //"Configure voice input settings."
        case .voice(.output): return "Voice output language selection is not yet implemented."//"Adjust voice output settings."
        }
    }
}

#Preview {
    NavigationStack {
        SettingsScreen()
    }
}
