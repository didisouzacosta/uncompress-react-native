//
//  RarExtractor.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation
import UIKit
import UnrarKit

public final class RarExtractor: Extractable {
    
    public var type: Type {
        return .rar
    }
    
    public init() {}
    
    public func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool = true,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        let archive = try URKArchive(path: filePath)
        
        if let password = password {
            archive.password = password
        }
        
        try archive.extractFiles(to: destination, overwrite: overwrite)
        
        progressHandler?(1)
    }
    
}
