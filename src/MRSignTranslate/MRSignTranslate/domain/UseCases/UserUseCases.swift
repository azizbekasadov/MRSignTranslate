//
//  UserUseCases.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import MRSignMTArchitecture

actor UserUseCases {
    
    @Inject private var userRepository: UserRepository
    @Inject private var storageManager: DataStorageManager
    
    func checkLoginState() async throws -> LoginState {
        return try await userRepository.checkLoginState()
    }
    
    func getUsername() async throws -> String? {
        try await userRepository.getUser().username
    }
    
    func retrieveAvatar() async throws -> Data? {
        return try await userRepository.retrieveAvatar()
    }
    
    func login(userName: String, password: String, simulatedUser: String) async throws -> LoginState {
        let loginState = try await userRepository.login(userName: userName, password: password, simulatedUser: simulatedUser)

        if loginState == .demoUser {
            logger.info("Setting Preview ModelContainer")
            
            InjectionContainer.register(type: RemoteRepository.self, MockRemoteRepositoryImpl())
            await storageManager.switchToPreviewContainer()
        }
        
        return loginState
    }
    
    func logout() async throws {
        try await userRepository.logout()
    }
}
