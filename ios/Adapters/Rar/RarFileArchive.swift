//
//  RarFileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation

public class RarFileArchive {
    
    // MARK: - Public Methods
    
    public init() {}
    
}

extension RarFileArchive: FileArchive {
    
    public var type: Type {
        .rar
    }
    
    public func compress(
        _ filePath: String,
        to destination: String,
        password: String?
    ) throws {
        
    }
    
    public func decompress(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String?
    ) throws {
        
    }
    
    public func isFilePasswordProtected(_ filePath: String) -> Bool {
        return false
    }
    
}
