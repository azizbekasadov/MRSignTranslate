//
//  InAppPurchasesLabel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI

struct InAppPurchasesLabel: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 8))
            .foregroundStyle(Color(UIColor.label))
    }
}

#Preview {
    InAppPurchasesLabel(text: "Hello World")
}
