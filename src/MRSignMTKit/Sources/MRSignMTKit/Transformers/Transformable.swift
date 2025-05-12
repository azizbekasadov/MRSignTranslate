//
//  Transformable.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation

public protocol Transformable {
    associatedtype Input = Encodable
    associatedtype Output = Decodable
    
    func transform(_ input: Input) async throws -> Output?
}
