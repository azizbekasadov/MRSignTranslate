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

struct SkeletonView: View {
    @Bindable var viewModel = MRWebViewViewModel(
        textToInject: "Hello!",
        customJavaScript: SignMTInputText.textInjectMobile("Hello!").makeScript() //hideAllButSkeleton(input: "Hello!").makeScript()
    )
    
    @StateObject private var speechViewModel = Speech2ToTextViewModel()
    
    var body: some View {
        viewModel.textToInject = speechViewModel.transcript
        viewModel.customJavaScript = SignMTInputText.textInjectMobile(speechViewModel.transcript).makeScript()
        
        return MRWebViewFactory(
            type: .remote(url: signMTURL.url!),
            viewModel: viewModel
        )
        .make()
        .imageScale(.large)
//        .frame(width: 1000, height: 1400)
        .frame(width: 500, height: 700)
        .frame(depth: 5)
        .padding(.top, -60)
        .padding(.bottom, -120)
        .background(Color(hex: "#202124"))
        .glassBackgroundEffect()
        .onAppear {
            speechViewModel.startRecording()
        }
        .overlay {
            Color.clear.cornerRadius(16, corners: .allCorners)
        }
    }
}
