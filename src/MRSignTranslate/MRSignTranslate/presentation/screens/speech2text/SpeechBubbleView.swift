//
//  SpeechBubbleView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 20.03.2025.
//

import SwiftUI
import RealityKit
import RealityKitContent
import MRSignMTKit
import Combine

struct SpeechBubbleView: View {
    @Bindable private var speechRecognizer = SpeechRecognitionManager.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        RealityView { content in
            let textEntity = createTextEntity(text: "")
            let anchor = AnchorEntity(world: [0, 0, -1]) // Default position
            anchor.addChild(textEntity)
            content.add(anchor)

            // Update text and position dynamically when someone speaks
            Task { @MainActor in
                textEntity.model = ModelComponent(
                    mesh: .generateText(speechRecognizer.recognizedText, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.06)),
                    materials: [SimpleMaterial(color: .white, isMetallic: false)]
                )
            }

            
//            Task { @MainActor in
//                if let position = newPosition {
//                    anchor.position = position // Update the position
//                    anchor.isEnabled = true
//                } else {
//                    anchor.isEnabled = false // Hide bubble when no speaker
//                }
//            }
        }
        .onAppear {
            speechRecognizer.startRecognition(for: .usLocale) { captions in
                debugPrint("captions:\(captions)")
            }
        }
    }

    /// 🔥 Creates a RealityKit 3D text entity
    private func createTextEntity(text: String) -> ModelEntity {
        return ModelEntity(
            mesh: .generateText(text, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.06)),
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
    }
}
