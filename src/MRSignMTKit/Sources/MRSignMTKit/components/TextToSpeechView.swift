//
//  SwiftUIView.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI
import AVFoundation

struct TextToSpeechView: View {
    @StateObject private var viewModel = TextToSpeechViewModel()

    var body: some View {
        VStack {
            if !viewModel.text.isEmpty {
                Button(action: {
                    viewModel.isSpeaking ? viewModel.cancel() : viewModel.play()
                }) {
                    Image(systemName: viewModel.isSpeaking ? "stop.circle.fill" : "speaker.wave.2.fill")
                        .font(.system(size: 50))
                        .foregroundColor(viewModel.isSpeaking ? .red : .blue)
                        .padding()
                        .background(Circle().fill(Color.white).shadow(radius: 5))
                }
                .accessibilityLabel(viewModel.isSpeaking ? "Stop Speaking" : "Play Speech")
                .padding()
            }
        }
    }
}

// ViewModel for Text-to-Speech Logic
class TextToSpeechViewModel: ObservableObject {
    @Published var isSpeaking = false
    @Published var text = "Hello, welcome to text-to-speech in SwiftUI!"

    private let synthesizer = AVSpeechSynthesizer()

    init() {
        synthesizer.delegate = SpeechSynthesizerDelegate.shared
        SpeechSynthesizerDelegate.shared.onSpeechStateChange = { [weak self] isSpeaking in
            DispatchQueue.main.async {
                self?.isSpeaking = isSpeaking
            }
        }
    }

    func play() {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Set language
        synthesizer.speak(utterance)
        isSpeaking = true
    }

    func cancel() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}

// Delegate to track speech synthesis state
class SpeechSynthesizerDelegate: NSObject, AVSpeechSynthesizerDelegate {
    static let shared = SpeechSynthesizerDelegate()
    var onSpeechStateChange: ((Bool) -> Void)?

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        onSpeechStateChange?(true)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        onSpeechStateChange?(false)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        onSpeechStateChange?(false)
    }
}
