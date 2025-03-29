//
//  SpeechToTextViewModel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 29.03.2025.
//

import Foundation

import Foundation
import SwiftUI

final class Speech2ToTextViewModel: ObservableObject {
    @Published var transcript: String = "Here captions will be displayed"
    @Published var isRecording = false
    @Published var errorMessage: String?
    
    private let speechToTextService: Speech2ToTextService
    
    private var transcriptionTask: Task<Void, Never>?
    
    init(speechToTextService: Speech2ToTextService = .init()) {
        self.speechToTextService = speechToTextService
    }
    
    @MainActor
    func startRecording() {
        guard !isRecording else {
            return
        }
        
        isRecording = true
        
        transcriptionTask = Task {
            do {
                try await speechToTextService.authorize()
                
                let stream = speechToTextService.transcribe()
                for try await partialResult in stream {
                    self.transcript = partialResult
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func stopRecording() {
        guard isRecording else {
            return
        }
        isRecording = false
        transcriptionTask?.cancel()
        transcriptionTask = nil
        speechToTextService.stopTranscribing()
    }
}
