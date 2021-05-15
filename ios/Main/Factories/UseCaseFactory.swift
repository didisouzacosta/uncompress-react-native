//
//  UseCaseFactory.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

final class UseCaseFactory {
    
    private static let engines: [Extractable] = [
        ZipExtractor(),
        RarExtractor()
    ]
    
    static func extractUseCase() -> ExtractUseCase {
        return ExtractUseCase(engines: engines)
    }
    
    static func isProtectedUseCase() -> IsProctectedUseCase {
        return IsProctectedUseCase(engines: engines)
    }
    
}
