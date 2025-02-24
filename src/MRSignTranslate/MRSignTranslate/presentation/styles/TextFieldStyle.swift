//
//  TextFieldStyle.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import SwiftUI

struct OutlinedTextField: TextFieldStyle {
    @FocusState private var focused

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
            .foregroundColor(Color(.textPrimary))
            .focused($focused)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(focused ? Color.blue : Color(.separatorGray), lineWidth: 1)
            )
    }
}

#Preview("OutlinedTextField") {
    struct Container: View {
        @State private var text = ""

        var body: some View {
            VStack(spacing: 20) {
                TextField("Placeholder", text: $text)
                    .textFieldStyle(OutlinedTextField())
            }
        }
    }
    return Container()
}
