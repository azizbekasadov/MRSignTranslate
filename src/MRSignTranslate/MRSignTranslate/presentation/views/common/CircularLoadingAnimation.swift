//
//  CircularLoadingAnimation.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 16.03.2025.
//

import SwiftUI

struct CircularLoadingAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Track Circle
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            // Animated Arc
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(style: StrokeStyle(
                    lineWidth: 5,
                    lineCap: .round,
                    lineJoin: .round
                ))
                .foregroundColor(Color(.redHighlight))
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .frame(width: 50, height: 50)
        .padding()
        .onAppear {
            isAnimating = true
        }
    }
}

struct SimpleSpinnerView: View {
    @State private var isAnimating = false
    
    var color: Color = Color(.redHighlight)
    var lineWidth: CGFloat = 5
    var size: CGFloat = 50
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 1.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.8)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .frame(width: size, height: size)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(foreverAnimation, value: isAnimating)
        }
        .frame(width: size, height: size)
        .onAppear {
            self.isAnimating = true
        }
    }
}

// Preview
struct CircularLoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            CircularLoadingAnimation()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
