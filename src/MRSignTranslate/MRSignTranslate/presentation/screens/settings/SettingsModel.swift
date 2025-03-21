//
//  SettingsModel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import MRSignMTArchitecture
import SwiftUI

@MainActor
final class SettingsModel: ObservableObject {
    @StateObject var router: SettingsRouter = .init()
    
    @Inject private var storageManager: DataStorageManager
    @Inject private var emailService: EmailServiceProtocol
    
    func handleSupport() {
        emailService.openEmail(
            to: GlobalConstants.Email.recipient,
            subject: GlobalConstants.Email.subject,
            body: ""
        )
    }
}
