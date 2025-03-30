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
    @StateObject private var viewModel = Speech2ToTextViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        #if targetEnvironment(simulator)
        VStack {
            Spacer()
            SpeechBubble(text: $viewModel.transcript)
                .onAppear {
                    viewModel.startRecording()
                }
                .padding(.bottom, 20)
        }
        #else
        RealityView { content in
            let textEntity = createTextEntity(text: viewModel.transcript)
            let anchor = AnchorEntity(world: [0, 0, -1]) // Default position
            anchor.addChild(textEntity)
            content.add(anchor)

            // Update text and position dynamically when someone speaks
            Task { @MainActor in
                textEntity.model = ModelComponent(
                    mesh: .generateText(viewModel.transcript, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.06)),
                    materials: [SimpleMaterial(color: .white, isMetallic: false)]
                )
            }
        }
        .onAppear {
            viewModel.startRecording()
        }
        #endif
    }

    private func createTextEntity(text: String) -> ModelEntity {
        return ModelEntity(
            mesh: .generateText(text, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.06)),
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
    }
}


struct SpeechBubbleWithSignMTView: View {
    @StateObject private var speechViewModel = Speech2ToTextViewModel()
    
    @Bindable var viewModel = MRWebViewViewModel(
        textToInject: "Start Speaking...",
        customJavaScript: SignMTInputText.zoom(3).makeScript() //hideAllButSkeleton(input: "Hello!").makeScript()
    )
    
    var body: some View {
        viewModel.textToInject = speechViewModel.transcript
        viewModel.customJavaScript = SignMTInputText.textInjectMobile(speechViewModel.transcript).makeScript()
        
        return HStack(spacing: 0) {
            MRWebViewFactory(
                type: .remote(url: signMTURL.url!),
                viewModel: viewModel
            )
            .zoomed(4)
            .make()
            .frame(width: 500, height: 700)
            .padding(.top, -60)
            .padding(.bottom, -120)
            .background(Color(hex: "#202124"))
            .cornerRadius(32, corners: .allCorners)
            
            Spacer()
                .frame(width: 200)
            
            SpeechBubble(
                text: $speechViewModel.transcript
            )
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                speechViewModel.startRecording()
            }
        }
    }
}
