//
//  UserRepositoryImpl.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import MRSignMTArchitecture
import Foundation

final class UserRepositoryImpl: UserRepository {
    private(set) var cachedAvatarImageData: Data?
    private var dataProvider: DataProvider = RemoteRepositoryImpl()
    
    private var isDemoModeEnabled = false
    
    var userModel: User?
    
    func getUser() async throws -> User {
        return userModel ?? User(username: "DEMO-USER")//UUID().uuidString)
    }
    
    func login(userName: String, password: String, simulatedUser: String) async -> LoginState {
        do {
            let state = try await createSession(username: userName, password: password, simulatedUser: simulatedUser)
            let isAdmin = try await isAdminToken()
            if isAdmin && simulatedUser.isEmpty {
                return .superUser
            }
            return state
        } catch {
            return .loggedOut
        }
    }
    
    func loginWithSuperUser(userName: String, password: String, simulatedUser: String) async -> LoginState {
        do {
            let state = try await createSession(
                username: userName,
                password: password,
                simulatedUser: simulatedUser
            )
            return state
        } catch {
            return .loggedOut
        }
    }
    
    func checkLoginState() async throws -> LoginState {
        #if DEBUG
        return .loggedIn
        #else
        do {
            let userModel = try await fetchUserModel()
            let userModelData = try JSONEncoder().encode(userModel)
            try KeychainHelper.shared.save(userModelData, service: .userInfo)
            await MainActor.run {
                self.userModel = userModel
            }
            
            try await getUserInfo()
            
            return .loggedIn
        } catch {
            return .loggedOut
        }
        #endif
    }
    
    func getUserInfo() async throws {
        throw NetworkError.invalidCredentials
    }
    
    func retrieveAvatar() async throws -> Data? {
        do {
            guard cachedAvatarImageData == nil else {
                return cachedAvatarImageData
            }
            
            cachedAvatarImageData = try await dataProvider.retrieveAvatar(
                for: userModel?.credentials
            )
        } catch {
            logger.error("Error retrieving avatar")
        }
        
        return cachedAvatarImageData
    }
    
    func logout() {
        KeychainHelper.shared.delete(service: .userInfo)
        KeychainHelper.shared.delete(service: .userName)
        KeychainHelper.shared.delete(service: .userPassword)
        KeychainHelper.shared.delete(service: .userSimulatedName)
        
        dataProvider.resetSessionID()
    }
    
    private func isAdminToken() async throws -> Bool {
        return try dataProvider.isSuperUserUsingSync()
    }
    
    private func isDemoLoginValid(username: String, password: String) -> Bool {
        return username.uppercased() == "DEMO-USER" && password.uppercased() == "DEMO"
    }
    
    private func createSession(username: String, password: String, simulatedUser: String) async throws -> LoginState {
        isDemoModeEnabled = isDemoLoginValid(username: username, password: password)
        
        if isDemoModeEnabled {
            dataProvider = MockRemoteRepositoryImpl()
            return .demoUser
        } else {
            dataProvider = RemoteRepositoryImpl()
        }
        // TODO
        throw NetworkError.invalidCredentials
    }
    
    private func demoSavedCredentials() -> Bool {
        return false
    }
    
    private func fetchUserInfo() async throws -> User {
        throw NetworkError.invalidCredentials
    }
    
    private func fetchUserModel() async throws -> User {
        do {
            guard !demoSavedCredentials() else {
                throw NetworkError.invalidCredentials
            }
            
            try await dataProvider.sessionId()
            return try await dataProvider.getUserDetailsSync()
        } catch {
            throw NetworkError.invalidCredentials
        }
    }

}
