//
//  SpeechOverlayView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 18.03.2025.
//

import Foundation
import SwiftUI
import RealityKit
import MRSignMTKit

struct SpeechOverlayView: View {
    @State private var spokenText: String = ""
    @State private var speakerPosition: SIMD3<Float> = [0, 0, 0]

    private let speechManager = SpeechRecognitionManager()

    init() {
//        (speechManager.speechRecognition as? RealSpeechRecognitionManager)?.onSpeechDetected = { text, position in
//            self.spokenText = text
//            self.speakerPosition = position
//        }
    }
    
    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity(.head)
            content.add(anchor)
            
            DispatchQueue.main.async {
                let bubble = SpeechBubbleEntity(text: spokenText, position: speakerPosition)
                anchor.addChild(bubble)
            }
            
//            speechManager.startRecognition(
//                for: .usLocale,
//                completion: { captions in
//                    spokenText = captions
//                }
//            )
        }
    }
}


#Preview {
    SpeechOverlayView()
}
