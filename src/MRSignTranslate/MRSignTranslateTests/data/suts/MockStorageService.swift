//
//  File.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation
import CoreData

@testable import MRSignTranslate

final class MockStorageService: StorageService {
    
    let context: MRManagedObjectContext
    
    init(context: MRManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Write (No-op for testing)
    
    func write() {
        do {
            try context.save()
        } catch {
            debugPrint("MockStorageService: Failed to write changes - \(error)")
        }
    }
    
    // MARK: - Remove Logic
    
    func remove(_ object: Storagable) {
        context.delete(object)
    }

    func remove<S: Sequence>(_ objects: S) where S.Iterator.Element: Storagable {
        objects.forEach { context.delete($0) }
    }

    func removeAll<T: Storagable>(type: T.Type) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            debugPrint("MockStorageService: Failed to remove all objects of type \(T.self) - \(error)")
        }
    }

    func removeAll<T: Storagable>(type: T.Type, predicate: NSPredicate) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            debugPrint("MockStorageService: Failed to remove all objects with predicate \(predicate) - \(error)")
        }
    }
    
    // MARK: - Fetch Logic
    
    func fetchLast<T: Storagable>(type: T.Type) -> T? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        return try? context.fetch(fetchRequest).first
    }
    
    func fetch<T: Storagable>(type: T.Type) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        return try? context.fetch(fetchRequest)
    }
    
    func fetch<T: Storagable>(type: T.Type, predicate: NSPredicate) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        
        return try? context.fetch(fetchRequest)
    }
    
    func fetch<T: Storagable>(type: T.Type, sortDescriptors: [NSSortDescriptor]) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.sortDescriptors = sortDescriptors
        
        return try? context.fetch(fetchRequest)
    }
    
    func fetch<T: Storagable>(type: T.Type, predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        return try? context.fetch(fetchRequest)
    }
    
    func fetch<T: Storagable>(type: T.Type, configuration: FetchConfiguration) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.predicate = configuration.predicate
        fetchRequest.sortDescriptors = configuration.sortDescriptors
        if let limit = configuration.fetchLimit {
            fetchRequest.fetchLimit = limit
        }
        if let offset = configuration.fetchOffset {
            fetchRequest.fetchOffset = offset
        }
        
        return try? context.fetch(fetchRequest)
    }
}
