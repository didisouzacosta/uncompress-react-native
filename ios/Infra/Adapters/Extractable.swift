//
//  Extractable.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation

public protocol Extractable {

    var compatibilities: [Compatibility] { get }
    
    func extract(
        _ filePath: URL,
        to destination: URL,
        overwrite: Bool,
        password: String?
    ) throws
    
    func isProtected(_ filePath: URL) throws -> Bool
    
}
