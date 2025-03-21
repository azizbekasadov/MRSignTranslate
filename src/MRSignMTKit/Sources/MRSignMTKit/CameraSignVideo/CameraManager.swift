//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 17.03.2025.
//

import Foundation
import AVFoundation
import SwiftUI

#if os(visionOS)
import RealityKit
import ARKit
#endif


public protocol CameraManagerProtocol {
    
    func checkPermissions(completion: @escaping (Bool) -> Void)
    
    #if !os(visionOS)
    func startCameraPreview() -> AVCaptureVideoPreviewLayer
    #else
    associatedtype MRVisionOSCameraView = View
    
    func startCameraPreviewForVisionOS() -> MRVisionOSCameraView
    #endif
    
    func stopCamera()
}

public class CameraManager: CameraManagerProtocol {
    private let session = AVCaptureSession()
    
    public init() {}

    /// Requests camera permissions
    public func checkPermissions(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        default:
            completion(false)
        }
    }
    
    #if !os(visionOS)
    public func startCameraPreview() -> AVCaptureVideoPreviewLayer {
        let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        guard let cameraInput = try? AVCaptureDeviceInput(device: camera!) else {
            fatalError("No camera available")
        }
        
        session.addInput(cameraInput)
        session.startRunning()
        
        return AVCaptureVideoPreviewLayer(session: session)
    }
    #endif
    
    #if os(visionOS)
    @available(visionOS 1.0, *)
    public struct VisionOSCameraView: View {
        public init() {}

        public var body: some View {
            RealityView { content in
                let cameraEntity = PerspectiveCamera()
                content.add(cameraEntity)
            }
            .frame(width: 500, height: 500)
        }
    }
    
    public func startCameraPreviewForVisionOS() -> VisionOSCameraView {
        return VisionOSCameraView()
    }
    #endif

    
    /// Stops the camera session
    public func stopCamera() {
        session.stopRunning()
    }
}
