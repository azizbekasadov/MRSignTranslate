//
//  SwiftUIView.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 19.03.2025.
//

import SwiftUI
import Foundation
import CoreGraphics
import UIKit
import VideoToolbox

// MARK: - UIImage Extension (Convert to CGImage)
extension UIImage {
    func toCGImage() -> CGImage? {
        return self.cgImage
    }
}

// MARK: - CGImage Extension (Convert to Data)
extension CGImage {
    func toPixelData() -> Data? {
        guard let dataProvider = self.dataProvider else { return nil }
        return dataProvider.data as Data?
    }
}

// MARK: - CVPixelBuffer Extension (Convert to CGImage)
extension CVPixelBuffer {
    func toCGImage() -> CGImage? {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(self, options: nil, imageOut: &cgImage)
        return cgImage
    }
}

// MARK: - Async Image Processing Helper
struct ImageProcessor {
    static func transferableImage(
        _ pixelBuffer: CVPixelBuffer,
        completion: @escaping (CGImage?) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            let outputImage = pixelBuffer.toCGImage()
            DispatchQueue.main.async {
                completion(outputImage)
            }
        }
    }
    
    static func transferableImageData(_ input: Any, completion: @escaping (Data?) -> Void) {
        transferableImage(input as! CVPixelBuffer) { cgImage in
            guard let cgImage = cgImage else {
                completion(nil)
                return
            }
            completion(cgImage.toPixelData())
        }
    }
}
