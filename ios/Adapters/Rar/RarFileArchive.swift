//
//  RarFileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation
import UnrarKit

public final class RarFileArchive: FileArchive {
    
    public static var type: Type {
        return .rar
    }
    
    public static func compress(
        _ filePath: String,
        to destination: String,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        
    }
    
    public static func decompress(
        _ filePath: String,
        to destination: String,
        overwrite: Bool = true,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        
    }
    
}
