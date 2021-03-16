//
//  Compress.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation

public protocol Compress {
    
    static var type: Type { get }
    
    static func compress(
        _ filePath: String,
        to destination: String,
        password: String?,
        progressHandler: ((Double) -> Void)?
    ) throws
    
}

extension Compress {
    
    static func destinationPath(
        filePath: String,
        destination: String
    ) -> String {
        let lastPath = (filePath as NSString).lastPathComponent
        let pathPieces = lastPath.split(separator: ".")
        
        return destination + pathPieces[0] + ".\(type.rawValue)"
    }
    
}
