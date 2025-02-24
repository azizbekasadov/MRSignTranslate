//
//  DataProvider.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import Foundation

protocol SessionProvider {
    @discardableResult
    func sessionId() async throws -> String
    
    mutating func resetSessionID()

    var lastSessionId: String? { get set }
    var lastSessionIdCreationDate: Date? { get set }
}

protocol DataProvider: SessionProvider, RemoteRepository {
    func getUserDetailsSync() async throws -> User
    
    func retrieveAvatar(
        for credentials: Credentials?
    ) async throws -> Data
    
    func isSuperUserUsingSync() throws -> Bool
}

extension SessionProvider {
    mutating func resetSessionID() {
        lastSessionId = nil
        lastSessionIdCreationDate = nil
    }
}
