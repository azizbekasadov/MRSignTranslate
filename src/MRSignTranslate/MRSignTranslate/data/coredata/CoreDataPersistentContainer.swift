//
//  CoreDataPersistentContainer.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import CoreData

typealias MRPersistentContainer = NSPersistentContainer
typealias MRPersistentContainerName = String

protocol MRCoreDataPersistentContainerProtocol {
    typealias LoadPersisntantStoresCompletionHandler = ((NSPersistentStoreDescription, (any Error)?) -> Void)
    
    func configure(
        mergePolicy: NSMergePolicy,
        completion: LoadPersisntantStoresCompletionHandler?,
        inMemory: Bool
    ) -> MRPersistentContainer
}

final class MRCoreDataPersistentContainer: MRCoreDataPersistentContainerProtocol {
    private let containerName: MRPersistentContainerName
    
    init(
        containerName: MRPersistentContainerName = "DB"
    ) {
        self.containerName = containerName
    }
    
    func configure(
        mergePolicy: NSMergePolicy = .overwrite,
        completion: LoadPersisntantStoresCompletionHandler? = nil,
        inMemory: Bool = false
    ) -> MRPersistentContainer {
        let container = NSPersistentContainer(name: containerName)
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.url = URL(fileURLWithPath: "/dev/null")
            description.configuration = nil
            
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("Unable to load persistent stores: \(error)")
                fatalError(error.localizedDescription)
            }
            
            completion?(description, error)
        }
        
        container.viewContext.mergePolicy = mergePolicy
        return container
    }
}
