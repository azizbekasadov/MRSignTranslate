//
//  Speech2CaptionsView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 29.03.2025.
//

import SwiftUI
import MRSignMTArchitecture

struct Speech2CaptionsView: HidingWindowViewProtocol {
    
    @StateObject private var viewModel = Speech2ToTextViewModel()
    @Binding private var isVisible: Bool
    @Binding private var showMainWindow: Bool
    
    init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
        self._showMainWindow = .constant(true)
    }
    
    init(
        showMainWindow: Binding<Bool>,
        isVisible: Binding<Bool>
    ) {
        self._isVisible = isVisible
        self._showMainWindow = showMainWindow
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.transcript)
                .font(.system(size: 24, weight: .semibold))
                .lineLimit(nil)
                .truncationMode(.tail)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.ultraThickMaterial)
                .cornerRadius(12)
                .foregroundColor(.white)
                .transition(.opacity)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.bottom, 20)
        }
        .onAppear {
            toggleRecord()
        }
        .onDisappear {
            showMainWindow = true
        }
    }
    
    private func toggleRecord() {
        if viewModel.isRecording {
            viewModel.stopRecording()
        } else {
            viewModel.startRecording()
        }
    }
}

#Preview {
    Speech2CaptionsView(isVisible: .constant(true))
}
