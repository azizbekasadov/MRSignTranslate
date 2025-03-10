//
//  Speech2TextScreen.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import SwiftUI

struct SpeechToTextView: View {
    @StateObject private var viewModel: SpeechToTextViewModel
    @State private var isListening = false
    
    init(
        viewModel: SpeechToTextViewModel = SpeechToTextViewModel(
            speechService: SpeechToTextService()
        )
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.transcribedText.isEmpty ? "Start speaking..." : viewModel.transcribedText)
                .padding()
                .frame(height: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button(action: toggleListening) {
                Text(isListening ? "Stop Listening" : "Start Listening")
                    .padding()
                    .background(isListening ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    private func toggleListening() {
        if isListening {
            viewModel.stopListening()
        } else {
            viewModel.requestPermission { granted in
                if granted {
                    viewModel.startListening()
                } else {
                    print("Permission denied")
                }
            }
        }
        isListening.toggle()
    }
}

// MARK: - Preview
#Preview {
    SpeechToTextView()
}
