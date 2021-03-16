//
//  Decompress.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation

public protocol Decompress {

    static func decompress(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String?,
        progressHandler: ((Double) -> Void)?
    ) throws
    
}
