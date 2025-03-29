//
//  NavigationStackDestination.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import Observation
import SwiftUI

public protocol NavigationStackDestination: Equatable, Hashable, Codable {//, CustomStringConvertible {
    typealias Router = NavigationStackRouter<Self>
}

extension NavigationStackDestination {
    public var commonString: String {
       String(describing: self).components(separatedBy: "(").first ?? ""
    }
}

public protocol WindowType {
    func getProviderID() -> String
}

public class NavigationStackRouter<T: NavigationStackDestination>: ObservableObject {
    @Published public var path = [T]()
    @Environment(\.openWindow) public var openWindow

    public init() {}
    
    public func setRoot(_ destination: T) {
        logger.info("\(destination) will be a new root")
        path.removeLast(path.count)
        pushDestination(destination)
    }

    public func open(_ windowType: WindowType) {
        openWindow.callAsFunction(id: windowType.getProviderID())
    }
    
    public func popToRoot() {
        logger.info("\(self) will pop to root")
        
        path.removeLast(path.count)
    }

    public func pushDestination(_ destination: T) {
        logger.info("\(self) will go to screen: \(destination)")
        
        path.append(destination)
    }

    public func goBack() {
        logger.info("will go to back")
        
        if path.isEmpty {
            let log = "Unable to go back on an empty path -> did some path elements get lost?"
            logger.warning("\(log)")
            logPath(path)
            
            assertionFailure(log)
            return
        }
        
        path.removeLast()
    }

    public func goBack(to destination: T) {
        logger.info(.init(stringLiteral: destination.commonString))
        
        guard let index = path.firstIndex(of: destination) else {
            let log = "\(self) did no find \(destination.commonString) in the view stack"
            logger.warning("\(log)")
            logPath(path)
//            assertionFailure(log)
            return
        }
        path.removeLast(path.count - (index + 1))
    }

    private func logPath(_ path: [T]) {
        let path = "\(path.map { $0.commonString }.joined(separator: ","))"
        
        logger.info("\(self )count: \(path.count), path: \(path)")
    }
}
