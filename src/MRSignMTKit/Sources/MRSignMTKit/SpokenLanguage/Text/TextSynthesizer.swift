//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation
import AVFoundation

public protocol TextSynthesizer: Synthesizable {}

public protocol Text2SpeechRecognizing: AVSpeechSynthesizerDelegate {
    func speak(
        text: String,
        language: MRLanguage,
        rate: Float
    )
    
    func stop()
}

public class Text2SpeechManager: NSObject, Text2SpeechRecognizing {
    
    nonisolated(unsafe) private let synthesizer = AVSpeechSynthesizer()
    
    public func speak(
        text: String,
        language: MRLanguage,
        rate: Float
    ) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language.locale.identifier)
        utterance.rate = rate
        synthesizer.speak(utterance)
    }
    
    public func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}

extension Text2SpeechManager {
    
    public func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didStart utterance: AVSpeechUtterance
    ) {
        debugPrint("🔊 Started speaking: \(utterance.speechString)")
    }

    public func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        debugPrint("✅ Finished speaking: \(utterance.speechString)")
    }

    public func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didPause utterance: AVSpeechUtterance
    ) {
        debugPrint("⏸️ Paused speaking")
    }

    public func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didContinue utterance: AVSpeechUtterance
    ) {
        debugPrint("▶️ Resumed speaking")
    }

    public func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didCancel utterance: AVSpeechUtterance
    ) {
        debugPrint("❌ Canceled speaking")
    }
}
