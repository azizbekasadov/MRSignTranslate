//
//  DismissButton.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    var title: String
    
    var body: some View {
        Button(title) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}
