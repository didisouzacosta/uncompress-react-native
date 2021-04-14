//
//  UseCaseFactory.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

final class UseCaseFactory {
    
    static func extractUseCase() -> ExtractUseCase {
        return ExtractUseCase(engines: [
            ZipExtractor(),
            RarExtractor()
        ])
    }
    
}
