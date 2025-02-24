//
//  KeychainTests.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 23.02.2025.
//

//import Foundation
//import Testing
//
//@testable import MRSignMTArchitecture // Replace with your actual module name
//
//@Suite("Keychain Tests Tests")
//struct KeychainTests {
//    // Reset Keychain state before each test (simulated for testing)
//    func resetKeychain() {
//        // In a real test, you'd need to clear the Keychain or use a mock.
//        // For simplicity, we'll simulate this by resetting a mock or using a test Keychain.
//        // Here, we'll assume KeychainHelper.shared is mocked or reset.
//        let helper = KeychainHelper.shared
//        helper.delete(service: .userInfo, account: .signMT)
//        helper.delete(service: .userName, account: .signMT)
//        helper.delete(service: .userSimulatedName, account: .signMT)
//        helper.delete(service: .userPassword, account: .signMT)
//    }
//    
//    // Mock struct for testing (since we can't directly manipulate the real Keychain in tests)
//    struct MockCodable: Codable, Equatable {
//        let id: Int
//        let name: String
//    }
//    
//    // Test KeychainHelper with a mock implementation if needed
//    @Test("Save and read Codable object")
//    func testSaveAndReadCodable() throws {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        let item = MockCodable(id: 1, name: "Test")
//        let service = KeychainHelper.KeychainServiceKeys.userInfo
//        
//        // When: Save the item
//        KeychainHelper.shared.save(item, service: service, account: .signMT)
//        
//        // Then: Read it back
//        let readItem = KeychainHelper.shared.read(
//            service: service,
//            account: .signMT,
//            type: MockCodable.self
//        )
//        
//        #expect(readItem == item, "Saved and read items should match")
//    }
//    
//    @Test("Save and read raw Data")
//    func testSaveAndReadData() throws {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        let data = Data("Test Data".utf8)
//        let service = KeychainHelper.KeychainServiceKeys.userPassword
//        
//        // When: Save the data
//        try KeychainHelper.shared.save(data, service: service, account: .signMT)
//        
//        // Then: Read it back
//        let readData = try KeychainHelper.shared.read(
//            service: service,
//            account: .signMT
//        )
//        
//        #expect(readData == data, "Saved and read data should match")
//    }
//    
//    @Test("Delete item from Keychain")
//    func testDelete() {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        let item = MockCodable(id: 1, name: "Test")
//        let service = KeychainHelper.KeychainServiceKeys.userInfo
//        
//        // When: Save and then delete
//        KeychainHelper.shared.save(item, service: service, account: .signMT)
//        KeychainHelper.shared.delete(service: service, account: .signMT)
//        
//        // Then: Should be nil after deletion
//        let readItem = KeychainHelper.shared.read(
//            service: service,
//            account: .signMT,
//            type: MockCodable.self
//        )
//        
//        #expect(readItem == nil, "Item should be deleted")
//    }
//    
//    @Test("Handle Keychain error on save")
//    func testSaveError() throws {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        let invalidData = Data(count: 0) // Could simulate an invalid case
//        let service = KeychainHelper.KeychainServiceKeys.userInfo
//        
//        // When/Then: Expect an error for invalid data or keychain failure
//        #expect(throws: KeychainHelper.KeychainAccessError.self) {
//            try KeychainHelper.shared.save(invalidData, service: service, account: .signMT)
//        }
//    }
//    
//    @Test("Handle Keychain error on read")
//    func testReadError() throws {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        let service = KeychainHelper.KeychainServiceKeys.userInfo
//        
//        // When/Then: Expect an error for non-existent data
//        #expect(throws: KeychainHelper.KeychainAccessError.self) {
//            _ = try KeychainHelper.shared.read(service: service, account: .signMT)
//        }
//    }
//    
//    @Test("Keychain property wrapper usage")
//    func testKeychainPropertyWrapper() {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        struct TestStruct {
//            @Keychain(.userName)
//            var username: String?
//        }
//        
//        var test = TestStruct()
//        
//        // When: Set a value
//        test.username = "TestUser"
//        
//        // Then: Read it back
//        #expect(test.username == "TestUser", "Property wrapper should save and read correctly")
//        
//        // When: Delete (set to nil)
//        test.username = nil
//        
//        // Then: Should be nil
//        #expect(test.username == nil, "Property wrapper should delete correctly")
//    }
//    
//    @Test("Keychain property wrapper with Codable")
//    func testKeychainPropertyWrapperCodable() {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        struct TestStruct {
//            @Keychain(.userInfo)
//            var user: MockCodable?
//        }
//        
//        var test = TestStruct()
//        let user = MockCodable(id: 1, name: "TestUser")
//        
//        // When: Set a value
//        test.user = user
//        
//        // Then: Read it back
//        #expect(test.user == user, "Property wrapper should save and read Codable correctly")
//        
//        // When: Delete (set to nil)
//        test.user = nil
//        
//        // Then: Should be nil
//        #expect(test.user == nil, "Property wrapper should delete correctly")
//    }
//    
//    @Test("Concurrent Keychain access")
//    func testConcurrentAccess() {
//        // Reset Keychain
//        resetKeychain()
//        
//        // Given
//        let item = MockCodable(id: 1, name: "Concurrent")
//        let service = KeychainHelper.KeychainServiceKeys.userInfo
//        KeychainHelper.shared.save(item, service: service, account: .signMT)
//        
//        // Use DispatchQueue to simulate concurrent access
//        let queue = DispatchQueue(label: "test.keychain.queue", attributes: .concurrent)
//        let group = DispatchGroup()
//        var results: [MockCodable?] = []
//        
//        for _ in 0..<100 {
//            group.enter()
//            queue.async {
//                let readItem = KeychainHelper.shared.read(
//                    service: service,
//                    account: .signMT,
//                    type: MockCodable.self
//                )
//                results.append(readItem)
//                group.leave()
//            }
//        }
//        
//        group.wait()
//        
//        // Then: All reads should match the original item
//        let expected = MockCodable(id: 1, name: "Concurrent")
//        #expect(results.allSatisfy { $0 == expected }, "Concurrent reads should return consistent data")
//        #expect(results.count == 100)
//    }
//}
//
//// Helper to simulate Keychain behavior in tests (optional, for real Keychain testing)
//extension KeychainHelper {
//    static var isTesting: Bool {
//        // Simulate testing environment
//        NSClassFromString("XCTestCase") != nil || ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
//    }
//}
