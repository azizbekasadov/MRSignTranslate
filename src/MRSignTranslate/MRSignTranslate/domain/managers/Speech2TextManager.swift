//
//  Speech2TextManager.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Speech
import AVFoundation

protocol SpeechRecognitionService {
    var transcribedText: String { get }
    
    func requestPermission(
        permissionGranted: Bool?,
        completion: @escaping (Bool) -> Void
    )
    func startListening() throws
    func stopListening()
}

final class SpeechToTextService: NSObject, ObservableObject, SpeechRecognitionService {
    @Published private(set) var transcribedText: String = ""
    
    private let speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    override init() {
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en_US"))
        super.init()
        self.speechRecognizer?.delegate = self
    }
}

// MARK: - SpeechRecognitionService Implementation
extension SpeechToTextService {
    
    func requestPermission(
        permissionGranted: Bool? = nil,
        completion: @escaping (Bool) -> Void
    ) {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status == .authorized)
            }
        }
    }

    func startListening() throws {
        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
            print("Speech recognition permission not granted.")
            return
        }

        resetRecognition()

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let inputNode = audioEngine.inputNode
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true

        guard let recognitionRequest = recognitionRequest else { return }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                logger.info(.init(stringLiteral: result.bestTranscription.formattedString))
                
                DispatchQueue.main.async {
                    self.transcribedText = result.bestTranscription.formattedString
                }
            }
            
            if error != nil {
                self.stopListening()
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }

    func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionTask = nil
    }

    private func resetRecognition() {
        recognitionTask?.cancel()
        recognitionTask = nil
    }
}

// MARK: - SFSpeechRecognizerDelegate
extension SpeechToTextService: SFSpeechRecognizerDelegate { }
