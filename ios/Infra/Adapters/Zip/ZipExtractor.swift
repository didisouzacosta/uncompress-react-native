//
//  ZipExtractor.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import Zip

public final class ZipExtractor: Extractable {
    
    public var compatibilities: [Compatibility] {
        return [.zip, .cbz]
    }
    
    public init() {}
    
    public func extract(
        _ filePath: URL,
        to destination: URL,
        overwrite: Bool = false,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        try Zip.unzipFile(
            filePath,
            destination: destination,
            overwrite: overwrite,
            password: password,
            progress: progressHandler
        )
    }
    
}
