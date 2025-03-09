//
//  TestEntity+CoreDataProperties.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//
//

import Foundation
import CoreData

extension TestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestEntity> {
        return NSFetchRequest<TestEntity>(entityName: "TestEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?

}

extension TestEntity : Identifiable {}
