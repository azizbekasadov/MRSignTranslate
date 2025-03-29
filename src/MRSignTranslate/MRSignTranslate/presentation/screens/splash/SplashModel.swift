//
//  SplashModel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import SwiftUI
import MRSignMTArchitecture

enum SplashIntent {
    case checkLoginState
}

enum MainWindowType: String, WindowType {
    case privacy
    case main
    
    func getProviderID() -> String {
        switch self {
        case .privacy:
            MRSignTranslateApp.WindowGroupIdentifiers.privacy
        case .main:
            MRSignTranslateApp.WindowGroupIdentifiers.main
        }
    }
}

@MainActor
final class SplashViewModel: ObservableObject {
    @Inject private var router: MainRouter
    @Inject private var storageManager: DataStorageManager
    
    @Published var isLoading: Bool = false
    
    private var userUseCases = UserUseCases()
        
    func dispatch(_ intent: SplashIntent) {
        switch intent {
        case .checkLoginState:
            handleCheckLoginState()
        }
    }
    
    init() {}
    
    private func handleCheckLoginState() {
        
//        Task { @MainActor in
//            do {
//                let loginState = try await userUseCases.checkLoginState()
//                
//                switch loginState {
//                case .loggedIn, .superUser:
//                    await MainActor.run {
//                        router.setRoot(.home)
//                    }
//                case .loggedOut, .demoUser:
//                    logger.info("Setting Store ModelContanier")
//                    storageManager.switchToStoreContainer()
//                    router.pushDestination(.home)
//                }
//            }
//            catch {
//                router.pushDestination(.home)
//            }
//        }
//        if !settingsConfigurator.hasShownWelcomeMessage {
            router.open(MainWindowType.privacy)
//        }
    }
}
