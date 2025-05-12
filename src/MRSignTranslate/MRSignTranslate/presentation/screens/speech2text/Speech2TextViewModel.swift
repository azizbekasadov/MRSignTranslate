//
//  Speech2TextViewModel.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import Foundation
import SwiftUI
import Observation
import MRSignMTArchitecture

final class SpeechToTextViewModel: ObservableObject {
    @Published private(set) var transcribedText: String = "You will read captions here"
    
    private(set) var speechService: SpeechRecognitionService
    
    init(speechService: SpeechRecognitionService) {
        self.speechService = speechService
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        speechService.requestPermission(permissionGranted: nil) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func startListening() {
        do {
            try speechService.startListening()
        } catch {
            logger.error(.init(stringLiteral: "Failed to start listening: \(error)"))
        }
    }
    
    func stopListening() {
        speechService.stopListening()
    }
}
