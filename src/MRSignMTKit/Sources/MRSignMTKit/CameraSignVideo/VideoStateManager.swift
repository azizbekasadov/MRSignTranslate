//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import Foundation
import AVFoundation
import SwiftUI
import RealityKit
import os

// Aspect Ratios
enum AspectRatio: String {
    case ratio16_9 = "16-9"
    case ratio4_3 = "4-3"
    case ratio2_1 = "2-1"
    case ratio1_1 = "1-1"

    static func from(_ ratio: CGFloat) -> AspectRatio {
        return ratio > 1.9 ? .ratio2_1 : (ratio < 1.5 ? (ratio < 1.1 ? .ratio1_1 : .ratio4_3) : .ratio16_9)
    }
}

// Video Settings
struct VideoSettings {
    let aspectRatio: AspectRatio
    let frameRate: Int
    let width: Int
    let height: Int
}

@Observable
class VideoStateManager {
    var videoURL: URL?
    var isCameraActive = false
    var videoPlayer = AVPlayer()
    
    func startCamera() {
        DispatchQueue.main.async {
            self.isCameraActive = true
        }
    }
    
    func stopCamera() {
        DispatchQueue.main.async {
            self.isCameraActive = false
        }
    }
    
    func setVideo(url: URL) {
        DispatchQueue.main.async {
            self.videoURL = url
            self.videoPlayer = AVPlayer(url: url)
            self.isCameraActive = false
        }
    }
}
