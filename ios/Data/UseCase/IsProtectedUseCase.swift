//
//  IsProtectedUseCase.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 26/04/21.
//

import Foundation

public protocol IsProtectedUseCaseProtocol {
    var engines: [Extractable] { get }
}

public extension IsProtectedUseCaseProtocol {
    
    func run(_ filePath: String) throws -> Bool {
        guard let filePathUrl = URL(string: filePath) else {
            throw "The file path is invalid"
        }

        let engine = try engines.selectAt(filePathUrl.pathExtension)
        
        return try engine.isProtected(filePathUrl)
    }
    
}

public final class IsProctectedUseCase: IsProtectedUseCaseProtocol {
    
    // MARK: - Public Properties

    private(set) public var engines: [Extractable]

    // MARK: - Public Methods

    public init(engines: [Extractable]) {
        self.engines = engines
    }
    
}
