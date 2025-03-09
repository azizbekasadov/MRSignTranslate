//
//  NavigationStackRouterTests.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import MRSignMTArchitecture
import XCTest

@testable import MRSignTranslate

final class NavigationStackRouterTests: XCTestCase {
    
    var router: NavigationStackRouter<TestDestination>!

    override func setUp() {
        super.setUp()
        router = NavigationStackRouter<TestDestination>()
    }
    
    override func tearDown() {
        router = nil
        super.tearDown()
    }

    // MARK: - tests
    
    func testPushDestination() {
        // Given
        let destination = TestDestination.screen1
        
        // When
        router.pushDestination(destination)
        
        // Then
        XCTAssertEqual(router.path, [destination])
    }
    
    // MARK: - Test goBack
    func testGoBack() {
        // Given
        let screen1 = TestDestination.screen1
        let screen2 = TestDestination.screen2
        router.pushDestination(screen1)
        router.pushDestination(screen2)
        
        // When
        router.goBack()
        
        // Then
        XCTAssertEqual(router.path, [screen1])
    }
    
    // MARK: - Test popToRoot
    func testPopToRoot() {
        // Given
        let screen1 = TestDestination.screen1
        let screen2 = TestDestination.screen2
        router.pushDestination(screen1)
        router.pushDestination(screen2)
        
        // When
        router.popToRoot()
        
        // Then
        XCTAssertTrue(router.path.isEmpty)
    }
    
    // MARK: - Test goBack(to:) with valid destination
    func testGoBackToDestination() {
        // Given
        let screen1 = TestDestination.screen1
        let screen2 = TestDestination.screen2
        let screen3 = TestDestination.screen3
        router.pushDestination(screen1)
        router.pushDestination(screen2)
        router.pushDestination(screen3)
        
        // When
        router.goBack(to: screen1)
        
        // Then
        XCTAssertEqual(router.path, [screen1])
    }
    
    // MARK: - Test goBack(to:) with invalid destination
    func testGoBackToInvalidDestination() {
        // Given
        let screen1 = TestDestination.screen1
        let screen2 = TestDestination.screen2
        router.pushDestination(screen1)
        router.pushDestination(screen2)
        
        // When & Then
        XCTAssertLogs(
            when: { [weak self] in
                guard let strongSelf = self else {
                    XCTFail("unable to fetch self reference")
                    return
                }
                
                print(strongSelf.router.path)
                strongSelf.router.goBack(to: .screen3)
            },
        contains: "failed - Expected log 'did no find Screen 2 in the view stack' but it was not found")
    }
}
