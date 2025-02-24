//
//  InjectionContainer.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Observation
import Foundation

import Foundation

public final class InjectionContainer: @unchecked Sendable {
    // Use a private serial queue for thread safety
    private static let syncQueue = DispatchQueue(label: "com.injectioncontainer.sync")
    
    package static var cache: [String: Any] = [:]
    package static var generators: [String: () -> Any] = [:]
    
    public static func register<Component>(
        type: Component.Type,
        as injectionType: InjectionType = .automatic,
        _ factory: @autoclosure @escaping () -> Component
    ) {
        let key = String(reflecting: type)
        
        // Synchronize access to static properties
        syncQueue.sync {
            generators[key] = factory
            
            if injectionType == .singleton {
                cache[key] = factory()
            }
        }
    }
    
    public static func resolve<Component>(
        dependencyType: InjectionType = .automatic,
        _ type: Component.Type
    ) -> Component {
        let key = String(reflecting: type)
        
        // Synchronize access to static properties
        return syncQueue.sync {
            switch dependencyType {
            case .singleton:
                if let cachedService = cache[key] as? Component {
                    return cachedService
                }
                preconditionFailure("\(key) is not registered as singleton")
                
            case .automatic:
                if let cachedService = cache[key] as? Component {
                    return cachedService
                }
                fallthrough
            case .new:
                guard let component = generators[key]?() as? Component else {
                    preconditionFailure("\(key) is not registered as newInstance")
                }
                cache[key] = component
                return component
            }
        }
    }
}
