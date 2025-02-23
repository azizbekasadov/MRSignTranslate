//
//  NetworkError.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

enum NetworkError: Error {
    case genericError
    case invalidCredentials
    case expectedResultTypeNotFound
    case webServiceError(errorCodes: Int)
    case parseError
    case noDataAvailable
}
