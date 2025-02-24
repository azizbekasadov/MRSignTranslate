//
//  File 2.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 23.02.2025.
//

//import Foundation
//import Testing
//
//@testable import MRSignMTArchitecture
//
//@Suite("Navigation Stack Router Tests")
//struct NavigationStackRouterTests {
//    // Mock implementation of NavigationStackDestination for testing
//    struct MockDestination: NavigationStackDestination {
//        let id: Int
//        let name: String
//        
//        static func ==(lhs: MockDestination, rhs: MockDestination) -> Bool {
//            lhs.id == rhs.id
//        }
//        
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(id)
//        }
//        
//        // Codable conformance (required by NavigationStackDestination)
//        enum CodingKeys: String, CodingKey {
//            case id, name
//        }
//    }
//    
//    // Test setup
//    func createRouter() -> NavigationStackRouter<MockDestination> {
//        NavigationStackRouter<MockDestination>()
//    }
//    
//    // Test pushing destinations
//    @Test("Push destination to stack")
//    func testPushDestination() {
//        // Given
//        let router = createRouter()
//        let destination = MockDestination(id: 1, name: "Screen1")
//        
//        // When
//        router.pushDestination(destination)
//        
//        // Then
//        #expect(router.path.count == 1, "Path should have one destination")
//        #expect(router.path.first == destination, "Path should contain the pushed destination")
//    }
//    
//    @Test("Push multiple destinations to stack")
//    func testPushMultipleDestinations() {
//        // Given
//        let router = createRouter()
//        let destinations = [
//            MockDestination(id: 1, name: "Screen1"),
//            MockDestination(id: 2, name: "Screen2"),
//            MockDestination(id: 3, name: "Screen3")
//        ]
//        
//        // When
//        destinations.forEach { router.pushDestination($0) }
//        
//        // Then
//        #expect(router.path.count == 3, "Path should have three destinations")
//        #expect(router.path == destinations, "Path should match the pushed destinations in order")
//    }
//    
//    @Test("Pop to root removes all destinations")
//    func testPopToRoot() {
//        // Given
//        let router = createRouter()
//        let destinations = [
//            MockDestination(id: 1, name: "Screen1"),
//            MockDestination(id: 2, name: "Screen2")
//        ]
//        destinations.forEach { router.pushDestination($0) }
//        
//        // When
//        router.popToRoot()
//        
//        // Then
//        #expect(router.path.isEmpty, "Path should be empty after popping to root")
//    }
//    
//    @Test("Go back from non-empty stack")
//    func testGoBack() {
//        // Given
//        let router = createRouter()
//        let destinations = [
//            MockDestination(id: 1, name: "Screen1"),
//            MockDestination(id: 2, name: "Screen2")
//        ]
//        destinations.forEach { router.pushDestination($0) }
//        
//        // When
//        router.goBack()
//        
//        // Then
//        #expect(router.path.count == 1, "Path should have one destination after going back")
//        #expect(router.path.first == destinations[0], "Path should contain the first destination")
//    }
//    
//    @Test("Go back on empty stack fails with assertion")
//    func testGoBackOnEmptyStack() throws {
//        // Given
//        let router = createRouter()
//        
//        // When/Then: Expect an assertion failure (simulated as throwing for testing)
//        #expect(throws: AssertionFailure.self) {
//            router.goBack()
//        }
//    }
//    
//    @Test("Go back to specific destination")
//    func testGoBackToDestination() {
//        // Given
//        let router = createRouter()
//        let destinations = [
//            MockDestination(id: 1, name: "Screen1"),
//            MockDestination(id: 2, name: "Screen2"),
//            MockDestination(id: 3, name: "Screen3")
//        ]
//        destinations.forEach { router.pushDestination($0) }
//        let target = destinations[1] // Go back to Screen2
//        
//        // When
//        router.goBack(to: target)
//        
//        // Then
//        #expect(router.path.count == 2, "Path should have two destinations after going back")
//        #expect(router.path == Array(destinations.prefix(2)), "Path should contain destinations up to the target")
//    }
//    
//    @Test("Go back to non-existent destination fails with assertion")
//    func testGoBackToNonExistentDestination() throws {
//        // Given
//        let router = createRouter()
//        let destinations = [
//            MockDestination(id: 1, name: "Screen1"),
//            MockDestination(id: 2, name: "Screen2")
//        ]
//        destinations.forEach { router.pushDestination($0) }
//        let nonExistent = MockDestination(id: 3, name: "Screen3")
//        
//        // When/Then: Expect an assertion failure (simulated as throwing for testing)
//        #expect(throws: AssertionFailure.self) {
//            router.goBack(to: nonExistent)
//        }
//    }
//    
//    @Test("Equatable conformance for destinations")
//    func testEquatableConformance() {
//        // Given
//        let dest1 = MockDestination(id: 1, name: "Screen1")
//        let dest2 = MockDestination(id: 1, name: "Different")
//        let dest3 = MockDestination(id: 2, name: "Screen2")
//        
//        // Then
//        #expect(dest1 == dest2, "Destinations with same ID should be equal")
//        #expect(dest1 != dest3, "Destinations with different IDs should not be equal")
//    }
//    
//    @Test("Hashable conformance for destinations")
//    func testHashableConformance() {
//        // Given
//        let dest1 = MockDestination(id: 1, name: "Screen1")
//        let dest2 = MockDestination(id: 1, name: "Different")
//        
//        // When
//        var set = Set<MockDestination>()
//        set.insert(dest1)
//        set.insert(dest2)
//        
//        // Then
//        #expect(set.count == 1, "Hashable destinations with same ID should be treated as one")
//    }
//    
//    @Test("Codable conformance for destinations")
//    func testCodableConformance() throws {
//        // Given
//        let destination = MockDestination(id: 1, name: "Screen1")
//        
//        // When: Encode and decode
//        let encoder = JSONEncoder()
//        let decoder = JSONDecoder()
//        let data = try encoder.encode(destination)
//        let decoded = try decoder.decode(MockDestination.self, from: data)
//        
//        // Then
//        #expect(decoded == destination, "Decoded destination should match original")
//    }
//    
//    @Test("CustomStringConvertible conformance for destinations")
//    func testCustomStringConvertible() {
//        // Given
//        let destination = MockDestination(id: 1, name: "Screen1")
//        
//        // Then
//        #expect(destination.description == "MockDestination", "Description should match the type name")
//    }
//    
//    @Test("Concurrent navigation operations")
//    func testConcurrentNavigation() {
//        // Given
//        let router = createRouter()
//        let destinations = [
//            MockDestination(id: 1, name: "Screen1"),
//            MockDestination(id: 2, name: "Screen2")
//        ]
//        destinations.forEach { router.pushDestination($0) }
//        
//        // Use DispatchQueue to simulate concurrent access
//        let queue = DispatchQueue(label: "test.navigation.queue", attributes: .concurrent)
//        let group = DispatchGroup()
//        var paths: [[MockDestination]] = []
//        
//        for _ in 0..<100 {
//            group.enter()
//            queue.async {
//                let localRouter = router // Copy for thread safety (since @Observable might not be thread-safe)
//                if Bool.random() {
//                    localRouter.pushDestination(MockDestination(id: 3, name: "Screen3"))
//                } else {
//                    localRouter.goBack()
//                }
//                paths.append(localRouter.path)
//                group.leave()
//            }
//        }
//        
//        group.wait()
//        
//        // Then: Verify that the operations were applied consistently (this is a basic check; more detailed verification might be needed)
//        #expect(paths.count == 100, "Should record 100 concurrent operations")
//        #expect(paths.allSatisfy { !$0.isEmpty || $0 == destinations }, "Paths should either be empty or match initial state after operations")
//    }
//}
//
//// Helper to simulate assertionFailure for testing (since it crashes otherwise)
//extension NavigationStackRouter {
//    func pushDestination(_ destination: T) {
//        // Mock logging for testing
//        // logger.info("\(self) will go to screen: \(destination)")
//        path.append(destination)
//    }
//    
//    func goBack() {
//        // Mock logging and assertion for testing
//        // logger.info("will go to back")
//        if path.isEmpty {
//            // Simulate assertion failure as throwing for testing
//            throw AssertionFailure(message: "Unable to go back on an empty path -> did some path elements get lost?")
//        }
//        path.removeLast()
//    }
//    
//    func goBack(to destination: T) {
//        // Mock logging and assertion for testing
//        // logger.warning("\(self) did no find \(destination.description) in the view stack")
//        guard let index = path.firstIndex(of: destination) else {
//            throw AssertionFailure(message: "\(self) did no find \(destination.description) in the view stack")
//        }
//        path.removeLast(path.count - (index + 1))
//    }
//    
//    func popToRoot() {
//        // Mock logging for testing
//        // logger.info("\(self) will pop to root")
//        path.removeLast(path.count)
//    }
//}
//
//// Custom error for testing assertion failures
//struct AssertionFailure: Error {
//    let message: String
//}
