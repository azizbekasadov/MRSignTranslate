//
//  DetailView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

// MARK: - Detail Content Area
struct DetailView: View {
    var selectedSection: SidebarSection?

    var body: some View {
        Group {
            switch selectedSection {
            case .home:
                HomeView()
            case .scenarios:
                ScenariosView()
            case .settings:
                NavigationStack {
                    SettingsScreen()
                }
                .navigationBarBackButtonHidden(false)
            case .history:
                HistoryView()
            case .none:
                Text("Select a Section").font(.largeTitle)
            }
        }
        .navigationTitle(selectedSection?.rawValue ?? "VisionOS App")
    }
}
