//
//  PrivacyView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 28.03.2025.
//

import Foundation
import SwiftUI
import MRSignMTArchitecture

struct PrivacyScreen: View {
    @Environment(\.openWindow) private var openWindow
    
    @State private var speechPermission = true
    @State private var cameraPermission = true
    @State private var avatarRecording = false

    var body: some View {
        VStack(spacing: 32) {
            // Title + Subtitle
            VStack(
                alignment: .center,
                spacing: 8
            ) {
                Image("privacy")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.regularMaterial)
                    .frame(width: 45, height: 45)
                    .scaledToFit()
                
                Text("Privacy & Security")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)

                Text("Your data stays private. We only process it locally to help you communicate effectively in mixed reality environments.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            // Card Section
            VStack(spacing: 20) {
                PrivacyCard(
                    icon: "mic.fill",
                    title: "Speech Recognition",
                    description: "Audio input is processed on-device and not shared with any third parties.",
                    isEnabled: $speechPermission
                )

                PrivacyCard(
                    icon: "camera.fill",
                    title: "Camera Access",
                    description: "We use your camera to interpret sign language. Visual data is never stored.",
                    isEnabled: $cameraPermission
                )

                PrivacyCard(
                    icon: "person.crop.square.fill",
                    title: "Avatar Motion",
                    description: "Avatar gestures are generated in real-time. No motion data is retained.",
                    isEnabled: $avatarRecording
                )
            }
            
            Button {
                DispatchQueue.main.async {
                    SettingsConfigurationManager.shared.hasShownWelcomeMessage = true
                    openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
                }
            } label: {
                Text("Agree & Proceed")
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
            }

        }
        .padding(40)
        .frame(width: 750, height: 1000)
//        .frame(maxWidth: 700, maxHeight: 350)
        .glassBackgroundEffect(in: .rect(cornerRadius: 24))
        .padding()
        .onDisappear {
            openWindow.callAsFunction(id: MRSignTranslateApp.WindowGroupIdentifiers.main)
        }
    }
}

struct PrivacyCard: View {
    let icon: String
    let title: String
    let description: String
    @Binding var isEnabled: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Toggle("", isOn: $isEnabled)
                .toggleStyle(.switch)
                .labelsHidden()
                .tint(.accent)
                
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}


#Preview("PrivacyCard") {
    PrivacyCard(
        icon: "person.crop.square.fill",
        title: "Avatar Motion",
        description: "Avatar gestures are generated in real-time. No motion data is retained.",
        isEnabled: .constant(true)
    )
}

#Preview("PrivacyScreen") {
    PrivacyScreen()
}
