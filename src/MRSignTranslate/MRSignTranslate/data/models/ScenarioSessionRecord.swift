//
//  ScenarioSessionRecord.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation
import Collections

struct ScenarioSessionRecord: Identifiable {
    let id: UUID
    let title: String
    let hash: Hash
    
//    let conversation: Hash
}


typealias Hash = String
