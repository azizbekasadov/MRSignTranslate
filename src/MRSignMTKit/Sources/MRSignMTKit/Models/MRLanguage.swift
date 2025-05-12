//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 17.03.2025.
//

import Foundation

public protocol LanguageListable {
    var iconName: String { get }
    var title: String { get }
    var description: String { get }
}

public struct MRLanguage: Identifiable, LanguageListable {
    public let id = UUID()
    public let iconName: String
    public let title: String
    public let description: String
    public let locale: Locale  // New property

    public init(
        iconName: String,
        title: String,
        description: String,
        locale: Locale
    ) {
        self.iconName = iconName
        self.title = title
        self.description = description
        self.locale = locale
    }
}

extension MRLanguage {
    static let IANASignedLanguages: [[String: String]] = [
        ["signed": "ads", "spoken": "ak", "country": "gh", "abbreviation": ""], // Adamorobe Sign Language
        ["signed": "sqk", "spoken": "sq", "country": "al", "abbreviation": ""], // Albanian Sign Language
        ["signed": "ase", "spoken": "en", "country": "us", "abbreviation": "ASL"], // American Sign Language
        ["signed": "asf", "spoken": "en", "country": "au", "abbreviation": "Auslan"], // Australian Sign Language
        ["signed": "asq", "spoken": "de", "country": "at", "abbreviation": "ÖGS"], // Austrian Sign Language
        ["signed": "bfi", "spoken": "en", "country": "gb", "abbreviation": "BSL"], // British Sign Language
        ["signed": "cse", "spoken": "cs", "country": "cz", "abbreviation": "CZJ"], // Czech Sign Language
        ["signed": "dse", "spoken": "nl", "country": "nl", "abbreviation": "NGT"], // Dutch Sign Language
        ["signed": "fsl", "spoken": "fr", "country": "fr", "abbreviation": "LSF"], // French Sign Language
        ["signed": "gsg", "spoken": "de", "country": "de", "abbreviation": "DGS"], // German Sign Language
        ["signed": "gss", "spoken": "el", "country": "gr", "abbreviation": "GSL"], // Greek Sign Language
        ["signed": "isg", "spoken": "ga", "country": "ie", "abbreviation": "ISL"], // Irish Sign Language
        ["signed": "ise", "spoken": "it", "country": "it", "abbreviation": "LIS"], // Italian Sign Language
        ["signed": "jsl", "spoken": "ja", "country": "jp", "abbreviation": "JSL"], // Japanese Sign Language
        ["signed": "nzs", "spoken": "en", "country": "nz", "abbreviation": "NZSL"], // New Zealand Sign Language
        ["signed": "ssp", "spoken": "es", "country": "es", "abbreviation": "LSE"], // Spanish Sign Language
        ["signed": "swl", "spoken": "sv", "country": "se", "abbreviation": "STS"], // Swedish Sign Language
        ["signed": "pso", "spoken": "pl", "country": "pl", "abbreviation": "PJM"], // Polish Sign Language
        ["signed": "psl", "spoken": "es", "country": "pr", "abbreviation": "PRSL"], // Puerto Rican Sign Language
        ["signed": "fcs", "spoken": "fr", "country": "ca", "abbreviation": "LSQ"], // Quebec Sign Language
        ["signed": "rsl", "spoken": "ru", "country": "ru", "abbreviation": ""], // Russian Sign Language
        ["signed": "sfs", "spoken": "af", "country": "za", "abbreviation": ""], // South African Sign Language
    ]

    // Convert TypeScript Object to Swift Array of `MRLanguage`
    static let mappedLanguages: [MRLanguage] = IANASignedLanguages.compactMap { entry in
        guard let signed = entry["signed"], let spoken = entry["spoken"], let country = entry["country"] else {
            return nil
        }
        
        let abbreviation = entry["abbreviation"] ?? ""
        let title = !abbreviation.isEmpty ? abbreviation : signed.uppercased()  // Use abbreviation or fallback to `signed`
        let locale = Locale(identifier: "\(spoken)_\(country)")  // Create locale from spoken & country
        
        return MRLanguage(
            iconName: signed,
            title: title,
            description: "\(title) Sign Language",
            locale: locale
        )
    }
}

