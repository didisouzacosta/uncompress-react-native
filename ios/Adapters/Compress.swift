//
//  Compress.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation

public protocol Compress {
    
    var type: Type { get }
    
    func compress(
        _ filePath: String,
        to destination: String,
        password: String?
    ) throws
    
}
