//
//  MainContainer.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI

struct MainSplitView: View {
    @State private var selectedSection: SidebarSection? = .settings
    
    private let sections: [SidebarSection] = SidebarSection.allCases.sorted(
        by: { $0.order < $1.order }
    )
    
    var body: some View {
        NavigationSplitView {
            SideView()
        } detail: {
            DetailView()
        }
    }
    
    @ViewBuilder
    private func DetailView() -> some View {
        if let selectedSection {
            MRSignTranslate.DetailView(
                selectedSection: selectedSection
            )
            .id(selectedSection.id)
        } else {
            Text("No option has ben selected")
        }
    }
    
    @ViewBuilder
    private func SideView() -> some View {
        List(
            sections,
            id: \.self,
            selection: $selectedSection
        ) { section in
            SectionView(section)
        }
        .listStyle(.sidebar)
        .navigationTitle("Menu")
    }
    
    @ViewBuilder
    private func SectionView(_ section: SidebarSection) -> some View {
            HStack {
                Image(systemName: section.icon)
                    .font(.system(size: 18, weight: .medium))
                
                Text(section.rawValue)
                    .font(.system(size: 18, weight: .medium)
                )
                
                Spacer()
            }
            .padding(10)
    }
    
}

#Preview {
    MainSplitView()
}
