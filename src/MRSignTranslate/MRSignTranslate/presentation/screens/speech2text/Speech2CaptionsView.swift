//
//  Speech2CaptionsView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 29.03.2025.
//

import SwiftUI

struct Speech2CaptionsView: View {
    @StateObject private var viewModel = Speech2ToTextViewModel()
    
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
    Speech2CaptionsView()
}
