//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 17.03.2025.
//

import Foundation
import Speech
import XCTest

@testable import MRSignMTKit

internal final class MockSpeechRecognitionTask: SFSpeechRecognitionTask {
    var mockResult: SFSpeechRecognitionResult?
    var mockError: Error?
    var resultHandler: ((SFSpeechRecognitionResult?, Error?) -> Void)?

    override func finish() {
        resultHandler?(mockResult, mockError)
    }
}

internal final class MockSpeechRecognizer: SFSpeechRecognizer {
    var mockTask: MockSpeechRecognitionTask?
    var isAvailableOverride = true

    override var isAvailable: Bool {
        return isAvailableOverride
    }

    override func recognitionTask(with request: SFSpeechRecognitionRequest, resultHandler: @escaping (SFSpeechRecognitionResult?, Error?) -> Void) -> SFSpeechRecognitionTask {
        let task = MockSpeechRecognitionTask()
        task.resultHandler = resultHandler
        return task
    }
}

internal final class SpeechRecognitionManagerTests: XCTestCase {
    var speechManager: SpeechRecognitionManager!
    var mockSpeechRecognizer: MockSpeechRecognizer!
    
    override func setUp() {
        super.setUp()
        
        let usLanguage = MRLanguage.usLocale
        mockSpeechRecognizer = MockSpeechRecognizer(locale: usLanguage.locale)
        speechManager = SpeechRecognitionManager(language: usLanguage)
    }
    
    override func tearDown() {
        speechManager = nil
        mockSpeechRecognizer = nil
        super.tearDown()
    }
    
    func testRequestPermissions() async {
        let granted = await SpeechRecognitionManager.requestPermissions()
        XCTAssertTrue(granted, "Permissions should be granted")
    }
    
    /// Test starting speech recognition with a valid language
    func testStartRecognition_ValidLanguage() async throws {
        let language = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
        
        let stream = try await speechManager.startRecognition(for: language)
        XCTAssertNotNil(stream, "Recognition stream should not be nil")
    }
    
    /// Test stopping recognition
    func testStopRecognition() {
        speechManager.stopRecognition()
        XCTAssertNil(speechManager.recognitionTask, "Recognition task should be nil after stopping")
    }
    
    /// Test when speech recognizer is unavailable
    func testStartRecognition_RecognizerUnavailable() async {
        mockSpeechRecognizer.isAvailableOverride = false
        let language = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
        
        do {
            _ = try await speechManager.startRecognition(for: language)
            XCTFail("Should throw error when recognizer is unavailable")
        } catch {
            XCTAssertNotNil(error, "Error should be thrown")
        }
    }
    
    /// Test handling of an error during recognition
    func testRecognitionTask_ErrorHandling() async throws {
        let mockTask = MockSpeechRecognitionTask()
        mockTask.mockError = NSError(domain: "TestError", code: 123, userInfo: nil)
        mockSpeechRecognizer.mockTask = mockTask

        let language = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))

        do {
            _ = try await speechManager.startRecognition(for: language)
            XCTFail("Should throw an error on recognition failure")
        } catch {
            XCTAssertEqual((error as NSError).code, 123, "Error code should match expected")
        }
    }
    /// Test that recognized text is streamed
    func testRecognition_YieldsTranscriptions() async throws {
        let mockTask = MockSpeechRecognitionTask()
        let expectedText = "Hello world"
        let result = SFSpeechRecognitionResult()
        mockTask.mockResult = result
        mockSpeechRecognizer.mockTask = mockTask

        let language = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
        
        let stream = try await speechManager.startRecognition(for: language)
        var receivedText: String?
        
        for await text in stream {
            receivedText = text
            break
        }

        XCTAssertEqual(receivedText, expectedText, "Transcription should match expected")
    }
    
    /// Test performance of speech recognition start
    func testPerformance_StartRecognition() {
        measure {
            let language = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
            Task {
                _ = try await speechManager.startRecognition(for: language)
            }
        }
    }
    
    /// Test handling of invalid locale
    func testStartRecognition_InvalidLocale() async {
        let invalidLanguage = MRLanguage(iconName: "🚫", title: "Invalid", description: "Invalid Locale", locale: Locale(identifier: "invalid"))
        
        do {
            _ = try await speechManager.startRecognition(for: invalidLanguage)
            XCTFail("Should throw an error with invalid locale")
        } catch {
            XCTAssertNotNil(error, "Error should be thrown for invalid locale")
        }
    }
    
    /// Test switching between two languages
    func testSwitchingLanguages() async throws {
        let english = MRLanguage(iconName: "🇺🇸", title: "English", description: "United States", locale: Locale(identifier: "en_US"))
        let french = MRLanguage(iconName: "🇫🇷", title: "Français", description: "France", locale: Locale(identifier: "fr_FR"))
        
        _ = try await speechManager.startRecognition(for: english)
        speechManager.stopRecognition()
        
        _ = try await speechManager.startRecognition(for: french)
        XCTAssertNotNil(speechManager.recognitionTask, "Recognition should start for French")
    }
    
    /// Test that speech recognition works in multiple languages
    func testMultiLanguageRecognition() async throws {
        let languages = [
            MRLanguage(iconName: "🇪🇸", title: "Español", description: "España", locale: Locale(identifier: "es_ES")),
            MRLanguage(iconName: "🇩🇪", title: "Deutsch", description: "Deutschland", locale: Locale(identifier: "de_DE")),
            MRLanguage(iconName: "🇯🇵", title: "日本語", description: "日本", locale: Locale(identifier: "ja_JP"))
        ]
        
        for language in languages {
            let stream = try await speechManager.startRecognition(for: language)
            XCTAssertNotNil(stream, "Recognition should work for \(language.title)")
        }
    }
}
