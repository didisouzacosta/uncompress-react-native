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
        return destination + lastPath
    }
    
}
