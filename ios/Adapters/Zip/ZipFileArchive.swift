//
//  ZipFileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import SSZipArchive

public final class ZipFileArquive {
    
    // MARK: - Public Methods
    
    public init() {}
    
}

extension ZipFileArquive: FileArchive {
    
    public var type: Type {
        return .zip
    }
    
    public func compress(
        _ filePath: String,
        to destination: String,
        password: String? = nil
    ) throws {
        let destination = destinationPath(
            filePath: filePath,
            destination: destination
        )
        
        SSZipArchive.createZipFile(
            atPath: destination,
            withFilesAtPaths: [
                filePath
            ],
            withPassword: password
        )
    }
    
    public func decompress(
        _ filePath: String,
        to destination: String,
        overwrite: Bool = false,
        password: String? = nil
    ) throws {
        try SSZipArchive.unzipFile(
            atPath: filePath,
            toDestination: destination,
            overwrite: overwrite,
            password: password
        )
    }
    
    public func isFilePasswordProtected(_ filePath: String) -> Bool {
        return SSZipArchive.isFilePasswordProtected(atPath: filePath)
    }
    
}
