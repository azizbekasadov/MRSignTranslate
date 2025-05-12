//
//  UserFooterViewModel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import SwiftUI
import Foundation

struct UserFooterState: Equatable {
    var avatar: Data?
    var userName: String?
    
    static let initial = UserFooterState()
}

enum UserFooterIntent {
    case initialLoad
    case logout(() -> Void)
}

enum UserFooterError: Error {
    case contextNotConfigured
    case actorNotInitialized
}

@MainActor
final class UserFooterViewModel: ObservableObject {

    @Published private(set) var state: UserFooterState = .initial
    private var userUseCases = UserUseCases()
        
    func dispatch(_ intent: UserFooterIntent) {
        switch intent {
        case .initialLoad:
            handleInitialLoad()
            
        case .logout(let callback):
            handleLogout(callback: callback)
        }
    }
    
    private func handleInitialLoad() {
        Task {
            state.avatar = try await userUseCases.retrieveAvatar()
            state.userName = try await userUseCases.getUsername()
        }
    }
    
    
    private func handleLogout(callback: @escaping () -> Void) {
        Task {
            do {
                try await userUseCases.logout()
            } catch {
                logger.info("Logout failed: \(error)")
            }
            
            await MainActor.run {
                callback()
            }
        }
    }
}
