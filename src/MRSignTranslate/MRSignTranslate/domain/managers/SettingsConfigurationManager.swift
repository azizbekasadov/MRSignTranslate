//
//  SettingsConfigurationManager.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation
import Observation
import SwiftUI

protocol SettingsConfigurationManagerProtocol {
    var isDarkMode: Bool { set get }
    var notificationsEnabled: Bool { set get }
    var hasShownWelcomeMessage: Bool { set get }
}

@Observable
final class SettingsConfigurationManager: SettingsConfigurationManagerProtocol {
    private let defaults = UserDefaults.standard
    
    enum Keys {
        static let isDarkMode = "21e123e21w12w2`1"
        static let notificationsEnabled = "12eqwdefrgrefawderwgethrgdr"
        static let welcomeMessage = "123e1er23r23r23dqf2w"
    }
    
    var isDarkMode: Bool {
        get { defaults.bool(forKey: Keys.isDarkMode) }
        set {
            defaults.set(newValue, forKey: Keys.isDarkMode)
        }
    }
    
    var notificationsEnabled: Bool {
        get { defaults.bool(forKey: Keys.notificationsEnabled) }
        set {
            defaults.set(newValue, forKey: Keys.notificationsEnabled)
        }
    }
    
    var hasShownWelcomeMessage: Bool {
        get { defaults.bool(forKey: Keys.welcomeMessage) }
        set {
            defaults.set(newValue, forKey: Keys.welcomeMessage)
        }
    }
}
