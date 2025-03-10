//
//  GlassButtonStyle.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 07.03.2025.
//

import Foundation
import SwiftUI

struct GlassButtonStyle: ButtonStyle {
    @State private var isHovered: Bool = false
    
    var icon: String? = nil
    var title: String
    var size: CGSize = .init(width: 120, height: 80)
    var fontSize: CGFloat = 35
    var opacity: Double = 0.75

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: fontSize))
                    .foregroundStyle(.white)
            }
            Text(title)
                .font(.system(size: fontSize, weight: .bold))
                .foregroundStyle(.white)
                .scaleEffect(isHovered ? 1.1 : 1.0) // Slight zoom on hover
                .animation(.easeInOut(duration: 0.2), value: isHovered)
        }
        .padding()
        .frame(width: size.width * 2, height: size.height)
        .background(
            VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                .opacity(opacity)
                .clipShape(RoundedRectangle(cornerRadius: size.height / 2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: size.height / 2)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
