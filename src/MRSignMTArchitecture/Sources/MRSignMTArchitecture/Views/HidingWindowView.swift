//
//  File.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 31.03.2025.
//

import Foundation

#if canImport(SwiftUI)
import SwiftUI

public protocol HidingWindowViewProtocol: View {
    init(isVisible: Binding<Bool>)
}


#endif
