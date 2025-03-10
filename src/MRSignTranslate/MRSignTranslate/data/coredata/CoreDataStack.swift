//
//  CoreDataStack.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import CoreData

protocol CoreDataStack {
    var context: MRManagedObjectContext! { get }
    var persistentContainer: MRPersistentContainer! { get }
    
    func saveContextIfChanged()
}

final class MRCoreDataStack: CoreDataStack {
    lazy var context: MRManagedObjectContext! = persistentContainer.viewContext

    // MARK: Private vars
    private var dataModelName = "DB" {
        didSet {
            persistentContainer = persistentContainerBuilder.configure(
                mergePolicy: NSMergePolicy.overwrite,
                completion: nil,
                inMemory: true
            )
        }
    }
    
    var persistentContainer: MRPersistentContainer!
    private var persistentContainerBuilder: MRCoreDataPersistentContainerProtocol
    
    init(
        dbName: String,
        persistentContainerBuilder: MRCoreDataPersistentContainerProtocol = MRCoreDataPersistentContainer()
    ) {
        dataModelName = dbName
        
        self.persistentContainerBuilder = persistentContainerBuilder
        
        persistentContainer = persistentContainerBuilder.configure(
            mergePolicy: NSMergePolicy.overwrite,
            completion: nil,
            inMemory: true
        )
    }
    
    func saveContextIfChanged() {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            debugPrint("Unable to save context: \(error)")
            fatalError(error.localizedDescription)
        }
    }
}
