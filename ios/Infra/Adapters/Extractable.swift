//
//  Extractable.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation

public protocol Extractable {

    var type: Type { get }
    
    func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String?,
        progressHandler: ((Double) -> Void)?
    ) throws
    
}

private extension Extractable {
    
    func destinationPath(
        filePath: String,
        destination: String
    ) -> String {
        let lastPath = (filePath as NSString).lastPathComponent
        let pathPieces = lastPath.split(separator: ".")
        
        return destination + pathPieces[0] + ".\(type.rawValue)"
    }
    
}
