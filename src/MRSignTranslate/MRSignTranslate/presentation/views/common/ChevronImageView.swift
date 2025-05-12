//
//  ChevronImageView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 17.04.2025.
//

import SwiftUI

struct ChevronImageView: View {
    var body: some View {
        Image(systemName: "chevron.down")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(.gray.opacity(0.75))
    }
}

#Preview {
    ChevronImageView()
}
