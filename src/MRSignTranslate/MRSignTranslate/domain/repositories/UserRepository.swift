//
//  UserRepository.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

protocol UserRepository: UserLoginLogic {
    func checkLoginState() async throws -> LoginState
    func getUser() async throws -> User
    func retrieveAvatar() async throws -> Data?
}

protocol UserLoginLogic {
    func login(
        userName: String,
        password: String,
        simulatedUser: String
    ) async throws -> LoginState
    
    func logout() async throws
}
