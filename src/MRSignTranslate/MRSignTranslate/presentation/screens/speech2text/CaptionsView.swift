//
//  CaptionsView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI
import MRSignMTKit

struct CaptionsView: View {
    @State private var captionText: String = "Here you will read captions of the speech"
    @State private var opacity: Double = 0.0

    private let speechManager = SpeechRecognitionManager()

    var body: some View {
        VStack {
            Spacer()
            
            Text(captionText)
                .font(.system(size: 24, weight: .semibold))
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.ultraThickMaterial)
                .cornerRadius(12)
                .foregroundColor(.white)
                .opacity(opacity)
                .animation(.easeInOut(duration: 0.25), value: opacity)
                .transition(.opacity)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
        .onAppear {
            #if targetEnvironment(simulator)
            captionText = "This is a simulator preview"
            opacity = 1.0
            #else
            speechManager.startRecognition(for: .usLocale) { newCaption in
                withAnimation {
                    captionText = newCaption
                    opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        opacity = 0.0
                    }
                }
            }
            #endif
        }
    }
}

#Preview {
    CaptionsView()
}
