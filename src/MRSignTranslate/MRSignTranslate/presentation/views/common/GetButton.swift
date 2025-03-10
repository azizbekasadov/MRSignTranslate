//
//  GetButton.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import SwiftUI

struct GetButton: View {
    private enum Constants {
        enum Colors {
            static var backgroundColor: Color {
                #if os(visionOS)
                return Color.white.opacity(0.15)
                #else
                return Color(UIColor.systemGray6)
                #endif
            }
        }
        
        enum Paddings {
            static let horizontal: CGFloat = 12
            static let vertical: CGFloat = 6
        }
    }
    
    private let title: String
    private let action: (()->Void)?
    
    init(
        title: String = "GET",
        action: (()->Void)? = nil
    ) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .foregroundStyle(Color(UIColor.label))
                .font(.system(size: 10, weight: .semibold))
                .padding(.horizontal, Constants.Paddings.horizontal)
                .padding(.vertical, Constants.Paddings.vertical)
                .layoutPriority(0)
        }
        .font(Font.system(.caption).bold())
        .background(Constants.Colors.backgroundColor)
        .clipShape(Capsule())
        .buttonStyle(.plain)
        .hoverEffect(.lift)
    }
}

#Preview {
    GetButton(
        title: "GET",
        action: nil
    )
}
