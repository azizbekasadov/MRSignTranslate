//
//  MockRemoteRepository.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

final class MockRemoteRepositoryImpl: DataProvider, RemoteRepository {
    private let bundle: Bundle
    
    var lastSessionId: String?
    var lastSessionIdCreationDate: Date?
    
    private let demoSessionId = "DEMO-SESSION"
    
    init(
        bundle: Bundle = .main
    ) {
        self.bundle = bundle
        
        logger.info("MockDataProvider")
    }
    
    @discardableResult func sessionId() async throws -> String {
        return demoSessionId
    }
    
    func isSuperUserUsingSync() throws -> Bool {
        return false
    }
    
    func getUserDetailsSync() async throws -> User {
        return User.mock
    }
    
    func retrieveAvatar(for credentials: Credentials?) async throws -> Data {
        throw NetworkError.genericError
    }
    
    func fetchUserInfo() async throws -> User {
        return User.mock
    }
    
    private func loadMockData<T: Codable>(filename: String) throws -> T {
        guard let url = bundle.url(
            forResource: filename,
            withExtension: "json"
        ) else {
            throw MockError.fileNotFound(filename)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(MockResponse<T>.self, from: data)
            return response.data
        } catch {
            throw MockError.decodingError(error)
        }
    }
    
    enum MockError: Error {
        case fileNotFound(String)
        case decodingError(Error)
        
        var localizedDescription: String {
            switch self {
            case .fileNotFound(let filename):
                return "Mock file not found: \(filename).json"
            case .decodingError(let error):
                return "Failed to decode mock data: \(error.localizedDescription)"
            }
        }
    }
}

struct MockResponse<T: Codable>: Codable {
    struct Mock: Codable {
        let status: Int
        let method: String
        let urlPath: String
        let headers: [String: String]
    }
    
    let mock: Mock
    let data: T
}
