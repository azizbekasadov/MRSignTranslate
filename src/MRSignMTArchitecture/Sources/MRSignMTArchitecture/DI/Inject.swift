//
//  Inject.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

@propertyWrapper
public struct Inject<Component: Sendable> {
    
    private var component: Component
    
    public init(_ dependencyType: InjectionType = .new) {
        self.component = InjectionContainer.resolve(
            dependencyType: dependencyType,
            Component.self
        )
    }
    
    public var wrappedValue: Component {
        get { component }
        mutating set { component = newValue }
    }
}
