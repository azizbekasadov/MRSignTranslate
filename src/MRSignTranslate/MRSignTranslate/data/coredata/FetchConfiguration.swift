//
//  FetchConfiguration.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import CoreData

struct FetchConfiguration {
    let predicate: NSPredicate?
    let sortDescriptors: [NSSortDescriptor]?
    let fetchLimit: Int?
    let fetchOffset: Int?

    init(
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        fetchLimit: Int? = nil,
        fetchOffset: Int? = nil
    ) {
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
        self.fetchLimit = fetchLimit
        self.fetchOffset = fetchOffset
    }
}
