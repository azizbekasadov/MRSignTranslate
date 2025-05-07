//
//  SkeletonView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 30.03.2025.
//

import Foundation
import SwiftUI
import MRSignMTArchitecture
import MRSignMTKit

struct SkeletonView: HidingWindowViewProtocol {
    @Bindable var viewModel = MRWebViewViewModel(
        textToInject: "Hello!",
        customJavaScript: SignMTInputText.textInjectMobile("Hello!").makeScript() //hideAllButSkeleton(input: "Hello!").makeScript()
    )
    
    @StateObject private var speechViewModel = Speech2ToTextViewModel()
    
    @Environment(\.openWindow) private var openWindow
    @Binding var showMainWindow: Bool
    @Binding var isVisible: Bool
    
    init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
        self._showMainWindow = .constant(true)
    }
    
    init(
        viewModel: MRWebViewViewModel = MRWebViewViewModel(
            textToInject: "Hello!",
            customJavaScript: SignMTInputText.textInjectMobile("Hello!").makeScript() //hideAllButSkeleton(input: "Hello!").makeScript()
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
        
        return MRWebViewFactory(
            type: .remote(url: signMTURL.url!),
            viewModel: viewModel
        )
        .make()
        .imageScale(.large)
        .frame(width: 550, height: 1000)
        .frame(depth: 5)
        .padding(.top, -60)
        .padding(.bottom, -200)
        .background(Color(hex: "#202124"))
        .onAppear {
            speechViewModel.startRecording()
        }
        .overlay {
            Color.clear.cornerRadius(16, corners: .allCorners)
        }
        .onDisappear {
            openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
        }
        .glassBackgroundEffect()
    }
}
