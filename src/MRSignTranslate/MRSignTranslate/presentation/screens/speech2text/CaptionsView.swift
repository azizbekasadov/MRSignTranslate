//
//  CaptionsView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI
import MRSignMTKit

struct CaptionsView: View {
    @State private var captionText: String = ""
    @State private var opacity: Double = 0.0
    
    private let speechManager = SpeechRecognitionManager()

    var body: some View {
        ZStack {
            Text(captionText)
                .font(.system(size: 30, weight: .bold))
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .foregroundColor(.white)
                .opacity(opacity)
                .animation(.easeInOut(duration: 0.3), value: opacity)
        }
        .onAppear {
            speechManager.startRecognition(for: .usLocale) { captions in
                withAnimation {
                    captionText = captions
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        opacity = 0.0
                    }
                }
            }
        }
    }
}


#Preview {
    CaptionsView()
}
