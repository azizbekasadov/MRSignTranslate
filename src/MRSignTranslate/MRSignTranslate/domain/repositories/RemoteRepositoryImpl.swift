//
//  RemoteRepositoryImpl.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import MRSignMTArchitecture

final class RemoteRepositoryImpl: DataProvider, RemoteRepository {
    var lastSessionId: String?
    var lastSessionIdCreationDate: Date?
    
    func resetSessionID() {
        lastSessionId = nil
        lastSessionIdCreationDate = nil
    }
    
    @discardableResult
    func sessionId() async throws -> String {
        if lastSessionIdCreationDate == nil || lastSessionIdCreationDate!.timeIntervalSinceNow < -60 * 5 {
            do {
                let sessionId = try await createSessionId()
                lastSessionId = sessionId
                lastSessionIdCreationDate = Date()
            } catch {
                throw NetworkError.invalidCredentials
            }
        }
        return lastSessionId ?? ""
    }
    
    func createSessionId() async throws -> String {
        do {
            
        } catch {
            throw NetworkError.invalidCredentials
        }
        
        return "/"
    }
    
    func getUserDetailsSync() async throws -> User {
        return User.mock
        //        throw NetworkError.webServiceError(errorCode: 98)
    }
    
    func fetchUserInfo() async throws -> User {
        return User.mock
    }
    
    func isSuperUserUsingSync() throws -> Bool {
        return true
        //        throw NetworkError.webServiceError(errorCode: 98)
    }
    
    func retrieveAvatar(for credentials: Credentials?) async throws -> Data {
        throw NetworkError.webServiceError(errorCodes: 98)
    }
}
