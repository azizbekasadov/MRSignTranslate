//
//  SpeechRecognizerProtocol.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 29.03.2025.
//
//
import Foundation

protocol SpeechToTextServiceProtocol {
    func authorize() async throws
    func transcribe() -> AsyncThrowingStream<String, Error>
    func stopTranscribing()
}
