//import Testing
//import Foundation
//import MRSignMTArchitecture
//
//@testable import MRSignMTArchitecture
//
//@Suite("Injection Container Tests")
//struct InjectionContainerTests {
//    // Reset container before each test
//    func resetContainer() {
//        InjectionContainer.cache.removeAll()
//        InjectionContainer.generators.removeAll()
//    }
//    
//    @Test("Register and resolve new instance")
//    func testRegisterNewInstance() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .new,
//            TestService(value: "Test")
//        )
//        
//        // When
//        let service1 = InjectionContainer.resolve(dependencyType: .new, TestService.self)
//        let service2 = InjectionContainer.resolve(dependencyType: .new, TestService.self)
//        
//        // Then
//        #expect(service1.value == "Test")
//        #expect(service2.value == "Test")
//        #expect(service1 !== service2, "New instances should be different objects")
//    }
//    
//    @Test("Register and resolve singleton")
//    func testRegisterSingleton() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .singleton,
//            TestService(value: "Singleton")
//        )
//        
//        // When
//        let service1 = InjectionContainer.resolve(dependencyType: .singleton, TestService.self)
//        let service2 = InjectionContainer.resolve(dependencyType: .singleton, TestService.self)
//        
//        // Then
//        #expect(service1.value == "Singleton")
//        #expect(service2.value == "Singleton")
//        #expect(service1 === service2, "Singleton instances should be the same object")
//    }
//    
//    @Test("Register and resolve automatic")
//    func testRegisterAutomatic() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .automatic,
//            TestService(value: "Auto")
//        )
//        
//        // When
//        let service1 = InjectionContainer.resolve(dependencyType: .automatic, TestService.self)
//        let service2 = InjectionContainer.resolve(dependencyType: .automatic, TestService.self)
//        
//        // Then
//        #expect(service1.value == "Auto")
//        #expect(service2.value == "Auto")
//        #expect(service1 === service2, "Automatic should cache the first instance")
//    }
//    
//    @Test("Resolve different types")
//    func testResolveDifferentTypes() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            TestService(value: "Service")
//        )
//        InjectionContainer.register(
//            type: String.self,
//            "String"
//        )
//        
//        // When
//        let service = InjectionContainer.resolve(TestService.self)
//        let string = InjectionContainer.resolve(String.self)
//        
//        // Then
//        #expect(service.value == "Service")
//        #expect(string == "String")
//    }
//    
//    @Test("Inject new instance")
//    func testInjectNew() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .new,
//            TestService(value: "Injected")
//        )
//        
//        // When
//        let inject1 = Inject(.new).wrappedValue as TestService
//        let inject2 = Inject(.new).wrappedValue as TestService
//        
//        // Then
//        #expect(inject1.value == "Injected")
//        #expect(inject2.value == "Injected")
//        #expect(inject1 !== inject2)
//    }
//    
//    @Test("Inject singleton")
//    func testInjectSingleton() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .singleton,
//            TestService(value: "Singleton")
//        )
//        
//        // When
//        let inject1 = Inject(.singleton).wrappedValue as TestService
//        let inject2 = Inject(.singleton).wrappedValue as TestService
//        
//        // Then
//        #expect(inject1.value == "Singleton")
//        #expect(inject2.value == "Singleton")
//        #expect(inject1 === inject2)
//    }
//    
//    @Test("Concurrent access maintains singleton integrity")
//    func testConcurrentAccess() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .singleton,
//            TestService(value: "Concurrent")
//        )
//        
//        // When/Then
//        let results = (0..<100).map { _ in
//            InjectionContainer.resolve(dependencyType: .singleton, TestService.self)
//        }
//        
//        let first = results.first!
//        #expect(results.allSatisfy { $0 === first })
//        #expect(results.count == 100)
//    }
//    
//    @Test("Thread safety with multiple threads")
//    func testThreadSafety() {
//        // Reset container
//        resetContainer()
//        
//        // Given
//        InjectionContainer.register(
//            type: TestService.self,
//            as: .singleton,
//            TestService(value: "ThreadSafe")
//        )
//        
//        // Use DispatchQueue to simulate concurrent access
//        let queue = DispatchQueue(label: "test.queue", attributes: .concurrent)
//        let group = DispatchGroup()
//        var results: [TestService] = []
//        
//        for _ in 0..<100 {
//            group.enter()
//            queue.async {
//                let service = InjectionContainer.resolve(dependencyType: .singleton, TestService.self)
//                results.append(service)
//                group.leave()
//            }
//        }
//        
//        group.wait()
//        
//        // Then
//        let first = results.first!
//        #expect(results.allSatisfy { $0 === first })
//        #expect(results.count == 100)
//    }
//}
//
//// Test Service for verification (must conform to Sendable since Inject requires Component: Sendable)
//final class TestService: @unchecked Sendable {
//    let value: String
//    
//    init(value: String) {
//        self.value = value
//    }
//}
