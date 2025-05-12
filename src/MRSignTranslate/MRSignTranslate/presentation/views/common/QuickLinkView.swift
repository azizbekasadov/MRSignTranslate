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
            HStack(alignment: .top) {
                Text(title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.primary)
                    .padding(6)
                Spacer()
                    .frame(maxWidth: 250)
            }
        }
        .sheet(isPresented: self.$isPresented) {
            DefaultView(title: title)
        }
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.plain)
    }
}

#Preview {
    SingleLineButton(title: "Hello World!")
}

