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
import MRSignMTArchitecture
import Combine

struct SpeechBubbleView: HidingWindowViewProtocol {
    @StateObject private var viewModel = Speech2ToTextViewModel()
    @State private var viewType: MainContentViewType = .simpleBubble
    
    private var cancellables = Set<AnyCancellable>()

    @Environment(\.openWindow) private var openWindow
    
    @Binding var showMainWindow: Bool
    @Binding var isVisible: Bool
    
    init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
        self._showMainWindow = .constant(true)
    }
    
    init(
        showMainWindow: Binding<Bool>,
        isVisible: Binding<Bool>
    ) {
        self._showMainWindow = showMainWindow
        self._isVisible = isVisible
    }
    
    @ViewBuilder
    private func MRRealityBubleView() -> some View {
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
        .onDisappear {
            openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
        }
    }
    
    @ViewBuilder
    private func MainContentBubbleView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            SpeechBubble(text: $viewModel.transcript)
                .onAppear {
                    viewModel.startRecording()
                }
        }
    }
    
    enum MainContentViewType: Int {
        case simpleBubble
        case realityBubble
    }
    
    @ViewBuilder
    private func setupMainView() -> some View {
        switch viewType {
        case .realityBubble:
            MRRealityBubleView()
        case .simpleBubble:
            MainContentBubbleView()
        }
    }
    
    var body: some View {
        setupMainView()
    }

    private func createTextEntity(text: String) -> ModelEntity {
        return ModelEntity(
            mesh: .generateText(text, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.06)),
            materials: [SimpleMaterial(color: .white, isMetallic: false)]
        )
    }
}


struct SpeechBubbleWithSignMTView: HidingWindowViewProtocol {
    @StateObject private var speechViewModel = Speech2ToTextViewModel()
    
    @Bindable var viewModel = MRWebViewViewModel(
        textToInject: "Start Speaking...",
        customJavaScript: SignMTInputText.zoom(3).makeScript() //hideAllButSkeleton(input: "Hello!").makeScript()
    )
    @Binding var showMainWindow: Bool
    @Binding var isVisible: Bool
    @Environment(\.openWindow) private var openWindow
    
    init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
        self._showMainWindow = .constant(true)
    }
    
    init(
        viewModel: MRWebViewViewModel = MRWebViewViewModel(
            textToInject: "Start Speaking...",
            customJavaScript: SignMTInputText.zoom(3).makeScript() //hideAllButSkeleton(input: "Hello!").makeScript()
        ),
        showMainWindow: Binding<Bool>,
        isVisible: Binding<Bool>
    ) {
        self.viewModel = viewModel
        self._showMainWindow = showMainWindow
        self._isVisible = isVisible
    }
    
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
            .frame(width: 550, height: 1000)
            .padding(.top, -100)
            .padding(.bottom, -200)
            .background(Color(hex: "#202124"))
            .cornerRadius(32, corners: .allCorners)
            .glassBackgroundEffect()
            
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
        .frame(depth: 1.2)
        .onDisappear {
            openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
        }
        
    }
}
