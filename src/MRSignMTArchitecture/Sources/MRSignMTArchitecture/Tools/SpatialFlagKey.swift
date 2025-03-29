//
//  SpatialFlagKey.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import SwiftUI

public struct SpatialFlagKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

extension EnvironmentValues {
    public var isSpatial: Bool {
        get { self[SpatialFlagKey.self] }
        set { self[SpatialFlagKey.self] = newValue }
    }
}
