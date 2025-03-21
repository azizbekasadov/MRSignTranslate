//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import Foundation
import SwiftUI
import AVKit
import RealityKit
import ARKit
import AVFoundation

struct VideoView: View {
    @State private var videoManager = VideoStateManager()

    var body: some View {
        VStack {
            if let videoURL = videoManager.videoURL {
                VideoPlayer(player: videoManager.videoPlayer)
                    .frame(height: 400)
                    .onAppear {
                        videoManager.videoPlayer.play()
                    }
            } else if videoManager.isCameraActive {
                CameraSimulationRealityView()
                    .frame(height: 400)
            } else {
                Text("No video source available")
                    .foregroundStyle(.red)
            }

            HStack {
                Button(videoManager.isCameraActive ? "Stop Camera Simulation" : "Start Camera Simulation") {
                    videoManager.isCameraActive ? videoManager.stopCamera() : videoManager.startCamera()
                }

                Button("Load Video") {
                    if let url = Bundle.main.url(forResource: "sample", withExtension: "mp4") {
                        videoManager.setVideo(url: url)
                    }
                }
            }
            .padding()
        }
    }
}

struct CameraSimulationRealityView: View {
    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity(world: [0, 0, -2]) // Place 2 meters in front
            let plane = ModelEntity(mesh: .generatePlane(width: 1.5, height: 1), materials: [UnlitMaterial(color: .gray)])

            anchor.addChild(plane)
            content.add(anchor)
        }
        .frame(height: 400)
    }
}
