//
//  SettingsDetailView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

struct SettingsDetailItem: Identifiable {
    let id: UUID
    let title: String
    let detailText: String
    let destination: (any NavigationStackDestination)
    
    init(
        id: UUID = .init(),
        title: String,
        detailText: String,
        destination: any NavigationStackDestination
    ) {
        self.id = id
        self.title = title
        self.detailText = detailText
        self.destination = destination
    }
}

final class SettingsDetailViewModel: ObservableObject {
    private(set) var item: SettingsDetailItem
    @Published private(set) var destination: SettingsDestination
    
    init(
        destination: SettingsDestination
    ) {
        self.destination = destination
        
        self.item = SettingsDetailItem(
            title: SettingsDetailViewModel.title(
                for: destination
            ),
            detailText: SettingsDetailViewModel.detailText(for: destination),
            destination: destination
        )
    }
    
    // MARK: - Title based on Destination
    private static func title(for destination: SettingsDestination) -> String {
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
    private static  func detailText(for destination: SettingsDestination) -> String {
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

// MARK: - Detail View for Subcategories
struct SettingsDetailView: View {
    private let viewModel: SettingsDetailViewModel
    
    init(viewModel: SettingsDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(viewModel.item.detailText)
                .font(.title2)
                .padding()
            
            Spacer()
        }
        .navigationTitle(viewModel.item.title)
    }
}

#Preview {
    NavigationStack {
        SettingsScreen()
    }
}
