//
//  SwiftUIView.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI

struct LanguageGroup {
    let label: String
    let languages: [MRLanguage]
}

struct LanguageSelectorView: View {
    @State private var currentLanguage: MRLanguage = .usLocale

    let languages: [LanguageGroup] = [
        .init(label: "Main", languages: MRLanguage.allLanguages)
    ]

    var body: some View {
        VStack {
            Text("Select Language").font(.headline)

//            Picker("Language", selection: $currentLanguage) {
//                ForEach(languages, id: \.label) { group in
//                    Section(header: Text(group.label)) {
//                        ForEach(group.languages, id: \.key) { lang in
//                            Text(lang.title).tag(lang.id)
//                        }
//                    }
//                }
//            }
//            .pickerStyle(MenuPickerStyle()) // Drop-down menu style
//            .onChange(of: currentLanguage) { newLang in
//                changeLanguage(to: newLang)
//            }
        }
        .padding()
    }

    func changeLanguage(to language: String) {
        // Implement i18n switching logic (e.g., UserDefaults, Localization API)
        print("Language changed to: \(language)")
    }
}

#Preview {
    LanguageSelectorView()
}
