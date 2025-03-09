//
//  StorageService.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import CoreData

protocol StorageServiceRemoveLogic {
    // MARK: Remove
    func remove(_ object: Storagable)

    func remove<S: Sequence>(_ objects: S) where S.Iterator.Element: Storagable

    func removeAll<T: Storagable>(type: T.Type)

    func removeAll<T: Storagable>(type: T.Type, predicate: NSPredicate)
}

protocol StorageServiceFetchLogic {
    // MARK: Fetch
    func fetchLast<T: Storagable>(type: T.Type) -> T?
    
    func fetch<T: Storagable>(type: T.Type) -> [T]?

    func fetch<T: Storagable>(type: T.Type, predicate: NSPredicate) -> [T]?

    func fetch<T: Storagable>(type: T.Type, sortDescriptors: [NSSortDescriptor]) -> [T]?

    func fetch<T: Storagable>(type: T.Type, predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> [T]?

    func fetch<T: Storagable>(type: T.Type, configuration: FetchConfiguration) -> [T]?
}

typealias MRManagedObjectContext = NSManagedObjectContext

protocol StorageService: StorageServiceRemoveLogic, StorageServiceFetchLogic {
    var context: MRManagedObjectContext { get }

    func write()
}
