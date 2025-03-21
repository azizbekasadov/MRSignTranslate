//
//  SwiftUIView 2.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI

struct SpeechToTextView: View {
    @Bindable private var viewModel = SpeechToTextViewModel()

    var body: some View {
        VStack {
            Text(viewModel.recognizedText)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            Button(action: {
                viewModel.toggleSpeechRecognition()
            }) {
                Image(systemName: viewModel.isRecording ? "stop.circle.fill" : "mic.fill")
                    .font(.system(size: 50))
                    .foregroundColor(viewModel.isRecording ? .red : .blue)
                    .padding()
                    .background(Circle().fill(Color.white).shadow(radius: 5))
            }
            .padding()
        }
    }
}

// ViewModel to handle speech recognition logic
@Observable
final class SpeechToTextViewModel {
    var recognizedText = "Tap the mic to start speaking"
    var isRecording = false
    
    private let speechRecognizer = SpeechRecognitionManager()

    func toggleSpeechRecognition() {
        if isRecording {
            speechRecognizer.stopRecognition()
            isRecording = false
        } else {
            speechRecognizer.startRecognition(for: .usLocale) { recognizedText in
                DispatchQueue.main.async {
                    self.recognizedText = recognizedText
                }
            }
            
            isRecording = true
        }
    }
}

#Preview {
    SpeechToTextView()
}
