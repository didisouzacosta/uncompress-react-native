//
//  DecompressUseCase.swift
//  DoubleConversion
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

public protocol DecompressUseCaseProtocol {
    var engines: [Extractable] { get }
}

public extension DecompressUseCaseProtocol {
    
    var Compatibilities: [Compatibility] {
        return engines.map { $0.compatibility }
    }
    
    func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        guard let fileExtension = filePath.fileExtension else {
            throw "Não foi possível determinar a extensão do arquivo"
        }
        
        guard let type = Compatibility.init(rawValue: fileExtension),
              let engine = engine(at: type) else {
            throw "Atualmente a lib não oferece recursos de descompressão para a extensão \(fileExtension)"
        }
        
        try engine.extract(
            filePath,
            to: destination,
            overwrite: overwrite,
            password: password,
            progressHandler: progressHandler
        )
    }
    
    private func engine(at compatibility: Compatibility) -> Extractable? {
        return engines.first { $0.compatibility == compatibility }
    }
    
}

final class DecompressUseCase {
    
    // MARK: - Private Properties
    
    private let _engines: [Extractable]
    
    // MARK: - Public Methods
    
    public init(engines: [Extractable]) {
        self._engines = engines
    }
    
}

extension DecompressUseCase: DecompressUseCaseProtocol {
    
    var engines: [Extractable] {
        return _engines
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

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }
    
}
