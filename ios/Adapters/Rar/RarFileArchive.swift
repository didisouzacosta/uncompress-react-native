//
//  RarFileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation

public class RarFileArchive {}

extension RarFileArchive: FileArchive {
    
    public static var type: Type {
        return .rar
    }
    
    public static func compress(
        _ filePath: String,
        to destination: String,
        password: String?,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        
    }
    
    public static func decompress(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String?,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        
    }
    
}
