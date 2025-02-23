//
//  InjectionError.swift
//  MRSignMTArchitecture
//
//  Created by Azizbek Asadov on 23.02.2025.
//

import Foundation

public enum InjectionError: Error {
    case unregisteredType(String)
    case invalidDependencyType(String)
}
