//
//  Uncompress.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 05/05/21.
//

import Foundation

public final class Uncompress {
    
    // MARK: - Private Properties
    
    private let extractUseCase: ExtractUseCaseProtocol
    private let isProctedUseCase: IsProtectedUseCaseProtocol
    
    // MARK: - Public Methods
    
    public init(
        extractUseCase: ExtractUseCaseProtocol,
        isProctedUseCase: IsProtectedUseCaseProtocol
    ) {
        self.extractUseCase = extractUseCase
        self.isProctedUseCase = isProctedUseCase
    }
    
    public func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool = true,
        password: String? = nil
    ) throws {
        try extractUseCase.run(
            filePath,
            to: destination,
            overwrite: overwrite,
            password: password
        )
    }
    
    public func isProtected(_ filePath: String) throws -> Bool {
        return try isProctedUseCase.run(filePath)
    }
    
}
