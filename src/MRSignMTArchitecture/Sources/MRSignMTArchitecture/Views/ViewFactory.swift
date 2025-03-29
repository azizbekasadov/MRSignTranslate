//
//  ViewFactory.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation
import SwiftUI

public protocol ViewFactory {
    @ViewBuilder
    @MainActor @preconcurrency
    func make() -> AnyView
}
