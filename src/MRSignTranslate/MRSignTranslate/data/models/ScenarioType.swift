//
//  ScenarioType.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

enum ScenarioType: Int, CustomStringConvertible {
    case basic = 0
    case aviation
    case learnASL
    case training
    case conference
    
    var description: String {
        String(describing: self)
    }
}
