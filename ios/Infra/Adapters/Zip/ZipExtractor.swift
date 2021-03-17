//
//  ZipExtractor.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import Zip

public final class ZipExtractor: Extractable {
    
    public var compatibility: Compatibility {
        return .zip
    }
    
    public init() {}
    
    public func extract(
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
