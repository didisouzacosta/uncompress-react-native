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

extension Compress {
    
    func destinationPath(filePath: String, destination: String) -> String {
        let lastPath = (filePath as NSString).lastPathComponent
        let pathPieces = lastPath.split(separator: ".")
        
        return destination + pathPieces[0] + ".\(type.rawValue)"
    }
    
}
