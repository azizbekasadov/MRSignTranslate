//
//  LanguageManager.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 20.03.2025.
//

import SwiftUI

public class LanguageManager: ObservableObject {
    @Published public var currentLanguage: MRLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.locale.identifier, forKey: "selectedLanguage")
        }
    }
    
    init() {
        let storedLocale = UserDefaults.standard.string(forKey: "selectedLanguage")!
        let locale = Locale(identifier: storedLocale)
        
        self.currentLanguage = MRLanguage.allLanguages.first {
            $0.locale == locale
        } ?? .usLocale
    }
}
