//
//  Uncompress.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

public protocol Uncompress {
    var engines: [Extractable] { get }
}

extension Uncompress {
    
    var types: [Type] {
        return engines.map { $0.type }
    }
    
    func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String?,
        progressHandler: ((Double) -> Void)?
    ) throws {
        guard let fileExtension = filePath.fileExtension,
              let type = Type.init(rawValue: fileExtension),
              let engine = engine(at: type) else {
            return
        }
        
        try engine.extract(
            filePath,
            to: destination,
            overwrite: overwrite,
            password: password,
            progressHandler: progressHandler
        )
    }
    
    private func engine(at type: Type) -> Extractable? {
        return engines.first { $0.type == type }
    }
    
}

fileprivate extension String {
    
    var fileExtension: String? {
        let lastPath = (self as NSString).lastPathComponent
        
        guard let fileExtension = lastPath.split(separator: ".").last else {
            return nil
        }
        
        return String(fileExtension)
    }
    
}
