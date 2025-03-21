//
//  LanguageListItem.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation
import SwiftUI
import MRSignMTKit

// MARK: - Language Data
struct LanguageData {
    static let allLanguages: [MRLanguage] = MRLanguage.allLanguages
}

extension LocaleCountry: LanguageListable {
    var iconName: String {
        switch self {
        case .argentina: return "🇦🇷"
        case .america: return "🇺🇸"
        case .germany: return "🇩🇪"
        case .france: return "🇫🇷"
        case .britain: return "🇬🇧"
        case .switzerlandGerman, .switzerlandFrench, .switzerlandItalian: return "🇨🇭"
        case .israel: return "🇮🇱"
        case .spain: return "🇪🇸"
        case .jordan: return "🇯🇴"
        case .belarusBelarusian, .belarusRussian: return "🇧🇾"
        case .bulgaria: return "🇧🇬"
        case .china: return "🇨🇳"
        case .croatia: return "🇭🇷"
        case .czechRepublic: return "🇨🇿"
        case .denmark: return "🇩🇰"
        case .indiaHindi: return "🇮🇳"
        case .newZealand: return "🇳🇿"
        case .estonia: return "🇪🇪"
        case .finland: return "🇫🇮"
        case .austria: return "🇦🇹"
        case .cyprusGreek, .cyprusTurkish: return "🇨🇾"
        case .greece: return "🇬🇷"
        case .iceland: return "🇮🇸"
        case .italy: return "🇮🇹"
        case .japan: return "🇯🇵"
        case .latvia: return "🇱🇻"
        case .lithuania: return "🇱🇹"
        case .iran: return "🇮🇷"
        case .poland: return "🇵🇱"
        case .brazil: return "🇧🇷"
        case .portugal: return "🇵🇹"
        case .russia: return "🇷🇺"
        case .slovakia: return "🇸🇰"
        case .chile: return "🇨🇱"
        case .cuba: return "🇨🇺"
        case .mexico: return "🇲🇽"
        case .sweden: return "🇸🇪"
        case .turkey: return "🇹🇷"
        case .ukraine: return "🇺🇦"
        case .pakistanUrdu, .pakistanEnglish: return "🇵🇰"
        }
    }
    
    var title: String {
        displayName // Locale code (e.g., "es_AR", "de_DE")
    }
    
    var description: String {
        Locale(identifier: self.rawValue).localizedString(forLanguageCode: self.rawValue) ?? ""
    }
}
