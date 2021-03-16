//
//  FileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation

public protocol FileArchive: Compress & Decompress {
    
    static var type: Type { get }
    
}

extension FileArchive {
    
    static func destinationPath(
        filePath: String,
        destination: String
    ) -> String {
        let lastPath = (filePath as NSString).lastPathComponent
        let pathPieces = lastPath.split(separator: ".")
        
        return destination + pathPieces[0] + ".\(type.rawValue)"
    }
    
}
