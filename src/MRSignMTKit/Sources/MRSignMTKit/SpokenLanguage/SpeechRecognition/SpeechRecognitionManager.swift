//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 17.03.2025.
//

import Speech
import AVFoundation
import Observation

public protocol SpeechRecognizing {
    func startRecognition(
        for language: MRLanguage
    ) async throws -> AsyncStream<String>
    
    func stopRecognition()
}

public final class RealSpeechRecognitionManager: NSObject, SpeechRecognizing {
    private let speechRecognizer: SFSpeechRecognizer?
    
    private let audioEngine = AVAudioEngine()
    private let request = SFSpeechAudioBufferRecognitionRequest()
    
    public var onSpeechDetected: ((String, SIMD3<Float>) -> Void)?
    public var onCaptionUpdate: ((String) -> Void)?

    var recognitionTask: SFSpeechRecognitionTask?
    
    public init(language: MRLanguage) {
        self.speechRecognizer = SFSpeechRecognizer(locale: language.locale)
    }

    public static func requestPermissions() async -> Bool {
        let speechStatus = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
        
        let audioStatus = await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { granted in
                continuation.resume(returning: granted)
            }
        }
        
        return speechStatus && audioStatus
    }

    public func startRecognition(
        for language: MRLanguage
    ) async throws -> AsyncStream<String> {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            throw NSError(domain: "SpeechRecognition", code: 1, userInfo: [NSLocalizedDescriptionKey: "Speech recognition not available."])
        }

        return AsyncStream { continuation in
            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.request.append(buffer)
            }

            self.audioEngine.prepare()
            try? self.audioEngine.start()

            self.recognitionTask = recognizer.recognitionTask(with: self.request) { result, error in
                if let result = result {
                    let spokenText = result.bestTranscription.formattedString
                    let speakerPosition = self.estimateSpeakerPosition()
                    self.onSpeechDetected?(spokenText, speakerPosition)
                    continuation.yield(spokenText)
                }
                if error != nil {
                    continuation.finish()
                }
            }
        }
    }
    
    public func startRecognitionForCaptions(
        for language: MRLanguage
    ) async throws {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            throw NSError(domain: "SpeechRecognition", code: 1, userInfo: [NSLocalizedDescriptionKey: "Speech recognition not available."])
        }
        
        let inputNode = self.audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        self.audioEngine.prepare()
        try? self.audioEngine.start()
        
        self.recognitionTask = recognizer.recognitionTask(with: self.request) { result, error in
            if let result = result {
                let spokenText = result.bestTranscription.formattedString
                self.onCaptionUpdate?(spokenText)
            }
            if error != nil {
                self.stopRecognition()
            }
        }
    }

    private func estimateSpeakerPosition() -> SIMD3<Float> {
        SIMD3(Float.random(in: -0.5...0.5), 0.2, -0.5)
    }

    public func stopRecognition() {
        audioEngine.stop()
        recognitionTask?.cancel()
        recognitionTask = nil
    }
}

final class SimulatedSpeechRecognition: NSObject, SpeechRecognizing {
    func startRecognition(for language: MRLanguage) async throws -> AsyncStream<String> {
        let phrases = ["Hello from the simulator!", "This is a test.", "How are you today?", "Swift is amazing!"]
        return AsyncStream { continuation in
            Task {
                for phrase in phrases {
                    try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds delay
                    continuation.yield(phrase)
                }
                continuation.finish()
            }
        }
    }

    func stopRecognition() {
        // No real engine, just stop async tasks if needed
        debugPrint("Speech Recognition stopped!")
    }
}

class SpeechRecognitionFactory {
    static func createSpeechRecognition(for language: MRLanguage) -> SpeechRecognizing {
        #if targetEnvironment(simulator)
        return SimulatedSpeechRecognition()
        #else
        return RealSpeechRecognition(language: language)
        #endif
    }
}

@Observable
public final class SpeechRecognitionManager: NSObject, Sendable {
    public static let shared = SpeechRecognitionManager()  // Singleton
    
    public private(set) var speechRecognition: SpeechRecognizing?
    
    nonisolated(unsafe) private var recognitionTask: Task<Void, Never>?
    
    public var recognizedText: String = ""   // Triggers UI updates automatically in SwiftUI
    public var isSpeaking: Bool = false      // Keeps track of speaking state

    public func configure(language: MRLanguage) {
        self.speechRecognition = SpeechRecognitionFactory.createSpeechRecognition(for: language)
    }

    public func startRecognition(
        for language: MRLanguage = .usLocale,
        completion: @escaping (String) -> Void
    ) {
        guard let speechRecognition = speechRecognition else { return }
        recognitionTask?.cancel()
        isSpeaking = true

        recognitionTask = Task {
            do {
                for await text in try await speechRecognition.startRecognition(
                    for: language
                ) {
                    DispatchQueue.main.async { [weak self] in
                        self?.recognizedText = text
                    }
                }
                self.isSpeaking = false
                completion(self.recognizedText)
            } catch {
                debugPrint(error.localizedDescription)
                completion(error.localizedDescription)
            }
        }
    }

    public func stopRecognition() {
        speechRecognition?.stopRecognition()
        recognitionTask?.cancel()
        isSpeaking = false
        recognizedText = ""
    }
}
