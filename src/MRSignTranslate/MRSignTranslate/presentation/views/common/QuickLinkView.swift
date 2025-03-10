//
//  QuickLinkView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import SwiftUI

struct SingleLineButton: View {
    @State var isPresented = false
    let title: String
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.primary)
        }
        .sheet(isPresented: self.$isPresented) {
            DefaultView(title: title)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SingleLineButton(title: "Hello World!")
}

