//
//  LanguageListItem.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation
import SwiftUI

protocol LanguageListable {
    var iconName: String { get }
    var title: String { get }
    var description: String { get }
}

struct Language: Identifiable, LanguageListable {
    let id = UUID()
    let iconName: String
    let title: String
    let description: String
}

// MARK: - Language Data
struct LanguageData {
    static let allLanguages: [Language] = [
        Language(iconName: "🇦🇷", title: "Español", description: "Argentina"),
        Language(iconName: "🇦🇹", title: "Deutsch", description: "Österreich"),
        Language(iconName: "🇧🇪", title: "Nederlands", description: "België"),
        Language(iconName: "🇧🇬", title: "Български", description: "България"),
        Language(iconName: "🇧🇷", title: "Português", description: "Brasil"),
        Language(iconName: "🇨🇳", title: "中文", description: "中国"),
        Language(iconName: "🇨🇿", title: "Čeština", description: "Česká republika"),
        Language(iconName: "🇩🇪", title: "Deutsch", description: "Deutschland"),
        Language(iconName: "🇩🇰", title: "Dansk", description: "Danmark"),
        Language(iconName: "🇪🇪", title: "Eesti", description: "Eesti"),
        Language(iconName: "🇪🇸", title: "Español", description: "España"),
        Language(iconName: "🇫🇮", title: "Suomi", description: "Suomi"),
        Language(iconName: "🇫🇷", title: "Français", description: "France"),
        Language(iconName: "🇬🇧", title: "English", description: "United Kingdom"),
        Language(iconName: "🇬🇷", title: "Ελληνικά", description: "Ελλάδα"),
        Language(iconName: "🇮🇳", title: "हिन्दी", description: "भारत"),
        Language(iconName: "🇮🇱", title: "עברית", description: "ישראל"),
        Language(iconName: "🇮🇹", title: "Italiano", description: "Italia"),
        Language(iconName: "🇯🇵", title: "日本語", description: "日本"),
        Language(iconName: "🇱🇻", title: "Latviešu", description: "Latvija"),
        Language(iconName: "🇱🇹", title: "Lietuvių", description: "Lietuva"),
        Language(iconName: "🇳🇱", title: "Nederlands", description: "Nederland"),
        Language(iconName: "🇵🇱", title: "Polski", description: "Polska"),
        Language(iconName: "🇵🇹", title: "Português", description: "Portugal"),
        Language(iconName: "🇷🇺", title: "Русский", description: "Россия"),
        Language(iconName: "🇸🇪", title: "Svenska", description: "Sverige"),
        Language(iconName: "🇹🇷", title: "Türkçe", description: "Türkiye"),
        Language(iconName: "🇺🇦", title: "Українська", description: "Україна"),
        Language(iconName: "🇺🇸", title: "English", description: "United States")
    ].sorted { $0.title < $1.title } // Sort alphabetically by title
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
        case .indiaEnglish, .indiaHindi, .indiaBengali, .indiaTamil, .indiaTelugu: return "🇮🇳"
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
//        displayName // Human-readable name (e.g., "French", "German")
        Locale(identifier: self.rawValue).language.languageCode?.debugDescription ?? ""
    }
}
