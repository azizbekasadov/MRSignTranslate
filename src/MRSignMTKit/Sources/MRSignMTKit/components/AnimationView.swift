//
//  SwiftUIView.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI
import RealityKit
import ARKit

struct AnimationView: View {
    @State private var modelEntity: ModelEntity?
    @State private var isModelLoaded = false

    var body: some View {
        ZStack {
            RealityView { content in
                let anchor = AnchorEntity(world: [0, 0, 0])

                if let model = modelEntity {
                    modelEntity = model
                    anchor.addChild(model)
                }
                
                content.add(anchor)
            }
            .frame(width: 600, height: 400)
            .background(.black)
            
            if !isModelLoaded {
                ProgressView("Loading 3D Avatar...") // Show loading indicator
            }
        }
        .onAppear {
            load3DModel()
        }
    }

    private func load3DModel() {
        Task {
            do {
                
                let entity = try await ModelEntity(named: "SignLanguageAvatar.usdz")
                entity.setPosition(SIMD3<Float>(0, 2.8, 0), relativeTo: nil) // Equivalent to camera target
                modelEntity = entity
                isModelLoaded = true
            } catch {
                print("Failed to load model: \(error)")
            }
        }
    }
}
