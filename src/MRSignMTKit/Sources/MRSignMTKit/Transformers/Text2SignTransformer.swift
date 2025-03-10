//
//  Text2SignTransformer.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation
import SwiftUI
import AVFoundation
import AVFAudio

public protocol Text2SignTransformable: Transformable {}

public final class Text2SignTransformer: Text2SignTransformable {
    public func transform(_ input: any Encodable) async throws -> (any Decodable)? {
        return nil
    }
}
