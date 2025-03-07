//
//  MainContainer.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI

struct MainSplitView: View {
    @State private var selectedSection: SidebarSection? = .home
    @State private var searchText: String = ""

    var body: some View {
        NavigationSplitView {
            SidebarView(
                selectedSection: $selectedSection,
                searchText: $searchText
            )
        } detail: {
            DetailView(
                selectedSection: selectedSection
            )
        }
    }
}

#Preview {
    MainSplitView()
}
