//
//  NavigationStackDestination.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation
import Observation

public protocol NavigationStackDestination: Equatable, Hashable, Codable, CustomStringConvertible {
    typealias Router = NavigationStackRouter<Self>
}

extension NavigationStackDestination {
    public var description: String {
       String(describing: self).components(separatedBy: "(").first ?? ""
    }
}

@Observable
public class NavigationStackRouter<T: NavigationStackDestination> {
    public var path = [T]()

    public init() {}

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
        logger.info(.init(stringLiteral: destination.description))
        
        guard let index = path.firstIndex(of: destination) else {
            let log = "\(self) did no find \(destination.description) in the view stack"
            logger.warning("\(log)")
            logPath(path)
//            assertionFailure(log)
            return
        }
        path.removeLast(path.count - (index + 1))
    }

    private func logPath(_ path: [T]) {
        let path = "\(path.map { $0.description }.joined(separator: ","))"
        
        logger.info("\(self )count: \(path.count), path: \(path)")
    }
}
