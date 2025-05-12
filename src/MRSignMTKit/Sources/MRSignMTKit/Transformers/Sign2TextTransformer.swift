//
//  Sign2TextTransformer.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation
import SwiftUI
import AVFoundation
import AVFAudio

public protocol Sign2TextTransformable: Transformable {}

public final class Sign2TextTransformer: Sign2TextTransformable {
    public func transform(_ input: any Encodable) async throws -> (any Decodable)? {
        return nil
    }
}
