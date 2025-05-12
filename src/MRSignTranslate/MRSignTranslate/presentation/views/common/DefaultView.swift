//
//  DefaultView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import SwiftUI

struct DefaultView: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    
    var body: some View {
        NavigationView {
            Text(title)
                .navigationBarTitle(title, displayMode: .inline)
                .navigationBarItems(
                    leading: DismissButton(
                        presentationMode: _presentationMode,
                        title: "Cancel"
                    )
                )
        }
    }
}

#Preview {
    DefaultView(title: "Some title")
}
