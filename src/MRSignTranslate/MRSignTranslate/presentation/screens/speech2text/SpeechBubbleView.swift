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
        }
        .onAppear {
            speechRecognizer.startRecognition(for: .usLocale) { captions in
                debugPrint("captions:\(captions)")
            }
        }
    }

    private func createTextEntity(text: String) -> ModelEntity {
        return ModelEntity(
            mesh: .generateText(text, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.06)),
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
    }
}


struct SpeechBubbleWithSignMTView: View {
    @Bindable var viewModel = MRWebViewViewModel(
        textToInject: "Hello!",
        customJavaScript: SignMTInputText.textInjectMobile("Hello!").makeScript()
    )
    
    var body: some View {
        HStack(spacing: 0) {
            MRWebViewFactory(
                type: .remote(url: signMTURL.url!),
                viewModel: viewModel
            )
            .make()
            .frame(width: 500, height: 700)
            .padding(.top, -55)
            .padding(.bottom, -90)
            .background(Color(hex: "#202124"))
            .cornerRadius(32, corners: .allCorners)
            
            Spacer()
                .frame(depth: 0.8)
                .frame(width: 20)
                
            
            SpeechBubble(
                text: $viewModel.textToInject
            )
        }
        .onAppear {
            withAnimation {
                let newSpeechText = "Recognized speech: Hello, world!Recognized speech: Hello, world!Recognized speech: Hello, world!Recognized speech: Hello, world!Recognized speech: Hello, world!Recognized speech: Hello, world!Recognized speech: Hello, world!Recognized speech: Hello, world!"
                
                viewModel.textToInject = newSpeechText
                viewModel.customJavaScript = SignMTInputText.textInjectMobile(newSpeechText).makeScript()
            }
        }
    }
}
