//
//  TestLogger.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation

protocol Loggable {
    var logHandler: (String) -> Void { get }
    
    func info(_ message: String)
    func warning(_ message: String)
    
    init(logHandler: @escaping (String) -> Void)
}

final class TestLogger: Loggable {
    let logHandler: (String) -> Void
    
    required init(
        logHandler: @escaping (String) -> Void
    ) {
        self.logHandler = logHandler
    }
    
    func info(_ message: String) {
        logHandler(message)
    }
    
    func warning(_ message: String) {
        logHandler(message)
    }
}
