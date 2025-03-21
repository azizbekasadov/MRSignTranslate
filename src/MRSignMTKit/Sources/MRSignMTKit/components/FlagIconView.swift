//
//  SwiftUIView.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI

struct FlagIconView: View {
    let language: MRLanguage // e.g., "us", "fr", "de"
    let isSquared: Bool

    var body: some View {
        Image(language.iconName) // Load flag image from assets
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: isSquared ? 50 : 30) // Square or rectangular
            .clipShape(
                RoundedRectangle(cornerRadius: isSquared ? 5 : 50)
            )
    }
}