// MARK: - Language Data
extension MRLanguage {
    public static let usLocale: MRLanguage = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
    
    public static let allLanguages: [MRLanguage] = [
        MRLanguage(iconName: "🇦🇷", title: "Español", description: "Argentina", locale: Locale(identifier: "es_AR")),
        MRLanguage(iconName: "🇦🇹", title: "Deutsch", description: "Österreich", locale: Locale(identifier: "de_AT")),
        MRLanguage(iconName: "🇧🇪", title: "Nederlands", description: "België", locale: Locale(identifier: "nl_BE")),
        MRLanguage(iconName: "🇧🇬", title: "Български", description: "България", locale: Locale(identifier: "bg_BG")),
        MRLanguage(iconName: "🇧🇷", title: "Português", description: "Brasil", locale: Locale(identifier: "pt_BR")),
        MRLanguage(iconName: "🇨🇳", title: "中文", description: "中国", locale: Locale(identifier: "zh_CN")),
        MRLanguage(iconName: "🇨🇿", title: "Čeština", description: "Česká republika", locale: Locale(identifier: "cs_CZ")),
        MRLanguage(iconName: "🇩🇪", title: "Deutsch", description: "Deutschland", locale: Locale(identifier: "de_DE")),
        MRLanguage(iconName: "🇩🇰", title: "Dansk", description: "Danmark", locale: Locale(identifier: "da_DK")),
        MRLanguage(iconName: "🇪🇪", title: "Eesti", description: "Eesti", locale: Locale(identifier: "et_EE")),
        MRLanguage(iconName: "🇪🇸", title: "Español", description: "España", locale: Locale(identifier: "es_ES")),
        MRLanguage(iconName: "🇫🇮", title: "Suomi", description: "Suomi", locale: Locale(identifier: "fi_FI")),
        MRLanguage(iconName: "🇫🇷", title: "Français", description: "France", locale: Locale(identifier: "fr_FR")),
        MRLanguage(iconName: "🇬🇧", title: "English", description: "United Kingdom", locale: Locale(identifier: "en_GB")),
        MRLanguage(iconName: "🇬🇷", title: "Ελληνικά", description: "Ελλάδα", locale: Locale(identifier: "el_GR")),
        MRLanguage(iconName: "🇮🇳", title: "हिन्दी", description: "भारत", locale: Locale(identifier: "hi_IN")),
        MRLanguage(iconName: "🇮🇱", title: "עברית", description: "ישראל", locale: Locale(identifier: "he_IL")),
        MRLanguage(iconName: "🇮🇹", title: "Italiano", description: "Italia", locale: Locale(identifier: "it_IT")),
        MRLanguage(iconName: "🇯🇵", title: "日本語", description: "日本", locale: Locale(identifier: "ja_JP")),
        MRLanguage(iconName: "🇱🇻", title: "Latviešu", description: "Latvija", locale: Locale(identifier: "lv_LV")),
        MRLanguage(iconName: "🇱🇹", title: "Lietuvių", description: "Lietuva", locale: Locale(identifier: "lt_LT")),
        MRLanguage(iconName: "🇳🇱", title: "Nederlands", description: "Nederland", locale: Locale(identifier: "nl_NL")),
        MRLanguage(iconName: "🇵🇱", title: "Polski", description: "Polska", locale: Locale(identifier: "pl_PL")),
        MRLanguage(iconName: "🇵🇹", title: "Português", description: "Portugal", locale: Locale(identifier: "pt_PT")),
        MRLanguage(iconName: "🇷🇺", title: "Русский", description: "Россия", locale: Locale(identifier: "ru_RU")),
        MRLanguage(iconName: "🇸🇪", title: "Svenska", description: "Sverige", locale: Locale(identifier: "sv_SE")),
        MRLanguage(iconName: "🇹🇷", title: "Türkçe", description: "Türkiye", locale: Locale(identifier: "tr_TR")),
        MRLanguage(iconName: "🇺🇦", title: "Українська", description: "Україна", locale: Locale(identifier: "uk_UA")),
        MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
    ].sorted { $0.title < $1.title }
}
