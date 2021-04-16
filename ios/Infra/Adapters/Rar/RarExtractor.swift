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
    
    public var compatibilities: [Compatibility] {
        return [.rar, .cbr]
    }
    
    public init() {}
    
    public func extract(
        _ filePath: URL,
        to destination: URL,
        overwrite: Bool = true,
        password: String? = nil
    ) throws {
        let archive = try URKArchive(path: filePath.absoluteString)
        
        if let password = password {
            archive.password = password
        }
        
        try archive.extractFiles(to: destination.absoluteString, overwrite: overwrite)
    }
    
}
