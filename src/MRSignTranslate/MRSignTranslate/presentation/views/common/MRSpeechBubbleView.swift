//
//  SpeechBubbleView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import SwiftUI

struct SpeechBubble: View {
    @Binding var text: String
    
    var body: some View {
        ScrollView {
            Text(text)
                .font(.system(size: 36))
                .multilineTextAlignment(.leading)
                .padding(16)
                .layoutPriority(1)
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 16)
        }
        .background(
            MRSpeechBubble(radius: 24)
                .fill(Color.black)
        )
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: 500, maxHeight: 1200)
    }
}

#Preview {
    SpeechBubble(text: .constant("Hello World!"))
}


// Simple triangle shape for the tail
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Pointing down triangle
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))   // bottom center
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // top left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // top right
        path.closeSubpath()
        return path
    }
}

struct MRSpeechBubble: Shape {
    private let radius: CGFloat
    private let tailSize: CGSize

    init(radius: CGFloat = 10, tailSize: CGSize = CGSize(width: 20, height: 20)) {
        self.radius = radius
        self.tailSize = tailSize
    }

    func path(in rect: CGRect) -> Path {
        let tailWidth = tailSize.width
        let tailHeight = tailSize.height

        var path = Path()

        // Start at top-left corner
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))

        // Top edge
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(270),
                    endAngle: .degrees(0),
                    clockwise: false)

        // Right edge
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius - tailHeight))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius - tailHeight),
                    radius: radius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(90),
                    clockwise: false)

        // Bottom edge before tail
        path.addLine(to: CGPoint(x: rect.minX + tailWidth + radius, y: rect.maxY - tailHeight))

        // Tail
        path.addLine(to: CGPoint(x: rect.minX + tailWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + tailWidth - 10, y: rect.maxY - tailHeight))

        // Bottom edge continued
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY - tailHeight))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius - tailHeight),
                    radius: radius,
                    startAngle: .degrees(90),
                    endAngle: .degrees(180),
                    clockwise: false)

        // Left edge
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false)

        return path
    }
}
