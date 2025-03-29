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
        HStack(alignment: .top, spacing: -5) {
            
            // Bubble tail
            Triangle()
                .fill(Color.black)
                .frame(width: 20, height: 12)
                .rotationEffect(.degrees(90))
                .padding(.top, 30)
                .padding(.leading, 5)
            
                // Bubble content
                Text(text)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
                .font(.system(size: 50))
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black)
                            .shadow(radius: 5)
                    )
                    .layoutPriority(1)
                    .frame(maxWidth: 500)

            }
            .padding()
            .opacity(text.isEmpty ? 0 : 1)
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
