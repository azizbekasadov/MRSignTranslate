//
//  ScenarioType.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

enum ScenarioType: Int, CustomStringConvertible, Hashable {
    case bubble
    case captions
    case skeleton
    case skeletonOnly
    case avatar
    
    var description: String {
        String(describing: self)
    }
}
