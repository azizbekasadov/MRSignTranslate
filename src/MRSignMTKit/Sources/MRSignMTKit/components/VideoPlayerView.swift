//
//  SwiftUIView.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @StateObject private var viewModel = VideoPlayerViewModel()
    
    var body: some View {
        ZStack {
            if let player = viewModel.player {
                VideoPlayer(player: player)
                    .onAppear { viewModel.playVideo() }
                    .onDisappear { viewModel.pauseVideo() }
            } else {
                Text("Loading video...")
                    .padding()
            }

            if viewModel.videoEnded {
                Button(action: {
                    viewModel.replayVideo()
                }) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VideoControlsView(isVideoEnabled: $viewModel.isVideoEnabled)
                        .padding()
                }
            }
        }
    }
}

struct VideoControlsView: View {
    @Binding var isVideoEnabled: Bool
    
    var body: some View {
        Button(action: {
            isVideoEnabled.toggle()
        }) {
            Image(systemName: isVideoEnabled ? "video.fill" : "video.slash.fill")
                .font(.system(size: 40))
                .foregroundColor(isVideoEnabled ? .blue : .red)
                .padding()
                .background(Circle().fill(Color.white).shadow(radius: 5))
        }
        .accessibilityLabel(isVideoEnabled ? "Disable Video" : "Enable Video")
    }
}

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var videoEnded = false
    @Published var isVideoEnabled = true

    init() {
        if let url = Bundle.main.url(forResource: "sample", withExtension: "mp4") {
            player = AVPlayer(url: url)
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player?.currentItem,
                queue: .main
            ) { _ in
                self.videoEnded = true
            }
        }
    }

    func playVideo() {
        videoEnded = false
        player?.seek(to: .zero)
        player?.play()
    }

    func pauseVideo() {
        player?.pause()
    }

    func replayVideo() {
        videoEnded = false
        player?.seek(to: .zero)
        player?.play()
    }
}

#Preview(body: {
    VideoPlayerView()
})
