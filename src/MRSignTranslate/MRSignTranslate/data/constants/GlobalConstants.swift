//
//  GlobalConstants.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation

enum GlobalConstants {
    enum URLs {
        static let terms: URL = .init(string: "https://research.sign.mt/")!
        static let privacy: URL = .init(string: "https://research.sign.mt/")!
    }
    
    enum Email {
        static let recipient: String = "azizbek.asadov@uzh.ch"
        static let subject: String = "Feedback on the MRSignTranslate App"
    }
}
