//
//  MockSpeechTranslator.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//
import XCTest
import Foundation
@testable import MRSignTranslate

final class MockSpeechRecognitionService: SpeechRecognitionService {
    var transcribedText: String = ""
    var permissionGranted = false
    var isListening = false
    var simulatedTranscription: String = "Hello, this is a test."

    func requestPermission(
        permissionGranted: Bool? = nil,
        completion: @escaping (Bool) -> Void
    ) {
        if let permissionGranted {
            self.permissionGranted = permissionGranted
        }
        
        DispatchQueue.main.async {
            completion(self.permissionGranted) // Now correctly simulates denial
        }
    }

    func startListening() throws {
        guard permissionGranted else {
            throw NSError(domain: "Permission not granted", code: 1, userInfo: nil)
        }
        isListening = true
        transcribedText = simulatedTranscription
    }

    func stopListening() {
        isListening = false
    }
}
