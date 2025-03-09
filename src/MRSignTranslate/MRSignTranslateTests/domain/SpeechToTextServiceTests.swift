//
//  SpeechToTextServiceTests.swift
//  MRSignTranslateTests
//
//  Created by Azizbek Asadov on 09.03.2025.
//

import XCTest

@testable import MRSignTranslate

final class SpeechToTextServiceTests: XCTestCase {
    
    var mockService: MockSpeechRecognitionService!

    override func setUp() {
        super.setUp()
        mockService = MockSpeechRecognitionService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    // MARK: - Test Speech Permission Request
    func testSpeechPermissionRequest() {
        let expectation = self.expectation(description: "Permission request should complete")

        mockService.requestPermission(permissionGranted: true) { granted in
            XCTAssertTrue(granted, "Speech permission should be granted")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // MARK: - Test Start Listening with Permission
    func testStartListeningWithPermission() {
        mockService.permissionGranted = true  // Simulate permission granted
        
        XCTAssertNoThrow(try mockService.startListening(), "Start listening should not throw when permission is granted")
        XCTAssertTrue(mockService.isListening, "Service should be in listening state")
        XCTAssertEqual(mockService.transcribedText, "Hello, this is a test.", "Transcribed text should be updated")
    }

    // MARK: - Test Start Listening Without Permission
    func testStartListeningWithoutPermission() {
        mockService.permissionGranted = false  // Simulate no permission
        
        XCTAssertThrowsError(try mockService.startListening(), "Start listening should throw when permission is denied")
        XCTAssertFalse(mockService.isListening, "Service should not be in listening state")
    }

    // MARK: - Test Stop Listening
    func testStopListening() {
        mockService.isListening = true  // Simulate active listening
        
        mockService.stopListening()
        
        XCTAssertFalse(mockService.isListening, "Service should not be in listening state after stopping")
    }

    // MARK: - Test Transcribed Text Updates
    func testTranscribedTextUpdate() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        
        XCTAssertEqual(mockService.transcribedText, "Hello, this is a test.", "Transcribed text should match simulated text")
    }
    
    func testMultipleStartCalls() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        try? mockService.startListening() // Second call

        XCTAssertTrue(mockService.isListening, "Service should still be listening after multiple start calls")
    }

    // MARK: - TEST: Stop Without Starting
    func testStopWithoutStarting() {
        mockService.stopListening()

        XCTAssertFalse(mockService.isListening, "Service should remain stopped when calling stop before start")
    }

    // MARK: - TEST: Start After Stop
    func testStartAfterStop() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        mockService.stopListening()
        try? mockService.startListening()

        XCTAssertTrue(mockService.isListening, "Service should restart after being stopped")
    }

    // MARK: - TEST: Simulated Background Interruption
    func testBackgroundInterruption() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        
        // Simulate a background audio interruption
        mockService.stopListening()

        XCTAssertFalse(mockService.isListening, "Service should stop listening when interrupted by background activity")
    }

    // MARK: - TEST: Rapid Start and Stop Calls
    func testRapidStartStopCalls() {
        mockService.permissionGranted = true

        for _ in 1...5 {
            try? mockService.startListening()
            mockService.stopListening()
        }

        XCTAssertFalse(mockService.isListening, "Service should not be listening after multiple rapid start/stop calls")
    }

    // MARK: - TEST: Microphone Permission Denied
    func testMicrophonePermissionDenied() {
        mockService.permissionGranted = false

        let expectation = expectation(description: "Permission denied case")
        
        mockService.requestPermission { granted in
            XCTAssertFalse(granted, "Microphone permission should be denied")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    // MARK: - TEST: Audio Engine Not Running When Stopped
    func testAudioEngineNotRunningAfterStop() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        mockService.stopListening()

        XCTAssertFalse(mockService.isListening, "Audio engine should not be running after stopping")
    }

    // MARK: - TEST: Handle Empty Transcription
    func testHandleEmptyTranscription() {
        mockService.permissionGranted = true
        mockService.simulatedTranscription = ""
        
        try? mockService.startListening()

        XCTAssertEqual(mockService.transcribedText, "", "Transcribed text should be empty if no words were detected")
    }

    // MARK: - TEST: Handle Long Speech Transcription
    func testHandleLongSpeechTranscription() {
        mockService.permissionGranted = true
        mockService.simulatedTranscription = "This is a long test sentence that should still be fully transcribed without truncation."

        try? mockService.startListening()

        XCTAssertEqual(mockService.transcribedText, "This is a long test sentence that should still be fully transcribed without truncation.",
                       "Long speech should be fully captured")
    }

    // MARK: - TEST: Stop Listening Clears Transcription
    func testStopListeningClearsTranscription() {
        mockService.permissionGranted = true
        mockService.simulatedTranscription = "Hello, world!"

        try? mockService.startListening()
        mockService.stopListening()
        XCTAssertNotEqual(mockService.transcribedText, "", "Transcription should not clear when stopping but should persist for review")
    }

    // MARK: - TEST: Multiple Permission Requests
    func testMultiplePermissionRequests() {
        for _ in 1...3 {
            mockService.requestPermission(permissionGranted: true) { _ in }
        }
        XCTAssertTrue(mockService.permissionGranted, "Permission should remain granted after multiple requests")
    }

    // MARK: - TEST: Restart Speech Recognition
    func testRestartSpeechRecognition() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        mockService.stopListening()
        try? mockService.startListening()
        
        XCTAssertTrue(mockService.isListening, "Speech recognition should be able to restart after stopping")
    }

    // MARK: - TEST: Handle Speech Interruptions
    func testHandleSpeechInterruption() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        
        // Simulate an interruption (like an incoming call)
        mockService.stopListening()
        
        XCTAssertFalse(mockService.isListening, "Service should stop after an interruption")
    }

    // MARK: - TEST: Handle Invalid Speech Recognition Request
    func testInvalidSpeechRecognitionRequest() {
        mockService.permissionGranted = false // No permission

        XCTAssertThrowsError(try mockService.startListening(), "Starting speech recognition without permission should throw an error")
    }

    // MARK: - TEST: Ensure Service Resets Properly
    func testServiceReset() {
        mockService.permissionGranted = true
        try? mockService.startListening()
        
        mockService.transcribedText = "Temporary text"
        mockService.stopListening()

        XCTAssertNotEqual(mockService.transcribedText, "", "Text should not be reset after stopping (should persist for review)")
    }
}
