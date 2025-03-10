//
//  Synthesizer.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 10.03.2025.
//

import Foundation

public protocol Synthesizable: AnyObject {
    associatedtype Input = Encodable
    associatedtype Output = Decodable
    
    func synthesize(_ input: Input) async throws -> Output
}
