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
    
    init() {
        
    }
    
    private func handleCheckLoginState() {
        Task {
            do {
                let loginState = try await userUseCases.checkLoginState()
                
                switch loginState {
                case .loggedIn, .superUser:
                    await MainActor.run {
                        router.pushDestination(.home)
                    }
                case .loggedOut, .demoUser:
                    logger.info("Setting Store ModelContanier")
                    storageManager.switchToStoreContainer()
                    router.pushDestination(.login)
                }
            }
            catch {
                router.pushDestination(.login)
            }
        }
    }
}
