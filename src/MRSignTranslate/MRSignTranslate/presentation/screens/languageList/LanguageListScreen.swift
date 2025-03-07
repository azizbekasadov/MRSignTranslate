//
//  LanguageListScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI

struct LanguageListView: View {
    let destination: SettingsDestination
    
    @State private var searchText = ""
    @State private var selectedLanguage: LocaleCountry = .america // Default selection

    private var filteredLanguages: [LocaleCountry] {
        LocaleCountry
            .allCases
            .sorted { $0.description < $1.description }
//            .filter {
//                searchText.isEmpty ||
//                $0.title.lowercased().contains(searchText.lowercased()) ||
//                $0.description.lowercased().contains(searchText.lowercased())
//            }
            .filter { $0 != selectedLanguage }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("🌍 Select Language")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                
                List {
                    // Top Section for Selected Language
                    Section(header: Text("Selected Language").foregroundColor(.gray)) {
                        ListRow(item: selectedLanguage)
                            .onTapGesture {
                                // Handle selected language tap
                            }
                    }
                    
                    // Main Language List
                    Section(header: Text("All Languages").foregroundColor(.gray)) {
                        ForEach(filteredLanguages, id: \.self) { language in
                            ListRow(item: language)
                                .onTapGesture {
                                    selectedLanguage = language
                                }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    LanguageListView(destination: .general(.language))
}

// MARK: - Generic List Row View
struct ListRow: View {
    let item: LanguageListable
    
    var body: some View {
        HStack(spacing: 20) {
            Image("icons/flags/" + item.iconName)
                .resizable()
                .frame(width: 32, height: 32)
            VStack(alignment: .leading) {
                Text(item.title) // Localized name
                    .font(.title)
                Text(item.description) // Display name
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 2)
    }
}
