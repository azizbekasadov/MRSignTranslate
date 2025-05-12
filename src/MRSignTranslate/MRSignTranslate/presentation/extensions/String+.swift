//
//  String+.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import SwiftUI

extension String {
    var url: URL? {
        URL(string: self)
    }
    
    var image: Image {
        Image(self)
    }
    
    var asFlagName: String {
        "icons/flags/" + self
    }
}
