//
//  ZipFileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import SSZipArchive

public final class ZipFileArquive: FileArchive {
    
    public var type: Type {
        return .zip
    }
    
    public func compress(
        _ filePath: URL,
        to destination: URL,
        password: String?
    ) throws {
        SSZipArchive.createZipFile(
            atPath: destination.absoluteString,
            withFilesAtPaths: [
                filePath.absoluteString
            ],
            withPassword: password
        )
    }
    
    public func decompress(
        _ filePath: URL,
        to destination: URL,
        overwrite: Bool,
        password: String?
    ) throws {
        try SSZipArchive.unzipFile(
            atPath: filePath.absoluteURL.absoluteString,
            toDestination: destination.absoluteURL.absoluteString,
            overwrite: overwrite,
            password: password
        )
    }
    
    public func isFilePasswordProtected(_ filePath: URL) -> Bool {
        return SSZipArchive.isFilePasswordProtected(
            atPath: filePath.absoluteString
        )
    }
    
}
