//
//  ButtonWithPopOver.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import SwiftUI

struct ButtonWithPopOver<Content: View, PopOverContent: View>: View {
    @ViewBuilder var content: Content
    @ViewBuilder var popoverContent: PopOverContent
    
    @State private var isPresented = false
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            content
        }
        .popover(isPresented: $isPresented) {
            popoverContent
        }
    }
}
