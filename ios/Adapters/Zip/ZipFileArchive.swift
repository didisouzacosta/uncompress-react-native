//
//  ZipFileArchive.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import Zip

public final class ZipFileArquive {}

extension ZipFileArquive: FileArchive {
    
    public static var type: Type {
        return .zip
    }
    
    public static func compress(
        _ filePath: String,
        to destination: String,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        let destination = destinationPath(
            filePath: filePath,
            destination: destination
        )
        
        try Zip.zipFiles(
            paths: [
                URL(string: filePath)!
            ],
            zipFilePath: URL(string: destination)!,
            password: password,
            compression: .BestCompression,
            progress: progressHandler
        )
    }
    
    public static func decompress(
        _ filePath: String,
        to destination: String,
        overwrite: Bool = false,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        try Zip.unzipFile(
            URL(string: filePath)!,
            destination: URL(string: destination)!,
            overwrite: overwrite,
            password: password,
            progress: progressHandler
        )
    }
    
}
