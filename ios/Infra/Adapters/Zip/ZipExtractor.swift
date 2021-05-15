//
//  ZipExtractor.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import SSZipArchive

public final class ZipExtractor: Extractable {
    
    public var compatibilities: [Compatibility] {
        return [.zip, .cbz]
    }
    
    public init() {}
    
    public func extract(
        _ filePath: URL,
        to destination: URL,
        overwrite: Bool = false,
        password: String? = nil
    ) throws {
        var error: NSError?
        
        let status = SSZipArchive.unzipFile(
            atPath: filePath.path,
            toDestination: destination.absoluteString,
            preserveAttributes: true,
            overwrite: overwrite,
            password: password,
            error: &error,
            delegate: nil
        )
        
        if let error = error {
            throw error
        }
        
        if !status {
            throw "Unable to extract file \(filePath.absoluteString)"
        }
    }
    
    public func isProtected(_ filePath: URL) throws -> Bool {
        return SSZipArchive.isFilePasswordProtected(atPath: filePath.path)
    }
    
}
