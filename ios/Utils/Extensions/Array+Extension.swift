//
//  Array+Extension.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 26/04/21.
//

import Foundation

extension Array where Element == Extractable {
    
    func selectAt(_ fileExtension: String) throws -> Extractable {
        if let compatibility = Compatibility(rawValue: fileExtension.lowercased()),
           let engine = self.first(where: { (engine) -> Bool in
            return engine.compatibilities.contains(compatibility)
        }) {
            return engine
        }

        throw "Does not have a \(fileExtension) extension engine"
    }
    
}
