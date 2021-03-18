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
        _ filePath: String,
        to destination: String,
        overwrite: Bool = false,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        guard let filePathUrl = URL(string: filePath) else {
            throw "O caminho do arquivo não e válido"
        }
        
        guard let destinationUrl = URL(string: destination) else {
            throw "O destino da descompressão não e válido"
        }
        
        try Zip.unzipFile(
            filePathUrl,
            destination: destinationUrl,
            overwrite: overwrite,
            password: password,
            progress: progressHandler
        )
    }
    
}
