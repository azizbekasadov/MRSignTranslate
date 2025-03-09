//
//  XCTestCase+.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import XCTest

extension XCTestCase {
    func XCTAssertLogs(
        when action: @escaping () -> Void,
        contains expectedLog: String
    ) {
        let logExpectation = expectation(description: "Expect log contains: \(expectedLog)")
        var logCaptured = false
        
        let logger = TestLogger { log in
            if log.contains(expectedLog) {
                logCaptured = true
                logExpectation.fulfill()
            }
        }
        
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !logCaptured {
                XCTFail("Expected log '\(expectedLog)' but it was not found.")
            }
        }
               
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
