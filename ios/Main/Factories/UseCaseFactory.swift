//
//  UseCaseFactory.swift
//  DoubleConversion
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

final class UseCaseFactory {
    
    static func decompressUseCase() -> DecompressUseCase {
        return DecompressUseCase(engines: [
            ZipExtractor(),
            RarExtractor()
        ])
    }
    
}
