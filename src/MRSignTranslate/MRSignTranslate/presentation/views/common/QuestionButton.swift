//
//  QuestionButton.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI
//questionmark.circle.fill

struct QuestionButton: View {
    private enum Constants {
        enum Paddings {
            static let horizontal: CGFloat = 24
            static let vertical: CGFloat = 6
        }
        
        enum Colors {
            static var backgroundColor: Color {
                #if os(visionOS)
                return Color.white.opacity(0.15)
                #else
                return Color(UIColor.systemGray6)
                #endif
            }
        }
    }
    
    private let action: (()->Void)?
    
    init(
        action: (()->Void)? = nil
    ) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: "questionmark")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 32,
                    height: 32
                )
                .padding(12)
        }
        .font(Font.system(.caption).bold())
        .background(Constants.Colors.backgroundColor)
        .clipShape(Capsule())
        .buttonStyle(.plain)
        .controlSize(.extraLarge)
    }
}

#Preview {
    QuestionButton()
}
