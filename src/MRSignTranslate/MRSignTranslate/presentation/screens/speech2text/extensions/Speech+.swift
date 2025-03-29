//
//  Speech+.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 29.03.2025.
//

import AVFoundation
import Speech

extension SFSpeechRecognizer {
    /// Checks if the app has authorization to perform speech recognition.
    /// - Returns: `true` if authorized, `false` otherwise.
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    /// Checks if the app has permission to record audio.
    /// - Returns: `true` if permission is granted, `false` otherwise.
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            #if os(visionOS)
            AVAudioApplication.requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
            #else
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
            #endif
        }
    }
}
