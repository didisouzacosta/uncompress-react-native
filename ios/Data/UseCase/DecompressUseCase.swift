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
    
    var compatibilities: [Compatibility] {
        return engines.flatMap { $0.compatibilities }
    }
    
    private func engine(at compatibility: Compatibility) -> Extractable? {
        return engines.first { (engine) -> Bool in
            return engine.compatibilities.contains(compatibility)
        }
    }
}

public extension DecompressUseCaseProtocol {
    
    func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String? = nil,
        progressHandler: ((Double) -> Void)? = nil
    ) throws {
        guard let filePathUrl = URL(string: filePath) else {
            throw "O caminho do arquivo é inválido"
        }
        
        guard let destinationUrl = URL(string: destination) else {
            throw "O destino da descompressão é inválido"
        }
        
        guard let type = Compatibility(rawValue: filePathUrl.pathExtension),
              let engine = engine(at: type) else {
            throw "Atualmente a lib não oferece recursos de descompressão para a extensão \(filePathUrl.pathExtension)"
        }
        
        try engine.extract(
            filePathUrl,
            to: destinationUrl,
            overwrite: overwrite,
            password: password,
            progressHandler: progressHandler
        )
    }
    
}

public final class DecompressUseCase: DecompressUseCaseProtocol {
    
    // MARK: - Public Properties
    
    private(set) public var engines: [Extractable]
    
    // MARK: - Public Methods
    
    public init(engines: [Extractable]) {
        self.engines = engines
    }
    
}
