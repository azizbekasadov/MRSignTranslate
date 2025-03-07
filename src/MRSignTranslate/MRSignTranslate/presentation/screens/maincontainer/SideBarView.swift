//
//  SideBarView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI

struct SidebarView: View {
    @Binding var selectedSection: SidebarSection?
    @Binding var searchText: String
    
    var filteredSections: [SidebarSection] {
        SidebarSection.allCases.sorted(
            by: { $0.order < $1.order }
        ).filter { section in
            let searchMatchedWithSection = section
                .rawValue
                .localizedCaseInsensitiveContains(searchText)
            
            return searchText.isEmpty || searchMatchedWithSection
        }
    }
    
    @ViewBuilder
    private func SectionView(_ section: SidebarSection) -> some View {
        GeometryReader { geometry in
            HStack {
                Image(systemName: section.icon)
                    .font(.system(size: 18, weight: .medium))
                
                Text(section.rawValue)
                    .font(.system(size: 18, weight: .medium)
                )
                
                Spacer()
            }
            .padding(10)
            .background(
                SelectedOverlay(section, geometry: geometry)
            )
        }
    }
    
    private func SelectedOverlay(
        _ section: SidebarSection,
        geometry: GeometryProxy
    ) -> some View {
        Group {
            if selectedSection == section {
                VisualEffectBlur(
                    blurStyle: .systemUltraThinMaterialDark
                )
                .clipShape(RoundedRectangle(cornerRadius: geometry.size.height*0.25))
                .overlay(RoundedRectangle(cornerRadius: geometry.size.height*0.25)
                    .stroke(
                        Color.white.opacity(0.3),
                        lineWidth: 1
                    )
                )
            } else {
                Color.clear
            }
        }
    }
    
    var body: some View {
        List(
            filteredSections,
            selection: $selectedSection
        ) { section in
            SectionView(section)
        }
        .listStyle(.sidebar)
        .navigationTitle("Menu")
        .searchable(
            text: $searchText,
            prompt: "Search..."
        )
    }
}

#Preview {
    SidebarView(
        selectedSection: .constant(.home),
        searchText: .constant("")
    )
}
