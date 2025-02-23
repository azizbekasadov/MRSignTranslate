//
//  RemoteRepository.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//
import Foundation

protocol RemoteRepository {
    func fetchUserInfo() async throws -> User
}
