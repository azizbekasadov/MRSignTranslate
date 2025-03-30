//
//  SpeechToTextService.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 29.03.2025.
//

import AVFoundation
import Foundation
import Speech
import NaturalLanguage

final class Speech2ToTextService: @preconcurrency SpeechToTextServiceProtocol {
    private var accumulatedText: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    private var isLanguageChecked = false
    private var currentLocaleIdentifier: String
    
    /// Initializes a new instance of the speech recognition service with the provided locale identifier.
    /// - Parameter localeIdentifier: The locale identifier to use (defaults to the device's current locale).
    init(localeIdentifier: String = Locale.current.identifier) {
        self.currentLocaleIdentifier = localeIdentifier
        self.recognizer = SFSpeechRecognizer(locale: Locale(identifier: localeIdentifier))
    }
    
    /// Requests permissions and verifies the availability of the speech recognizer.
    /// - Throws: `RecognizerError` if the recognizer is unavailable or if the necessary permissions are not granted.
    func authorize() async throws {
        guard let recognizer = self.recognizer else {
            throw RecognizerError.recognizerUnavailable
        }
        
        let hasAuthorization = await SFSpeechRecognizer.hasAuthorizationToRecognize()
        guard hasAuthorization else {
            throw RecognizerError.notAuthorizedToRecognize
        }
        
        let hasRecordPermission = await AVAudioSession.sharedInstance().hasPermissionToRecord()
        guard hasRecordPermission else {
            throw RecognizerError.notPermittedToRecord
        }
        
        if !recognizer.isAvailable {
            throw RecognizerError.recognizerUnavailable
        }
    }
    
    deinit {
        reset()
    }
    
    @MainActor
    func transcribe() -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let (audioEngine, request) = try Self.prepareEngine()
                    self.audioEngine = audioEngine
                    self.request = request
                    
                    guard let recognizer = self.recognizer else {
                        throw RecognizerError.recognizerUnavailable
                    }
                    
                    self.task = recognizer.recognitionTask(with: request, resultHandler: { [weak self] result, error in
                        guard let self = self else { return }
                        
                        if let error = error {
                            continuation.finish(throwing: error)
                            self.reset()
                            return
                        }
                        
                        if let result = result {
                            let newText = result.bestTranscription.formattedString
                            logger.info(.init(stringLiteral: newText))
                            continuation.yield(self.accumulatedText + newText)
                            
                            if result.speechRecognitionMetadata != nil {
                                self.accumulatedText += newText + " "
                            }
                            
                            if !self.isLanguageChecked && self.accumulatedText.split(separator: " ").count >= 3 {
                                if let detectedLang = self.detectLanguage(from: self.accumulatedText),
                                   let mappedLocale = Self.languageMapping[detectedLang],
                                   mappedLocale != self.currentLocaleIdentifier {
                                    
                                    self.isLanguageChecked = true
                                    logger.info("🌐 Detected language: \(detectedLang) → \(mappedLocale)")
                                    self.stopTranscribing()
                                    self.currentLocaleIdentifier = mappedLocale
                                    continuation.finish()
                                    return
                                }
                                self.isLanguageChecked = true
                            }
                            
                            if result.isFinal {
                                continuation.finish()
                                self.reset()
                            }
                        }
                    })
                    
                } catch {
                    continuation.finish(throwing: error)
                    self.reset()
                }
            }
        }
    }
    
    static let languageMapping: [String: String] = [
        "en": "en-US",
        "de": "de-DE",
        "es": "es-ES",
        "fr": "fr-FR",
        "it": "it-IT",
        // Add more as needed
    ]
    
    /// Stops the transcription process and releases associated resources.
    func stopTranscribing() {
        reset()
    }
    
    /// Resets and releases the resources used by the speech recognition service.
    func reset() {
        task?.cancel()
        task = nil
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        accumulatedText = ""
    }
    
    /// Prepares the audio engine and speech recognition request.
    /// - Returns: A tuple containing the configured `AVAudioEngine` and `SFSpeechAudioBufferRecognitionRequest`.
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.addsPunctuation = true
        request.taskHint = .dictation
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    func detectLanguage(from text: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        
        guard let language = recognizer.dominantLanguage else {
            return nil
        }
        
        return language.rawValue // e.g. "en", "de", "es"
    }
}
