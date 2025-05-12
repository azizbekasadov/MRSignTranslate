//
//  SpeechBubbleEntity.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 18.03.2025.
//

import Foundation
import RealityKit
import SwiftUI

final class SpeechBubbleEntity: Entity, HasModel, HasAnchoring {
    required init(text: String, position: SIMD3<Float>) {
        super.init()
        
        let textMesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.01,
            font: .systemFont(ofSize: 0.08)
        )
        
        let material = SimpleMaterial(color: .white, isMetallic: false)
        let model = ModelEntity(mesh: textMesh, materials: [material])
        
        self.position = position
        self.addChild(model)
        
        self.anchoring = AnchoringComponent(.head)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
