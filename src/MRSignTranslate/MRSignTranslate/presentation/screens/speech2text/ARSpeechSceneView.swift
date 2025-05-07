//
//  ARSpeechSceneView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 30.03.2025.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Combine

@MainActor
final class SpeechCaptionViewModel: ObservableObject {
    @Published var caption: String = ""
    
    private(set) var speechService = Speech2ToTextService(localeIdentifier: "en-US")

    func startListening() {
        Task {
            do {
                try await speechService.authorize()

                for try await chunk in speechService.transcribe() {
                    caption = chunk
                }
            } catch {
                caption = "Speech error: \\(error.localizedDescription)"
            }
        }
    }

    func stopListening() {
        speechService.stopTranscribing()
    }
}

struct MRBubbleImmersiveSceneView: View {
    @StateObject private var viewModel = Speech2ToTextViewModel()

    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        RealityView { (content, attachements) in
            let speaker = Entity()
            speaker.name = "speaker"
            speaker.position = SIMD3<Float>(0, 1.6, -1) // Position 1.6m high, 1m in front

            content.add(speaker)

        } attachments: {
            Attachment(id: "captions") {
                CaptionBubble(text: $viewModel.transcript)
            }
        }
        .onAppear {
            viewModel.startRecording()
        }
        .onDisappear {
            openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
        }
    }
}

struct CaptionBubble: View {
    @Binding var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .medium))
            .padding(12)
            .background(.ultraThickMaterial)
            .cornerRadius(12)
            .frame(maxWidth: 240)
            .multilineTextAlignment(.center)
    }
}

struct CaptionBillboard: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
            .padding(10)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(radius: 3)
            .lineLimit(2)
            .frame(maxWidth: 200)
    }
}
