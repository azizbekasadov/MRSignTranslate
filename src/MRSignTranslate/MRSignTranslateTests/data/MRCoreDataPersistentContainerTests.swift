//
//  MRCoreDataPersistentContainerTests.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import XCTest
import CoreData

@testable import MRSignTranslate

final class MRCoreDataPersistentContainerTests: XCTestCase {
    
    private var container: MRCoreDataPersistentContainer!
    
    override func setUp() {
        super.setUp()
        container = MRCoreDataPersistentContainer(containerName: "DB")
    }
    
    override func tearDown() {
        container = nil
        super.tearDown()
    }

    // MARK: - Initialization Tests

    func testPersistentContainerInitialization() {
        let persistentContainer = container.configure(inMemory: true)
        XCTAssertNotNil(persistentContainer)
        XCTAssertEqual(persistentContainer.name, "DB")
    }
    
    // MARK: - In-Memory Store Tests

    func testPersistentContainerUsesInMemoryStore() {
        let persistentContainer = container.configure(inMemory: true)
        let description = persistentContainer.persistentStoreDescriptions.first
        XCTAssertEqual(description?.type, NSInMemoryStoreType)
    }
    
    func testPersistentContainerUsesDiskStore() {
        let persistentContainer = container.configure(inMemory: false)
        let description = persistentContainer.persistentStoreDescriptions.first
        XCTAssertNotEqual(description?.type, NSInMemoryStoreType)
    }

    // MARK: - Persistent Store Loading Tests

    func testPersistentContainerLoadStoreSuccessfully() {
        let expectation = self.expectation(description: "Persistent store should load successfully")

        container.configure { _, error in
            XCTAssertNil(error, "Persistent store should load without errors")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    // MARK: - MRCoreDataStack Tests

    func testCoreDataStackInitialization() {
        let stack = MockCoreDataStack(dbName: "DB")
        XCTAssertNotNil(stack.persistentContainer)
        XCTAssertNotNil(stack.context)
    }
    
    func testCoreDataStackContextPersistsChanges() {
        let stack = MockCoreDataStack(dbName: "DB")
        stack.context.performAndWait {
            let newEntity = NSEntityDescription.insertNewObject(forEntityName: "TestEntity", into: stack.context)
            XCTAssertNotNil(newEntity)
        }
    }
    
    func testCoreDataStackContextSavesChanges() {
        let stack = MockCoreDataStack(dbName: "DB")
        stack.context.performAndWait {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "TestEntity", into: stack.context)
            XCTAssertNotNil(entity)
        }
        XCTAssertNoThrow(stack.saveContextIfChanged())
    }
    
    func testCoreDataStackSaveDoesNotCrashOnNoChanges() {
        let stack = MRCoreDataStack(dbName: "DB")
        XCTAssertNoThrow(stack.saveContextIfChanged())
    }
    
    // MARK: - StorageService Fetching Tests

    func testFetchConfigurationWithPredicate() {
        let predicate = NSPredicate(format: "name == %@", "John")
        let fetchConfig = FetchConfiguration(predicate: predicate)
        XCTAssertEqual(fetchConfig.predicate, predicate)
    }
    
    func testFetchConfigurationWithSorting() {
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let fetchConfig = FetchConfiguration(sortDescriptors: [sortDescriptor])
        XCTAssertEqual(fetchConfig.sortDescriptors?.first, sortDescriptor)
    }

    func testFetchConfigurationWithLimit() {
        let fetchConfig = FetchConfiguration(fetchLimit: 5)
        XCTAssertEqual(fetchConfig.fetchLimit, 5)
    }

    // MARK: - StorageService Removal Tests

    func testStorageServiceRemoveObject() {
        let stack = MRCoreDataStack(dbName: "DB")
        let mockStorageService = MockStorageService(context: stack.context)
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "TestEntity", into: stack.context) as! Storagable
        mockStorageService.remove(object)
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "TestEntity")
        let result = try? stack.context.fetch(fetchRequest)
        
        XCTAssertEqual(result?.count, 0)
    }
}

extension TestEntity: Storagable {}
